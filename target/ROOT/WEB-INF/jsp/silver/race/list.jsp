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
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div id="authorityButton" class="navbar navbar-inner block-header">
                        <a id="540" href="javascript:add()"><button class="btn btn-lg btn-success">新增</button></a>
                        <a id="541" href="javascript:detail()"><button class="btn btn-lg btn-primary">查看<i class=""></i></button></a>
                        <a id="542" href="javascript:edit()"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                        <a id="543" href="javascript:audit()"><button class="btn btn-lg btn-primary">审核</button></a>
                        <a id="544" href="javascript:exchangeDetail()"><button class="btn btn-lg btn-primary">夺宝记录</button></a>
                    </div>
                    <form id="search" action="${pageContext.request.contextPath}/silver/give/list" method="post">
                        <input type="hidden" id="size" name="size" value="${size}" />
                        <input type="hidden" id="page" name="page" value="${page}" />
                    </form>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>商品名称</th>
                                    <th>参与人次</th>
                                    <th>单次消耗(两)</th>
                                    <th>中奖用户</th>
                                    <th>夺宝状态</th>
                                    <th>审核状态</th>
                                </tr>
                                </thead>
                                <tbody class="receSortable">
                                <c:choose>
                                    <c:when test="${fn:length(goodses) > 0}">
                                        <c:forEach var="goods" items="${goodses}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="goodId${goods.id}N${goods.sortNumber}">
                                                <td class="hidden">${goods.id}</td>
                                                <td class="hidden">${goods.status}</td>
                                                <td class="hidden">${goods.sortNumber}</td>
                                                <td>${status.count}</td>
                                                <td>${goods.name}</td>
                                                <td>${goods.joinNum} / ${goods.stock}</td>
                                                <td>${goods.consumeSilver}</td>
                                                <td>
                                                    <c:if test="${empty goods.cellphone }">--</c:if>
                                                    <c:if test="${not empty goods.cellphone }">${goods.cellphone}</c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${goods.status == 2 }">
                                                        <c:if test="${goods.joinNum < goods.stock }"> 进行中</c:if>
                                                        <c:if test="${goods.joinNum >= goods.stock }">已结束</c:if>
                                                    </c:if>
                                                    <c:if test="${goods.status != 2 }">
                                                        --
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${goods.status == 2 }">
                                                        审核通过
                                                    </c:if>
                                                    <c:if test="${goods.status == 3 }">
                                                        审核不通过
                                                    </c:if>
                                                    <c:if test="${goods.status <= 0 }">
                                                        待审核
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="10">暂时还没有商品列表</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="10"><div id="goods-page"></div></td>
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
<div class="modal hide fade" id="authorizationDiv" role="dialog" style="margin-top: 200px">
    <form id="fmg" class="modal-content form-horizontal password-modal" >
        <input type="hidden" id="id" name="id">
        <input type="hidden" id="customer" name="customer" value="${sessionsilverfoxkey.admin.id}">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">审核意见</h4>
        </div>
        <div class="modal-body">
            请确认审核结果！
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="setStatus('2','status')">通过</button>
                <button type="button" class="btn btn-default" onclick="setStatus('3','status')">不通过</button>
            </div>
        </div>
    </form>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
</body>
<script type="text/javascript">
    var rowId = 0;
    var status = '';
    var type = '';
    var sortNumber = 0;
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">银子管理 &nbsp;/&nbsp;0元夺宝</li>');
        $('[rel="tooltip"]').tooltip();
        $('#541').hide();
        $('#542').hide();
        $('#543').hide();
        $('#544').hide();
        $('.thumbnailSize').css('height', '40px');
        $('.thumbnailSize').css('width', '60px');
        var workImg=document.getElementsByTagName('img');
        for(var i=0; i<workImg.length; i++) {
            workImg[i].onclick=ImgShow;
        }
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
                    $('#search').attr('action','${pageContext.request.contextPath}/silver/race/list/');
                    $('#page').val(page);
                    $('#search').submit();
                }
            };
            $('#goods-page').bootstrapPaginator(options);
        }
        changeSort('${pageContext.request.contextPath}/silver/goods/change/sort','receSortable','tr:contains("\u8fdb\u884c\u4e2d")',/goodId/g,'N');
        $( ".receSortable" ).sortable("disable");
    });


    function getRow(tr, color) {
        $('#541').hide();
        $('#542').hide();
        $('#543').hide();
        $('#544').hide();
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
        } else {
            $('#goodId'+rowId+'N'+sortNumber).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = $.trim(tr.getElementsByTagName('td')[0].innerHTML);
            status = $.trim(tr.getElementsByTagName('td')[1].innerHTML);
            sortNumber = $.trim(tr.getElementsByTagName('td')[2].innerHTML);
            buttonShowOrHide(status);
        }

    }

    function exchangeDetail() {
        window.location.href='${pageContext.request.contextPath}/silver/race/exchange/record/'+ rowId;
    }

    function buttonShowOrHide(status){
        if(status == 0 || status == 3){
            $('#541').show();
            $('#542').show();
            $('#543').show();
        }else if(status == 2){
            $('#541').show();
            $('#544').show();
        }
    }

    function add(){
        window.location.href='${pageContext.request.contextPath}/silver/race/add';
    }

    function edit() {
        if (rowId > 0) {
            window.location.href='${pageContext.request.contextPath}/silver/race/edit/'+rowId;
        } else {
            alert('请先选择您想编辑的行!');
        }
    }

    function detail() {
        if (rowId > 0) {
            window.location.href='${pageContext.request.contextPath}/silver/race/detail/'+rowId;
        } else {
            alert('请先选择您想查看的数据!');
        }
    }

    function audit(){
        if(rowId > 0){
            $('#authorizationDiv').modal('show');
        }else{
            alert('请先选择一条记录!');
        }
    }

    function setStatus(statue,category){
        if(rowId > 0){
            $.post('${pageContext.request.contextPath}/silver/goods/'+rowId+'/'+statue,{category:category}, function(result){
                window.location.href='${pageContext.request.contextPath}/silver/race/list';
            });
        }else{
            alert('请先选择要审核的商品！');
        }
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>