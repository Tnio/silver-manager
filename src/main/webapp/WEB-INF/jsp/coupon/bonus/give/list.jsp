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
	                	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                		<form id="search" action="${pageContext.request.contextPath}/coupon/bonus/give/list" method="post" style="margin:-10px auto auto auto">
	                		<input type="hidden" id="size" name="size" value="${size}" />
	                		<input type="hidden" id="page" name="page" value="${page}" />
                    	</form>
	                    <div class="row-fluid">
	                    	<div class="block">
	                    		<div id="authorityButton" class="navbar navbar-inner block-header">
	                                <a id="490" class="btn btn-lg btn-success" href="${pageContext.request.contextPath}/coupon/bonus/give/add"> 新增 </a>
	                                <a id="491" href="javascript:detail()"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
	                            	<a id="492" href="javascript:edit()"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
	                            	<a id="493" href="javascript:audit()"><button class="btn btn-lg btn-primary" >审核<i class=""></i></button></a>
	                            	<a id="494" href="javascript:record()"><button class="btn btn-lg btn-primary" >查看明细<i class=""></i></button></a>
	                            </div>
	                            <div class="block-content collapse in">   
	                                <div class="span12">
	                                    <table id="coupon" cellpadding="0" cellspacing="0" border="0" class="table">
	                                         <thead>
	                                            <tr align="center">
		                                            <th>序号</th>
		                                            <th>赠送日期</th>
		                                            <th>优惠券</th>
		                                            <th>用户数量</th>
		                                            <th>原因</th>
		                                            <th>状态</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        <c:choose>
	                                          <c:when test="${fn:length(dispatchingBonusLogs) > 0}">
	                                            <c:forEach var="dispatchingBonusLog" items="${dispatchingBonusLogs}" varStatus="status">
	                                            <tr onclick="getRow(this, '#BFBFBF')" id="dispatchingBonusLogId${dispatchingBonusLog.id}">
	                                                <td class="hiddenid">${dispatchingBonusLog.id}</td>
	                                                <td class="hiddenid">${dispatchingBonusLog.status}</td>
	                                                <td>${status.count}</td>
	                                                <td>${dispatchingBonusLog.giveDate}</td>
	                                                <td class="numbercss">
	                                                	<c:choose>
			                                          		<c:when test="${fn:length(fn:split(dispatchingBonusLog.couponAmounts,',')) > 0}">
			                                            		<c:forEach var="coupons" items="${fn:split(dispatchingBonusLog.couponAmounts,',')}" varStatus="statuss">
			                                            			<c:forEach var="couponId" items="${fn:split(dispatchingBonusLog.couponIds,',')}" varStatus="statuses">
			                                            				<c:if test="${statuss.index == statuses.index}">
					                                            			<a href="javascript:showDialog(${couponId});"><span class="label btn-danger" style="height:22px;width:75px;margin-top: 1px;padding-top: 8px" >${coupons}</span></a>
			                                            				</c:if>
			                                            			</c:forEach>
			                                            		</c:forEach>
	                                          				</c:when>
	                                          			</c:choose>
	                                                </td>
	                                                <td>${dispatchingBonusLog.userNum}</td>
	                                                <td>
	                                                	<c:if test="${not empty dispatchingBonusLog.reason && fn:length(dispatchingBonusLog.reason) > 10}">
	                                           				<span data-trigger="mousemove" data-toggle="tooltip" class="tooltip-show" data-placement="left" title="原因 : ${dispatchingBonusLog.reason}">${fn:substring(dispatchingBonusLog.reason, 0, 10)}</span>
	                                           			</c:if>
	                                           			<c:if test="${not empty dispatchingBonusLog.reason && fn:length(dispatchingBonusLog.reason) <= 10}">
	                                           				${dispatchingBonusLog.reason}
	                                           			</c:if>
	                                                </td>
	                                                <td><c:if test="${dispatchingBonusLog.status == 0}">待审核</c:if><c:if test="${dispatchingBonusLog.status == 1}">审核不通过</c:if><c:if test="${dispatchingBonusLog.status == 2}">审核通过</c:if></td>
	                                            </tr>
	                                            </c:forEach>
	                                          </c:when>
	                                          <c:otherwise>
	                                        	<tr>
	                                                <td colspan="7">暂时还没有优惠券赠送列表</td>
	                                            </tr>  
	                                          </c:otherwise>
	                                        </c:choose>
	                                        </tbody>
	                                        <tfoot>
	                                            <tr>
	                                       		    <td colspan="7"><div id="coupon-page"></div></td>
	                                          	</tr>
	                                        </tfoot>
	                                    </table>
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
					<div class="modal hide fade" id="couponDialog" role="dialog" >
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
		        </div>
        	</div>
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
		var rowId = 0;
		var initStatus = -1;
		$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;优惠券赠送管理</li>');
		$(".liq").css({'width':'100px','display':'block','overflow':'hidden','word-break':'keep-all','white-space':'nowrap','text-overflow':'ellipsis'});
		$(function() {
			$('td.hiddenid').hide();
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/give/list');
		            	$('#page').val(page);
		                $('#search').submit();
		            }  
			    };
				$('#coupon-page').bootstrapPaginator(options);
			}
			
			$('#491').hide();
			$('#492').hide();
			$('#493').hide();
			$('#496').hide();
			
			$('.numbercss').css({width:400});
		})
	
		function search(){
			$('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/give/list');
            $('#search').submit(); 
		}
		
		$('#491').hide();
		$('#496').hide();
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#491').hide();
				$('#492').hide();
				$('#493').hide();
				$('#496').hide();
				rowId = 0;
			}else{
				$('#dispatchingBonusLogId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				initStatus = tr.getElementsByTagName('td')[1].innerHTML;
				buttonShowOrHide();
			}
		}
		
		function buttonShowOrHide(){
			$('#491').show();
			if(initStatus == 0){
				$('#492').show();
				$('#493').show();
			}
			if(initStatus == 1){
				$('#492').show();
				$('#493').hide();
			}
			if (initStatus == 2) {
				$('#492').hide();
				$('#493').hide();
				$('#496').show();
			} else if (initStatus == 3) {
				$('#492').hide();
				$('#493').hide();
				$('#496').show();
			}
		}
		
		function detail(){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/coupon/bonus/give/detail/'+rowId;
			}else{
				alert('请先选择一条记录！');
			}
		}
		
		function edit(){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/coupon/bonus/give/edit/'+rowId;
			}else{
				alert('请先选择一条记录！');
			}
		}
		
		function audit(){
			if(rowId > 0){
				$('#authorizationDiv').modal('show');
			}else{
				alert('请先选择一条记录！');
			}
			
		}
		
		function record(){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/coupon/bonus/give/record/'+rowId;
			}else{
				alert('请先选择一条记录！');
			}
		}
		
		function setStatus(status){
			if(rowId > 0){
				$.get('${pageContext.request.contextPath}/coupon/dispatching/log/'+rowId, function(data){
					if (data && data.status == initStatus) {
						$('#authorizationDiv').modal('show');
						if(status == 2){
							$.post('${pageContext.request.contextPath}/coupon/give/user/'+rowId, function(result){
							    if (result) {
							    	$('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/give/list');
					                $('#search').submit();
							    } else {
							    	alert('赠送失败,请先确认是否有可赠送用户!');
							    }
				            });
						}else{
							$.getJSON('${pageContext.request.contextPath}/coupon/bonus/give/status', {dispatchingBonusLogId:rowId, status:status, initStatus: initStatus},function(result){
								if(!result){
									alert('更新失败，数据状态已被更改!');
							   	}else{
								    $('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/give/list');
					                $('#search').submit();
							   	}
							});
						}
				    } else {
				    	alert('该优惠券赠送信息的状态已发生改变，不能再进行此操作');
				    }
	            });
			}else{
				alert('请先选择一条记录！');
			}	
		}
		
		function showDialog(couponId){
	    	$('#couponDialog').modal('show');
			getCoupon(couponId);
		}
		
		function getCoupon(couponId){
			$('#head').html("");
    	  	$.get('${pageContext.request.contextPath}/coupon/coupon/detail',{couponId:couponId} , function(result){
				if (result != null) {
				   $('#myModalLabel').empty().html('优惠券信息');
				   if(result.category < 4){
					   $('#couponBody').html("");
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td width="80">使用条件</td>');
			    	   $('#couponBody').append('<td>'+result.condition+'</td>');
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>红包类型</td>');
			    	   if(result.category == 0){
			    		   $('#couponBody').append('<td>'+'固定红包'+'</td>');
			    	   }
			    	   if(result.category == 1){
			    		   $('#couponBody').append('<td>'+'概率红包'+'</td>');
			    	   }
			    	   if(result.category == 4){
			    		   $('#couponBody').append('<td>'+'加息券'+'</td>');
			    	   }
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>红包金额</td>');
			    	   $('#couponBody').append('<td>'+result.amount+'元</td>');
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>可否转赠</td>');
			    	   if (result.donation == 0) {
				    	   $('#couponBody').append('<td>不可转赠</td>');
			    	   	} else {
				    	   $('#couponBody').append('<td>可转赠</td>');
			    	   	}
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>有效期限</td>');
			    	   if(result.lifeCycle == 0){
			    		   $('#couponBody').append('<td>'+'一万年有效'+'</td>');
			    	   }
					   if(result.lifeCycle == 1){
						   $('#couponBody').append('<td>'+result.expiresPoint+'到期</td>');			    		   
					   }
					   if(result.lifeCycle == 2){
						   $('#couponBody').append('<td>'+'自领取后'+result.expiresPoint+'天</td>');  
					   }
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>投资金额</td>');
			    	   if(result.moneyLimit == 0){
			    		   $('#couponBody').append('<td>'+'不限制 </td>');
			    	   }
			    	   if(result.moneyLimit == 1){
			    		   $('#couponBody').append('<td>单笔满'+result.tradeAmount+'元可用 </td>');
			    	   }
			    	   if(result.moneyLimit == 2){
			    		   $('#couponBody').append('<td>累计满'+result.tradeAmount+'元可用 </td>');
			    	   }
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>理财期限</td>');
			    	   if(result.financePeriod == 0){
			    		   $('#couponBody').append('<td>'+'不限制 </td>');
			    	   }else{
			    		   $('#couponBody').append('<td>'+result.financePeriod+'天及以上 </td>');
			    	   }
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>备注</td>');
			    	   $('#couponBody').append('<td>'+result.remark+'</td>');
			    	   $('#couponBody').append('</tr>'); 
				   }else{
					   $('#couponBody').html("");
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td width="80">使用条件</td>');
			    	   $('#couponBody').append('<td>'+result.condition+'</td>');
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>加息券收益</td>');
			    	   $('#couponBody').append('<td>'+result.amount+'%</td>');
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>加息天数</td>');
			    	   $('#couponBody').append('<td>'+result.increaseDays+'天</td>');
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>可否转赠</td>');
			    	   if (result.donation == 0) {
				    	   $('#couponBody').append('<td>不可转赠</td>');
			    	   	} else {
				    	   $('#couponBody').append('<td>可转赠</td>');
			    	   	}
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>有效期限</td>');
			    	   if(result.lifeCycle == 0){
			    		   $('#couponBody').append('<td>'+'一万年有效'+'</td>');
			    	   }
					   if(result.lifeCycle == 1){
						   $('#couponBody').append('<td>'+result.expiresPoint+'到期</td>');			    		   
					   }
					   if(result.lifeCycle == 2){
						   $('#couponBody').append('<td>'+'自领取后'+result.expiresPoint+'天</td>');  
					   }
			    	   $('#couponBody').append('</tr>'); 
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>投资金额</td>');
			    	   if(result.moneyLimit == 0){
			    		   $('#couponBody').append('<td>'+'不限制 </td>');
			    	   }
			    	   if(result.moneyLimit == 1){
			    		   $('#couponBody').append('<td>单笔满'+result.tradeAmount+'元可用 </td>');
			    	   }
			    	   if(result.moneyLimit == 2){
			    		   $('#couponBody').append('<td>累计满'+result.tradeAmount+'元可用 </td>');
			    	   }
			    	   $('#couponBody').append('</tr>');
			    	   $('#couponBody').append('<tr>');
			    	   $('#couponBody').append('<td>备注</td>');
			    	   $('#couponBody').append('<td>'+result.remark+'</td>');
			    	   $('#couponBody').append('</tr>'); 
				   }
		       }else{
		    	   $('#couponBody').html('<tr><td colspan="2">请先添加优惠券</td></tr>');	
		       }
           });
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>