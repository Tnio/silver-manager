<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
<body>
<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
<div class="container-fluid">
    <div class="row-fluid">
        <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
        <div class="span10" id="content">
            <div class="row-fluid">
                <form id="search" action="${pageContext.request.contextPath}/photo/list/1" method="post" class="form-search">
                    <input type="hidden" id="size" name="size" value="${size}" />
                </form>
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div id="authorityButton" class="navbar navbar-inner block-header" style="border-top: none;"> <!-- authorityButton -->
                        <a href="#" id="440"></a>
                        <a href="javascript:detail()" id="441"><button type="button" class="btn btn-lg btn-primary" >查看</button></a>
                        <a href="javascript:edit();" id="442"><button type="button" class="btn btn-primary">编辑 </button></a>
                        <a href="javascript:enable(1);" id="443"><button type="button" class="btn btn-primary">启用</button></a>
                        <a href="javascript:enable(0);" id="444"><button type="button" class="btn btn-primary">禁用</button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table id="product" cellpadding="0" cellspacing="0" border="0" class="table">
                                <thead>
                                <tr>
                                    <th width="10%">序号</th>
                                    <th width="20%">图片标题</th>
                                    <th width="40%">缩略图</th>
                                    <th width="15%">显示平台</th>
                                    <th width="15%">状态</th>

                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(photos) > 0}">
                                        <c:forEach var="photo" items="${photos}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="photo${photo.id}">
                                                <td class="hidden">${photo.id}</td>
                                                <td class="hidden">${photo.status}</td>
                                                <td class="vertical">${status.count}</td>
                                                <td class="vertical">${photo.name}</td>
                                                <td class="vertical"><img class="thumbnail thumbnailSize" src="${photo.url}" style="height:80px;width:120px"/></td>
                                                <td class="vertical">web</td>
                                                <td class="vertical">
                                                    <c:if test="${photo.status == 0}">禁用</c:if>
                                                    <c:if test="${photo.status == 1}">启用</c:if>
                                                </td>

                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5">暂时还没有图片信息</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script type="text/javascript">
    var rowId = 0;
    var status = '';
    $('.vertical').css('vertical-align', 'middle');
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;网站图片管理</li>');
        if(totalPages > 0) {
            var options = {
                currentPage: '${page}',
                totalPages: totalPages,
                size: 'normal',
                alignment: 'center',
                tooltipTitles: function (type, page, current) {
                    switch (type) {
                        case 'first':
                            return '首页';
                        case 'prev':
                            return '上一页';
                        case 'next':
                            return '下一页';
                        case 'last':
                            return '末页';
                        case 'page':
                            return (page === current) ? '当前页 ' + page : '跳到 ' + page;
                    }
                },
                onPageClicked: function(event, originalEvent, type, page){
                    $('#search').attr('action','${pageContext.request.contextPath}/photo/list/'+page);
                    $('#search').submit();
                }
            };
            $('#photo-page').bootstrapPaginator(options);
        }
    });

    $('#441').hide();
    $('#442').hide();
    $('#443').hide();
    $('#444').hide();
    $('#375').hide();
    function getRow(tr, color) {
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
            $('#441').hide();
            $('#442').hide();
            $('#443').hide();
            $('#444').hide();
            $('#375').hide();
        } else {
            $('#photo'+rowId).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = tr.getElementsByTagName('td')[0].innerHTML;
            status = tr.getElementsByTagName('td')[1].innerHTML;
            if(status == 0){
                $('#442').show();
                $('#443').show();
                $('#444').hide();
            } else {
                $('#443').hide();
                $('#444').show();
            }
            $('#441').show();
            $('#375').show();
        }
    }

    function add(para){
        window.location.href='${pageContext.request.contextPath}/web/image/add/'+para;
    }

    function edit() {
        if (rowId > 0) {
            window.location.href='${pageContext.request.contextPath}/web/image/edit/'+rowId
        } else {
            alert('请先选择您想编辑的行!');
        }
    }

    function detail() {
        if (rowId > 0) {
            window.location.href='${pageContext.request.contextPath}/web/image/detail/'+rowId;
        } else {
            alert('请先选择要查看的数据!');
        }
    }

    function enable(value) {
        $.get('${pageContext.request.contextPath}/photo/enable/'+rowId+'/'+value, function(result){
            if (result) {
                window.location.href = '${pageContext.request.contextPath}/web/image/list/${page}';
            }
        }, 'json');
    }



    function deleteRow() {
        if (rowId > 0) {
            if (confirm("确认要删除本条记录吗?")) {
                $.get('${pageContext.request.contextPath}/photo/remove/' + rowId, function(result){
                    if (result) {
                        window.location.href = '${pageContext.request.contextPath}/photo/list/${page}';
                    } else {
                        alert('删除失败，请重试');
                    }
                }, 'json');
            }
        } else {
            alert('请选择一条要删除的数据');
        }
    }
    $('#search').css('visibility','visible');
    $('#search').children().show();
    $(function(){

        if("${fn:length(photos)}"<1){
            $("#440").html('<button type="button" onclick="add(0)" class="btn btn-success">新增 </button>');
        }else if("${fn:length(photos)}">0 & "${fn:length(photos)}"<2){
            if("${photos[0].category}"==2){
                $("#440").html('<button type="button" onclick="add(3)" class="btn btn-success">新增 </button>');
            }else{
                $("#440").html('<button type="button" onclick="add(2)" class="btn btn-success">新增 </button>');
            }
        }

    });



</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>