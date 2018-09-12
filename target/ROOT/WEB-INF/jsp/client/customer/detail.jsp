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
            <div id="content">
                <!-- content begin -->
                <div class="row-fluid">
                    <!-- block -->
                    <div class="block">
                        <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                        <div class="navbar navbar-inner block-header">
                            <form id="search" action="${pageContext.request.contextPath}/client/customer/${customerId}/trade/1" method="post">
                                <div style="margin-top: 2px">
                                    <span>选择类型</span>
                                    <select id="isPayback" name="isPayback">
                                        <option value="0">全部</option>
                                        <option value="1">购买</option>
                                        <option value="2">转出</option>
                                        <option value="3">到期回款</option>
                                    </select>
                                    <input type="checkbox" id="couponType" name="couponType" value="1"><span>只看优惠券订单</span>
                                    <input type="submit" value="查询" style="margin-top: -10px" class="btn btn-default" />
                                </div>
                            </form>
                        </div>
                        <div class="block-content collapse in">
                            <table cellpadding="0" class="table" cellspacing="0" border="0" id="orders">
                                <thead>
                                <tr>
                                    <th class="center">序号</th>
                                    <th class="center">交易日期时间</th>
                                    <th class="center">订单号</th>
                                    <th class="center">产品名称</th>
                                    <th class="center">优惠券</th>
                                    <!-- <th class="center">年化收益(%)</th> -->
                                    <th class="center">期限</th>
                                    <th class="center">购买金额(元)</th>
                                    <!--<th class="center">收益(元)</th>
                                    <th class="center">使用红包(元)</th> -->
                                    <th class="center">类型</th>
                                    <th class="center">回款金额(元)</th>

                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(customerOrders) > 0}">
                                        <c:forEach var="customerOrder" items="${customerOrders}" varStatus="status">
                                            <tr <c:if test="${status.count%2==0}"></c:if>>
                                                <td>${status.count}</td>
                                                <td><fmt:formatDate value="${customerOrder.orderTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td>${customerOrder.orderNO}</td>
                                                <td>${customerOrder.product.name}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${customerOrder.couponAmount > 0 && customerOrder.interestPeriod > 0}">
                                                            加息：<fmt:formatNumber value="${customerOrder.couponAmount}" pattern="##0.0#"/>%${customerOrder.interestPeriod}天
                                                        </c:when>
                                                        <c:when test="${customerOrder.couponAmount > 0 && customerOrder.interestPeriod == 0}">
                                                            红包：<fmt:formatNumber value="${customerOrder.couponAmount}" pattern="##0.0#" />元
                                                        </c:when>
                                                        <c:otherwise>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                    <%--  <td>${customerOrder.product.yearIncome}</td> --%>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${customerOrder.product.category.property != 'TREASURE'}">
                                                            ${customerOrder.product.financePeriod}天
                                                        </c:when>
                                                        <c:otherwise>
                                                            随存随取
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${customerOrder.product.category.property == 'TREASURE'}">
                                                            <c:choose>
                                                                <c:when test="${customerOrder.isPayback == 0}">
                                                                    <fmt:formatNumber value="${customerOrder.principal}" pattern="#,##0" />
                                                                </c:when>
                                                                <c:otherwise>

                                                                </c:otherwise>
                                                            </c:choose>
                                                            <%-- <fmt:formatNumber value="${customerOrder.principal}" pattern="#,##0.00#" /> --%>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${customerOrder.principal}" pattern="#,##0" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${customerOrder.product.category.property == 'TREASURE'}">
                                                            <c:choose>
                                                                <c:when test="${customerOrder.isPayback == 0}">
                                                                    购买
                                                                </c:when>
                                                                <c:otherwise>
                                                                    转出
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:when test="${customerOrder.product.category.property != 'TREASURE'}">
                                                            <c:choose>
                                                                <c:when test="${customerOrder.isPayback != 1 and customerOrder.isPayback != 3}">
                                                                    购买
                                                                </c:when>
                                                                <c:when test="${customerOrder.isPayback == 1}">
                                                                    到期回款
                                                                </c:when>
                                                                <c:when test="${customerOrder.isPayback == 3}">
                                                                    回款失败
                                                                </c:when>
                                                                <c:otherwise>
                                                                    --
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:otherwise>
                                                            --
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${customerOrder.product.category.property != 'TREASURE'}">
                                                            <c:choose>
                                                                <c:when test="${customerOrder.isPayback == 1 or customerOrder.isPayback == 3}">
                                                                    <fmt:formatNumber value="${customerOrder.paybackAmount}" pattern="#,##0.00" />
                                                                </c:when>
                                                                <c:otherwise>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:choose>
                                                                <c:when test="${customerOrder.isPayback == 0}">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <fmt:formatNumber value="${customerOrder.principal}" pattern="#,##0.00" />
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="18">暂时还没有交易明细</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="14"><div id="customer-detail-page"></div></td>
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
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<%-- <script src="${pageContext.request.contextPath}/js/json.js"></script> --%>
<script type="text/javascript">
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
        $('#isPayback').find('option[value="${isPayback}"]').attr('selected','selected');
        if('${couponType}' == 1){
            $('input[name="couponType"]').prop('checked', true);
        }
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;<a href="${pageContext.request.contextPath}/client/customer/list/1">用户管理</a>&nbsp;/&nbsp;交易明细</li>');
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
                    $('#search').attr('action','${pageContext.request.contextPath}/client/customer/${customerId}/trade/'+page);
                    $('#search').submit();
                }
            };
            $('#customer-detail-page').bootstrapPaginator(options);
        }
        $('.mixcss').css({width:5,align:'center'});
        $('.shortcss').css({width:9,align:'center'});
        $('.numbercss').css({width:10,align:'center'});
    });

    function quit() {
        window.location.href='${pageContext.request.contextPath}/client/customer/list/1';
    }
</script>
</body>
</html>