<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<c:import url="/header" />
	<body>
		<c:import url="/menu" />
        <div class="container-fluid">
            <div class="row-fluid">
                <c:import url="/sidebar"></c:import>
                <div class="span10" id="content">
                	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <!-- content begin -->
                    <form class="form-horizontal" id="fm" method="post"  action="${pageContext.request.contextPath}/coupon/exchange/save" >
                    <input id="id" name="id" value="${couponExchange.id}" type="hidden">
                    <input id="status" name="status" value="0" type="hidden">
                    <div class="accordion" id="accordion2">
					  <div class="accordion-group">
					    <!-- <div class="accordion-heading">
					      <a class="accordion-toggle btn-info" data-toggle="collapse" data-parent="#accordion2" style="text-decoration: none; ">
					       		 兑换券管理
					      </a>
					    </div> -->
					    <div id="collapseOne" class="accordion-body collapse in">
					      <div class="accordion-inner">
					      	<div class="well" style="margin: 0;">
					      		<div class="row-fluid" id="categoryGroup">
				      				<div class="control-group">
										<label class="control-label"><span class="required">*</span>选择类型</label>
										<div class="controls">
											<div class="span2">
												<input type="radio" name="category" prot="0" value="0" class="validate[required] span1" style="margin-top: -1px">
												<span> 红包 </span>
											</div>
											<div class="span7">
												<input type="radio" name="category" prot="1"  value="1" class="validate[required] span1" style="margin-top: -1px">
												<span> 加息券  </span>
											</div>
										</div>
									</div>
				      			</div>
				      			<div class="row-fluid">
					      			<div class="span8">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span>选择优惠券</label>
											<div class="controls">
												 <input type="hidden" id="couponId" name="coupon.id" value="${couponExchange.coupon.id}"/>
												 <c:if test="${couponExchange.coupon.category <= 3}">
													<input type="text" id="couponName" name="couponName" value="${couponExchange.coupon.amount}元  ${couponExchange.coupon.condition}" class="text-input span7" readonly/> 单选
												 </c:if>
												 <c:if test="${couponExchange.coupon.category > 3}">
													<input type="text" id="couponName" name="couponName" value="加息: ${couponExchange.coupon.amount}% ${couponExchange.coupon.financePeriod}天  ${couponExchange.coupon.condition}" class="validate[required] text-input span7" readonly/>
												 </c:if>
											</div>
										</div>
					      			</div>
					      		</div>
					      		<div class="row-fluid">
					      			<div class="span6">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span>数量(个)</label>
											<div class="controls">
												 <input type="text" id="quantity" name="quantity" value="${couponExchange.quantity}" class="validate[required,custom[integer],min[1],max[99999]] text-input span6" onkeyup="this.value=this.value.replace(/^((0{1,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/>
											</div>
										</div>
					      			</div>
					      		</div>
				      			<div class="row-fluid" id="makeModeGroup" >
				      				<div class="control-group">
										<label class="control-label"><span class="required">*</span> 兑换码</label>
										<div class="controls">
											<div class="span2">
												<input type="radio" name="makeMode" prot="0" value="0"  class="validate[required] span1" style="margin-top: -1px">
												<span> 系统生成 </span>
											</div>
											<div class="span7">
												<input type="radio" name="makeMode" prot="1" value="1" class="validate[required] span1" style="margin-top: -1px">
												<span> 自定义   <input type="text" id="code" name="code" class="validate[required, maxSize[20], custom[anotherNotSpecialCharacter], ajax[checkCouponCode]] text-input span7" <c:if test="${couponExchange.makeMode == 1}">value="${couponExchange.goodsCouponCode.code}"</c:if> /> </span>
											</div>
										</div>
									</div>
				      			</div>
				      			<div class="row-fluid">
									<div class="span5">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 开始时间</label>
											<div class="controls"><input type="text" id="beginTime" name="beginTime" value="${couponExchange.beginTime}" class="validate[required,custom[date],past[#endTime]] text-input span9" /></div>
										</div>
									</div>
									<div class="span5">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 结束时间</label>
											<div class="controls"><input type="text" id="endTime" name="endTime" value="${couponExchange.endTime}" class="validate[required,custom[date],future[#beginTime]] text-input span9" /></div>
										</div>
									</div>
								</div>
					      	</div>
					      </div>
					    </div>
					  </div>
					</div>
					<div class="row-fluid">
					  	<div class="span6" align="right">
					  		<button type="submit" id="save" class="btn btn-success btn-lg">保存</button>
					  	</div>
					  	<div class="span6" align="left">
					  		<a class="btn btn-default btn-lg" href="${pageContext.request.contextPath}/coupon/exchange/list">返回</a>
					  	</div>
					</div>
					</form>
                    <!-- content end -->
                    <div class="modal hide fade" id="coupon" style="width:800px;" role="dialog" >
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
					                	<thead>
					                    	<tr id="head">
					                        </tr>
					                   </thead>
					                   <tbody id="couponBody">
			                     	   </tbody>
			                     	   <tfoot>
			                      	        <tr>
			                      				<td colspan="5">
			                      					<div id="coupon-page"></div>
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
        </div>
        <div class="modal hide fade" id="couponDialog" role="dialog" >
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
			    	<div class="modal-header">
			        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        		<span aria-hidden="true">&times;</span>
			        	</button>
			        	<h4 class="modal-title" id="myCouponLabel"></h4>
			      	</div>
				    <div class="modal-body">
                        <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
		                	<!-- <thead>
		                    	<tr id="head">
		                        </tr>
		                   </thead> -->
		                   <tbody id="couponInfo">
                     	   </tbody>
             			</table>
		      		</div>
		    	</div>
		    </div>
        </div>
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
	    var index = 1;
	    var flag = 0;
	    
	    function couponDetail() {
	    	var couponId = $('#couponId').val();
	    	location.href='${pageContext.request.contextPath}/coupon/coupon/detail/'+couponId+'/0';
	    }
	    $(document).ready(function(){
	    	$('#code').focus();
			$('#fm').validationEngine('attach', { 
		        promptPosition: 'centerRight', 
		        scroll: false,
		        showOneMessage : true
		    });
			$('#categoryGroup').find('input:radio').change(function(){
	    		$('#couponId').val(0);
				$('#couponName').val('');
	    	})
			$('#couponName').bind('click',function(){
		    	 var value = $('input[name=category]').filter(':checked').attr('value');
		    	 if('${operation}' == 'edit'){
			    	 showDialog(value);
		    	 } else {
			    	 showInfo();
		    	 }
			});
			$('#makeModeGroup').find('input:radio').click(function(){
				if($.trim($(this).attr('prot')) == 0){
					$('#code').hide();
				}else{
					$('#code').show();
				}
			});
			$('#categoryGroup').find('input:radio').eq($.trim('${couponExchange.category}')).attr('checked',true);
			$('#makeModeGroup').find('input:radio').eq($.trim('${couponExchange.makeMode}')).trigger('click');
			
			if('${operation}' == 'edit'){
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">兑换券管理</a>&nbsp;/&nbsp;修改兑换券</li>');
				$('#save').show();				
			}else{
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">兑换券管理</a>&nbsp;/&nbsp;查看兑换券</li>');
				readOnly();
				$('#save').hide();				
			}
	    }); 
	    
	    $('#beginTime').datetimepicker({
			format:'Y-m-d',
			lang:'ch',
			timepicker:false
		});
		$('#endTime').datetimepicker({
			 format:'Y-m-d',
			 lang:'ch',
			 timepicker:false
		});
		
		function quit(){
			window.location.href='${pageContext.request.contextPath}/coupon/exchange/list';
		}
		
		function readOnly() {   
	        var a = document.getElementsByTagName('input');   
	        for(var i=0; i<a.length; i++) {   
	           if(a[i].type=='checkbox' || a[i].type=='radio' || a[i].type=='text'){
	        	   a[i].readOnly = true;
	        	   a[i].disabled = 'disabled';
	           }     
	        }
	        
	        var b = document.getElementsByTagName("select");   
	        for(var i=0; i<b.length; i++) {   
	             b[i].disabled='disabled';   
	        }
	        
	        var c = document.getElementsByTagName("textarea");
	        for (var i=0; i<c.length; i++) {   
	        	c[i].disabled='disabled';   
	        }
	        
	        /* var d = document.getElementsByTagName("button");
	        for (var i=0; i<d.length; i++) {   
	        	d[i].disabled='disabled';     
	        } */
	        document.getElementById('couponName').disabled = false;
		}
		
		function showDialog(category){
			  $('#coupon').modal('show');
			  getCoupon(1,category);
		  }
		  
		  function getCoupon(page,category){
			  $('#head').html("");
			  if(category == 0){
		    	  $('#head').append('<th style="width:30px;">序号</th>');
		    	  $('#head').append('<th style="width:200px;">使用条件</th>');
		    	  $('#head').append('<th>是否可转赠</th>');
		    	  $('#head').append('<th>到期时间</th>');
		    	  $('#head').append('<th>红包金额</th>');
		    	  $('#head').append('<th>操作</th>');
		    	  $.post('${pageContext.request.contextPath}/coupon/bonus/give/srource/list/'+ page, {category:0}, function(result){
					   if (result.total > 0) {
						   //$('#myModalLabel').empty().html('活动红包');
						   $('#couponBody').html("");
					       for (var i = 0; i < result.bonus.length; i++) {
					    	   var b = result.bonus[i];
					    	   $('#couponBody').append('<tr>');
					    	   $('#couponBody').append('<td class="hidden">'+b.id+'</td>');
					    	   $('#couponBody').append('<td>'+(i+1)+'</td>');
					    	   $('#couponBody').append('<td>'+b.condition+'</td>');
					    	   if (b.donation == 0) {
					    	   		$('#couponBody').append('<td>不可转赠</td>');
					    	   	} else {
					    	   		$('#couponBody').append('<td>可转赠</td>');
					    	   	}
					    	   	if (b.lifeCycle == 0) {
					    	   		$('#couponBody').append('<td>一万年有效</td>');
					    	   	} else if (b.lifeCycle == 1) {
					    	   		$('#couponBody').append('<td>'+b.expiresPoint+'到期</td>');
					    	   	} else if (b.lifeCycle == 2) { 
					    	   		$('#couponBody').append('<td>自领取后'+b.expiresPoint+'天过期</td>');
					    	   	}else {
					    	   		$('#couponBody').append('<td></td>');
					    	   	}
					    	   $('#couponBody').append('<td>'+b.amount+'元</td>');
					    	   var _t = b.condition;
					    	   _t = _t.replace(' ', '');
					    	   $('#couponBody').append('<td><a href=javascript:choiceCoupon('+b.id+',"'+ _t +'"'+','+b.amount+','+0+',0'+');>选择</a></td>');
					    	   $('#couponBody').append('</tr>');
						   }
					       
					       var totalPages = Math.ceil(result.total/15);
					       var options = {
						        currentPage: page,
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
					            	getCoupon(page,category);
					            }  
						    };
							$('#coupon-page').bootstrapPaginator(options);
				       }else{
				    	   $('#couponBody').html('<tr><td colspan="5">请先添加活动红包</td></tr>');	
				       }
		           });
			  }else if(category == 1){
				  $('#head').append('<th style="30px;">序号</th>');
		    	  $('#head').append('<th style="width:200px;">使用条件</th>');
		    	  $('#head').append('<th>是否可转赠</th>');
		    	  $('#head').append('<th>到期时间</th>');
		    	  $('#head').append('<th>加息收益</th>');
		    	  $('#head').append('<th>加息天数</th>');
		    	  $('#head').append('<th>操作</th>');
		    	  $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/' + page, {type:2}, function(result){
					   if (result.total > 0) {
						   //$('#myModalLabel').empty().html('活动加息券');
						   $('#couponBody').html("");
					       for (var i = 0; i < result.bonus.length; i++) {
					    	   var b = result.bonus[i];
					    	   $('#couponBody').append('<tr>');
					    	   $('#couponBody').append('<td class="hidden">'+b.id+'</td>');
					    	   $('#couponBody').append('<td>'+(i+1)+'</td>');
					    	   $('#couponBody').append('<td>'+b.condition+'</td>');
					    	   if (b.donation == 0) {
					    	   		$('#couponBody').append('<td>不可转赠</td>');
					    	   	} else {
					    	   		$('#couponBody').append('<td>可转赠</td>');
					    	   	}
					    	   	if (b.lifeCycle == 0) {
					    	   		$('#couponBody').append('<td>一万年有效</td>');
					    	   	} else if (b.lifeCycle == 1) {
					    	   		$('#couponBody').append('<td>'+b.expiresPoint+'到期</td>');
					    	   	} else if (b.lifeCycle == 2) { 
					    	   		$('#couponBody').append('<td>自领取后'+b.expiresPoint+'天过期</td>');
					    	   	}else {
					    	   		$('#couponBody').append('<td></td>');
					    	   	}
					    	   $('#couponBody').append('<td>'+b.amount+'%</td>');
					    	   $('#couponBody').append('<td>'+b.increaseDays+'天</td>');
					    	   var _t = b.condition;
					    	   _t = _t.replace(' ', '');
					    	   $('#couponBody').append('<td><a href=javascript:choiceCoupon('+b.id+',"'+ _t +'"'+','+b.amount+','+b.increaseDays+',1'+');>选择</a></td>');
					    	   $('#couponBody').append('</tr>');
						   }
					       
					       var totalPages = Math.ceil(result.total/15);
					       var options = {
						        currentPage: page,
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
					            	getCoupon(page,category);
					            }  
						    };
							$('#coupon-page').bootstrapPaginator(options);
				       }else{
				    	   $('#couponBody').html('<tr><td colspan="5">请先添加活动加息券</td></tr>');	
				       }
		           });
			  }else{
				  //do nothing
			  }
			}
		  
		  	function choiceCoupon(couponId,tempConcent,amount, time, type){
		    	$('#couponId').val(couponId);
		    	//$('#couponDetail').attr('href', '${pageContext.request.contextPath}/coupon/coupon/detail/'+couponId+'/0');
		    	if(type == 0){
		    		$('#couponName').val(amount + '元 '+tempConcent);
		    	}
		    	if(type == 1){
		    		$('#couponName').val('加息:' +amount + '% '+time+'天 '+tempConcent);
		    	}
		    	
				$('#coupon').modal('hide');
			}
		
			function remove(id){
				flag --;
				$('#quantity').val(parseInt($('#quantity').val()) - parseInt($(id).attr('amount')));
				$('#quantity').blur();
				$(id).remove();
				
			}
			
			function showInfo(){
		    	$('#couponDialog').modal('show');
				var couponId = $('#couponId').val();
				getCouponInfo(couponId);
			}
			
			function getCouponInfo(couponId){
				$('#head').html("");
	    	  	$.get('${pageContext.request.contextPath}/coupon/coupon/detail',{couponId:couponId} , function(result){
					if (result != null) {
					   $('#myCouponLabel').empty().html('优惠券信息');
					   if(result.category < 4){
						   $('#couponInfo').html("");
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td width="80">使用条件</td>');
				    	   $('#couponInfo').append('<td>'+result.condition+'</td>');
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>红包类型</td>');
				    	   if(result.category == 0){
				    		   $('#couponInfo').append('<td>'+'固定红包'+'</td>');
				    	   }
				    	   if(result.category == 1){
				    		   $('#couponInfo').append('<td>'+'概率红包'+'</td>');
				    	   }
				    	   if(result.category == 4){
				    		   $('#couponInfo').append('<td>'+'加息券'+'</td>');
				    	   }
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>红包金额</td>');
				    	   $('#couponInfo').append('<td>'+result.amount+'元</td>');
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>可否转赠</td>');
				    	   if (result.donation == 0) {
					    	   $('#couponInfo').append('<td>不可转赠</td>');
				    	   	} else {
					    	   $('#couponInfo').append('<td>可转赠</td>');
				    	   	}
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>有效期限</td>');
				    	   if(result.lifeCycle == 0){
				    		   $('#couponInfo').append('<td>'+'一万年有效'+'</td>');
				    	   }
						   if(result.lifeCycle == 1){
							   $('#couponInfo').append('<td>'+result.expiresPoint+'到期</td>');			    		   
						   }
						   if(result.lifeCycle == 2){
							   $('#couponInfo').append('<td>'+'自领取后'+result.expiresPoint+'天</td>');  
						   }
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>投资金额</td>');
				    	   if(result.moneyLimit == 0){
				    		   $('#couponInfo').append('<td>'+'不限制 </td>');
				    	   }
				    	   if(result.moneyLimit == 1){
				    		   $('#couponInfo').append('<td>单笔满'+result.tradeAmount+'元可用 </td>');
				    	   }
				    	   if(result.moneyLimit == 2){
				    		   $('#couponInfo').append('<td>累计满'+result.tradeAmount+'元可用 </td>');
				    	   }
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>理财期限</td>');
				    	   if(result.financePeriod == 0){
				    		   $('#couponInfo').append('<td>'+'不限制 </td>');
				    	   }else{
				    		   $('#couponInfo').append('<td>'+result.financePeriod+'天及以上 </td>');
				    	   }
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>备注</td>');
				    	   $('#couponInfo').append('<td>'+result.remark+'</td>');
				    	   $('#couponInfo').append('</tr>'); 
					   }else{
						   $('#couponInfo').html("");
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td width="80">使用条件</td>');
				    	   $('#couponInfo').append('<td>'+result.condition+'</td>');
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>加息券收益</td>');
				    	   $('#couponInfo').append('<td>'+result.amount+'%</td>');
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>加息天数</td>');
				    	   $('#couponInfo').append('<td>'+result.increaseDays+'天</td>');
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>可否转赠</td>');
				    	   if (result.donation == 0) {
					    	   $('#couponInfo').append('<td>不可转赠</td>');
				    	   	} else {
					    	   $('#couponInfo').append('<td>可转赠</td>');
				    	   	}
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>有效期限</td>');
				    	   if(result.lifeCycle == 0){
				    		   $('#couponInfo').append('<td>'+'一万年有效'+'</td>');
				    	   }
						   if(result.lifeCycle == 1){
							   $('#couponInfo').append('<td>'+result.expiresPoint+'到期</td>');			    		   
						   }
						   if(result.lifeCycle == 2){
							   $('#couponInfo').append('<td>'+'自领取后'+result.expiresPoint+'天</td>');  
						   }
				    	   $('#couponInfo').append('</tr>'); 
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>投资金额</td>');
				    	   if(result.moneyLimit == 0){
				    		   $('#couponInfo').append('<td>'+'不限制 </td>');
				    	   }
				    	   if(result.moneyLimit == 1){
				    		   $('#couponInfo').append('<td>单笔满'+result.tradeAmount+'元可用 </td>');
				    	   }
				    	   if(result.moneyLimit == 2){
				    		   $('#couponInfo').append('<td>累计满'+result.tradeAmount+'元可用 </td>');
				    	   }
				    	   $('#couponInfo').append('</tr>');
				    	   $('#couponInfo').append('<tr>');
				    	   $('#couponInfo').append('<td>备注</td>');
				    	   $('#couponInfo').append('<td>'+result.remark+'</td>');
				    	   $('#couponInfo').append('</tr>'); 
					   }
			       }else{
			    	   $('#couponInfo').html('<tr><td colspan="2">请先添加优惠券</td></tr>');	
			       }
	           });
			}
	</script>
</html>