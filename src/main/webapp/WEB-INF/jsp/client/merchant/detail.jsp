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
                    <div class="navbar navbar-inner block-header">
                        <a href="javascript:quit();"><button type="button" class="btn">返回</button></a>
                    </div>
                    <form id="fm" action='${pageContext.request.contextPath}/client/merchant/detail/${merchantId}/1' method="post">
                        <input name="name" value="${name}" type="hidden">
                    </form>
                    <div class="block-content collapse in">
                        <table class="table" id="merchantLoan">
                            <thead>
                            <tr>
                                <th class="center">序号</th>
                                <th class="center">产品名称</th>
                                <th class="center">借款金额</th>
                                <th class="center">起息日</th>
                                <th class="center">最后还款日</th>
                                <th class="center">状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${fn:length(orders) > 0}">
                                    <c:forEach var="order" items="${orders}" varStatus="status">
                                        <tr>
                                            <td class="hidden">${order.id}</td>
                                            <td>${status.count}</td>
                                            <td>${order.product.name}</td>
                                            <td><fmt:formatNumber value="${order.principal}" pattern="#,##0" /></td>
                                            <td>${order.product.interestDate}</td>
                                            <td><fmt:formatDate value="${order.tradeTime}" type="date" dateStyle="medium"/></td>
                                            <td>
                                                <c:if test="${order.type == 1 and order.status == 1}">放款中</c:if>
                                                <c:if test="${order.type == 1 and order.status == 2}">待还款</c:if>
                                                <c:if test="${order.type == 0 and order.status == 1}">还款中</c:if>
                                                <c:if test="${order.type == 0 and order.status == 2}">已还款</c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="12">暂时还没有借款信息</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="10">数量:<fmt:formatNumber value="${fn:length(orders)}" pattern="#,##0" />次
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;借款金额:<fmt:formatNumber value="${totalAmount}" pattern="#,##0" />元
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <!-- /block -->
            </div>
            <!-- content end -->
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<script src="${pageContext.request.contextPath}/js/json.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;<a href="javascript:quit();">借款人管理</a>&nbsp;/&nbsp;借款明细</li>');
        $('.waring-borrow').css('background-color', '#46A3FF');
        $('.serious-borrow').css('background-color', '#FFFF37');
        $('.danger-borrow').css('background-color', '#FF5151');
    });

    function quit() {
        $('#fm').attr('action','${pageContext.request.contextPath}/client/merchant/list/1');
        //$('#fm').attr('onsubmit','true');
        $('#fm').submit();
        // window.location.href='${pageContext.request.contextPath}/client/merchant/list/1';
    }
</script>
</body>
</html>