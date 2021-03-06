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
                    <!-- content begin -->
                        <div class="well" style="height:40px">
                           	<form id="search" action="${pageContext.request.contextPath}/statistics/bonus/${source}" method="post" >
                            	<div class="input-group">
                           			<div class="input-group marginDivTop" >
	                           			<span>时间</span> 
	                           				<input type="text" id="beginTime" name="beginTime" value="${beginTime}" class="marginTop span2" onkeypress="return false" style="background: white; width:163px"/> 至
	                           				<input type="text" id="endTime" name="endTime"  value="${endTime}" class="marginTop span2" onkeypress="return false" style="background: white; width:163px"/>
	                                    <input type="submit" class="btn btn-default span1" value="查询"/>
                                    </div>
                                 </div>
                            </form>
                         </div>
	                    <!-- content begin -->
	                    <div class="row-fluid">
	                        <!-- block -->
	                        <div class="block">
	                        	<div class="navbar navbar-inner block-header"></div>
	                            <div class="block-content collapse in">
	                                <div class="span12">
	                                    <table id="increaseCoupon" cellpadding="0" cellspacing="0" border="0" class="table" >
	                                        <thead>
	                                            <tr>
	                                            	<th>序号</th>
	                                                <th class="center">金额（元）</th>
	                                                <th class="center">使用条件</th>
	                                                <th class="center">发放总金额（元）</th>
	                                                <th class="center">使用总金额（元）</th>
	                                                <th class="center">使用占比（%）</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        	<c:choose>
	                                        		<c:when test="${fn:length(bonuses) > 0}">
	                                        			<c:forEach var ="bonus" items="${bonuses}" varStatus="status">
	                                        				<tr>
	                                        					<td>${status.count}</td>
	                                        					<td>${bonus.amount}</td>
	                                        					<td>${bonus.useCondition}</td>
	                                        					<td><fmt:formatNumber value="${bonus.totalAmount}" pattern="##0" maxFractionDigits="2"/></td>
	                                        					<td><fmt:formatNumber value="${bonus.usedAmount}" pattern="##0" maxFractionDigits="2"/></td>
	                                        					<td>
	                                        					<c:choose>
	                                        						<c:when test="${(bonus.totalAmount) > 0}">
	                                        							<fmt:formatNumber value="${bonus.usedAmount*100/bonus.totalAmount}" pattern="##0" maxFractionDigits="3"/>
	                                        						</c:when>
					                                        		<c:otherwise>
					                                        			--
					                                        		</c:otherwise>
				                                        		</c:choose>
	                                        					</td>
	                                        				</tr>
	                                        			</c:forEach>
	                                        		</c:when>
	                                        		<c:otherwise>
	                                        			<tr>
	                                        				<td colspan="6">暂时没有数据</td>
	                                        			</tr>
	                                        		</c:otherwise>
	                                        	</c:choose>
	                                        </tbody>
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
		<script src="${pageContext.request.contextPath}/plugin/echarts/echarts.js"></script>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.marginTop').css('margin', '2px auto auto auto');
			$('.marginDivTop').css('margin', '5px auto auto auto');
			$('.longcss').css({width:80});
			$('.breadcrumb').html('<li class="active">统计管理&nbsp;/&nbsp;红包统计明细</li>');
			
			$('#beginTime').datetimepicker({
				format:'Y-m-d',
				maxDate:new Date().toLocaleDateString(),
				lang:'ch',
				timepicker:false,
				scrollInput:false,
				onShow:function() {
					if ($('td').hasClass('xdsoft_other_month')) {
						$('td').removeClass('xdsoft_other_month');
					} 
				},
				onSelectDate:function() {
					getBeginTime();
				}
			});
			
			$('#endTime').datetimepicker({
				 format:'Y-m-d',
				 maxDate:new Date().toLocaleDateString(),
				 lang:'ch',
				 timepicker:false,
				 scrollInput:false,
				 onShow:function() {
					if ($('td').hasClass('xdsoft_other_month')) {
						$('td').removeClass('xdsoft_other_month');
					} 
				},
				onSelectDate:function() {
					getEndTime();
				}
			});
			getBeginTime();
			getEndTime();
		});
		
		function getBeginTime(){
			var fromDate = $('#beginTime').val();
			var startDate = new Date(Date.parse(fromDate.replace(/-/g,"/")));
			$('#endTime').datetimepicker({
				format:'Y-m-d',
				minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
				maxDate:new Date().toLocaleDateString(),
				lang:'ch',
				timepicker:false
			});
		}
		
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
	</script>
</html>