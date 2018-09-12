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
                    <div class="row-fluid">
                        <div class="well">
                            <form id="search" action="${pageContext.request.contextPath}/coupon/grab/record/${couponActivityId}" method="post" >
                                <input type="hidden" id="size" name="size" value="${size}" />
                                <input type="hidden" id="page" name="page" value="1" />
                                <div class="input-group" style="height:0px">
                                    <span style="vertical-align: 3px">手机号</span>
                                    <input class="horizontal marginTop" style="vertical-align: 3px" type="text" id="cellphone" name="cellphone" value="${cellphone}" class="span3" />
                                    <span style="vertical-align: 3px">是否使用</span>
                                    <select id="used" name="used" class="span3">
                                        <option value="-1" <c:if test="${used ==-1 }"> selected="selected"</c:if>>全部</option>
                                        <option value="0" <c:if test="${used ==0 }"> selected="selected"</c:if>>未使用</option>
                                        <option value="1" <c:if test="${used ==1 }"> selected="selected"</c:if>>已使用</option>
                                    </select>
                                    <input type="submit" class="btn btn-default" style="margin-top: -10px" value="查询"/>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>手机号</th>
                                    <th>红包金额</th>
                                    <th>是否使用</th>
                                    <th>获得时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(customerCoupons) > 0}">
                                        <c:forEach var="customerCoupon" items="${customerCoupons}" varStatus="s">
                                            <tr>
                                                <td>${s.count}</td>
                                                <td>${customerCoupon.cellphone}</td>
                                                <td>${customerCoupon.amount}</td>
                                                <td><c:if test="${customerCoupon.used == 0}">未使用</c:if><c:if test="${customerCoupon.used == 1}">已使用</c:if></td>
                                                <td><fmt:formatDate value="${customerCoupon.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8">暂时还没有抢红包记录信息</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="8"><div id="couponActivity-page"></div></td>
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
    $(document).ready(function(){
        var totalPages = parseInt('${pages}');
        $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">抢红包活动管理</a>&nbsp;/&nbsp;活动记录明细</li>');
        $('[rel="tooltip"]').tooltip();
        $('.marginTop').css('margin', '2px auto auto auto');
        if(totalPages > 0) {
            var options = {
                currentPage: parseInt('${page}'),
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
                    $('#search').attr('action','${pageContext.request.contextPath}/coupon/grab/record/${couponActivityId}');
                    $('#page').val(page);
                    $('#search').submit();
                }
            };
            $('#couponActivity-page').bootstrapPaginator(options);
        }
    });
    function quit(){
        window.location.href='${pageContext.request.contextPath}/activity/grab/list/1';
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>