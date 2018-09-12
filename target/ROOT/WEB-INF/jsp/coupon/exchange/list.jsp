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
                    	<div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                            	<a id="560" class="btn btn-lg btn-success" href="${pageContext.request.contextPath}/coupon/exchange/add"> 新增 </a>
                            	<a id="561" href="javascript:detail()"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                            	<a id="562" href="javascript:edit()"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                            	<a id="563" href="javascript:audit()"><button class="btn btn-lg btn-primary" >审核<i class=""></i></button></a>
                            	<a id="564" href="javascript:codesDetail()"><button class="btn btn-lg btn-primary">查看明细<i class=""></i></button></a>
                            	<a id="565" href="javascript:exportCodes()"><button class="btn btn-lg btn-primary" >导出<i class=""></i></button></a>     
                            </div>
                            <form id="search" action="${pageContext.request.contextPath}/coupon/exchange/list" method="post">
		                   		<input type="hidden" id="size" name="size" value="${size}" />
		                   		<input type="hidden" id="page" name="page" value="${page}" />
		                   		<input type="hidden" id="couponExchangeId" name="couponExchangeId" value="0" />
		                   		
                            </form> 
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="coupon" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr align="center">
	                                            <th>序号</th>
	                                            <th>兑换日期</th>
	                                            <th>优惠券</th>
	                                            <th>兑换数量</th>
	                                            <th>兑换码</th>
	                                            <th>状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(exchanges) > 0}">
                                            <c:forEach var="exchange" items="${exchanges}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="exchangeId${exchange.id}">
                                                <td class="hiddenid">${exchange.id}</td>
                                                <td class="hiddenid">${exchange.status}</td>
                                                <td class="hiddenid">${exchange.makeMode}</td>
                                                <td>${status.count}</td>
                                                <td>${exchange.beginTime}至${exchange.endTime}</td>
                                                <td>
                                                	<c:if test="${exchange.coupon.category <= 3}">
                                                		<a href="javascript:showDialog(${exchange.coupon.id})"><span class="label label-important" style="height:22px;width:80px;margin-top: 1px;padding-top: 8px" >${exchange.coupon.amount} 元</span></a>
                                                	</c:if>
                                                	<c:if test="${exchange.coupon.category > 3}">
                                                		<a href="javascript:showDialog(${exchange.coupon.id})"><span class="label label-important" style="height:22px;width:80px;margin-top: 1px;padding-top: 8px" >${exchange.coupon.amount}% ${exchange.coupon.increaseDays}天</span></a>
                                                	</c:if>
                                                </td>
                                                <td>${exchange.quantity}</td>
                                                <td><c:if test="${exchange.makeMode == 0}">系统生成</c:if><c:if test="${exchange.makeMode == 1}">${exchange.goodsCouponCode.code}</c:if></td>
                                                <td>
                                                	<c:if test="${exchange.status == 0}">待审核</c:if>
                                                	<c:if test="${exchange.status == 1}">审核不通过</c:if>
                                                	<c:if test="${exchange.status == 2 and systemTime < exchange.beginTime}">审核通过</c:if>
                                                	<c:if test="${exchange.status == 2 and systemTime >= exchange.beginTime and systemTime <= exchange.endTime}">兑换中</c:if>
                                                	<c:if test="${exchange.status == 2 and systemTime > exchange.endTime}">失效</c:if>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="7">暂时还没有优惠券列表</td>
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
			           	  <input type="hidden" id="id" name="id">
						  <input type="hidden" id="customer" name="customer" value="${sessionsilverfoxkey.admin.id}">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					        <h4 class="modal-title">审核意见</h4>
					      </div>
					      <div class="modal-body">
					      	请确认审核结果！
					      <div class="modal-footer">
					        <button type="button" class="btn btn-primary" onclick="setStatus('2','status')">通过</button>
					        <button type="button" class="btn btn-default" onclick="setStatus('1','status')">不通过</button>
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
		var category = '';
		var makeMode = -1;
		$(function() {
			$('td.hiddenid').hide();
			$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;兑换券管理</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/exchange/list');
		            	$('#page').val(page);
		                $('#search').submit();
		            }  
			    };
				$('#coupon-page').bootstrapPaginator(options);
			}
			
			if($.trim($('#category').val()) != ''){
            	var ev = new Object();
    			ev.value = $.trim($('#category').val());
    			showView(ev);
            }
			
			$('#561').hide();
			$('#562').hide();
			$('#563').hide();
			$('#564').hide();
			$('#565').hide();
		})
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
		
				$('#561').hide();
				$('#562').hide();
				$('#563').hide();
				$('#564').hide();
				$('#565').hide();
				rowId = 0;
			}else{
				$('#exchangeId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = $.trim(tr.getElementsByTagName('td')[0].innerHTML);
				initStatus = $.trim(tr.getElementsByTagName('td')[1].innerHTML);
				makeMode = $.trim(tr.getElementsByTagName('td')[2].innerHTML);
				buttonShowOrHide();
			}
		
		}
		
		function buttonShowOrHide(){
			$('#561').hide();
			$('#562').hide();
			$('#563').hide();
			$('#564').hide();
			$('#565').hide();
			
			if($.trim(initStatus) == 0){
				$('#561').show();
				$('#562').show();
				$('#563').show();
			}
			if($.trim(initStatus) == 2){
				$('#561').show();
				$('#564').show();
				if(makeMode == 0){
					$('#565').show();
				}
			}
			if($.trim(initStatus) == 1){
				$('#561').show();
				$('#562').show();
			}
		}
		
		function detail(){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/coupon/exchange/detail/'+rowId;
			}else{
				alert('请先选择一条记录！');
			}
		}
		
		function edit(){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/coupon/exchange/edit/'+rowId;
			}else{
				alert('请先选择一条记录！');
			}
		}
		
		function audit(){ 
			if(rowId > 0){
				$('#authorizationDiv').modal('show');
			}else{
				alert('请先选择一条记录!');
			}
		}

		function codesDetail(){
			window.location.href='${pageContext.request.contextPath}/coupon/exchange/codes/'+rowId;
		}
		
		function setStatus(status){
			if(rowId > 0){
				$.getJSON('${pageContext.request.contextPath}/coupon/exchange/status', {couponExchangeCodeId:rowId, status:status, initStatus: initStatus},function(result){
				   if(!result){
					   alert('更新失败，数据状态已被更改!');
				   }else{
					   $('#search').attr('action','${pageContext.request.contextPath}/coupon/exchange/list');
		               $('#search').submit();
				   }
				});
			}else{
				alert('请先选择一条记录！');
			}	
		}
		
		function exportCodes(){
			var count = 50000;
			if(rowId > 0){
				if($.trim('${total}') > 0){
					if($.trim('${total}') <= count){
						$('#couponExchangeId').val(rowId);
						$('#search').attr('action','${pageContext.request.contextPath}${pageContext.request.contextPath}/coupon/exchange/codes/export');
			            $('#search').submit();
					}else{
						alert('查询结果集超过Excel导出最大限制 '+ count +' 条,请精确查询条件!');	
					}
				}else{
					alert('没有需要导出的记录');
				}
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
			  /* $('#head').append('<th>序号</th>');
	    	  $('#head').append('<th>红包名称</th>');
	    	  $('#head').append('<th>红包金额</th>');
	    	  $('#head').append('<th>操作</th>'); */
	    	  $.get('${pageContext.request.contextPath}/coupon/coupon/detail',{couponId:couponId} , function(result){
				   if (result != null){
					   $('#myModalLabel').empty().html('优惠券信息');
					   if(result.category < 4){
						   $('#couponBody').html("");
				    	   $('#couponBody').append('<tr>');
				    	   $('#couponBody').append('<td style="width:80px">使用条件</td>');
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
				    	   $('#couponBody').append('<td style="width:80px">使用条件</td>');
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