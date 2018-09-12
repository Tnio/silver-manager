<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:import url="/header" />
<body>
<c:import url="/menu" />
<div class="container-fluid">
    <div class="row-fluid">
        <c:import url="/sidebar" />
        <div class="span10" id="content">
            <c:import url="/breadcrumb" />
            <div class="row-fluid">
                <div class="well">
                    <form id="search" action="${pageContext.request.contextPath}/bonus/lottery/detail/list/${lotteryId}" method="post" >
                        <input type="hidden" id="size" name="size" value="${size}" />
                        <input type="hidden" id="page" name="page" value="1" />
                        <div class="input-group" style="height:0px">
                            <span style="vertical-align: 3px">手机号</span>
                            <input class="horizontal marginTop" type="text" style="width:90px" id="cellphone" name="cellphone" value="${cellphone}" class="span3" />
                            <span>中奖时间:</span>
                            <input id="beginTime" class="datepicker marginTop" style="background:white;width:90px" onkeypress="return false" name="beginTime" type="text" value="${beginTime}" />
                            -
                            <input class="datepicker marginTop" id="endTime" style="background:white;width:90px" onkeypress="return false" name="endTime" type="text" value="${endTime}" />
                            <span style="vertical-align: 3px">奖品项</span>
                            <select id="prizeId" style="width:120px" name="prizeId" class="span3">
                                <c:set var="times" value="0"/>
                                <option value="0">全部</option>
                                <c:forEach items="${prizes}" var="prize">
                                    <c:if test="${prize.category  == 1}">
                                        <option value="${prize.id}" >${prize.silverQuantity }两银子</option>
                                    </c:if>
                                    <c:if test="${prize.category  == 2}">
                                        <option value="${prize.id}">${prize.coupon.amount }元红包</option>
                                    </c:if>
                                    <c:if test="${prize.category  == 3}">
                                        <option value="${prize.id}">${prize.prizeName }</option>
                                    </c:if>
                                    <c:if test="${prize.category  == 4 and times == 0}">
                                        <c:set var="times" value="1"/>
                                        <option value="-1">谢谢参与</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <input type="submit" class="btn btn-default" style="margin-top: -10px" value="查询"/>
                        </div>
                    </form>
                </div>
                <div class="block">
                    <div id="authorityButton" class="navbar navbar-inner block-header">

                    </div>
                    <!-- <form id="search" action=""></form> -->
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>手机号</th>
                                    <th>消耗银子</th>
                                    <th>获得奖品</th>
                                    <th>中奖时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(lotteryDetails) > 0}">
                                        <c:forEach var="detail" items="${lotteryDetails}" varStatus="status">
                                            <tr>
                                                <td class="hidden">${detail.id}</td>
                                                <td>${status.count}</td>
                                                <td>${detail.user.cellphone}</td>
                                                <td>${detail.silverCost}两</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${detail.lotteryPrize.category == 1}">
                                                            ${detail.lotteryPrize.prizeName} 两银子
                                                        </c:when>
                                                        <c:when test="${detail.lotteryPrize.category == 2}">
                                                            ${detail.lotteryPrize.prizeName} 元红包
                                                        </c:when>
                                                        <c:when test="${detail.lotteryPrize.category == 3}">
                                                            ${detail.lotteryPrize.prizeName}
                                                        </c:when>
                                                        <c:otherwise>
                                                            谢谢参与
                                                        </c:otherwise>
                                                    </c:choose>


                                                </td>
                                                <td><fmt:formatDate value="${detail.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4">暂时还没有中奖明细列表</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="9">抽奖数:${total}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;消耗银子总数:<fmt:formatNumber value="${costSilvers}" pattern="#,##0" />两
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;获得银子总数:${getSilvers}两&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;获得红包总数:<fmt:formatNumber value="${getCoupons}" pattern="#,##0" />个</td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div id="detail-page"></div>
                                    </td>
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
<c:import url="/footer" />
</body>
<script type="text/javascript">
    var rowId = 0;
    var status = '';
    $('#prizeId').find("option[value='${prizeId}']").attr('selected',true);
    $('#beginTime').datetimepicker({
        format:'Y-m-d',
        lang:'ch',
        timepicker:false,
        onSelectDate:function() {
            var fromDate = $('#beginTime').val();
            var startDate = new Date(Date.parse(fromDate.replace(/-/g,"/")));
            $('#endTime').datetimepicker({
                format:'Y-m-d',
                minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
                lang:'ch',
                timepicker:false
            });
        }
    });

    $('#endTime').datetimepicker({
        format:'Y-m-d',
        lang:'ch',
        timepicker:false,
        onSelectDate:function() {
            getEndTime();
        }
    });
    function getEndTime(){
        var toDate = $('#endTime').val();
        var endDate = new Date(Date.parse(toDate.replace(/-/g,"/")));
        $('#beginTime').datetimepicker({
            format:'Y-m-d',
            maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
            lang:'ch',
            timepicker:false
        });
    }
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active"><a href="javascript:quit()" >抽奖管理 </a>&nbsp;/&nbsp;中奖明细</li>');
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
                    $('#page').val(page);
                    $('#search').attr('action','${pageContext.request.contextPath}/bonus/lottery/detail/list/${lotteryId}');
                    $('#search').submit();
                }
            };
            $('#detail-page').bootstrapPaginator(options);
        }
    });
    function quit(){
        $('#search').attr('action','${pageContext.request.contextPath}/bonus/lottery/list/1');
        $('#search').submit();
    }
</script>
<c:import url="/authority" />
</html>