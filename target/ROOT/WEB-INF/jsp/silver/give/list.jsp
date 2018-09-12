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
            <div>
                <form id="search" action="${pageContext.request.contextPath}/silver/give/list" method="post" style="margin:-10px auto auto auto">
                    <input type="hidden" id="size" name="size" value="${size}" />
                    <input type="hidden" id="page" name="page" value="${page}" />
                    <%-- <span style="vertical-align: 3px">手机号</span>
                    <input class="span2" id="cellphone" name="cellphone" value="${cellphone}" type="text" onkeyup="this.value=this.value.trim()" />&nbsp; --%>
                    <!-- <input type="submit" value="查询" style="margin-top: -12px" class="btn btn-default" /> -->
                </form>
            </div>
            <div class="row-fluid">
                <div class="block">
                    <div id="authorityButton" class="navbar navbar-inner block-header">
                        <a id="500" class="btn btn-lg btn-success" href="${pageContext.request.contextPath}/silver/give/add"> 新增 </a>
                        <a id="501" href="javascript:detail()"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                        <a id="502" href="javascript:edit()"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                        <a id="503" href="javascript:audit()"><button class="btn btn-lg btn-primary" >审核<i class=""></i></button></a>
                        <a id="504" href="javascript:giveDetail()"><button class="btn btn-lg btn-primary">查看明细<i class=""></i></button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table id="coupon" cellpadding="0" cellspacing="0" border="0" class="table">
                                <thead>
                                <tr align="center">
                                    <th>序号</th>
                                    <th>赠送日期</th>
                                    <th>手机号数量</th>
                                    <th>银子数量(两)</th>
                                    <th>原因</th>
                                    <th>状态</th>
                                    <!-- <th>操作</th> -->
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(dispatchingBonusLogs) > 0}">
                                        <c:forEach var="dispatchingBonusLog" items="${dispatchingBonusLogs}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="dispatchingBonusLogId${dispatchingBonusLog.id}">
                                                <td class="hiddenid">${dispatchingBonusLog.id}</td>
                                                <td class="hiddenid">${dispatchingBonusLog.status}</td>
                                                <td>${status.count}</td>
                                                <td><p class="liq">${dispatchingBonusLog.giveDate}</p></td>
                                                <td>${dispatchingBonusLog.userNum}</td>
                                                <td>${dispatchingBonusLog.quantity}</td>
                                                <td>

                                                    <c:if test="${not empty dispatchingBonusLog.reason && fn:length(dispatchingBonusLog.reason) > 10}">
                                                        <span data-trigger="mousemove" data-toggle="tooltip" class="tooltip-show" data-placement="left" title="原因 : ${dispatchingBonusLog.reason}">${fn:substring(dispatchingBonusLog.reason, 0, 10)}</span>
                                                    </c:if>
                                                    <c:if test="${not empty dispatchingBonusLog.reason && fn:length(dispatchingBonusLog.reason) <= 10}">
                                                        ${dispatchingBonusLog.reason}
                                                    </c:if>

                                                </td>
                                                <td><c:if test="${dispatchingBonusLog.status == 0}">待审核</c:if><c:if test="${dispatchingBonusLog.status == 1}">审核不通过</c:if><c:if test="${dispatchingBonusLog.status >= 2}">审核通过</c:if></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="7">暂时还没有银子赠送列表</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="7"><div id="coupon-page"></div></td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal hide fade" id="authorizationDiv" role="dialog" style="margin-top: 200px">
            <form id="fmg" class="modal-content form-horizontal password-modal" >
                <input type="hidden" id="customer" name="customer" value="${sessionsilverfoxkey.admin.id}">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">审核意见</h4>
                </div>
                <div class="modal-body">
                    请确认审核结果！
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="setStatus(2)">通过</button>
                        <button type="button" class="btn btn-default" onclick="setStatus(1)">不通过</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script type="text/javascript">
    $('.breadcrumb').html('<li class="active">银子管理&nbsp;/&nbsp;银子赠送</li>');
    var rowId = 0;
    var initStatus = -1;
    $(".liq").css({'width':'100px','display':'block','overflow':'hidden','word-break':'keep-all','white-space':'nowrap','text-overflow':'ellipsis'});
    $(function() {
        $('td.hiddenid').hide();
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
                    $('#search').attr('action','${pageContext.request.contextPath}/silver/give/list');
                    $('#page').val(page);
                    $('#search').submit();
                }
            };
            $('#coupon-page').bootstrapPaginator(options);
        }

        $('#501').hide();
        $('#502').hide();
        $('#503').hide();
        $('#504').hide();
    })

    function search(){
        $('#search').attr('action','${pageContext.request.contextPath}/silver/give/list');
        $('#search').submit();
    }

    function getRow(tr, color) {
        $('#501').hide();
        $('#502').hide();
        $('#503').hide();
        $('#504').hide();
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
        }else{
            $('#dispatchingBonusLogId'+rowId).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = tr.getElementsByTagName('td')[0].innerHTML;
        }
        initStatus = tr.getElementsByTagName('td')[1].innerHTML;
        buttonShowOrHide();
    }

    function buttonShowOrHide(){
        $('#501').show();
        if(initStatus == 0){
            $('#502').show();
            $('#503').show();
            $('#504').hide();
        } else if(initStatus == 1){
            $('#504').hide();
            $('#503').hide();
            $('#502').show();
        } else {
            $('#504').show();
            $('#503').hide();
            $('#502').hide();
        }
    }

    function detail(){
        if(rowId > 0){
            window.location.href='${pageContext.request.contextPath}/silver/give/detail/'+rowId;
        }else{
            alert('请先选择一条记录！');
        }
    }

    function edit(){
        if(rowId > 0){
            window.location.href='${pageContext.request.contextPath}/silver/give/edit/'+rowId;
        }else{
            alert('请先选择一条记录！');
        }
    }

    function audit(){
        if(rowId > 0){
            $('#authorizationDiv').modal('show');
        }else{
            alert('请先选择一条记录！');
        }

    }

    function giveDetail(){
        if(rowId > 0){
            $('#search').attr('action','${pageContext.request.contextPath}/silver/give/user/detail/'+rowId);
            $('#search').submit();
        }else{
            alert('请先选择一条记录！');
        }
    }

    function setStatus(status){
        if(rowId > 0){
            $.get('${pageContext.request.contextPath}/coupon/dispatching/log/'+rowId, function(data){
                if (data && data.status == initStatus) {
                    if(initStatus > 1){
                        if (confirm('要确认本次修改吗?')) {
                            $.getJSON('${pageContext.request.contextPath}/silver/give/status', {dispatchingBonusLogId:rowId, status:status, initStatus:initStatus},function(result){
                                if(!result){
                                    alert('更新失败，数据状态已被更改!');
                                }else{
                                    $('#search').attr('action','${pageContext.request.contextPath}/silver/give/list');
                                    $('#search').submit();
                                }
                            });
                        }
                    }else{
                        $.get('${pageContext.request.contextPath}/coupon/dispatching/log/'+rowId, function(data){
                            if (data && data.status == initStatus) {
                                $.post('${pageContext.request.contextPath}/silver/give/user/count/'+rowId,function(data){
                                    if(status == 2){
                                        if (confirm('本次审核预计赠送'+data.count+'人,确认审核 ?')) {
                                            $.post('${pageContext.request.contextPath}/silver/give/user/'+rowId, function(result){
                                                if (result) {
                                                    $('#search').attr('action','${pageContext.request.contextPath}/silver/give/list');
                                                    $('#search').submit();
                                                } else {

                                                }
                                            });
                                        }
                                    }else{
                                        $.getJSON('${pageContext.request.contextPath}/silver/give/status', {dispatchingBonusLogId:rowId, status:status, initStatus:initStatus},function(result){
                                            if(!result){
                                                alert('更新失败，数据状态已被更改!');
                                            }else{
                                                $('#search').attr('action','${pageContext.request.contextPath}/silver/give/list');
                                                $('#search').submit();
                                            }
                                        });
                                    }
                                });
                            } else {
                                alert('该信息的状态已发生改变，不能再进行修改');
                                flag = false;
                                return flag;
                            }
                        });
                    }
                } else {
                    alert('该信息的状态已发生改变，不能再进行此操作');
                }
            });

        }else{
            alert('请先选择一条记录！');
        }
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>