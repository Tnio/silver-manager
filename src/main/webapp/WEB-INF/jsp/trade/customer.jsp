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
                    <div class="well" style="height:175px;">
                    	<form id="search" onsubmit="return validate();" action="${pageContext.request.contextPath}/trade/customer/${category}/${page}" method="post">
                        	<input type="hidden" id="size" name="size" value="${size}" />
                            <div class="input-group">
                  					<span>交易类型</span>
                  					<select id="type" name="type" class="horizontalType marginTop">
                           				<option value="0">交易成功</option>
                           				<option value="2">交易撤销</option>
                                		<option value="1">回款成功</option>
                                		<option value="3">逾期</option>
								    </select>
                        			<div style="margin:15px auto auto auto">
	                         			<span>开始时间</span>
	                         			<input type="text" id="beginTime" name="beginTime" style="background:white;" value="${beginTime}" class="horizontal marginTop" onkeypress="return false"/>
	                             		<span>结束时间</span>
	                             		<input type="text" id="endTime" name="endTime" style="background:white;" value="${endTime}" class="horizontal marginTop" onkeypress="return false"/>
	                             		<span id="payTypeSpan">支付方式</span>
	                             		<select class="marginTop" id="payType" name="payType" style="width: 163px">
											<option value="0">全部</option>
											<option value="1">WEB</option>
											<option value="5">WEB-网银支付</option>
											<option value="2">IOS</option>
											<option value="3">Android</option>
											<option value="4">WAP</option>
										</select>
										<span>产品名称</span>
	                                 	<input type="text" id="productName" name="productName" value="${productName}" class="horizontal marginTop"/> 
                            		</div>
                            		<div style="margin:15px auto auto auto">
                            			<c:if test="${type != 2}">
		                             		<span>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</span>
		                             		<input type="text" id="orderNO" name="orderNO" value="${orderNO}" class="horizontal marginTop" />
                            			</c:if>
	                             		<c:if test="${ type != 1}">
		                             		<span id="amountFromSpan">起始金额</span>
		                         			<input type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false" style="ime-mode:Disabled" id="amountFrom" name="amountFrom" value="${amountFrom}" class="horizontal marginTop" />
		                             		<span id="amountToSpan">结束金额</span>
		                             		<input type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false" style="ime-mode:Disabled" id="amountTo" name="amountTo" value="${amountTo}" class="horizontal marginTop" />
	                            			<span>渠道来源</span>
	                            			<select id="areaNO" name="areaNO">
		                             		    <option value="-1">全部</option>
												 <c:choose>
	                                                 <c:when test="${fn:length(channels) > 0}">
	                                                 	<c:forEach var="channel" items="${channels}" varStatus="status">
	                                                 		<option value="${channel.id}">${channel.name}</option>
	                                                 	</c:forEach>
	                                                 </c:when>
	                                             </c:choose>
											</select>
	                             		</c:if>
                            		</div>
                            		<div style="margin:15px auto auto auto">
	                         			<span>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</span>
	                                 	<input type="text" id="name" name="name" value="${name}" class="horizontal marginTop"/>
	                             		<span>手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机</span>
	                                 	<input type="text" id="phone" name="phone" value="${phone}" class="horizontal marginTop"/>
	                           			<a href="javascript:search();"><button type="button" class="btn">查询</button></a>
	                           			<a href="javascript:resetData();"><button type="button" class="btn">重置</button></a>
	                           			<c:if test="${type == 0}">
		                           			<a href="javascript:exportOrders();" class="authoritySettings" id="150"><button type="button" class="btn buttonHidden">导出EXCEL</button></a>
	                           			</c:if>
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
                                                <c:if test="${type == 0}">
	                                                <th>交易时间</th>
	                                                <th>交易订单号</th>
	                                                <th>产品名称</th>
	                                                <th>姓名</th>
	                                                <th>手机号</th>
	                                                <th>交易金额</th>
	                                                <th>优惠券</th>
	                                                <th>会员加息</th>
	                                                <th>渠道来源</th>
	                                                <th>支付方式</th>
                                                </c:if>
                                                 <c:if test="${type == 3}">
	                                                <th>交易订单号</th>
	                                                <th>产品名称</th>
	                                                <th>姓名</th>
	                                                <th>手机号</th>
	                                                <th>待还金额</th>
	                                                <th>约定还款日期</th>
	                                                <th>逾期天数</th>
                                                </c:if>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(orders) > 0}">
                                            <c:forEach var="order" items="${orders}" varStatus="status">
                                            <tr <c:if test="${status.count%2==0}">class="odd"</c:if> id="customerOrder${order.orderNO}">
                                                <td style="width:60px;">${status.count}</td>
                                                <c:if test="${type == 0}">
	                                               	<td><fmt:formatDate value="${order.orderTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                                               	<td>${order.orderNO}</td>
	                                                <td><c:if test="${!empty order.product}">${order.product.name }</c:if></td>
	                                                <td><c:if test="${!empty order.customer}">${order.customer.name}</c:if></td>
	                                                <td>${order.customer.cellphone}</td>
	                                                <td><fmt:formatNumber value="${order.principal}" pattern="#,##0" /></td>
	                                                <td><c:if test="${order.interestPeriod > 0 }">加息${order.couponAmount}%${order.interestPeriod}天</c:if>
	                                                	<c:if test="${order.interestPeriod < 1 and order.couponAmount > 0}">¥${order.couponAmount}</c:if></td>
	                                                <td><c:if test="${order.vipInterest ==0}">无</c:if>
	                                                    <c:if test="${order.vipInterest > 0}">${order.vipInterest}%</c:if></td>
	                                                <td>
	                                                	${order.customer.channel.name}
	                                                </td>
	                                                <td>
	                                                	<c:if test="${order.payType == 1}">web</c:if>
	                                                	<c:if test="${order.payType == 3}">android</c:if>
	                                                	<c:if test="${order.payType == 2}">ios</c:if>
	                                                	<c:if test="${order.payType == 4}">wap</c:if>
	                                                	<c:if test="${order.payType == 5}">web-网银支付</c:if>
	                                               </td>
                                                </c:if>
                                                <c:if test="${type == 3}">
	                                               	<td>${order.orderNO}</td>
	                                                <td><c:if test="${!empty order.product}">${order.product.name }</c:if></td>
	                                                <td><c:if test="${!empty order.customer}">${order.customer.name}</c:if></td>
	                                                <td>${order.customer.cellphone}</td>
	                                                <td><fmt:formatNumber value="${order.paybackAmount}" pattern="#,##0.00" /></td>
	                                                <td>${order.paybackNO }</td>
	                                                <td>${order.interestPeriod }</td>
                                                </c:if>
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
	                                        		交易数:${total}笔&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                        		<c:if test="${type == 3}">
	                                               		待还总金额:<fmt:formatNumber value="${totalMoney}" pattern="#,##0.00" />元
                                                	</c:if>
	                                        		<c:if test="${type != 3}">
	                                               		购买总金额:<fmt:formatNumber value="${totalMoney}" pattern="#,##0.00" />元
                                                	</c:if>
	                                        		</td>
	                                        	</tr>
	                                        </c:if>
                                        	<tr>
                                        		<td colspan="11">
                                        		    <div id="customer-page${type }"></div>
                                        		</td>
                                        	</tr>
                                        </tfoot>
                                    </table> 
                                    <table id="ordersOut" class="div_table" style="display:none;">
                                        <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>回款时间</th>
                                                <th>交易订单号</th>
                                                <th>产品名称</th>
                                                <th>姓名</th>
                                                <th>手机号</th>
                                                <th>回款金额</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(outOrders) > 0}">
                                            <c:forEach var="order" items="${outOrders}" varStatus="status">
                                            <tr <c:if test="${status.count%2==0}">class="odd"</c:if>>
                                                <td style="width:60px;">${status.count}</td>
                                                <td><fmt:formatDate value="${order.paybackTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td><c:if test="${not empty order.paybackNO }"><span data-trigger="click" data-toggle="tooltip" class="tooltip-show" data-placement="right" title="回款订单号    ：       ${order.paybackNO}">${order.orderNO}</span></c:if>
                                                	<c:if test="${empty order.paybackNO }"><span data-trigger="click" data-toggle="tooltip" class="tooltip-show" data-placement="right" title="回款订单号     ：       ${order.orderNO}">${order.orderNO}</span></c:if></td>
                                                <td><c:if test="${!empty order.product}">${order.product.name }</c:if></td>
                                                <td><c:if test="${!empty order.customer}">${order.customer.name}</c:if></td>
                                                <td>${order.customer.cellphone}</td>
                                                <td><fmt:formatNumber value="${order.paybackAmount}" pattern="#,##0.00" /></td>
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
                                        	<c:if test="${fn:length(outOrders) > 0}">
	                                            <tr>
	                                        		<td colspan="11">
	                                        		交易数:${total}笔&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;回款总金额:<fmt:formatNumber value="${totalMoney}" pattern="#,##0.00" />元
	                                        		</td>
	                                        	</tr>
                                        	</c:if>
                                        	<tr>
                                        		<td colspan="11">
                                        		    <div id="customer-page-out"></div>
                                        		</td>
                                        	</tr>
                                        	<tr></tr>
                                        </tfoot>
                                    </table>
                                    <table id="closedOrder" class="div_table" style="display:none;">
                                        <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>交易时间</th>
                                                <th>产品名称</th>
                                                <th>姓名</th>
                                                <th>手机号</th>
                                                <th>交易金额</th>
                                                <th>渠道</th>
                                                <th>支付方式</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(closedOrders) > 0}">
                                            <c:forEach var="order" items="${closedOrders}" varStatus="status">
                                            <tr <c:if test="${status.count%2==0}">class="odd"</c:if> id="customerOrder${order.orderNO}">
                                                <td style="width:60px;">${status.count}</td>
                                                <td><fmt:formatDate value="${order.orderTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td><c:if test="${!empty order.product}">${order.product.name }</c:if></td>
                                                <td><c:if test="${!empty order.user}">${order.user.name}</c:if></td>
                                                <td>${order.user.cellphone}</td>
                                                <td><fmt:formatNumber value="${order.principal}" pattern="#,##0.00" /></td>
                                                <td>${order.user.channel.name}</td>
                                                <td>
                                                	<c:if test="${order.payType == 1}">web</c:if>
                                                	<c:if test="${order.payType == 3}">android</c:if>
                                                	<c:if test="${order.payType == 2}">ios</c:if>
                                                	<c:if test="${order.payType == 4}">wap</c:if>
                                                	<c:if test="${order.payType == 5}">web-网银支付</c:if>
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
                                        	<c:if test="${fn:length(closedOrders) > 0}">
	                                        	<tr>
	                                        		<td colspan="11">
	                                        		交易数:${total}笔&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交易总金额:<fmt:formatNumber value="${totalMoney}" pattern="#,##0.00" />元
	                                        		</td>
	                                        	</tr>
	                                        </c:if>
                                        	<tr>
                                        		<td colspan="11">
                                        		    <div id="customer-page-close"></div>
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
        <div class="modal hide fade" id="orderDialog" role="dialog" >
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
			    	<div class="modal-header">
			        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        		<span aria-hidden="true">&times;</span>
			        	</button>
			        	<h4 class="modal-title" id="myModalLabel"></h4>
			      	</div>
				    <div class="modal-body">
                        <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
		                	<!-- <thead>
		                    	<tr id="head">
		                        </tr>
		                   </thead> -->
		                   <tbody id="couponBody">
                     	   </tbody>
             			</table>
		      		</div>
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
	    var rowId = 0;
	    var bankId = 0;
	    $('#areaNO').find('option[value=${areaNO}]').attr('selected',true);
	    $('#type').find('option[value=${type}]').attr('selected',true);
	    
	    $('#type').change(function() {
		    var value = $('#type').val();
		    if (value == 2) {
			    window.location.href='${pageContext.request.contextPath}/trade/abnormal/1/'+value;
		    } else {
			    window.location.href='${pageContext.request.contextPath}/trade/customer/silverfox/1/'+value;
		    }
	    });
		
		$(document).ready(function(){
			$('#areaNO').comboSelect();
			$('.marginTop').css('margin', '2px auto auto auto');
			var totalPages = '${pages}';
			var beforeDate = new Date();
			beforeDate.setTime(beforeDate.getTime()-1000*60*60*24*6);
			$('.breadcrumb').html('<li class="active">订单管理&nbsp;/&nbsp;用户订单</li>');
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
		            	var value = '${type}';
		            	if (value == 2) {
			            	$('#search').attr('action','${pageContext.request.contextPath}/trade/abnormal/'+page+'/'+value);
			                $('#search').submit();
		            	} else {
			            	$('#search').attr('action','${pageContext.request.contextPath}/trade/customer/${category}/'+page+'/${type}');
			                $('#search').submit();
		            	}
		            }  
			    };
				if ('${type}' == 1) {
					$('#customer-page-out').bootstrapPaginator(options);
				} else if ('${type}' == 2) {
					$('#customer-page-close').bootstrapPaginator(options);
				} else {
					$('#customer-page${type}').bootstrapPaginator(options);
				}
			}
			$('#fm').validationEngine('attach', { 
		        promptPosition: 'bottomRight', 
		        scroll: false 
		    }); 
			var type = '${type}';
			if (type == 1) {
				$('#ordersIn').hide();
				$('#closedOrder').hide();
				$('#ordersOut').show();
			} else if (type == 0 || type == 3){
				$('#closedOrder').hide();
				$('#ordersIn').show();
				$('#ordersOut').hide();
			}  else if (type == 2) {
				$('#closedOrder').show();
				$('#ordersIn').hide();
				$('#ordersOut').hide();
			}
			$('.horizontal').css({width:150});
			$('.horizontalType').css({width:160});
			$('td').addClass('xdsoft_date xdsoft_day_of_week2 xdsoft_date'); 
			$('#beginTime').datetimepicker({
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
					var beginTime = $('#beginTime').val();
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
					$('#beginTime').datetimepicker({
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
	    
		function resetData() { 
			$('#beginTime').val('');
			$('#endTime').val('');
			$('#amountFrom').val('');
			$('#amountTo').val('');
			$('#orderNO').val('');
			$('#productName').val('');
			$('#payType').find("option[value='${payType}']").attr("selected",false);
			$('#areaNO').val('');
			$('#name').val('');
			$('#phone').val('');
			var value = '${type}';
			if (value == 2) {
				$('#search').attr('action','${pageContext.request.contextPath}/trade/abnormal/1/'+value);
	            $('#search').submit(); 
			} else {
			    $('#search').attr('action','${pageContext.request.contextPath}/trade/customer/${category}/1/${type}');
	            $('#search').submit(); 
			}
		}
		
		function validate() {
			  /* if ($('#beginTime').val() || $('#endTime').val()) {
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
			var value = '${type}';
			if (value == 2) {
				$('#search').attr('action','${pageContext.request.contextPath}/trade/abnormal/1/'+value);
	            $('#search').submit(); 
			} else {
				$('#search').attr('action','${pageContext.request.contextPath}/trade/customer/${category}/1/${type}');
	            $('#search').submit(); 
			}
		}
		
		function exportOrders() {
			var count = 50000;
			if($.trim('${total}') > 0){
				if($.trim('${total}') <= count){
					$('#search').attr('action','${pageContext.request.contextPath}/trade/customer/export/${category}/${type}');
		            $('#search').submit(); 
				}else{
					alert('查询结果集超过Excel导出最大限制 '+ count +' 条,请精确查询条件!');	
				}
			}else{
				alert('没有查询，或查询结果为空，不用导出!');
			}
			
		}

		function orderList(value) {
			window.location.href='${pageContext.request.contextPath}/trade/customer/silverfox/1/'+value;
		}
		
		function vaildIntegerNumber(evnt){
			 evnt=evnt||window.event;
			 var keyCode=window.event?evnt.keyCode:evnt.which;
			 return keyCode>=48&&keyCode<=57||keyCode==8;
		}
		
		function getRow(tr, color, id) {
			if (rowId == tr.getElementsByTagName('td')[2].innerHTML) {
				$(tr).css('background-color', 'white');
				rowId = 0;
			} else {
				$('#customerOrder'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName("td")[2].innerHTML;
			}
			bankId = id;
	    }
		
		function checkBank(){
			if(rowId){
				$.get('${pageContext.request.contextPath}/trade/customer/check/bank',{bankId:$.trim(bankId)},function(result){
					if(result.result.split(',')[0] == 1){
						alert('更新银行卡信息成功!,原卡银行:'+result.result.split(',')[1]+',更新后银行: '+result.result.split(',')[2]);
					}else if(result.result.split(',')[0] == 2){
						alert("银行卡信息一致不用更新!");
					}else{
						alert("更新银行卡信息失败!");
					}
				})
			}else{
				alert("请先选择一条要[检查/更新]银行卡信息的订单");
			}
		}
		
		function getOrderDetail(orderNO){
			$('#orderDialog').modal('show');
			$('#head').html("");
    	  	$.get('${pageContext.request.contextPath}/trade/customer/order/detail.json',{orderNO:orderNO},function(data){
				if (data != null && data.order != null) {
					var result = data.order
				   var createTime = new Date(result.createTime);
				   var orderTime = new Date(result.orderTime)
				   $('#myModalLabel').empty().html('订单详细信息');
				   $('#couponBody').html("");
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td width="120">交易创建时间</td>');
		    	   $('#couponBody').append('<td>'+createTime.format('yyyy-MM-dd HH:mm:ss')+'</td>');
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>交易成功时间</td>');
		    	   $('#couponBody').append('<td>'+orderTime.format('yyyy-MM-dd HH:mm:ss')+'</td>');
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>订单号</td>');
		    	   $('#couponBody').append('<td>'+result.orderNO+'</td>');
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>产品名称</td>');
		    	   $('#couponBody').append('<td>'+result.product.name+'</td>');
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>姓名</td>');
		    	   $('#couponBody').append('<td>'+result.customer.name+' </td>');
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>手机号</td>');
		    	   if(result.customer != '' && result.customer.cellphone != ''){
		    		   $('#couponBody').append('<td>'+result.customer.cellphone+' </td>');
		    	   }else{
		    		   $('#couponBody').append('<td></td>'); 
		    	   }
		    	  
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>购买金额</td>');
		    	   $('#couponBody').append('<td>'+result.principal+'</td>');
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>支付方式</td>');
		    	   if(result.payType < 5 && result.bank != null){
		    		   $('#couponBody').append('<td>'+result.bank.bankName+'  尾号 :'+result.bank.cardNO.substr(result.bank.cardNO.length-4)+'</td>');
		    	   }else{
		    		   $('#couponBody').append('<td>'+'网银支付'+'</td>');
		    	   }
		    	  
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>优惠券</td>');
		    	   if(result.interestPeriod > 0){
		    		   $('#couponBody').append('<td>加息'+result.couponAmount+'%'+result.interestPeriod+'天</td>');
		    	   }else if(result.interestPeriod < 1 && 0 < result.couponAmount){
		    		   $('#couponBody').append('<td> ¥'+result.couponAmount+'</td>');
		    	   }else{
		    		   $('#couponBody').append('<td>无</td>'); 
		    	   }
		    	   
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>渠道</td>');
		    	   if(result.customer != null && result.customer.channel != null){
		    		   if(result.customer.channel.name != null){
		    			   $('#couponBody').append('<td>'+result.customer.channel.name+'</td>');
		    		   }else{
		    			   $('#couponBody').append('<td></td>'); 
		    		   }
		    	   }else{
		    		   $('#couponBody').append('<td></td>');
		    	   }
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>交易平台</td>');
		    	   if(result.payType == 1 || result.payType == 5){
		    		   $('#couponBody').append('<td>'+'web'+'</td>');
		    	   }else if(result.payType == 2){
		    		   $('#couponBody').append('<td>'+'ios'+'</td>');
		    	   }else if(result.payType == 3){
		    		   $('#couponBody').append('<td>'+'android'+'</td>');
		    	   }else if(result.payType == 4){
		    		   $('#couponBody').append('<td>'+'wap'+'</td>');
		    	   }else{
		    		   $('#couponBody').append('<td></td>');
		    	   }
		    	   $('#couponBody').append('</tr>');
		    	   $('#couponBody').append('<tr>');
		    	   $('#couponBody').append('<td>交易耗时</td>');
		    	   $('#couponBody').append('<td>'+((orderTime.getTime() - createTime.getTime()) / 1000)+'秒</td>');
		    	   $('#couponBody').append('</tr>');
		    	   
		       }else{
		    	   $('#couponBody').html('<tr><td colspan="2">未查到订单详情</td></tr>');	
		       }
           });
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>