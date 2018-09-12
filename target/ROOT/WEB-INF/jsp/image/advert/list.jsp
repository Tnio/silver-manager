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
            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
            <div class="well">
                <form id="searchForm" action="${pageContext.request.contextPath}/banner/list/1" method="post" class="form-search"  style="margin: 0px">
                    <div id="search" style="position:relative; left:6px;">
                        <span >显示平台</span>
                        <select class="marginTop" id="displayPlatform" name="dPlatform" style="width:163px">
                            <option value="-1">全部</option>
                            <option value="1">app</option>
                            <option value="2">web</option>
                        </select>
                        <a href="javascript:search();" id="226"><button type="button" class="btn">查询</button></a>
                    </div>
                </form>
            </div>
            <div class="row-fluid">
                <div class="block">
                    <div id="authorityButton" class="navbar navbar-inner block-header" >
                        <input type="hidden" id="size" name="size" value="${size}" />
                        <a href="javascript:add();" id="220"><button type="button" class="btn btn-success">新增 </button></a>
                        <a href="javascript:edit();" id="222"><button type="button" class="btn btn-primary">编辑 </button></a>
                        <a href="javascript:detail();" id="221"><button type="button" class="btn btn-primary" >查看</button></a>
                        <a href="javascript:enable(1);" id="223"><button type="button" class="btn btn-primary">启用</button></a>
                        <a href="javascript:enable(0);" id="224"><button type="button" class="btn btn-primary">禁用</button></a>
                        <a href="javascript:deleteRow();" id="225"><button type="button" class="btn">删除</button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table id="images" class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>名称</th>
                                    <th>缩略图</th>
                                    <th>显示平台</th>
                                    <!-- <th>排序</th> -->
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody class="bannerSortable">
                                <c:choose>
                                    <c:when test="${fn:length(images) > 0}">
                                        <c:forEach var ="image" items="${images}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="appId${image.id}N${image.sortNumber}">
                                                <td class="hidden">${image.id}</td>
                                                <td class="vertical">${status.count}</td>
                                                <td class="vertical">${image.name}</td>
                                                <td class="vertical"><img class="thumbnail" src="${image.url}" style="height: 60px;width: 100px"/></td>
                                                <td class="vertical"><c:if test="${image.displayPlatform > 1}">web</c:if><c:if test="${image.displayPlatform < 2}">app</c:if></td>
                                                <td class="vertical hidden">${image.sortNumber}</td>
                                                <td class="vertical"><c:if test="${image.status > 0}">启用</c:if><c:if test="${image.status < 1}">禁用</c:if></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="10">暂时没有广告图数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="10"><div id="image-page"></div></td>
                                </tr>
                                </tfoot>
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
    $('#224').hide();
    $('#223').hide();
    $('#222').hide();
    $('.vertical').css('vertical-align', 'middle');
    $('.thumbnailSize').css('height', '60px');
    $('.breadcrumb').html('<li class="active">图片管理 &nbsp;/&nbsp;广告图管理</li>');

    $(document).ready(function(){
        $('.marginTop').css('margin', '2px auto auto auto');
        $('#dPlatform').find("option[value='${dPlatform}']").attr('selected',true);
        var totalPages = '${pages}';
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
                    $('#searchForm').attr('action','${pageContext.request.contextPath}/banner/list/'+page);
                    $('#searchForm').submit();
                }
            };
            $('#image-page').bootstrapPaginator(options);
        }
        changeSort('${pageContext.request.contextPath}/banner/change/sort','bannerSortable','tr:contains("\u542f\u7528")',/appId/g,'N');
        $( ".bannerSortable" ).sortable("disable");
    });

    function search() {
        $('#searchForm').attr('action','${pageContext.request.contextPath}/banner/list/1');
        $('#searchForm').submit();
    }

    function add() {
        window.location.href = '${pageContext.request.contextPath}/banner/add/${page}/${size}';
    }

    function edit() {
        if (rowId > 0) {
            $('#searchForm').attr('action','${pageContext.request.contextPath}/banner/edit/' + rowId + '/${page}/${size}');
            $('#searchForm').attr('method','get');
            $('#searchForm').submit();
        } else {
            alert('请选择一条要修改的数据');
        }
    }

    function detail() {
        if (rowId > 0) {
            $('#searchForm').attr('action','${pageContext.request.contextPath}/banner/detail/' + rowId + '/${page}/${size}');
            $('#searchForm').attr('method','get');
            $('#searchForm').submit();
        } else {
            alert('请选择一条要查看的数据');
        }
    }

    var rowId = 0;
    var sortNumber = 0;
    $('#225').hide();
    $('#221').hide();
    function getRow(tr, color) {
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
            $('#225').hide();
            $('#221').hide();
            $('#223').hide();
            $('#224').hide();
            $('#222').hide();
        } else {
            $('#221').show();
            $('#appId'+rowId+'N'+sortNumber).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = $.trim(tr.getElementsByTagName("td")[0].innerHTML);
            sortNumber = $.trim(tr.getElementsByTagName('td')[5].innerHTML);
            var status = $.trim(tr.getElementsByTagName('td')[6].innerHTML);
            if (status == '禁用') {
                $('#222').show();
                $('#225').show();
                $('#223').show();
                $('#224').hide();
            } else if (status == '启用') {
                $('#225').hide();
                $('#222').hide();
                $('#223').hide();
                $('#224').show();
            }
        }
    }

    function enable(value) {
        $.post('${pageContext.request.contextPath}/banner/enable/'+rowId+'/'+value, function(result){
            if (result) {
                $('#searchForm').attr('action','${pageContext.request.contextPath}/banner/list/${page}');
                $('#searchForm').submit();
            }
        }, 'json');
    }




    function deleteRow() {
        if (rowId > 0) {
            if (confirm("确认要删除本条记录吗?")) {
                $.post('${pageContext.request.contextPath}/banner/delete/' + rowId, function(result){
                    if (result) {
                        window.location.href = '${pageContext.request.contextPath}/banner/list/${page}';
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
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>