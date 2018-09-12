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
                     	<form id="search" action="${pageContext.request.contextPath}/statistics/payback/calender" method="post">
                	  		<div class="input-group pull-left">
								<span style="vertical-align: 3px">统计分类</span>
                               	<select id="type" name="type" onchange="search()" style="vertical-align: 3px">
                               		<option value="1" <c:if test="${type == 1 }">selected="selected"</c:if>>按产品回款时间统计</option>
									<option value="2" <c:if test="${type == 2 }">selected="selected"</c:if> >按产品售罄时间统计</option>
								</select>&nbsp;
								<span style="vertical-align: 3px">时间</span> 
                       				<input type="text" id="beginDate" name="beginDate" value="${beginDate}" class="marginTop span2" onkeypress="return false" style="background: white; width:163px; vertical-align: 3px" /> 至
                       				<input type="text" id="endDate" name="endDate"  value="${endDate}" class="marginTop span2" onkeypress="return false" style="background: white; width:163px; vertical-align: 3px"/>
                        		<input type="submit" value="查询" class="btn btn-default" style="vertical-align: 3px"/>
                        		<span style="vertical-align: 3px">统计渠道</span>
                               	<select id="backChannel" name="backChannel" onchange="search()" style="vertical-align: 3px">
                               		<option value="0" <c:if test="${backChannel == 0 }">selected="selected"</c:if>>全部</option>
                               		<option value="1" <c:if test="${backChannel == 1 }">selected="selected"</c:if>>银行存管</option>
									<option value="2" <c:if test="${backChannel == 2 }">selected="selected"</c:if> >连连支付</option>
								</select>&nbsp;
                        		
                     		</div>
                 		</form>
                    </div>
                    <div class="row-fluid">
                       	<div class="block">
                       		<div class="navbar navbar-inner block-header">
                       		</div>
	                        <!-- block -->
                            <div class="block-content collapse in">
                                <div class="span12">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th>产品名称</th>
                                               <th>募集金额</th>
                                               <th>年化收益</th>
                                               <th>实际年化</th>
                                               <th>理财期限</th>
                                               <th>优惠券费用</th>
                                               <th>加息费用</th>
                                               <th>VIP加息费用</th>
                                               <th>商户应还金额</th>
                                               <th>服务费</th>
                                               <!-- <th>误差值</th> -->
                                               <th>预计回款金额</th>
                                               <th>预计回款日期</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       	<c:choose>
                                       		<c:when test="${fn:length(paybackMsgs) > 0}">
                                       			<c:forEach var ="payback" items="${paybackMsgs}" varStatus="status">
                                       				<tr>
														<td>${payback.productName}</td>
                                       					<td><fmt:formatNumber value="${payback.actualAmount}" pattern="#,##0" /></td>
                                       					<td><c:if test="${payback.increaseInterest == 0}">${payback.yearIncome}%</c:if><c:if test="${payback.increaseInterest > 0}">${payback.yearIncome}%+${payback.increaseInterest}%</c:if></td>
                                       					<td>
                                       						<c:if test="${payback.actualAmount <= 0 }">
                                       							${payback.yearIncome}%
                                       						</c:if>
                                       						<c:if test="${payback.actualAmount > 0 }">
                                       							<fmt:formatNumber value="${(payback.couponAmount+payback.interestCouponAmount) * 365 / payback.financePeriod/payback.actualAmount*100+payback.increaseInterest+payback.yearIncome}" pattern="#,##0.00" /> %
                                       						</c:if>
                                       					</td>
                                       					<td>${payback.financePeriod}</td>
                                       					<td><fmt:formatNumber value="${payback.couponAmount+payback.interestCouponAmount}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${payback.interestAmount}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${payback.vipInterestAmount}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${payback.merchantBackCharge+payback.serviceCharge+payback.actualAmount}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${payback.merchantBackCharge}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${payback.actualAmount+payback.serviceCharge+payback.couponAmount+payback.interestCouponAmount+payback.interestAmount+payback.vipInterestAmount}" pattern="#,##0.00" /></td>
                                       					<td>${payback.paybackDate}</td>
                                       				</tr>
                                       			</c:forEach>
                                       		</c:when>
                                       		<c:otherwise>
                                       			<tr>
                                       				<td colspan="10">暂时没有回款信息</td>
                                       			</tr>
                                       		</c:otherwise>
                                       	</c:choose>
                                       </tbody>
                                       <tfoot>
                                       	  <tr>
                                        	  <td colspan="11">
                                        	  	募集总金额:<fmt:formatNumber value="${actualAmount}" pattern="#,##0" />元
                                        	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;优惠券费用:<fmt:formatNumber value="${couponAmount}" pattern="#,##0.00" />元
                                        	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加息费用:<fmt:formatNumber value="${interestAmount}" pattern="#,##0.00" />元
                                        	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VIP加息费用:<fmt:formatNumber value="${vipInterestAmount}" pattern="#,##0.00" />元
                                        	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商户应还:<fmt:formatNumber value="${actualAmount+merchantBackCharges}" pattern="#,##0.00" />元
                                        	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;预计回款金额:<fmt:formatNumber value="${paybackAmount}" pattern="#,##0.00" />元
                                        	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;服务费:<fmt:formatNumber value="${serviceCharges}" pattern="#,##0.00" />元
                                        	  </td>
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
		$('.breadcrumb').html('<li class="active">统计管理&nbsp;/&nbsp;回款日历</li>');
		$('.marginTop').css('margin', '2px auto auto auto');
			
		$('#beginDate').datetimepicker({
			format:'Y-m-d',
			lang:'ch',
			timepicker:false,
			scrollInput:false,
			onShow:function() {
				if ($('td').hasClass('xdsoft_other_month')) {
					$('td').removeClass('xdsoft_other_month');
				} 
			},
			onSelectDate:function() {
				getBeginDate();
			}
		});
		
		$('#endDate').datetimepicker({
			 format:'Y-m-d',
			 lang:'ch',
			 timepicker:false,
			 scrollInput:false,
			 onShow:function() {
				if ($('td').hasClass('xdsoft_other_month')) {
					$('td').removeClass('xdsoft_other_month');
				} 
			},
			onSelectDate:function() {
				getEndDate();
			}
		});
		getBeginDate();
		getEndDate();
	
		function getBeginDate(){
			var fromDate = $('#beginDate').val();
			var toDate = $('#endDate').val();
			var startDate = new Date(Date.parse(fromDate.replace(/-/g,"/")));
			var endDate = new Date(Date.parse(toDate.replace(/-/g,"/")));
			if((endDate-startDate)>2592000000){
				$('#endDate').val('');
			}
			var begin = addDate((startDate.getMonth()+1)+'/'+startDate.getDate()+'/'+startDate.getFullYear() ,30);
			$('#endDate').datetimepicker({
				format:'Y-m-d',
				minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
				maxDate:begin.getFullYear()+'/'+(begin.getMonth()+1)+'/'+begin.getDate(),
				lang:'ch',
				timepicker:false
			});
		}
		
		function getEndDate(){
			var toDate = $('#endDate').val();
			var endDate = new Date(Date.parse(toDate.replace(/-/g,"/")));
			$('#beginDate').datetimepicker({
				format:'Y-m-d',
				//maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
				lang:'ch',
				timepicker:false
			});
		}
		
		function addDate(oldDay,days){
			var newDate = new Date(oldDay)
			newDate = newDate.valueOf()
			newDate = newDate + days * 24 * 60 * 60 * 1000
			newDate = new Date(newDate)
			return newDate;
		}
		
		function search(){
	    	$('#search').submit();
	    }
	</script>
</html>