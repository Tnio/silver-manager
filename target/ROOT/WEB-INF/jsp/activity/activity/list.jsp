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
                <form id="search" action="${pageContext.request.contextPath}/activity/list/1" method="post" class="form-search">
                    <input type="hidden" id="size" name="size" value="${size}" />
                </form>
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div id="authorityButton" class="navbar navbar-inner block-header" style="border-top: none;"><!-- authorityButton -->
                        <a href="javascript:add();" id="360"><button type="button" class="btn btn-success">新增 </button></a>
                        <a href="javascript:detail()" id="361"><button type="button" class="btn btn-lg btn-primary" >查看</button></a>
                        <a href="javascript:edit();" id="362"><button type="button" class="btn btn-primary">编辑 </button></a>
                        <a href="javascript:enable(1);" id="363"><button type="button" class="btn btn-primary">启用</button></a>
                        <a href="javascript:enable(0);" id="364"><button type="button" class="btn btn-primary">禁用</button></a>
                        <!-- <a href="javascript:recommend(1)"  id="365"><button class="btn btn-lg btn-primary" >推荐</button></a>
                        <a href="javascript:recommend(0)"  id="366"><button class="btn btn-lg btn-primary" >取消推荐</button></a> -->
                        <a href="javascript:deleteRow();" id="367"><button type="button" class="btn">删除</button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>活动标题</th>
                                    <!-- <th>排序</th> -->
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody class="activitySortable">
                                <c:choose>
                                    <c:when test="${fn:length(activitys) > 0}">
                                        <c:forEach var="activity" items="${activitys}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="activity${activity.id}N${activity.sortNumber}">
                                                <td class="hidden">${activity.id}</td>
                                                <td class="hidden">${activity.status}</td>
                                                <td class="hidden">${activity.recommend}</td>
                                                <td class="hidden">${activity.sortNumber}</td>
                                                <td>${status.count}</td>
                                                <td><c:if test="${activity.recommend ==1}"><span style="background-color: red; padding:2px; margin-right: 6px;">荐</span></c:if>${activity.title}</td>
                                                <td class="hidden">${activity.sortNumber}</td>
                                                <td>
                                                    <c:if test="${activity.status == 0}">禁用</c:if>
                                                    <c:if test="${activity.status == 1}">启用</c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8">暂时还没有活动信息</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="8"><div id="activity-page"></div></td>
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
    var rowId = 0;
    var status = '';
    var sortNumber = 0;
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;活动专区管理</li>');
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
                    $('#search').attr('action','${pageContext.request.contextPath}/activity/list/'+page);
                    $('#search').submit();
                }
            };
            $('#activity-page').bootstrapPaginator(options);
        }
        changeSort('${pageContext.request.contextPath}/activity/change/sort','activitySortable','tr:contains("\u542f\u7528")',/activity/g,'N');
        $( ".activitySortable" ).sortable("disable");
    });


    $('#361').hide();
    $('#362').hide();
    $('#363').hide();
    $('#364').hide();
    $('#365').hide();
    $('#366').hide();
    $('#367').hide();

    function getRow(tr, color) {
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
            $('#361').hide();
            $('#362').hide();
            $('#363').hide();
            $('#364').hide();
            $('#365').hide();
            $('#366').hide();
            $('#367').hide();
        } else {
            $('#activity'+rowId+'N'+sortNumber).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = tr.getElementsByTagName('td')[0].innerHTML;
            status = tr.getElementsByTagName('td')[1].innerHTML;
            _recommend = tr.getElementsByTagName('td')[2].innerHTML;
            sortNumber = $.trim(tr.getElementsByTagName('td')[3].innerHTML);
            if(status == 0){
                $('#362').show();
                $('#363').show();
                $('#364').hide();
                $('#365').hide();
                $('#366').hide();

            } else {
                $('#362').hide();
                $('#363').hide();
                $('#364').show();
                if(_recommend == 0){
                    $('#365').show();
                    $('#366').hide();
                } else {
                    $('#365').hide();
                    $('#366').show();
                }
            }

            $('#361').show();
            $('#367').show();
        }
    }

    function add(){
        window.location.href= '${pageContext.request.contextPath}/activity/add/${page}/${size}';
    }

    function edit() {
        if (rowId > 0) {
            window.location.href= '${pageContext.request.contextPath}/activity/edit/'+rowId+'/${page}/${size}';
        } else {
            alert('请先选择您想编辑的行!');
        }
    }

    function detail() {
        if (rowId > 0) {
            window.location.href='${pageContext.request.contextPath}/activity/detail/'+rowId+'/${page}/${size}';
        } else {
            alert('请先选择要查看的数据!');
        }
    }

    function enable(value) {
        if(rowId > 0) {
            $.get('${pageContext.request.contextPath}/activity/enable/'+rowId+'/'+value, function(result){
                if (result) {
                    if (value == 0) {
                        recommend(0);
                    } else {
                        window.location.href = '${pageContext.request.contextPath}/activity/list/${page}';
                    }
                }
            }, 'json');
        } else {
            alert('请先选择要一条数据!');
        }
    }

    function recommend(value) {
        if(rowId > 0) {
            $.get('${pageContext.request.contextPath}/activity/recommend/'+rowId+'/'+value, function(result){
                if (result) {
                    window.location.href = '${pageContext.request.contextPath}/activity/list/${page}';
                }
            }, 'json');
        } else {
            alert('请先选择要一条数据!');
        }
    }

    function deleteRow() {
        if (rowId > 0) {
            if (confirm("确认要删除本条记录吗?")) {
                $.get('${pageContext.request.contextPath}/activity/remove/' + rowId, function(result){
                    if (result) {
                        window.location.href = '${pageContext.request.contextPath}/activity/list/${page}';
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