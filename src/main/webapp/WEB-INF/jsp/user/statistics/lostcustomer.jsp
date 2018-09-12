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
		                		<form id="search" onsubmit="return validate();" action="${pageContext.request.contextPath}/user/lost/customer/list/1" method="post">
		                    		<input type="hidden" id="size" name="size" value="${size}" />
		                    		<input type="hidden" id="page" name="page" value="${page}" />
		                    		<input type="hidden" id="total" name="total" value="${total}" />
		                    		<input type="hidden" id="totalAmount" name="totalAmount" value="${totalAmount}" />
		                      		<div class="row-fluid" style="margin-left: 0px;">
										<span style="width:10px;">最后回款时间</span>
										<input id="startTime" style="background:white;width: 120px;" name="startTime" type="text" value="${startTime}" />
										<span>-</span>
										<input id="endTime" style="background:white;width: 120px;" name="endTime" type="text" value="${endTime}" />
										<span style="width:60px;margin-left: 10px;">手机号</span>
										<input type="text" id="cellphone" name="cellphone" style="background:white;width:150px; " value="${cellphone}" />
										<span style="width:60px; margin-left: 10px;">用户姓名</span>
										<input class="marginTop" style="width: 150px;" id="userName" name="userName" type="text"  value="${userName}" />
		                              	<input type="submit" value="查询" class="btn btn-default" style="margin-top: -15px"/>
		                              	<c:if test="${excelImport == true}">
   	                                    	<a href="javascript:exportOrders();"><button type="button" style="margin-top: -15px">导出EXCEL</button></a>
   	                                    </c:if>
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
	                                                <th class="center">手机号</th>
	                                                <th class="center">姓名</th>
	                                                <th class="center">投资总金额(元)</th>
	                                                <th class="center">渠道名称</th>
	                                                <th class="center">最后还款时间</th>
                                            	</tr>
                                        	</thead>
                                        	<tbody>
	                                        	<c:choose>
	                                            	<c:when test="${fn:length(lostcustomers)>0}">
	                                                	<c:forEach var="lostcustomer" items="${lostcustomers}" varStatus="status">
										       				<tr onclick="" id="${lostcustomer.userId}">
	                                                			<td>${status.count}</td>
	                                                			<td>${lostcustomer.cellphone}</td>
	                                                			<td>${lostcustomer.name}</td>
	                                                			<td>${lostcustomer.investAmount}</td>
	                                                			<td>${lostcustomer.channelName}</td>
			                                                	<td>
			                                                		<c:if test="${lostcustomer.lastPaybackTime != 'Thu Jan 01 00:00:00 GMT+08:00 1970'}">
    	                                    							<fmt:formatDate value="${lostcustomer.lastPaybackTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
   	                                    							</c:if>
   	                                    						</td>
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
		                                        		用户总人数:${total}人
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
				$('.breadcrumb').html('<li class="active">客服专区&nbsp;/&nbsp;流失用户管理</li>');
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
			            	$('#search').attr('action','${pageContext.request.contextPath}/user/lost/customer/list/'+page);
			                $('#search').submit();
			            }  
					};
					$('#order-page').bootstrapPaginator(options);
		   		}
				
				$('#startTime').datetimepicker({
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
						var beginTime = $('#startTime').val();
						var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
						var afterDate = new Date();
						afterDate.setTime(beginDate.getTime()+1000*60*60*24*6);
						$('#endTime').datetimepicker({
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
				
				$('#endTime').datetimepicker({
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
						var endTime = $('#endTime').val();
						var endDate = new Date(Date.parse(endTime.replace(/-/g,"/")));
						beforeDate.setTime(endDate.getTime()-1000*60*60*24*6);
						$('#startTime').datetimepicker({
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
			  $('#cellphone').val('');
			  $('#userName').val('');
			  $('#startTime').val('');
			  $('#endTime').val('');
			  $('#search').attr('action','${pageContext.request.contextPath}/user/lost/customer/list/1');
	          $('#search').submit(); 
		  }
		  
		  function exportOrders() {
		        var count = 50000;
		        if($.trim('${total}') > 0){
		            if($.trim('${total}') <= count){
		                $('#search').attr('action','${pageContext.request.contextPath}/user/lost/customer/export');
		                $('#search').submit();
		          }else{
		                alert('查询结果集超过Excel导出最大限制 '+ count +' 条,请精确查询条件!');
		            }
		        }else{
		            alert('没有查询，或查询结果为空，不用导出!');
		        } 
		  }
		  
		  function validate() {
			  if ($('#startTime').val() || $('#endTime').val()) {
				  if (!$('#startTime').val()) {
			          alert('起始日期不能为空！');
			          return false;
				  }
				  if (!$('#endTime').val()) {
			          alert('结束日期不能为空！');
			          return false;
				  }
			  }
			  return true;
		  }
		  $('#search').css('visibility','visible');
		  $('#search').children().show();
		</script>
	</body>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>