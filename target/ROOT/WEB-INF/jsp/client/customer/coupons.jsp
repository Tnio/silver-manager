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
            <form id="search" action="${pageContext.request.contextPath}/client/customer/coupons/${customerId}/1" method="post">
                <div style="margin-top: 2px">
                    <span>状态</span>
                    <select id="status" name="status">
                        <option value="-1" >全部</option>
                        <option value="0" <c:if test="${status == 0}"> selected="selected" </c:if> >未使用</option>
                        <option value="1" <c:if test="${status == 1}"> selected="selected" </c:if> >已使用</option>
                        <option value="2" <c:if test="${status == 2}"> selected="selected" </c:if> >已转赠</option>
                        <option value="3" <c:if test="${status == 3}"> selected="selected" </c:if> >已过期</option>
                    </select>
                    <input type="submit" value="查询" style="margin-top: -10px" class="btn btn-default" />
                </div>
            </form>
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table id="customers" cellpadding="0" cellspacing="0" border="0" class="div_table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>优惠券额度</th>
                                    <th>投资金额</th>
                                    <th>投资期限</th>
                                    <th>下发时间</th>
                                    <th>来源</th>
                                    <th>状态</th>
                                    <th>使用时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(coupons) > 0}">
                                        <c:forEach var ="customerCoupon" items="${coupons}" varStatus="status">
                                            <tr>
                                                <td>${status.count}</td>
                                                <td>
                                                    <c:if test="${customerCoupon.coupon.category == 4}">
                                                        <fmt:formatNumber value="${customerCoupon.amount }" pattern="##0.##"/>%
                                                    </c:if>
                                                    <c:if test="${customerCoupon.coupon.category < 4}">
                                                        <fmt:formatNumber value="${customerCoupon.amount }" pattern="##0.##"/>元
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${customerCoupon.coupon.moneyLimit == 0}">
                                                        不限制
                                                    </c:if>
                                                    <c:if test="${customerCoupon.coupon.moneyLimit == 1}">
                                                        单笔满${customerCoupon.coupon.tradeAmount}元可用
                                                    </c:if>
                                                    <c:if test="${customerCoupon.coupon.moneyLimit == 2}">
                                                        累计满${customerCoupon.coupon.tradeAmount}元可用
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${customerCoupon.coupon.financePeriod == 0}">
                                                        不限制
                                                    </c:if>
                                                    <c:if test="${customerCoupon.coupon.financePeriod > 0}">
                                                        ${customerCoupon.coupon.financePeriod}天及以上
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${customerCoupon.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
                                                </td>
                                                <td>
                                                    <c:if test="${customerCoupon.source == 0}">系统赠送</c:if>
                                                    <c:if test="${customerCoupon.source == 1}">抽奖活动</c:if>
                                                    <c:if test="${customerCoupon.source == 2}">投资返利</c:if>
                                                    <c:if test="${customerCoupon.source == 3}">银子商城兑换</c:if>
                                                    <c:if test="${customerCoupon.source == 4}">渠道奖励</c:if>
                                                    <c:if test="${customerCoupon.source == 5}">系统赠送</c:if>
                                                    <c:if test="${customerCoupon.source == 6}">邀请好友赠送</c:if>
                                                    <c:if test="${customerCoupon.source == 7}">注册</c:if>
                                                    <c:if test="${customerCoupon.source == 8}">首次投资</c:if>
                                                    <c:if test="${customerCoupon.source == 9}">分享奖励</c:if>
                                                    <c:if test="${customerCoupon.source == 10}">生日福利</c:if>
                                                    <c:if test="${customerCoupon.source == 11}">签到奖励</c:if>
                                                    <c:if test="${customerCoupon.source == 12}">兑换奖励</c:if>
                                                    <c:if test="${customerCoupon.source == 13}">抢红包活动</c:if>
                                                    <c:if test="${customerCoupon.source == 14}">好友转赠</c:if>
                                                    <c:if test="${customerCoupon.source == 15}">游戏奖励</c:if>
                                                    <c:if test="${customerCoupon.source == 16}">新年红包</c:if>
                                                    <c:if test="${customerCoupon.source == 17}">邀请奖励</c:if>
                                                    <c:if test="${customerCoupon.source == 18}">回款奖励</c:if>
                                                    <c:if test="${customerCoupon.source == 19}">VIP专属优惠券</c:if>
                                                    <c:if test="${customerCoupon.source == 20}">VIP生日红包</c:if>
                                                    <c:if test="${customerCoupon.source == 21}">VIP1专享</c:if>
                                                    <c:if test="${customerCoupon.source == 22}">VIP2专享</c:if>
                                                    <c:if test="${customerCoupon.source == 23}">VIP3专享</c:if>
                                                    <c:if test="${customerCoupon.source == 24}">VIP4专享</c:if>
                                                    <c:if test="${customerCoupon.source == 25}">VIP5专享</c:if>
                                                    <c:if test="${customerCoupon.source == 26}">VIP6专享</c:if>
                                                    <c:if test="${customerCoupon.source == 27}">VIP7专享</c:if>
                                                    <c:if test="${customerCoupon.source == 28}">VIP8专享</c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${customerCoupon.used == 0 }">
                                                        未使用
                                                    </c:if>
                                                    <c:if test="${customerCoupon.used == 1 }">
                                                        已使用
                                                    </c:if>
                                                    <c:if test="${customerCoupon.used == 2 }">
                                                        已转赠
                                                    </c:if>
                                                    <c:if test="${customerCoupon.used == 3 }">
                                                        已过期
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${customerCoupon.used == 1 }">
                                                        <fmt:formatDate value="${customerCoupon.usedTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="10">暂时没有优惠券数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="10"><div id="coupons-page"></div></td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /block -->
            </div>
            <!-- content end -->
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script type="text/javascript">
    var rowId = 0;
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;优惠券列表</li>');
        $('[rel="tooltip"]').tooltip();
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
                    $('#search').attr('action','${pageContext.request.contextPath}/client/customer/coupons/${customerId}/'+page);
                    $('#search').submit();
                }
            };
            $('#coupons-page').bootstrapPaginator(options);
        }
    });
</script>
</html>