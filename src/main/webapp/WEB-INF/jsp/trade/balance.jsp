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
                    	<form id="search" action="${pageContext.request.contextPath}/trade/balance/order/${type}/${page}" method="post">
                            <div class="input-group">
                  					<span>交易类型</span>
                  					<select id="type" name="type" class="horizontalType marginTop">
                                		<option value="1">充值订单</option>
                           				<option value="2">提现订单</option>
								    </select>
                        			<div style="margin:15px auto auto auto">
	                         			<span>开始时间</span>
	                         			<input type="text" id="startDate" name="startDate" style="background:white;" value="${startDate}" class="horizontal marginTop" onkeypress="return false"/>
	                             		<span>结束时间</span>
	                             		<input type="text" id="endDate" name="endDate" style="background:white;" value="${endDate}" class="horizontal marginTop" onkeypress="return false"/>
	                             		<span id="payTypeSpan">充值渠道</span>
	                             		<select class="marginTop" id="method" name="method" style="width: 163px">
											<option value="-1">全部</option>
											<option value="0">快捷充值</option>
											<option value="1">线下充值</option>
										</select>
                            		</div>
                            		<div style="margin:15px auto auto auto">
	                         			<span>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</span>
	                                 	<input type="text" id="userName" name="userName" value="${userName}" class="horizontal marginTop"/>
	                             		<span>手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机</span>
	                                 	<input type="text" id="cellphone" name="cellphone" value="${cellphone}" class="horizontal marginTop"/>
	                           			<a href="javascript:search();"><button type="button" class="btn">查询</button></a>
	                           			<a href="javascript:resetData();"><button type="button" class="btn">重置</button></a>
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
                                    <table class="div_table">
                                        <thead>
                                            <tr>
                                             <c:if test="${type == 1 }">
                                                <th>序号</th>
                                                <th>充值时间</th>
                                                <th>充值金额</th>
                                                <th>充值渠道</th>
                                                <th>姓名</th>
                                                <th>手机号</th>
                                             </c:if>
                                             <c:if test="${type == 2 }">
                                                <th>序号</th>
                                                <th>提现时间</th>
                                                <th>姓名</th>
                                                <th>手机号</th>
                                                <th>提现金额</th>
                                                <th>用户手续费（元）</th>
                                                <th>交易渠道</th>
                                             </c:if>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(orders) > 0}">
                                            <c:forEach var="order" items="${orders}" varStatus="status">
                                            <tr>
                                                <td style="width:30px;">${status.count}</td>
                                                <td><fmt:formatDate value="${order.tradeTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <c:if test="${type == 1 }">
                                                	<td><fmt:formatNumber value="${order.amount}" pattern="#,##0.00" /></td>
                                                	<td>
	                                                	<c:if test="${order.method == 0}">快捷充值</c:if>
	                                                	<c:if test="${order.method == 1}">线下充值</c:if>
	                                               </td>
                                                	<td><c:if test="${not empty order.user }">${order.user.name }</c:if></td>
                                                	<td><c:if test="${not empty order.user }">${order.user.cellphone }</c:if></td>
                                                </c:if>
                                                <c:if test="${type == 2 }">
                                                	<td><c:if test="${not empty order.user }">${order.user.name }</c:if></td>
                                                	<td><c:if test="${not empty order.user }">${order.user.cellphone }</c:if></td>
                                                	<td><fmt:formatNumber value="${0-order.amount}" pattern="#,##0.00" /></td>
                                                	<td>${order.fee}</td>
                                                	<td>
	                                                	<c:if test="${order.channel == 1}">网站</c:if>
	                                                	<c:if test="${order.channel == 2}">iOS</c:if>
	                                                	<c:if test="${order.channel == 3}">android</c:if>
	                                                	<c:if test="${order.channel == 4}">微信</c:if>
	                                               </td>
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
	                                        	<tr>
	                                        		<td colspan="11">
	                                        		交易数:${total}笔
	                                        		<c:if test="${type == 1 }">
		                                        		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交易总金额:<fmt:formatNumber value="${amount}" pattern="#,##0.00" />元
	                                        		</c:if>
	                                        		<c:if test="${type == 2 }">
		                                        		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交易总金额:<fmt:formatNumber value="${0-amount}" pattern="#,##0.00" />元
	                                        		</c:if>
													<c:if test="${type == 2}">
		                                        		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手续费:<fmt:formatNumber value="${0-fee}" pattern="#,##0.00" />元
													</c:if>
	                                        		</td>
	                                        	</tr>
                                        	<tr>
                                        		<td colspan="11">
                                        		    <div id="balance-page"></div>
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
			$("[data-toggle='tooltip']").tooltip(); 
		});
		$('#type').find("option[value='${type}']").attr('selected',true);
		$('#method').find("option[value='${method}']").attr('selected',true);
		var type = '${type}';
	    if (type == 1) {
	    	$('#payTypeSpan').show();
	    	$('#method').show();
	    } else {
	    	$('#payTypeSpan').hide();
	    	$('#method').hide();
	    }
		$('#type').change(function() {
		    var value = $('#type').val();
			window.location.href='${pageContext.request.contextPath}/trade/balance/order/'+value+'/1';
	    });
		$(document).ready(function(){
			$('.marginTop').css('margin', '2px auto auto auto');
			var totalPages = '${pages}';
			var beforeDate = new Date();
			beforeDate.setTime(beforeDate.getTime()-1000*60*60*24*6);
			$('.breadcrumb').html('<li class="active">订单管理&nbsp;/&nbsp;充值提现</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/trade/balance/order/${type}/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#balance-page').bootstrapPaginator(options);
			}
			$('#fm').validationEngine('attach', { 
		        promptPosition: 'bottomRight', 
		        scroll: false 
		    }); 
			
			$('#startDate').datetimepicker({
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
					var beginTime = $('#startDate').val();
					var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
					var afterDate = new Date();
					afterDate.setTime(beginDate.getTime()+1000*60*60*24*6);
					$('#endDate').datetimepicker({
						format:'Y-m-d',
						minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
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
			
			$('#endDate').datetimepicker({
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
					var endTime = $('#endDate').val();
					var endDate = new Date(Date.parse(endTime.replace(/-/g,"/")));
					beforeDate.setTime(endDate.getTime()-1000*60*60*24*6);
					$('#startDate').datetimepicker({
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
		function search() {
			$('#search').attr('action','${pageContext.request.contextPath}/trade/balance/order/${type}/1');
            $('#search').submit();
		}
		function resetData() { 
			$('#startDate').val('');
			$('#endDate').val('');
			$('#productName').val('');
			$('#method').find("option[value='-1']").attr("selected", true);
			$('#userName').val('');
			$('#cellphone').val('');
			search();
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>