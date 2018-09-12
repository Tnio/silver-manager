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
                    <div class="well" style="height:165px;">
                    	<form id="search" onsubmit="return validate();" action="${pageContext.request.contextPath}/trade/baobao/order/${category}/${page}" method="post">
                        	<input type="hidden" id="size" name="size" value="${size}" />
                            <div class="input-group">
                  					<span>交易类型</span>
                  					<select id="category" name="category" class="horizontalType marginTop">
                           				<option value="0">进账单</option>
                                		<option value="1">出账单</option>
                           				<option value="2">转出申请</option>
                           				<option value="3">交易关闭</option>
								    </select>
                        			<div style="margin:15px auto auto auto">
	                         			<span>起始时间</span>
	                         			<input type="text" id="beginTime" name="beginTime" style="background:white;" value="${beginTime}" class="horizontal marginTop" onkeypress="return false"/>
	                             		<span>结束时间</span>
	                             		<input type="text" id="endTime" name="endTime" style="background:white;" value="${endTime}" class="horizontal marginTop" onkeypress="return false"/>
	                             		<span id="payTypeSpan">支付方式</span>
	                             		<select class="marginTop" id="payType" name="payType" style="width: 163px">
											<option value="0">全部</option>
											<option value="1">WEB</option>
											<option value="2">IOS</option>
											<option value="3">Android</option>
											<option value="4">WAP</option>
										</select>
										<span>产品名称</span>
	                                 	<input type="text" id="productName" name="productName" value="${productName}" class="horizontal marginTop"/> 
	                             		<span id="orderStatusSpan">交易状态</span>
	                             		<select class="marginTop" id="orderStatus" name="orderStatus" style="width: 163px">
											<option value="-1">全部</option>
											<option value="2">交易成功</option>
											<option value="3">交易失败</option>
										</select>
                            		</div>
                            		<div style="margin:15px auto auto auto">
	                             		<span id="amountFromSpan">起始金额</span>
	                         			<input type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false" style="ime-mode:Disabled" id="amountFrom" name="amountFrom" value="${amountFrom}" class="horizontal marginTop" />
	                             		<span id="amountToSpan">结束金额</span>
	                             		<input type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false" style="ime-mode:Disabled" id="amountTo" name="amountTo" value="${amountTo}" class="horizontal marginTop" />
                            		    <span>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</span>
	                             		<input type="text" id="orderNO" name="orderNO" value="${orderNO}" class="horizontal marginTop" />
	                                 	<span>渠道名称</span>
	                                 	<select id="channelId" name="channelId">
	                             		    <option value="-1">全部</option>
											 <c:choose>
                                                 <c:when test="${fn:length(channels) > 0}">
                                                 	<c:forEach var="channel" items="${channels}" varStatus="status">
                                                 		<option value="${channel.id}">${channel.name}</option>
                                                 	</c:forEach>
                                                 </c:when>
                                             </c:choose>
										</select>
                            		</div>
                            		<div style="margin:15px auto auto auto">
	                         			<span>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</span>
	                                 	<input type="text" id="name" name="name" value="${name}" class="horizontal marginTop"/>
	                             		<span>手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机</span>
	                                 	<input type="text" id="phone" name="phone" value="${phone}" class="horizontal marginTop"/>
	                           			<a href="javascript:search();"><button type="button" class="btn">查询</button></a>
	                           			<a href="javascript:resetData();"><button type="button" class="btn">重置</button></a>
	                           			<a href="javascript:exportOrders();" class="authoritySettings" id="410"><button type="button" class="btn buttonHidden">导出EXCEL</button></a>
                  				</div>
                           	</div>
                       	</form>
                    </div>
                    <!-- content begin -->
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                        	<div id="authorityButton" class="navbar navbar-inner block-header">
                       		</div>
                            <div class="block-content collapse in">
                                <div class="span12">
                                    <table id="ordersIn" class="div_table" style="display:none;">
                                        <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>交易时间</th>
                                                <th>交易订单号</th>
                                                <th>使用优惠券</th>
                                                <th>产品名称</th>
                                                <th>姓名</th>
                                                <th>手机号</th>
                                                <th>购买金额(元)</th>
                                                <th>支付方式</th>
                                                <th>渠道</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(orders) > 0}">
                                            <c:forEach var="order" items="${orders}" varStatus="status">
                                            <tr>
                                                <td style="width:30px;">${status.count}</td>
                                                <td><fmt:formatDate value="${order.orderTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td>${order.orderNO}</td>
                                                <td><c:if test="${order.interestPeriod >0 }">加息${order.couponAmount }%${order.interestPeriod }天</c:if> </td>
                                                <td>${order.productName}</td>
                                                <td>${order.customerName}</td>
                                                <td>${order.cellphone}</td>
                                                <td><fmt:formatNumber value="${order.principal}" pattern="#,##0" /></td>
                                                <td><c:if test="${order.payType == 1}">web</c:if><c:if test="${order.payType == 3}">android</c:if><c:if test="${order.payType == 2}">ios</c:if><c:if test="${order.payType == 4}">wap</c:if></td>
                                                <td>${order.channelName}</td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="11">暂时还没有订单</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                        	<c:if test="${fn:length(orders) > 0}">
	                                        	<tr>
	                                        		<td colspan="11">
	                                        		交易数:${total}笔&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交易总金额:<fmt:formatNumber value="${totalMoney}" pattern="#,##0" />元
	                                        		</td>
	                                        	</tr>
	                                        </c:if>
                                        	<tr>
                                        		<td colspan="11">
                                        		    <div id="baobao-page0"></div>
                                        		</td>
                                        	</tr>
                                        </tfoot>
                                    </table> 
                                    <table id="ordersOut" class="div_table" style="display:none;">
                                        <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>交易成功时间</th>
                                                <th>交易订单号</th>
                                                <th>使用优惠券</th>
                                                <th>产品名称</th>
                                                <th>姓名</th>
                                                <th>手机号</th>
                                                <th>转出金额(元)</th>
                                                <th>手续费(元)</th>
                                                <th>实际到账金额(元)</th>
                                                <th>交易状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(orders) > 0}">
                                            <c:forEach var="order" items="${orders}" varStatus="status">
                                            <tr>
                                                <td style="width:30px;">${status.count}</td>
                                                <td style="display:block;"><fmt:formatDate value="${order.tradeTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td> 
                                                <td><c:if test="${not empty order.paybackNO }"><span data-trigger="click" data-toggle="tooltip" class="tooltip-show" data-placement="left" title="回款订单号    ：       ${order.paybackNO}">${order.orderNO}</span></c:if>
                                                	<c:if test="${empty order.paybackNO }"><span data-trigger="click" data-toggle="tooltip" class="tooltip-show" data-placement="left" title="回款订单号    ：       ${order.orderNO}">${order.orderNO}</span></c:if></td>
                                                <td><c:if test="${order.interestPeriod >0 }">加息${order.couponAmount }%${order.interestPeriod }天</c:if> </td>
                                                <td>${order.productName }</td>
                                                <td>${order.customerName}</td>
                                                <td>${order.cellphone}</td>
                                                <td><fmt:formatNumber value="${order.principal + order.fee}" pattern="#,##0.00" /></td>
                                                <td>${order.fee}</td>
                                                <td><fmt:formatNumber value="${order.principal}" pattern="#,##0.00" /></td>
                                                <td>
                                                	<c:choose>
                                                		<c:when test="${order.status == '1'}">
                                                			处理中
                                                		</c:when>     
                                                		<c:when test="${order.status == 2}">
                                                			交易成功
                                                		</c:when>
                                                		<c:when test="${order.status == 3}">
                                                			交易失败
                                                		</c:when>
                                                	</c:choose>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="11">暂时还没有订单</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                        	<c:if test="${fn:length(orders) > 0}">
	                                            <tr>
	                                        		<td colspan="11">
	                                        		交易数:${total}笔&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交易总金额:<fmt:formatNumber value="${totalMoney}" pattern="#,##0.00" />元
	                                        		</td>
	                                        	</tr>
                                        	</c:if>
                                        	<tr>
                                        		<td colspan="11">
                                        		    <div id="baobao-page1"></div>
                                        		</td>
                                        	</tr>
                                        	<tr></tr>
                                        </tfoot>
                                    </table>
                                    <table id="handingOrder" class="div_table" style="display:none;">
                                        <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>转出提交时间</th>
                                                <th>转出订单号</th>
                                                <th>产品名称</th>
                                                <th>姓名</th>
                                                <th>手机号</th>
                                                <th>转出金额(元)</th>
                                                <th>手续费(元)</th>
                                                <th>实际到账金额(元)</th>
                                                <th>交易状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(orders) > 0}">
                                            <c:forEach var="order" items="${orders}" varStatus="status">
                                            <tr>
                                                <td style="width:30px;">${status.count}</td>
                                                <td><fmt:formatDate value="${order.orderTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td><c:if test="${not empty order.paybackNO }"><span data-trigger="click" data-toggle="tooltip" class="tooltip-show" data-placement="left" title="回款订单号：${order.paybackNO}">${order.orderNO}</span></c:if>
                                                	<c:if test="${empty order.paybackNO }"><span data-trigger="click" data-toggle="tooltip" class="tooltip-show" data-placement="left" title="回款订单号：${order.orderNO}">${order.orderNO}</span></c:if></td>
                                                <td>${order.productName }</td>
                                                <td>${order.customerName}</td>
                                                <td>${order.cellphone}</td>
                                                <td><fmt:formatNumber value="${order.principal + order.fee}" pattern="#,##0.00" /></td>
                                                <td>${order.fee}</td>
                                                <td><fmt:formatNumber value="${order.principal}" pattern="#,##0.00" /></td>
                                                <td>
                                                	<c:choose>
                                                		<c:when test="${order.status == '1'}">
                                                			处理中
                                                		</c:when>
                                                		<c:when test="${order.status == '2'}">
                                                			交易成功
                                                		</c:when>
                                                		<c:when test="${order.status == '3'}">
                                                			交易失败
                                                		</c:when>
                                                	</c:choose>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="11">暂时还没有订单</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                        	<c:if test="${fn:length(orders) > 0}">
	                                        	<tr>
	                                        		<td colspan="11">
	                                        		交易数:${total}笔&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交易总金额:<fmt:formatNumber value="${totalMoney}" pattern="#,##0.00" />元
	                                        		</td>
	                                        	</tr>
	                                        </c:if>
                                        	<tr>
                                        		<td colspan="11">
                                        		    <div id="baobao-page2"></div>
                                        		</td>
                                        	</tr>
                                        </tfoot>
                                    </table> 
                                    <table id="closedOrder" class="div_table" style="display:none;">
                                        <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>交易时间</th>
                                                <th>交易订单号</th>
                                                <th>产品名称</th>
                                                <th>姓名</th>
                                                <th>手机号</th>
                                                <th>购买金额(元)</th>
                                                <th></th>
                                                <th>支付方式</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(closedOrders) > 0}">
                                            <c:forEach var="order" items="${closedOrders}" varStatus="status">
                                            <tr <c:if test="${status.count%2==0}">class="odd"</c:if> id="customerOrder${order.orderNO}">
                                                <td style="width:30px;">${status.count}</td>
                                                <td><fmt:formatDate value="${order.orderTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td>${order.orderNO}</td>
                                                <td><c:if test="${!empty order.product}">${order.product.name }</c:if></td>
                                                <td><c:if test="${!empty order.user}">${order.user.name}</c:if></td>
                                                <td>${order.user.cellphone}</td>
                                                <td><fmt:formatNumber value="${order.principal}" pattern="#,##0" /></td>
                                                <td>${order.user.channel.name}</td>
                                                <td><c:if test="${order.payType == 1}">web</c:if><c:if test="${order.payType == 3}">android</c:if><c:if test="${order.payType == 2}">ios</c:if><c:if test="${order.payType == 4}">wap</c:if></td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="11">暂时还没有订单</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                        	<c:if test="${fn:length(orders) > 0}">
	                                        	<tr>
	                                        		<td colspan="11">
	                                        		交易数:${total}笔&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购买总金额:<fmt:formatNumber value="${totalMoney}" pattern="#,##0.00" />元
	                                        		</td>
	                                        	</tr>
	                                        </c:if>
                                        	<tr>
                                        		<td colspan="11">
                                        		   <div id="baobao-page3"></div>
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
		$(function () { 
			//$("[data-toggle='tooltip']").tooltip({delay: {show: 10, hide: 1500 }});
			$("[data-toggle='tooltip']").tooltip(); 
		});
	    $('#channelId').find('option[value=${channelId}]').attr('selected',true);
	    $('#orderStatus').find('option[value=${orderStatus}]').attr('selected',true);
	    $('#category').find('option[value=${category}]').attr('selected',true);
	    $('#payType').find('option[value=${payType}]').attr('selected',true);
	    $('#category').change(function() {
		    var value = $('#category').val();
		    if (value == 3) {
			    window.location.href='${pageContext.request.contextPath}/trade/abnormal/1/'+value;
		    } else {
				window.location.href='${pageContext.request.contextPath}/trade/baobao/order/'+value+'/1';
		    }
	    });
	    
		$(document).ready(function(){
			$('#channelId').comboSelect();
			$('.marginTop').css('margin', '2px auto auto auto');
			var totalPages = '${pages}';
			var beforeDate = new Date();
			beforeDate.setTime(beforeDate.getTime()-1000*60*60*24*6);
			$('.breadcrumb').html('<li class="active">订单管理&nbsp;/&nbsp;活期产品订单</li>');
			$('#payType').find("option[value='${payType}']").attr('selected',true);
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
		            	var value = '${category}';
		            	if (value == 3) {
			            	$('#search').attr('action','${pageContext.request.contextPath}/trade/abnormal/'+page+'/'+value);
			                $('#search').submit();
		            	} else {
			            	$('#search').attr('action','${pageContext.request.contextPath}/trade/baobao/order/${category}/'+page);
			                $('#search').submit();
		            	}
		            }  
			    };
				$('#baobao-page${category}').bootstrapPaginator(options);
			}
			var category = '${category}';
			if (category == 1) {
				$('#ordersIn').hide();
				$('#ordersOut').show();
				$('#handingOrder').hide();
				$('#channelIdSpan').hide();
				$('#channelId').hide();
				$('#payTypeSpan').hide();
				$('#payType').hide();
				$('#orderStatusSpan').show();
				$('#orderStatus').show();
				$('#closedOrder').hide();
			} else if (category == 0){
				$('#ordersIn').show();
				$('#ordersOut').hide();
				$('#handingOrder').hide();
				$('#orderStatusSpan').hide();
				$('#orderStatus').hide();
				$('#handingOrder').hide();
				$('#channelIdSpan').show();
				$('#channelId').show();
				$('#payTypeSpan').show();
				$('#payType').show();
				$('#closedOrder').hide();
			} else if (category == 2) {
				$('#ordersIn').hide();
				$('#ordersOut').hide();
				$('#handingOrder').show();
				$('#orderStatusSpan').hide();
				$('#orderStatus').hide();
				$('#channelIdSpan').hide();
				$('#channelId').hide();
				$('#payTypeSpan').hide();
				$('#payType').hide();
				$('#closedOrder').hide();
			} else if (category == 3) {
				$('#closedOrder').show();
				$('#ordersIn').hide();
				$('#ordersOut').hide();
				$('#handingOrder').hide();
				$('#410').hide();
				
				$('#amountFromSpan').hide();
				$('#amountFrom').hide();
				$('#amountToSpan').hide();
				$('#amountTo').hide();
				$('#orderStatusSpan').hide();
				$('#orderStatus').hide();
			}
			$('.horizontal').css({width:150});
			$('.horizontalType').css({width:160});
			$('#beginTime').datetimepicker({
				format:'Y-m-d',
				maxDate:new Date().toLocaleDateString(),
				lang:'ch',
				scrollInput:false,
				timepicker:false,
				onSelectDate:function() {
					var beginTime = $('#beginTime').val();
					var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
					var afterDate = new Date();
					afterDate.setTime(beginDate.getTime()+1000*60*60*24*6);
					$('#endTime').datetimepicker({
						format:'Y-m-d',
						minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
						maxDate:new Date().toLocaleDateString(),
						lang:'ch',
						scrollInput:false,
						timepicker:false
					});
				}
			});
			
			$('#endTime').datetimepicker({
				 format:'Y-m-d',
				 maxDate:new Date().toLocaleDateString(),
				 lang:'ch',
				 scrollInput:false,
				 timepicker:false,
				 onSelectDate:function() {
					var endTime = $('#endTime').val();
					var endDate = new Date(Date.parse(endTime.replace(/-/g,"/")));
					beforeDate.setTime(endDate.getTime()-1000*60*60*24*6);
					$('#beginTime').datetimepicker({
						format:'Y-m-d',
						maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
						lang:'ch',
						scrollInput:false,
						timepicker:false
					});
				}
			});
		});
	    
		function resetData() { 
			$('#beginTime').val('');
			$('#endTime').val('');
			$('#amountFrom').val('');
			$('#amountTo').val('');
			$('#orderNO').val('');
			$('#productName').val('');
			$('#payType').val(0);
			$('#channelId').val(-1);
			$('#orderStatus').val('');
			$('#name').val('');
			$('#phone').val('');
			var value = '${category}';
			if (value == 3) {
				$('#search').attr('action','${pageContext.request.contextPath}/trade/abnormal/1/'+value);
	            $('#search').submit(); 
			} else {
			    $('#search').attr('action','${pageContext.request.contextPath}/trade/baobao/order/${category}/1');
	            $('#search').submit(); 
			}
		}
		
		function validate() {
			 /*  if ($('#beginTime').val() || $('#endTime').val()) {
				  if (!$('#beginTime').val()) {
			          alert('开始时间不能为空！');
			          return false;
				  }
				  if (!$('#endTime').val()) {
			          alert('结束时间不能为空！');
			          return false;
				  }
			  } */
			  if ($('#amountFrom').val() || $('#amountTo').val()) {
				  if (!$('#amountFrom').val()) {
			          alert('起始金额不能为空！');
			          return false;
				  }
				  if (!$('#amountTo').val()) {
					  $('#amountTo').val(500000);
				  }
				  if($('#amountFrom').val() != null && $('#amountFrom').val() > 0 && $('#amountTo').val() != null && $('#amountTo').val() > 0){
						if(parseFloat($.trim($('#amountFrom').val())) > parseFloat($.trim($('#amountTo').val()))){
							 alert('起始金额不能大于结束金额！');
							return false;
						}
				  }
			  }
			  return true;
		  }
		
		function search() {
			var value = '${category}';
			if (value == 3) {
				$('#search').attr('action','${pageContext.request.contextPath}/trade/abnormal/1/'+value);
	            $('#search').submit(); 
			} else {
				$('#search').attr('action','${pageContext.request.contextPath}/trade/baobao/order/${category}/1');
	            $('#search').submit(); 
			}
		}
		
		function exportOrders() {
			var count = 50000;
			if($.trim('${total}') > 0){
				if($.trim('${total}') <= count){
					$('#search').attr('action','${pageContext.request.contextPath}/trade/baobao/order/export/${category}');
		            $('#search').submit(); 
				}else{
					alert('查询结果集超过Excel导出最大限制 '+ count +' 条,请精确查询条件!');	
				}
			}else{
				alert('没有查询，或查询结果为空，不用导出!');
			}
			
		}

		function vaildIntegerNumber(evnt){
			 evnt=evnt||window.event;
			 var keyCode=window.event?evnt.keyCode:evnt.which;
			 return keyCode>=48&&keyCode<=57||keyCode==8;
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>