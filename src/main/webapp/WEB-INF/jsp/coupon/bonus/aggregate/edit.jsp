<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <!-- content begin -->
                    <form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post"  action="${pageContext.request.contextPath}/coupon/bonus/aggregate/save"  autocomplete="off">
                    <input id="id" name="id" value="${bonus.id}" type="hidden">
                    <input id="status" name="category" value="${bonus.category}" type="hidden">
                    <input id="status" name="status" value="${bonus.status}" type="hidden">
                    <input id="lifeCycle" name="lifeCycle" value="${bonus.lifeCycle}" type="hidden">
                    <input id="amountCategory" name="amountCategory" value="${bonus.amountCategory}" type="hidden">
                    <div class="accordion" id="accordion2">
					  <div class="accordion-group">
					    <div id="collapseOne" class="accordion-body collapse in">
					      <div class="accordion-inner">
					      	<div class="well" style="margin: 0;">
					      		<div class="row-fluid">
						      		<div class="span8">
					      				<div class="control-group">
											<label class="control-label"><span class="required">*</span> 使用条件</label>
											<div class="controls"><input type="text" readonly id="condition" name="condition" style="color: red;" value="${bonus.condition}" class="text-input span12" /></div>
										</div>
									</div>
				      			</div>
				      			<div class="row-fluid">
					      			<div class="span12">
						      			<div class="control-group">
											<label class="control-label"><span class="required">*</span> 返好友收益的</label>
											<div class="controls">
												<input type="text" id="amount" name="amount" value="${bonus.amount}" onkeyup="this.value=this.value.replace(/^((0)|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" class="validate[required, custom[numberSp], min[1], max[99]] text-input span4 "  onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>%
											</div>
										</div>
					      			</div>
					      		</div>
					      		<div class="row-fluid">
					      			<div class="control-group" id="moneyLimitGroup">
										<label class="control-label"><span class="required">*</span> 投资金额</label>
										<div class="controls">
											<div class="span2">
												<input type="radio" name="moneyLimit" value="0" class="radio span1" style="margin-top: -1px">
												<span> 不限 </span>
											</div>
											<div class="span3">
												<input type="radio" name="moneyLimit" value="1" class="radio span1" style="margin-top: -1px;">
												<span> 单笔满  <input type="text" onblur="changeCondition()" id="tradeAmountS" name="tradeAmountSington" class="validate[custom[integer],min[1],max[9999999]] span4" onkeyup="this.value=this.value.replace(/^((0)|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/>  可用  </span>
											</div>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 理财期限</label>
										<div class="controls">
											<span><input type="text" id="financePeriod" name="financePeriod" onblur="changeCondition()" onkeyup="this.value=this.value.replace(/^((0)|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" value="${bonus.financePeriod}" class="validate[required, custom[number],min[0],max[999] span2"/>  天以上  </span>
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
					  		<a class="btn btn-default btn-lg" href="${pageContext.request.contextPath}/coupon/bonus/aggregate/list">返回</a>
					  	</div>
					</div>
					</form>
                </div>
            </div>
        </div>
        <jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
		function changeCondition() {
			var financePeriod = $('#financePeriod').val();
			var tradeAmountSington = $('#tradeAmountS').val();
			if (!financePeriod) {
				return;
			}
			if (tradeAmountSington) {
				var label = '单笔投资≥'+tradeAmountSington+'元，理财期限≥'+financePeriod+'天，常规产品可用';
				$('#condition').val(label);
			} else {
				var label = '理财期限≥'+financePeriod+'天，常规产品可用';
				$('#condition').val(label);
			}
		}
	
		$(function() {
			$('#fm').validationEngine('attach', {
		        promptPosition:'bottomLeft',
		        showOneMessage: true,
		        focusFirstField:true,
		        scroll: true
		    });
						
			$('#amountGroup').find('input:radio').click(function(){
				if($(this).val() == 1){
					$('#amount').addClass('validate[required]');
					$('#amountFrom').removeClass('validate[required]');
					$('#amountTo').removeClass('validate[required]');
				}
				if($(this).val() == 2){
					$('#amount').removeClass('validate[required]');
					$('#amountFrom').addClass('validate[required]');
					$('#amountTo').addClass('validate[required]');
				}
			});
			
			$('#moneyLimitGroup').find('input:radio').click(function(){
				$('#tradeAmountS').blur();
				if($(this).val() == 0){
					$('#tradeAmountS').val('');
					$('#tradeAmountS').removeClass('validate[required]');
				} else if($(this).val() == 1){
					$('#tradeAmountS').addClass('validate[required]');
				}
				changeCondition();
			});
			
			var ev = new Object();
			ev.value = '${bonus.category}';
			showView(ev);
			
		});
		if('${operation}' == 'edit'){
			$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">累计红包管理</a>&nbsp;/&nbsp;编辑累计红包</li>');
			$('#save').show();
		}else{
			$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">累计红包管理</a>&nbsp;/&nbsp;查看累计红包</li>');
			$('#save').hide();
			readOnly();
		}
		function quit(){
			window.location.href='${pageContext.request.contextPath}/coupon/bonus/aggregate/list';
		}
		
		function initEdit(){
			if($.trim('${bonus.amountCategory}') =='0') {
				$('#amountGroup').find('input:radio').eq(0).attr('checked','checked');
				$('#amount').val('${bonus.amount}');
				preview('money');
			}
			if($.trim('${bonus.amountCategory}')=='1'){
				$('#amountFrom').val($.trim('${bonus.amount}').split('-')[0]);
				$('#amountTo').val($.trim('${bonus.amount}').split('-')[1]);
				$('#amountGroup').find('input:radio').eq(1).attr('checked','checked');
			}
			
			if($.trim('${bonus.moneyLimit}')=='0'){
				$('#moneyLimitGroup').find('input:radio').eq(0).attr('checked','checked');
			} else if($.trim('${bonus.moneyLimit}')=='1'){
				$('#moneyLimitGroup').find('input:radio').eq(1).attr('checked','checked');
				$('#tradeAmountS').val('${bonus.tradeAmount}');
			}
		}
		
		function showView(ev){
			if(ev != null){
				showChildView();
			}
		}
		
		function showChildView(){
			$('#amountGroup').hide();
			$('#giveDateGroup').hide();
			$('#fixation').hide();
			$('#random').hide();
			$('#detailConditionOne').hide();
			$('#detailConditionTwo').hide();
			$('#amountGroup').find('input:radio').eq(0).attr('checked','checked');
			$('#giveDate').val('');
			
			initEdit();
		}
		
		function readOnly(){   
	        var  a =  document.getElementsByTagName('input');   
	        for(var i=0; i<a.length;   i++)   {   
	           if(a[i].type=='checkbox' || a[i].type=='radio' || a[i].type=='text'){
	        	   a[i].disabled = 'disabled';
	           }     
	        }
	        var b =  document.getElementsByTagName('select');   
	        for(var i=0; i<b.length; i++){   
	              b[i].disabled = 'disabled';   
	        }
	        
	        var c = document.getElementsByTagName('textarea');
	        for   (var   i=0;   i<c.length;   i++){   
	              c[i].disabled = 'disabled';   
	        }
	        var d = document.getElementsByTagName('button');
	        for   (var   i=0;   i<d.length;   i++)   {   
	              d[i].disabled = 'disabled';   
	        }
		}
		
	</script>
</html>