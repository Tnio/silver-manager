<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
<!--
.combo-select {
  position: relative;
  max-width: 200px;
  min-width: 200px;
  /* margin-bottom: 15px; */
  font: 100% Helvetica, Arial, Sans-serif;
  border: 1px #ccc solid;
  border-radius: 3px;
  display:inline-block;
  vertical-align: top;
   } 
-->
</style>
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
		                		<form id="search" onsubmit="return validate();" action="${pageContext.request.contextPath}/trade/merchant/order/0/1" method="post">
		                    		<input type="hidden" id="size" name="size" value="${size}" />
		                    		<input type="hidden" id="page" name="page" value="${page}" />
		                    		<input type="hidden" id="total" name="total" value="${total}" />
		                    		<input type="hidden" id="totalAmount" name="totalAmount" value="${totalAmount}" />
		                    		<div class="row-fluid" style="margin-left: 0px;">
	                    				<span style="width:10px;">订单类型</span>
			                    		<span style="width: 60px;">
			                    			<select id="type" name="type" style="width: 150px;">
		                                		<option value="0" <c:if test="${type == 0 }">selected="selected"</c:if>>还款订单</option>
		                           				<option value="1" <c:if test="${type == 1 }">selected="selected"</c:if>>放款订单</option>
										    </select>
			                    		</span>
			                    		<span style="width:60px; margin-left: 10px;">借款类型</span>
										<select id="loanType" name="loanType" style="width: 150px;">
		                               		<option value="-1" <c:if test="${loanType == -1 }">selected="selected"</c:if>>全部</option>
		                               		<option value="0" <c:if test="${loanType == 0 }">selected="selected"</c:if>>供应链</option>
											<option value="1" <c:if test="${loanType == 1 }">selected="selected"</c:if> >信用贷</option>
											<option value="2" <c:if test="${loanType == 2 }">selected="selected"</c:if> >抵押贷</option>
										</select>
										<span style="width:60px; margin-left: 10px;">订单号</span>
	                         			<input type="text" id="orderNO" name="orderNO" style="background:white;width:150px; " value="${orderNO}" />
		                    		</div>
		                      		<div class="row-fluid" style="margin-left: 0px;">
										<span style="width:10px;">交易时间</span>
										<input id="fromDate" style="background:white;width: 120px;" name="fromDate" type="text" value="${fromDate}" />
										<span>-</span>
										<input id="toDate" style="background:white;width: 120px;" name="toDate" type="text" value="${toDate}" />
										<span style="width:60px; margin-left: 10px;">产品名称</span>
										<input class="marginTop" style="width: 150px;" id="productName" name="productName" type="text"  value="${productName}" />
										<span style="width:60px;margin-left: 10px;">借款人名称</span>
										<input type="text" id="loanName" name="loanName" style="background:white;width:150px; " value="${loanName}" />
										
		                              	<input type="submit" value="查询" class="btn btn-default" style="margin-top: -15px"/>
		                              	<input type="reset" value="重置" onclick="resetData()" class="btn btn-default" style="margin-top: -15px"/>
	                          		</div>
		                    	</form>
			                </div>
			                <div class="row-fluid">
		                        <div class="block">
		                            <div class="block-content collapse in">
		                                <table class="table">
                                        	<thead>
                                       			<tr>
	                                                <th class="center">序号</th>
	                                                <th class="center">交易时间</th>
	                                                <th class="center">交易订单号</th>
	                                                <th class="center">产品名称</th>
	                                                <c:if test= "${type == 0}">
	                                                	<th class="center">还款方</th>
		                                                <th class="center">还款金额</th>
	                                                </c:if>
	                                                <c:if test= "${type == 1}">
		                                                <th class="center">收款方</th>
		                                                <th class="center">放款金额</th>
	                                                </c:if>
	                                                <th class="center">交易状态</th>
                                            	</tr>
                                        	</thead>
                                        	<tbody>
	                                        	<c:choose>
	                                            	<c:when test="${fn:length(orders)>0}">
	                                                	<c:forEach var="order" items="${orders}" varStatus="status">
										       				<tr onclick="" id="${order.id}">
	                                                			<td class="hidden">${order.product.id}</td>
	                                                			<td>${status.count}</td>
			                                                	<td>
			                                                		<c:if test="${order.tradeTime != 'Thu Jan 01 00:00:00 GMT+08:00 1970' and order.tradeTime != 'Thu Jan 01 00:00:00 CST 1970'}">
    	                                    							<fmt:formatDate value="${order.tradeTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
   	                                    							</c:if>
   	                                    						</td>
		                                                		<td>${order.orderNO}</td>
		                                                		<td>${order.product.name }</td>
			                                                	<td>
			                                                		<c:if test="${fn:length(order.loanName)>10 }">
			                                                			${fn:substring(order.loanName, 0, 10)}...
			                                                		</c:if>
			                                                		<c:if test="${fn:length(order.loanName)<=10 }">
			                                                			${order.loanName}
			                                                		</c:if>
			                                                	</td>
			                                                	<c:if test= "${type == 0}">
				                                                	<td><fmt:formatNumber value="${order.repamentAmount}" pattern="#00.00"/></td>
				                                                </c:if>
				                                                <c:if test= "${type == 1}">
				                                                	<td><fmt:formatNumber value="${order.principal}" pattern="#00.00"/></td>
				                                                </c:if>
		                                                		<td>交易成功</td>
                                            				</tr>
	                                            		</c:forEach>
	                                        		</c:when>
			                                        <c:otherwise>
		                                        		<tr>
		                                                	<td colspan="7">暂时还没有记录</td>
		                                            	</tr>  
		                                        	</c:otherwise>
                                       		 	</c:choose>
                                    		</tbody>
		                                    <tfoot>
		                                        <tr>
		                                        	<td colspan="7">
		                                        		交易数:${total}笔
		                                        		&nbsp;&nbsp;&nbsp;交易总金额:<fmt:formatNumber value="${totalAmount}" pattern="#,##0.00" />元
		                                        	</td>
		                                    	</tr>
		                                    	<tr>
		                                        	<td colspan="7">
		                                        		<div id="order-page"></div>
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
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				var beforeDate = new Date();
				beforeDate.setTime(beforeDate.getTime()-1000*60*60*24*6);
				var totalPages = '${pages}';
				$('.breadcrumb').html('<li class="active">订单管理&nbsp;/&nbsp;商户订单</li>');
				$('.horizontalType').css({width:120});
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
			            	$('#search').attr('action','${pageContext.request.contextPath}/trade/merchant/order/0/'+page);
			                $('#search').submit();
			            }  
					};
					$('#order-page').bootstrapPaginator(options);
		   		}
				
				$('#fromDate').datetimepicker({
					format:'Y-m-d',
					//minDate:beforeDate.getFullYear()+'/'+(beforeDate.getMonth()+1)+'/'+beforeDate.getDate(),
					maxDate:new Date().toLocaleDateString(),
					lang:'ch',
					scrollInput:false,
					timepicker:false,
					onShow:function() {
						if ($('td').hasClass('xdsoft_other_month')) {
							$('td').removeClass('xdsoft_other_month');
						} 
					},
					onSelectDate:function() {
						var beginTime = $('#fromDate').val();
						var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
						var afterDate = new Date();
						afterDate.setTime(beginDate.getTime()+1000*60*60*24*6);
						$('#toDate').datetimepicker({
							format:'Y-m-d',
							minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
							//maxDate:afterDate.getFullYear()+'/'+(afterDate.getMonth()+1)+'/'+afterDate.getDate(),
							maxDate:new Date().toLocaleDateString(),
							lang:'ch',
							scrollInput:false,
							timepicker:false,
							onShow:function() {
								if ($('td').hasClass('xdsoft_other_month')) {
									$('td').removeClass('xdsoft_other_month');
								}  
							}
						});
					}
				});
				
				$('#toDate').datetimepicker({
					 format:'Y-m-d',
					 maxDate:new Date().toLocaleDateString(),
					 lang:'ch',
					 scrollInput:false,
					 timepicker:false,
					 onShow:function() {
						if ($('td').hasClass('xdsoft_other_month')) {
							$('td').removeClass('xdsoft_other_month');
						}  
					},
					onSelectDate:function() {
						var endTime = $('#toDate').val();
						var endDate = new Date(Date.parse(endTime.replace(/-/g,"/")));
						beforeDate.setTime(endDate.getTime()-1000*60*60*24*6);
						$('#fromDate').datetimepicker({
							format:'Y-m-d',
							//minDate:beforeDate.getFullYear()+'/'+(beforeDate.getMonth()+1)+'/'+beforeDate.getDate(),
							maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
							lang:'ch',
							scrollInput:false,
							timepicker:false,
							onShow:function() {
								if ($('td').hasClass('xdsoft_other_month')) {
									$('td').removeClass('xdsoft_other_month');
								}  
							}
						});
					}
				});
				
			
		   });
		   $('.horizontal').css({width:100});
		   
		  function resetData() {
			  $("#loanName option:first").prop("selected", true); 
			  $('#merchantName').val('');
			  $('#productName').val('');
			  $('#fromDate').val('');
			  $('#toDate').val('');
			  $('#orderNO').val('');
			  $('#search').attr('action','${pageContext.request.contextPath}/trade/merchant/order/0/1');
	          $('#search').submit(); 
		  }
		  
		  function validate() {
			  if ($('#fromDate').val() || $('#toDate').val()) {
				  if (!$('#fromDate').val()) {
			          alert('起始日期不能为空！');
			          return false;
				  }
				  if (!$('#toDate').val()) {
			          alert('结束日期不能为空！');
			          return false;
				  }
			  }
			  return true;
		  }
		</script>
	</body>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>