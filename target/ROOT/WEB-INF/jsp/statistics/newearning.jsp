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
                     	<form id="search" action="${pageContext.request.contextPath}/statistics/new/earning" method="post">
                	  		<div class="input-group pull-left">
								<span>时间</span> 
                       				<input type="text" id="beginDate" name="beginDate" value="${beginDate}" class="marginTop span2" onkeypress="return false" style="background: white; width:163px"/> 至
                       				<input type="text" id="endDate" name="endDate"  value="${endDate}" class="marginTop span2" onkeypress="return false" style="background: white; width:163px"/>
                        		<input type="submit" value="查询" class="btn btn-default" />
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
                                               <th>商户借款金额</th>
                                               <th>超募利息</th>
                                               <th>运营费用</th>
                                               <th>支付手续费</th>
                                               <th>借款收益</th>
                                               <th>用户收益</th>
                                               <th>公司收入</th>
                                               <th>公司利润</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       	<c:choose>
                                       		<c:when test="${fn:length(earnings) > 0}">
                                       			<c:forEach var ="earning" items="${earnings}" varStatus="status">
                                       				<tr>
														<td>${earning.productName}</td>
                                       					<td><fmt:formatNumber value="${earning.actualAmount}" pattern="#,##0" /></td>
                                       					<td><fmt:formatNumber value="${earning.borrowAmount}" pattern="#,##0" /></td>
                                       					<td><fmt:formatNumber value="${earning.overrangingProfit}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${earning.operatingCost}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${earning.paymentCost}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${earning.borrowProfit}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${earning.customerProfit}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${earning.companyEarning}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${earning.companyEarning-earning.operatingCost-earning.paymentCost-earning.overrangingProfit}" pattern="#,##0.00" /></td>
                                       				</tr>
                                       			</c:forEach>
                                       		</c:when>
                                       		<c:otherwise>
                                       			<tr>
                                       				<td colspan="10">暂时没有收入记录信息</td>
                                       			</tr>
                                       		</c:otherwise>
                                       	</c:choose>
                                       </tbody>
                                       <tfoot>
                                       	  <tr>
                                        	  <td colspan="10">超募利息:<fmt:formatNumber value="${totalOverrangingProfit}" pattern="#,##0.00" />元
                                        	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;运营费用:<fmt:formatNumber value="${totalOperatingCost}" pattern="#,##0.00" />元
                                        	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;支付手续费:<fmt:formatNumber value="${totalPaymentCost}" pattern="#,##0.00" />元
                                        	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公司收入:<fmt:formatNumber value="${totalCompanyEarning}" pattern="#,##0.00" />元
                                        	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公司利润:<fmt:formatNumber value="${totalCompanyProfit}" pattern="#,##0.00" />元
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
		$('.breadcrumb').html('<li class="active">统计管理&nbsp;/&nbsp;新产品收入</li>');
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
			var maxDate = new Date().toLocaleDateString();
			if(new Date() > begin){
				maxDate = begin.getFullYear()+'/'+(begin.getMonth()+1)+'/'+begin.getDate();
			}
			$('#endDate').datetimepicker({
				format:'Y-m-d',
				minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
				maxDate:maxDate,
				lang:'ch',
				timepicker:false
			});
		}
		
		function getEndDate(){
			var toDate = $('#endDate').val();
			var endDate = new Date(Date.parse(toDate.replace(/-/g,"/")));
			var maxDate = new Date().toLocaleDateString();
			if(new Date() > endDate){
				maxDate = endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate();
			}
			$('#beginDate').datetimepicker({
				format:'Y-m-d',
				maxDate:maxDate,
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
	</script>
</html>