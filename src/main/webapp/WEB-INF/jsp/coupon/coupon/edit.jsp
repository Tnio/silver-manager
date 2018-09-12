<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <!-- content begin -->
                     <form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post"  action="${pageContext.request.contextPath}/coupon/coupon/save"  autocomplete="off">
                    <input id="id" name="id" value="${coupon.id }" type="hidden">
                    <input id="status" name="status" value="${coupon.status }" type="hidden">
                    <input type="hidden" name="type" id="type" value="${type }"/>
				    <div id="collapseOne" class="accordion-body collapse in">
				      <div class="accordion-inner">
				      	<div class="well" style="margin: 0;">
				      		<div class="row-fluid">
				      			<div class="span8">
									<c:if test="${type==1 }">
							      		<div class="row-fluid"  >
							      			<div class="span10">
								      			<div class="control-group" id="amountGroup">
													<label class="control-label"><span class="required">*</span>红包金额(元)</label>
													<div class="controls">
														<span>
															<input type="radio" name="amountCategory" value="0" class="validate[required]" style="margin-top: 7px;"> <span style="vertical-align: -5px;margin-right: 20px">
															<span> 固定金额</span>&nbsp;
														 	<input type="text" id="amount" style="width: 50px;" name="amount" onkeyup="preview('amount')" class="validate[custom[integer],min[1],max[9999]] text-input span3" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
														</span>
														<span>
															<input type="radio" name="amountCategory" value="1" class="validate[required]" style="margin-top: 7px;"> <span style="vertical-align: -5px;margin-right: 20px"  >
															<span> 随机金额 </span>  
														 	<input type="text" id="amountFrom" style="width: 50px;" name="amountFrom" class="validate[custom[integer],min[1],max[999]] text-input span2"  onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
														 	-
														 	<input type="text" id="amountTo" style="width: 50px;" name="amountTo" class="validate[custom[integer],min[1],max[999]] text-input span2" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
														</span>
													</div>
												</div>
							      			</div>
							      		</div>
							      		<div class="row-fluid">
							      			<div class="control-group span9">
												<label class="control-label"><span class="required">*</span> 可否转赠</label>
												<div class="controls">
													<div class="span4">
														<input type="radio" name="donation" checked="checked" value="0"  class="validate[required] span1" style="margin-top: -1px">
														<span>不可转赠</span>
													</div>
													<div class="span4">
														<input type="radio" name="donation" value="1" class="validate[required] span1" style="margin-top: -1px;">
														<span>可转赠</span>
													</div>
												</div>
											</div>
										</div>
							      	</c:if>
						      		<c:if test="${type == 2 }">
							      		<div class="row-fluid"  >
							      			<div class="span8">
								      			<div class="control-group" >
													<label class="control-label"><span class="required">*</span> 加息券收益</label>
													<div class="controls"><input type="text" id="amount" name="amount" value="${coupon.amount }"
													class="validate[required,custom[numberSp],min[0.01],max[99]] text-input span11" 
													 onkeyup="preview('amount')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>  %</div>
												</div>
							      			</div>
							      		</div>
							      		<div class="row-fluid">
							      			<div class="span8">
								      			<div class="control-group">
													<label class="control-label"><span class="required">*</span> 加息天数(天)</label>
													<div class="controls"><input type="text" id="increaseDays" name="increaseDays" value="${coupon.increaseDays }" 
													 class="validate[required,custom[integer],min[1],max[999]] span11" 
													  onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>天 </div>
												</div>
							      			</div>
							      		</div>
							      		<div class="row-fluid">
							      			<div class="control-group span9">
												<label class="control-label"><span class="required">*</span> 可否转赠</label>
												<div class="controls">
													<div class="span4">
														<input type="radio" name="donation" checked="checked" value="0"  class="validate[required] span1" style="margin-top: -1px">
														<span>不可转赠</span>
													</div>
													<div class="span4">
														<input type="radio" name="donation" value="1" class="validate[required] span1" style="margin-top: -1px;">
														<span>可转赠</span>
													</div>
												</div>
											</div>
										</div>
						      		</c:if>
				      			</div>
				      			<div class="span4">
				      				<div class="span12" style="height: 100px; margin-top: -10px; background-color: red;">
				      					<div class="row-fluid">
				      						<div class="span8">
						      					<p style="margin-left: 10px;padding-top: 15px;" id="conditionP" ></p>
						      					<p style="margin-left: 10px;" id="lifeCycleP" ></p>
				      						</div>
				      						<div class="span4">
				      							<h2 style="margin-left: -5px;padding-top: 10px"><span id="money"></span></h2>
				      						</div>
				      					</div>
				      				</div>
				      			</div>
				      		</div>
				      		<div class="row-fluid">
				      			<div class="control-group span10" id="moneyLimitGroup">
									<label class="control-label"><span class="required">*</span> 投资金额</label>
									<div class="controls">
										<div class="span2">
											<input type="radio" name="moneyLimit" checked="checked" value="0"  class="validate[required] span1" style="margin-top: -1px">
											<span> 不限 </span>
										</div>
										<div class="span4">
											<input type="radio" name="moneyLimit" value="1" class="validate[required] span1" style="margin-top: -1px;">
											<span> 单笔满  <input type="text" style="width: 70px;"  id="tradeAmountSington" name="tradeAmountSington" onblur="changeCondition()" class="validate[custom[integer],min[1],max[9999999]] span4" onkeyup="this.value=this.value.replace(/^((0)|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/>  可用  </span>
										</div>
									</div>
								</div>
				      		</div>
				      		<div class="row-fluid">
				      			<%-- <c:if test="${type==1 }">
									
								</c:if> --%>
								<div class="control-group" id="limitPeriodGroup">
									<label class="control-label"><span class="required">*</span> 理财期限</label>
									<div class="controls">
										<span>  <input type="text" id="financePeriod" name="financePeriod" onblur="changeCondition()" value="${coupon.financePeriod }" class="validate[required, custom[integer],min[0],max[999] span2" onkeyup="this.value=this.value.replace(/^((0)|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/>  天以上  </span>
									</div>
								</div> 
				      		</div>
				      		<div class="row-fluid">
								<div class="control-group">
									<label class="control-label"><span class="required">*</span> 产品类型</label>
									<div class="controls">
										<span class="span2" style="margin-left:0;">
						        			<input type="checkbox" onclick="changeCondition()" name="useScene" class="validate[required]" style="margin-top: 0px;" value="COMMON"> 常规产品
						        		</span>
						        		<span class="span2" style="margin-left:0;">
						        			<input type="checkbox" name="useScene" onclick="changeCondition()" class="validate[required]" style="margin-top: 0px;" value="NOVICE"> 新手产品
						        		</span>
									</div>
								</div> 
				      		</div>
			      			<div class="row-fluid">
			      				<div class="span12">
				      				<div class="control-group" id="expiresPointGroup">
										<label class="control-label"><span class="required">*</span> 有效期限</label>
										<div class="controls">
											<div class="span4">
												<input type="radio" name="lifeCycle" value="1" checked="checked" class="validate[required] text-input span1" style="margin-top: -1px; margin-left: -5px">
												<span> 固定期限  <input type="text" id="expiresPointTime" name="expiresPointTime" class="validate[] span5" onblur="preview('expiresPointTime')" /> 到期  </span>
											</div>
											<div class="span4">
												<input type="radio" name="lifeCycle" value="2" class="validate[required] span1" style="margin-top: -1px">
												<span> 自领取后  <input type="text" id="expiresPoint" name="expiresPoint" class="validate[custom[integer],min[1],max[999]] span4" onkeyup="preview('expiresPoint')"/>  天到期  </span>
											</div>
											<div class="span2">
												<input type="radio" name="lifeCycle" value="0" class="validate[required] text-input span1" style="margin-top: -1px" onclick="preview('lifeCycle')">
												<span> 一万年有效 </span>
											</div>
										</div>
									</div>
			      				</div>
			      			</div>
				      		<div class="row-fluid">
			      				<div class="control-group span8">
									<label class="control-label"> 使用条件</label>
									<div class="controls"><input type="text" style="color: red;" readonly id="condition" name="condition"  value="${coupon.condition}"  class="text-input span12" /></div>
								</div>
			      			</div>
				      		<div class="row-fluid">
				      			<div class="control-group span8">
									<label class="control-label"><span class="required"></span>备注</label>
									<div class="controls">
										<textarea  id="remark" name="remark" rows="2"  class="validate[maxSize[100]] span12"> ${coupon.remark }</textarea>
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
					  		<a class="btn btn-default btn-lg" href="${pageContext.request.contextPath}/coupon/coupon/list">返回</a>
					  	</div>
					</div>
					</form>
                </div>
            </div>
        </div>
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
	
		function quit(){
			window.location.href='${pageContext.request.contextPath}/coupon/coupon/list';
		}
		
		$.each('${coupon.useScene}'.split(','),function(i,value){
			$("[name='useScene']:checkbox").each(function() {
				if($(this).attr('value') == value){
					$(this).prop('checked', true);
				}
			});
		});
		
		function changeCondition() {
			var type = '${type}';
			var financePeriod = $('#financePeriod').val();
			var tradeAmountSington = $('#tradeAmountSington').val();
			var userSceneCondition = '';
			$("[name='useScene']:checkbox").each(function() {
		        if ($(this).is(":checked")) {
		        	if($(this).attr('value') == 'COMMON') {
		        		userSceneCondition = '常规产品';
		        	}
		        	if($(this).attr('value') == 'NOVICE') {
		        		if (userSceneCondition != '') {
			        		userSceneCondition += '、新手产品';
		        		} else {
			        		userSceneCondition = '新手产品';
		        		}
		        	}
		        }
		    });
			if (userSceneCondition != '') {
				userSceneCondition += '可用';
			}
			$('#condition').val(userSceneCondition);
			$('#conditionP').empty().append('<font color="white">'+'使用条件 : ' + userSceneCondition +'</font>');
			if (type == 1) {
				if (!financePeriod) {
					return;
				}
				if (tradeAmountSington) {
					var label = '单笔投资≥'+tradeAmountSington+'元，理财期限≥'+financePeriod+'天';
					if (userSceneCondition != '') {
						label += '，' + userSceneCondition;
					}
					$('#condition').val(label);
					$('#conditionP').empty().append('<font color="white">'+'使用条件 : ' + label +'</font>');
				} else {
					var label = '理财期限≥'+financePeriod+'天';
					if (userSceneCondition != '') {
						label += '，' + userSceneCondition;
					}
					$('#condition').val(label);
					$('#conditionP').empty().append('<font color="white">'+'使用条件 : ' + label +'</font>');
				}
			} else {
				if (tradeAmountSington) {
					var label = '单笔投资≥'+tradeAmountSington+'元，理财期限≥'+financePeriod+'天';
					if (userSceneCondition != '') {
						label += '，' + userSceneCondition;
					}
					$('#condition').val(label);
					$('#conditionP').empty().append('<font color="white">'+'使用条件 : ' + label +'</font>');
				} else {
					var label = '理财期限≥'+financePeriod+'天';
					if (userSceneCondition != '') {
						label += '，' + userSceneCondition;
					}
					$('#condition').val(label);
					$('#conditionP').empty().append('<font color="white">'+'使用条件 : ' + label +'</font>');
				}
			}
		}
		$(function() {
			$('#fm').validationEngine('attach', {
		        promptPosition:'bottomLeft',
		        showOneMessage: true,
		        focusFirstField:true,
		        scroll: true
		    });
			$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">券码库</a>&nbsp;/&nbsp;新增优惠券</li>');
			$('#expiresPointTime').datetimepicker({
				format:'Y-m-d',
				lang:'ch',
				scrollInput:false,
				timepicker:false,
				minDate:new Date()
			});
		
			$('#expiresPointTime').addClass('validate[required]');
			$('#expiresPointGroup').find('input:radio').click(function(){
				$('#expiresPoint').blur();
				$('#expiresPointTime').blur();
				if($(this).val() == 1){
					$('#expiresPointTime').addClass('validate[required]');
					$('#expiresPoint').removeClass('validate[required]');
					$('#expiresPoint').val('');
				}
				if($(this).val() == 2){
					$('#expiresPointTime').removeClass('validate[required]');
					$('#expiresPoint').addClass('validate[required]');
					$('#expiresPointTime').val('');
				}
				if($(this).val() == 0){
					$('#expiresPointTime').removeClass('validate[required]');
					$('#expiresPoint').removeClass('validate[required]');
					$('#expiresPointTime').val('');
					$('#expiresPoint').val('');
					$('#lifeCycleP').empty().append('<font color="white">'+'使用限制 : ' + '一万年有效'+'</font>');
				}else{
					$('#lifeCycleP').empty().append();
				}
			});
			
			$('#amountGroup').find('input:radio').click(function(){
				if($(this).val() == 0){
					$('#amount').addClass('validate[required]');
					$('#amountFrom').removeClass('validate[required]');
					$('#amountTo').removeClass('validate[required]');
					$('#amountFrom').val('');
					$('#amountTo').val('');
					$('#amount').bind('keyup',function(){
						preview('amount');
					});
					preview('amount');
				}
				if($(this).val() == 1){
					$('#amount').removeClass('validate[required]');
					$('#amount').val('');
					$('#amountFrom').addClass('validate[required]');
					$('#amountTo').addClass('validate[required]');
					$('#amount').unbind('keyup');
					$('#money').empty().append('<font color="white">'+ '概率'+'</font>');
				}
			});
			
			$('#moneyLimitGroup').find('input:radio').click(function(){
				$('#tradeAmountSington').blur();
				if($(this).val() == 0){
					$('#tradeAmountSington').removeClass('validate[required]');
					$('#tradeAmountSington').val('');
				}
				if($(this).val() == 1){
					$('#tradeAmountSington').addClass('validate[required]');
				}
				changeCondition();
			});
			
			var ev = new Object();
			ev.value = '${coupon.category}';
			initEdit();
		});
		
		function preview(location){
			if($.trim(location) == 'name'){
				if($.trim($('#name').val()) != ''){
					if($.trim($('#name').val()).length <= 10){
						$('#nameP').empty().append('<font color="white">'+$('#name').val()+'</font>');
					}else{
						$('#nameP').empty().append('<font color="white">'+$('#name').val().substring(0,10)+'...</font>');
					}	
				}else{
					$('#nameP').empty().append();
				}	
			}
			if($.trim(location) == 'condition'){
				if($.trim($('#condition').val()) != ''){
					$('#conditionP').empty().append('<font color="white">'+'使用条件 : ' + $('#condition').val()+'</font>');
				}else{
					$('#conditionP').empty().append();
				}
			}
			if($.trim(location) == 'expiresPointTime'){
				if($.trim($('#expiresPointTime').val()) != ''){
					$('#lifeCycleP').empty().append('<font color="white">'+'使用限制 : ' + $('#expiresPointTime').val() +'到期'+'</font>');
				}else{
					$('#lifeCycleP').empty().append();
				}
			}
			
			if($.trim(location) == 'expiresPoint'){
				if($.trim($('#expiresPoint').val()) != ''){
					$('#lifeCycleP').empty().append('<font color="white">'+'使用限制 : ' + $('#expiresPoint').val() +'天到期'+'</font>');
				}else{
					$('#lifeCycleP').empty();
				}
			}
			
			if($.trim(location) == 'lifeCycle'){
				$('#lifeCycleP').empty().append('<font color="white">'+'使用限制 : ' + '一万年有效'+'</font>');
			}
			if($.trim(location) == 'amount'){
				var value = $("input[name='amountCategory']:checked").val();
				var type = '${type}';
				if($.trim($('#amount').val()) != '' && value == 0 && type == 1){
					$('#money').empty().append('<font color="white">'+'￥'+$('#amount').val()+'</font>');
				} else if (type == 2) {
					$('#money').empty().append('<font color="white">'+$('#amount').val()+'%'+'</font>');
				}
			}
		}
		
		function initEdit(){
			preview('name');
			preview('condition');
			if($.trim('${coupon.donation}')=='0') {
				$("input[name='donation']").eq(0).attr('checked','checked');
			} else if ($.trim('${coupon.donation}')=='1') {
				$("input[name='donation']").eq(1).attr('checked','checked');
			}
			if($.trim('${coupon.lifeCycle}')=='1') {
				$('#expiresPointGroup').find('input:radio').eq(0).attr('checked','checked');
				$('#expiresPointTime').addClass('validate[required]');
				$('#expiresPoint').removeClass('validate[required]');
				$('#expiresPointTime').val('${coupon.expiresPoint}');
				preview('expiresPointTime');
			} else if($.trim('${coupon.lifeCycle}')=='2'){
				$('#expiresPointGroup').find('input:radio').eq(1).attr('checked','checked');
				$('#expiresPointTime').removeClass('validate[required]');
				$('#expiresPoint').addClass('validate[required]');
				$('#expiresPoint').val('${coupon.expiresPoint}');
				preview('expiresPoint');
			} else if($.trim('${coupon.lifeCycle}')=='0'){
				$('#expiresPointGroup').find('input:radio').eq(2).attr('checked','checked');
				$('#expiresPointTime').removeClass('validate[required]');
				$('#expiresPoint').removeClass('validate[required]');
				preview('lifeCycle');
			}
			if($.trim('${coupon.amountCategory}') =='0') {
				$('#amountGroup').find('input:radio').eq(0).trigger('click');
				$('#amount').addClass('validate[required]');
				$('#amountFrom').removeClass('validate[required]');
				$('#amountTo').removeClass('validate[required]');
				$('#amount').val('${coupon.amount}');
				preview('amount');
			} else {
				if($.trim('${coupon.category}') =='4') {
					$('#amountGroup').find('input:radio').eq(0).trigger('click');
					$('#amount').addClass('validate[required]');
					$('#amountFrom').removeClass('validate[required]');
					$('#amountTo').removeClass('validate[required]');
					$('#amount').val('${coupon.amount}');
					preview('amount');
				}
			}
			 
			if($.trim('${coupon.amountCategory}')=='1'){
				$('#amountFrom').val($.trim('${coupon.amount}').split('-')[0]);
				$('#amountTo').val($.trim('${coupon.amount}').split('-')[1]);
				$('#amountGroup').find('input:radio').eq(1).trigger('click');
				$('#amount').removeClass('validate[required]');
				$('#amountFrom').addClass('validate[required]');
				$('#amountTo').addClass('validate[required]');
				$('#money').empty().append('<font color="white">'+ '概率'+'</font>');
			}

			if($.trim('${coupon.moneyLimit}')=='0'){
				$('#moneyLimitGroup').find('input:radio').eq(0).attr('checked','checked');
				$('#tradeAmountSington').removeClass('validate[required]');
			} else if($.trim('${coupon.moneyLimit}')=='1'){
				$('#moneyLimitGroup').find('input:radio').eq(1).attr('checked','checked');
				$('#tradeAmountSington').val('${coupon.tradeAmount}');
				$('#tradeAmountSington').addClass('validate[required]');
			}
			if('${operation}' == 'edit'){
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">券码库</a>&nbsp;/&nbsp;编辑优惠券</li>');
				$('#save').show();
			}else{
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">券码库</a>&nbsp;/&nbsp;查看优惠券</li>');
				$('#save').hide();
				readOnly();
			}
		}

		function startValidate() {
		    var flag = true;
		    if(flag){
		   		if($('#expiresPointTime').val() != ''){
					if('${systemTime}' > $('#expiresPointTime').val()){
						alert("固定期限时间不能小于当前时间,请修改固定期限时间!");
						flag = false;
					}
				} 
	   	   }
			$.ajaxSettings.async = false;
			$.post('${pageContext.request.contextPath}/coupon/coupon/check/status', {couponId:$('#id').val(),initStatus:$('#initStatus').val()}, function(result){
			    if (result) {
			    	return flag;
			    } else {
			    	alert('数据已被审核!');
			    	flag = false;
			    	return flag;
			    }
            });
			$.ajaxSettings.async = true;
			return flag;
		}
		
		function readOnly() {   
	        var a = document.getElementsByTagName('input');   
	        for(var i=0; i<a.length; i++) {   
	           if(a[i].type=='checkbox' || a[i].type=='radio' || a[i].type=='text'){
	        	   a[i].disabled = 'disabled';
	           }     
	        }
	        var b = document.getElementsByTagName('select');   
	        for(var i=0; i<b.length; i++){   
	              b[i].disabled = 'disabled';   
	        }
	        
	        var c = document.getElementsByTagName('textarea');
	        for (var i=0; i<c.length; i++){   
	              c[i].disabled = 'disabled';   
	        }
	        var d = document.getElementsByTagName('button');
	        for (var i=0; i<d.length; i++)   {   
	              d[i].disabled = 'disabled';   
	        }
		}
		
	</script>
</html>