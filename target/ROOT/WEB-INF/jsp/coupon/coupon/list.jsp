<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<c:import url="/header" />
	<body>
		<c:import url="/menu"></c:import>
        <div class="container-fluid">
            <div class="row-fluid">
              <c:import url="/sidebar"></c:import>
                <div class="span10" id="content">
                    <div class="row-fluid">
	                	<div class="span12" id="content">
	                	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
	                	<div class="well">
	                		<form id="search" action="${pageContext.request.contextPath}/coupon/coupon/list" method="post">
	                    		<input type="hidden" id="size" name="size" value="${size}" />
	                    		<input type="hidden" id="page" name="page" value="${page}" />
	                      		<div class="input-group" style="height:10px;">
	                      			<span>券码类型</span>
									<select id="type"  name="type" class="validate[required] span2" onchange="javascript:changeSubmit();">
                               			<option value="1" <c:if test="${type ==1 }"> selected="selected"</c:if> >红包</option>
                               			<option value="2" <c:if test="${type ==2  }"> selected="selected"</c:if>>加息券</option>
									</select>
                                  </div>
	                    	</form>
				         </div>
                    	<div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                            	<a id="470" class="btn btn-lg btn-success" href="javascript:add()"> 新增 </a>
                            	<a id="471" href="javascript:detail()"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                            	<a id="472" href="javascript:edit()"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <c:if test="${ type == 1 }"> 
	                                    <table id="bonus" class="div_table"  class="table">
	                                         <thead>
	                                            <tr align="center">
		                                            <th style="text-align:center">序号</th>
		                                            <th style="text-align:center">金额</th>
		                                            <th style="text-align:center">类型</th>
		                                            <th style="text-align:center">投资金额</th>
		                                            <th style="text-align:center">理财期限</th>
		                                         	<th style="text-align:center" >备注</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        <c:choose>
	                                          <c:when test="${fn:length(coupons) > 0}">
	                                            <c:forEach var="coupon" items="${coupons}" varStatus="status">
	                                            <tr onclick="getRow(this, '#BFBFBF')" id="couponId${coupon.id}">
	                                                <td class="hiddenid">${coupon.id}</td>
	                                                <td class="hiddenid">${coupon.status}</td>
	                                                <td class="hiddenid">${coupon.category}</td>
	                                               
	                                                <td style="text-align:center">${status.count}</td>
	                                                <td style="text-align:center">${coupon.amount}</td>
	                                                <td style="text-align:center">
	                                                	<c:forEach items="${categorys}" var="ca">
	                                                		<c:if test="${ca.key == coupon.category}">${ca.value}</c:if>
	                                                	</c:forEach>
	                                                </td>
	                                                <td style="text-align:center">
	                                                	<c:if test="${coupon.moneyLimit == 0 }">不限</c:if>
	                                                	<c:if test="${coupon.moneyLimit == 1 }">单笔满${coupon.tradeAmount}元可用</c:if>
	                                                	<c:if test="${coupon.moneyLimit == 2 }">累计满${coupon.tradeAmount}元可用</c:if>
	                                                </td>
	                                                <td style="text-align:center"><c:if test="${coupon.financePeriod == 0}">不限</c:if><c:if test="${coupon.financePeriod != 0}">${coupon.financePeriod}</c:if></td>  
	                                           		<td style="text-align:center">
	                                           			<c:if test="${not empty coupon.remark && fn:length(coupon.remark) > 10}">
	                                           				<span data-trigger="mousemove" data-toggle="tooltip" class="tooltip-show" data-placement="left" title="备注 : ${coupon.remark}">${fn:substring(coupon.remark, 0, 10)}</span>
	                                           			</c:if>
	                                           			<c:if test="${not empty coupon.remark && fn:length(coupon.remark) <= 10}">
	                                           				${coupon.remark}
	                                           			</c:if>
	                                           		</td>
	                                            </tr>
	                                            </c:forEach>
	                                          </c:when>
	                                          <c:otherwise>
	                                        	<tr>
	                                                <td colspan="12">暂时还没有红包信息</td>
	                                            </tr>  
	                                          </c:otherwise>
	                                        </c:choose>
	                                        </tbody>
	                                        <tfoot>
	                                            <tr>
	                                       		    <td colspan="12"><div id="coupon-page1"></div></td>
	                                          	</tr>
	                                        </tfoot>
	                                    </table>
	                                   </c:if>
	                                   <c:if test="${ type == 2 }">
	                                    <table id="coupon" class="div_table" class="table">
	                                         <thead>
	                                            <tr align="center">
		                                            <th style="text-align:center">序号</th>
		                                            <th style="text-align:center">加息券收益</th>
		                                            <th style="text-align:center">加息天数</th>
		                                            <th style="text-align:center" >需投资金额</th>
		                                            <th style="text-align:center" >备注</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        <c:choose>
	                                          <c:when test="${fn:length(coupons) > 0}">
	                                            <c:forEach var="coupon" items="${coupons}" varStatus="status">
	                                            <tr onclick="getRow(this, '#BFBFBF')" id="couponId${coupon.id}">
	                                                <td class="hiddenid">${coupon.id}</td>
	                                                <td class="hiddenid">${coupon.status}</td>
	                                                <td class="hiddenid">${coupon.category}</td>
	                                                <td style="text-align:center">${status.count}</td>
	                                                <td style="text-align:center"><fmt:formatNumber value="${coupon.amount}" pattern="#,##0.00" />%</td> 
	                                                <td style="text-align:center">${coupon.increaseDays} </td>
	                                                 <td style="text-align:center">
	                                                	<c:if test="${coupon.moneyLimit == 0 }">不限</c:if>
	                                                	<c:if test="${coupon.moneyLimit == 1 }">单笔满${coupon.tradeAmount}元可用</c:if>
	                                                	<c:if test="${coupon.moneyLimit == 2 }">累计满${coupon.tradeAmount}元可用</c:if>
	                                                </td>
	                                            	<td style="text-align:center">
	                                           			<c:if test="${not empty coupon.remark && fn:length(coupon.remark) > 10}">
	                                           				<span data-trigger="mousemove" data-toggle="tooltip" class="tooltip-show" data-placement="right" title="备注 :${coupon.remark}">${fn:substring(coupon.remark, 0, 10)}...</span>
	                                           			</c:if>
	                                           			<c:if test="${not empty coupon.remark && fn:length(coupon.remark) <= 10}">
	                                           				${coupon.remark}
	                                           			</c:if>
	                                           		</td>
	                                            </tr>
	                                            </c:forEach>
	                                          </c:when>
	                                          <c:otherwise>
	                                        	<tr>
	                                                <td colspan="12">暂时还没有加息券信息</td>
	                                            </tr>  
	                                          </c:otherwise>
	                                        </c:choose>
	                                        </tbody>
	                                        <tfoot>
	                                            <tr>
	                                       		    <td colspan="12"><div id="coupon-page2"></div></td>
	                                          	</tr>
	                                        </tfoot>
	                                    </table>
	                                 </c:if>
                                </div>
                            </div>
                        </div>		
                    </div>
                </div>
                <div class="modal hide fade" id="authorizationDiv" role="dialog" style="margin-top: 200px">
					<form id="fmg" class="modal-content form-horizontal password-modal" >
					    <input type="hidden" id="customer" name="customer" value="${sessionsilverfoxkey.admin.id}">
				        <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					        <h4 class="modal-title">审核意见</h4>
				        </div>
				      	<div class="modal-body">
				      		请确认审核结果！
					        <div class="modal-footer">
					        	<button type="button" class="btn btn-primary" onclick="setStatus(2)">通过</button>
					        	<button type="button" class="btn btn-default" onclick="setStatus(1)">不通过</button>
					        </div>
				    	</div>
					</form>		   
				</div>
            </div>
        </div>
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
		var rowId = 0;
		var initStatus = -1;
		var category = '';
		$(function() {
			$('td.hiddenid').hide();
			$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;券码库</li>');
			var totalPages = '${pages}';
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/coupon/list');
		            	$('#page').val(page);
		                $('#search').submit();
		            }  
			    };
				$('#coupon-page${type}').bootstrapPaginator(options);
			}
			 
			$('#471').hide();
			$('#472').hide();
			$('#474').hide();
			$('#475').hide();
		})
		function search(){
			$('#search').attr('action','${pageContext.request.contextPath}/coupon/coupon/list');
            $('#search').submit(); 
		}
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#471').hide();
				$('#472').hide();
				$('#474').hide();
				$('#475').hide();
				rowId = 0;
			}else{
				$('#couponId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				initStatus = tr.getElementsByTagName('td')[1].innerHTML;
				category = tr.getElementsByTagName('td')[2].innerHTML;
				buttonShowOrHide();
			}
		}
		function buttonShowOrHide(){
			var obj = document.getElementById("470");
			if(obj.style.visibility == 'hidden'){
				$('#470').hide();
			}else{
				$('#470').show();
			}
			$('#471').show();
			$('#472').hide();
			$('#474').hide();
			$('#475').hide();
			if(initStatus == 0){
				$('#472').show();
				$('#474').show();
			}
			if(initStatus == 1){
				$('#475').show();
			}
		}
		function detail(){
			if(rowId > 0){
				var type = $('#type').val();
				window.location.href = '${pageContext.request.contextPath}/coupon/coupon/detail/'+rowId+'/'+type;
			}else{
				alert('请先选择一条记录！');
			}
		}
		function edit(){
			if(rowId > 0){
				var type = $('#type').val();
				window.location.href = '${pageContext.request.contextPath}/coupon/coupon/edit/'+rowId+'/'+type;
			}else{
				alert('请先选择一条记录！');
			}
		}
		function add(){
			var type = $('#type').val();
			window.location.href = '${pageContext.request.contextPath}/coupon/coupon/add/'+type;
		}
		function exchangeRecord(){
			if(rowId > 0){
				if(category == 3){
					window.location.href='${pageContext.request.contextPath}/coupon/bonus/voucher/exchange/record/'+rowId;
				}else if(category == 5){
					window.location.href='${pageContext.request.contextPath}/coupon/coupon/voucher/exchange/record/'+rowId;
				}else{
					alert('没有兑换记录!');
				}
			}else{
				alert('请先选择一条记录！');
			}	
		}
		
		function setStatus(status){
			if(rowId > 0){
				if(initStatus > 1){
					if (confirm('要确认本次修改吗?')) {
						if (status == 3) {
							$.post('${pageContext.request.contextPath}/coupon/can/disable',{couponId:rowId},function(result){
								if (result == true) {
									$.getJSON('${pageContext.request.contextPath}/coupon/bonus/status', {bonusId:rowId, status:status, initStatus: initStatus},function(result){
									   if(!result){
										   alert('更新失败，红包状态已被更改!');
									   }else{
										   $('#search').attr('action','${pageContext.request.contextPath}/coupon/coupon/list');
							               $('#search').submit();
									   }
									}); 
								} else {
									alert('此优惠劵已被渠道、返利活动或银子商城关联，不能禁用');
								}
							});
						} else {
							$.getJSON('${pageContext.request.contextPath}/coupon/bonus/status', {bonusId:rowId, status:status, initStatus: initStatus},function(result){
							   if(!result){
								   var type = $('#type').val();
								   if (type == 1) {
									   alert('更新失败，红包状态已被更改!');
								   } else {
									   alert('更新失败，加息券状态已被更改!');
								   }
							   }else{
								   $('#search').attr('action','${pageContext.request.contextPath}/coupon/coupon/list');
					               $('#search').submit();
							   }
							}); 
						}
					}
				}else{
					$.getJSON('${pageContext.request.contextPath}/coupon/bonus/status', {bonusId:rowId, status:status, initStatus: initStatus},function(result){
					   if(!result){
						   var type = $('#type').val();
						   if (type == 1) {
							   alert('更新失败，红包状态已被更改!');
						   } else {
							   alert('更新失败，加息券状态已被更改!');
						   }
					   }else{
						   $('#search').attr('action','${pageContext.request.contextPath}/coupon/coupon/list');
			               $('#search').submit();
					   }
					});
				}
			}else{
				alert('请先选择一条记录！');
			}	
		}
		function changeSubmit(){
			$('#page').val('');
			$('#search').submit(); 
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>