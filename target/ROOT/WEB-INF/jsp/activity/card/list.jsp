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
                <form id="search" action="${pageContext.request.contextPath}/bonus/card/list/1" method="post">
                    <input type="hidden" id="size" name="size" value="${size}" />
                    <div class="input-group pull-left">
                        <span>名称:</span>
                        <input class="horizontal marginTop" id="cardName" name="cardName" type="text"  value="${cardName}" />
                        <input type="submit" value="查询" class="btn btn-default" />
                        <input type="reset" id="reset" value="重置"  class="btn btn-default" />
                    </div>
                </form>
            </div>
            <div class="row-fluid">
                <div class="block">
                    <div id="authorityButton" class="navbar navbar-inner block-header">
                        <a id="210" href="${pageContext.request.contextPath}/bonus/card/add"><button class="btn btn-lg btn-success">新增</button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>名称</th>
                                    <th>卡号</th>
                                    <th>领取人</th>
                                    <th>是否使用</th>
                                    <th>生成时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(cards) > 0}">
                                        <c:forEach var ="card" items="${cards}" varStatus="status">
                                            <tr>
                                                <td>${status.count}</td>
                                                <td>${card.cardName}</td>
                                                <td>${card.cardNO}</td>
                                                <c:choose>
                                                    <c:when test="${card.customer != null}">
                                                        <td>${fn:substring(card.customer.cellphone, 0, 3)}****${fn:substring(card.customer.cellphone, fn:length(card.customer.cellphone) - 4, fn:length(card.customer.cellphone))}</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>未领取</td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${card.used == 1}">
                                                        <td>是</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>未使用</td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td><fmt:formatDate value="${card.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td><a href="#" onclick="javascript:showBarcode('${card.cardNO}')">二维码</a></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="9">暂时没有支付卡</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="9"><div id="log-page"></div></td>
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
<div class="modal fade" id="barcodeDialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 id="qrcode-title" class="modal-title">支付卡二维码</h4>
            </div>
            <div class="modal-body">
                <div id="rqcode"></div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script src="${pageContext.request.contextPath}/res/js/jquery.qrcode.min.js"></script>
<script type="text/javascript">
    var rowId = 0;
    $('.marginTop').css('margin', '2px auto auto auto');
    $('.datepicker').css({width:120});
    $('.horizontal').css({width:120});
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">红包管理&nbsp;/&nbsp;支付卡管理</li>');

        $('#search').validationEngine('attach', {
            promptPosition:'bottomLeft',
            showOneMessage: true,
            scroll: false
        });

        $('#reset').click(function(){
            $('#cardName').val('');
            $('#search').attr('action', '${pageContext.request.contextPath}/bonus/card/list/'+1);
            $('#search').submit();
        });

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
                    $('#search').attr('action', '${pageContext.request.contextPath}/bonus/card/list/'+page);
                    $('#search').submit();
                }
            };
            $('#log-page').bootstrapPaginator(options);
        }
    });

    function showBarcode(cardNO) {
        $('#barcodeDialog').css({width:230,height:300});
        $("#qrcode-title").html(cardNO);
        $('#barcodeDialog').modal('show');
        $("#rqcode").html('');
        $("#rqcode").qrcode({
            render: 'canvas',
            width: 200,
            height:200,
            text: '${paymentCardUri}'+cardNO
        });
    }

</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>