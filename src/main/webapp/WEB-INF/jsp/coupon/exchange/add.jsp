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
                    <input id="id" name="id" value="0" type="hidden">
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
					      		<div class="row-fluid">
				      				<div class="control-group" id="categoryGroup">
										<label class="control-label"><span class="required">*</span>选择类型</label>
										<div class="controls">
											<div class="span2">
												<input type="radio" name="category" prot="0" value="0" checked="checked" class="validate[required] span1" style="margin-top: -1px">
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
					      			<div class="span6">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span>选择优惠券</label>
											<div class="controls">
												 <input type="hidden" id="couponId" name="coupon.id" />
												 <input type="text" id="couponName" name="couponName" class="validate[required] text-input span6" readonly/> 单选
											</div>
										</div>
					      			</div>
					      		</div>
					      		<div class="row-fluid">
					      			<div class="span6">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span>数量(个)</label>
											<div class="controls">
												 <input type="text" id="quantity" name="quantity" class="validate[required,custom[integer],min[1],max[99999]] text-input span6" onkeyup="this.value=this.value.replace(/^((0{1,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/>
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
												<span> 自定义   <input type="text" id="code" name="code" class="validate[required, maxSize[20], custom[anotherNotSpecialCharacter], ajax[checkCouponCode]] text-input span7"/> </span>
											</div>
										</div>
									</div>
				      			</div>
				      			<div class="row-fluid">
									<div class="span5">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 开始时间</label>
											<div class="controls"><input type="text" id="beginTime" name="beginTime" class="validate[required,custom[date],past[#endTime]] text-input span9" onkeypress="return false"/></div>
										</div>
									</div>
									<div class="span5">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 结束时间</label>
											<div class="controls"><input type="text" id="endTime" name="endTime" class="validate[required,custom[date],future[#beginTime]] text-input span9" onkeypress="return false"/></div>
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
                    <div class="modal hide fade" id="coupon" style="width: 800px;" role="dialog" >
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
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
	    var index = 1;
	    var flag = 0;
	    
	    $(document).ready(function(){
	    	$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">兑换券管理</a>&nbsp;/&nbsp;新增兑换券</li>');
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
		    	 showDialog(value);
			});
			$('#makeModeGroup').find('input:radio').click(function(){
				if($.trim($(this).attr('prot')) == 0){
					$('#code').hide();
				}else{
					$('#code').show();
					/* $('#code').addClass('validate[required]'); */
				}
			});
			$('#makeModeGroup').find('input:radio').eq(0).trigger('click');
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
					    	   $('#couponBody').append('<td style="width:45%">'+b.condition+'</td>');
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
				  $('#head').append('<th style="width:30px;">序号</th>');
		    	  $('#head').append('<th style="width:200px;">使用条件</th>');
		    	  $('#head').append('<th>是否可转赠</th>');
		    	  $('#head').append('<th>到期时间</th>');
		    	  $('#head').append('<th>加息收益</th>');
		    	  $('#head').append('<th>加息天数</th>');
		    	  $('#head').append('<th>操作</th>');
		    	  $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/' + page, {type:2},function(result){
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
	</script>
</html>