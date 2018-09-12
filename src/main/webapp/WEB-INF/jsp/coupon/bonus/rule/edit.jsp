<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                    <form class="form-horizontal"  id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/coupon/rule/save" >
                    <input id="id" name="id" value="${rule.id}" type="hidden">
                    <input id="couponQuantitys" value="${fn:length(fn:split(rule.couponIds,','))}" type="hidden">
                    <input id="status" name="status" value="3" type="hidden">
                    <div class="accordion" id="accordion2">
					  <div class="accordion-group">
					    <div class="accordion-heading">
					      <a class="accordion-toggle btn-info" data-toggle="collapse" data-parent="#accordion2" style="text-decoration: none; ">
					       		 优惠券规则
					      </a>
					    </div>
					    <div id="collapseOne" class="accordion-body collapse in">
					      <div class="accordion-inner">
					      	<div class="well" style="margin: 0;">
					      		<div class="row-fluid">
					      			<div class="span6">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span>赠送规则</label>
											<div class="controls">
												<c:forEach items="${sources}" var="so">
			                                    	<c:choose>
				                                  		<c:when test="${so.key == rule.source}">
															<input type="text" value="${so.value}" class="text-input span6" readonly />
				                                  		</c:when>
			                                 		</c:choose>
			                               		</c:forEach>
											</div>
										</div>
					      			</div>
					      		</div>
					      		<c:if test="${rule.source == 10}">
						      		<div id="paybackGiveDate" class="row-fluid">
							      		<div class="control-group">
											<label class="control-label"><span class="required">*</span> 赠送日期</label>
											<div class="controls">
								           	    <input type="text" value="到期前一天赠送"  class="text-input span3" readonly />
								            </div>
										</div>
					      			</div>
						      		<div id="paybackGiveStrategy" class="row-fluid">
							      		<div class="control-group">
											<label class="control-label"><span class="required">*</span> 赠送规则</label>
											<div id="list">
											</div>
											<c:if test="${operation == 'edit'}">
												<div class="control-group" style="margin-left: 165px;">
									           	    <button type="button" class="btn btn-icon btn-default" id="add" style="margin-left: 120px;margin-top: 20px;" >添加规则</button>
									            	<span>（最多可添加6条规则）</span>
									            </div>
											</c:if>
										</div>
					      			</div>
					      		</c:if>
					      		<c:if test="${rule.source != 10}">
						      		<div id="giveStrategy" class="row-fluid">
					      				<div class="control-group">
											<label class="control-label"><span class="required">*</span> 赠送策略</label>
											<div id="inviteGiveStrategy">
												<div class="span2">
													<div class="control-group ">
														<input type="radio" name="giveCondition" value="0" class="validate[required] radio span4">
														<span >好友注册即送</span>
													</div>
												</div>
												<div class="span2">
													<div class="control-group ">
														<input type="radio" name="giveCondition" value="1" class="validate[required] radio span4">
														<span >好友交易即送</span>
													</div>
												</div>
											</div>
											<div id ="shareGiveStrategy" class="span2" >
												<div class="control-group ">
													<input type="radio" name="giveCondition" value="2" class="validate[required] radio span4">
													<span >分享者领取</span>
												</div>
											</div>
										</div>
					      			</div>
					      			<div id="birthdayDate" class="row-fluid">
						      			<div class="span6">
											<div class="control-group">
												<label class="control-label"><span class="required">*</span>赠送日期</label>
												<div class="controls">
													<input type="text" value="生日当月赠送" class="text-input span6" readonly />
												</div>
											</div>
						      			</div>
						      		</div>
					      			<div id="silverQuantity" class="row-fluid">
						      			<div class="span6">
											<div class="control-group">
												<label class="control-label">银子数量</label>
												<div class="controls">
									      			<input id="quantity" name="quantity" type="text" value="${rule.quantity}" class="validate[custom[integer],min[0],max[9999]] text-input span3">
												</div>
											</div>
						      			</div>
						      		</div>
					      			<div id="shareCouponid" class="row-fluid">
						      			<div class="span6">
											<div class="control-group">
												<label class="control-label"><span class="required">*</span>选择红包</label>
												<div class="controls">
													<input type="text" class="text-input span6" readonly onclick="showBonusDialog(0)"/>
												</div>
											</div>
						      			</div>
						      		</div>
						      		<div id="chooseBonusId" class="row-fluid">
						      			<div class="span6">
											<div class="control-group">
												<label class="control-label"><span class="required">*</span>选择红包</label>
												<div class="controls">
													<input type="text" class="text-input span6" readonly onclick="showBonusDialog(0)"/>
												</div>
											</div>
						      			</div>
						      		</div>
						      		<div id="chooseIncreaseId" class="row-fluid">
						      			<div class="span6">
											<div class="control-group">
												<label class="control-label"><span class="required">*</span>选择加息券</label>
												<div class="controls">
													<input type="text" class="text-input span6" readonly onclick="showBonusDialog(4)"/>
												</div>
											</div>
						      			</div>
						      		</div> 
						      		<div class="row-fluid">
						      			<div class="span10">
											<div class="control-group">
												<label class="control-label"><span class="required">*</span>优惠券预览</label>
												<div class="controls" id="quantityGroup">
													<%-- <c:forEach var="couponId" items="${fn:split(rule.couponIds,',')}" varStatus="status">
	                                           		</c:forEach> --%>  
	                                           		<c:if test="${not empty rule.couponIds }">
		                                           		<c:forEach var="couponId" items="${fn:split(rule.couponIds,',')}" varStatus="status">
															<c:forEach var="couponAmount" items="${fn:split(rule.couponAmounts,',')}" varStatus="statuss">
																<c:if test="${status.index == statuss.index}">
																	<a <c:if test="${operation == 'edit'}"> href="javascript:remove(div${status.count})"</c:if><c:if test="${operation == 'detail'}"> href="javascript:showDialog(${couponId})"</c:if> id="div${status.count}">
																	<input id="couponIds${status.count}" name="couponIds"  value="${couponId}" type="hidden" >
																	<input id="couponAmount${status.count}" name="couponAmounts"  value="${couponAmount}" type="hidden" >
																	<span class="label label-important" style="height:22px;width:75px;margin-top: 1px;padding-top: 8px" title="点击可删除"> 
																		${couponAmount}
																	</span></a>
																</c:if>
															</c:forEach>
		                                           		</c:forEach>
	                                           		</c:if>
	                                           		<%-- <c:forEach var="couponAmount" items="${fn:split(rule.couponAmounts,',')}" varStatus="status">
														<a <c:if test="${operation == 'edit'}"> href="javascript:remove(div${status.count})"</c:if>  <c:if test="${operation == 'detail'}"> href="javascript:showDialog(div${status.count})"</c:if> id="div${status.count}">
														<input id="couponAmount${status.count }" name="couponAmounts"  value="${couponAmount}" type="hidden" >
														<input id="coupons${status.count }" name="coupons" value="${coupons}" type="hidden" >
														<span class="label label-important" style="height:22px;width:75px;margin-top: 1px;padding-top: 8px" <c:if test="${operation == 'edit'}">title="点击可删除"</c:if>> 
															${couponAmount}
														</span></a>
	                                           		</c:forEach>  --%> 
												</div>
											</div>
						      			</div>
						      		</div> 
					      			<div class="row-fluid" id="templateGroup">
					      				<div class="control-group">
											<label class="control-label"><span class="required">*</span> 短信通知</label>
											<div class="controls">
												<div class="span2">
													<input type="radio" name="template.id" prot="0" value="0" checked="checked" class="validate[required] span1" style="margin-top: -1px">
													<span> 否 </span>
												</div>
												<div class="span7">
													<c:if test="${rule.template != null }">
														<input type="radio" id="templateId" prot="1" name="template.id" value="${rule.template.id}" class="validate[required] span1" style="margin-top: -1px">
														<span> 是   <input type="text" id="templateConcent" class="text-input span7" readonly onclick="showTemplateDialog()"/> </span>
													</c:if>
													<c:if test="${rule.template == null }">
														<input type="radio" id="templateId" prot="1" name="template.id" value="0" class="validate[required] span1" style="margin-top: -1px">
														<span> 是   <input type="text" id="templateConcent" class="text-input span7" readonly onclick="showTemplateDialog()"/> </span>
													</c:if>
												</div>
											</div>
										</div>
					      			</div> 
					      		</c:if>
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
					  		<a class="btn btn-default btn-lg" href="${pageContext.request.contextPath}/coupon/bonus/rule/list">返回</a>
					  	</div>
					</div>
					</form>
                    <!-- content end -->
                    <div class="modal hide fade" id="bonus" role="dialog" style="top:2%;width:800px;">
					  	<div class="modal-dialog modal-lg">
					    	<div class="modal-content">
					      		<div class="modal-header">
					        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					        			<span aria-hidden="true">&times;</span>
					        		</button>
					        		<h4 class="modal-title" id="myModalLabel">选择优惠券</h4>
					      		</div>
					      		<div class="modal-body" style="max-height:250px;">
			                        <table class="table table-striped">
					                	<thead>
					                    	<tr>
				                                <th style="width:30px;">序号</th>
				                                <th style="width:200px;">使用条件</th>
				                                <th>是否可转赠</th>
		    	  								<th>到期时间</th>
				                                <th>优惠额度</th>
				                                <th>操作</th>
					                        </tr>
					                   </thead>
					                   <tbody id="bonusBody">
			                     	   </tbody>
			                     	   <tfoot>
			                      	        <tr>
			                      				<td colspan="5">
			                      					<div id="bonus-page"></div>
			                      				</td>
			                      			</tr>
			                      		</tfoot>
			             			</table>
					      		</div>
					    	</div>
					    </div>
					</div>
					
					<div class="modal hide fade" id="template" role="dialog" >
					  	<div class="modal-dialog modal-lg">
					    	<div class="modal-content">
					      		<div class="modal-header">
					        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					        			<span aria-hidden="true">&times;</span>
					        		</button>
					        		<h4 class="modal-title" id="myModalLabel">选择消息模板</h4>
					      		</div>
					      		<div class="modal-body">
			                        <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
					                	<thead>
					                    	<tr>
				                                <th>序号</th>
				                                <th>模板内容</th>
				                                <th>操作</th>
					                        </tr>
					                   </thead>
					                   <tbody id="templateBody">
			                     	   </tbody>
			                     	   <tfoot>
			                      	        <tr>
			                      				<td colspan="3">
			                      					<div id="template-page"></div>
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
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
	    var index = $.trim('${rule.couponIds}').split(',').length + 1;
	    var flag = $.trim('${rule.couponIds}').split(',').length;
	    
	    
	    function addDataRule(quota, couponIds, couponAmounts) {
			var html = '<div id="rule'+ruleNum+'"><div class="controls" style="margin-top: 10px;">';
			html += '<label class="control-label">回款金额满</label>';
			html += '<div class="controls">';
			html += '<input type="hidden" id="ruleCouponIds'+ruleNum+'" name="rules['+ruleNum+'].couponIds" value="'+couponIds+'" >';
			html += '<input type="hidden" id="ruleCouponAmounts'+ruleNum+'" name="rules['+ruleNum+'].couponAmounts" value="'+couponAmounts+'" >';
			html += '<input type="text"  style="width: 80px;" id="ruleQuota'+ruleNum+'" name="rules['+ruleNum+'].quota" value="'+quota+'"  class="validate[required,min[1],custom[integer],max[9999999]] text-input"/>';
			html += '<span>元，奖励红包</span>';
			html += '<input type="text"  style="width: 120px;" onclick="showBonusDialog(0, '+ruleNum+')" readonly class="text-input"/>';
			html += '<span>奖励加息券</span>';
			html += '<input type="text"  style="width: 120px;" onclick="showBonusDialog(4, '+ruleNum+')" readonly class="text-input"/>';
			if (ruleNum > 0) {
				var type = '${operation}';
				if (type == 'edit') {
					html += '<input type="button" class="btn btn-lg" value="删除" onclick="delHtml('+ruleNum+')">';
				}
			}
			
			html += '<div class="control-group" style="margin-left: -165px;" >';
			html += '<label class="control-label"><span class="required">*</span>优惠券预览</label>';
			html += '<div class="controls" style="margin-top:5px;" id="paybackRuleGroup'+ruleNum+'">';
			var couponIdsInfos = couponIds.split(',');
			var couponInfos = couponAmounts.split(',');
			for (var j = 0; j < couponInfos.length; j++) {
				var type = '${operation}';
				if (type == 'edit') {
					html += '<a href="javascript:remove(div'+j+ruleNum+','+ruleNum+','+couponIdsInfos[j]+','+"'"+couponInfos[j]+"'"+')" id="div'+j+ruleNum+'"><span class="label label-important" style="height:22px;width:75px;margin-top: 1px;margin-left: 5px;padding-top: 8px" title="点击可删除">'+ couponInfos[j] +'</span></a>';
				} else {
					html += '<a href="javascript:showDialog('+couponIdsInfos[j]+')" id="div'+j+ruleNum+'"><span class="label label-important" style="height:22px;width:75px;margin-top: 1px;margin-left: 5px;padding-top: 8px">'+ couponInfos[j] +'</span></a>';
				}
				//<a <c:if test="${operation == 'edit'}"> href="javascript:remove(div${status.count})"</c:if><c:if test="${operation == 'detail'}"> href="javascript:showDialog(${couponId})"</c:if> id="div${status.count}">
			}
			html += '</div></div>';
			html += '</div></div></div>';
			$('#list').append(html);
			ruleNum++;
		}
	   
	    $(function() {
	    	var infos = eval('${ruleCoupons}');
	    	if (infos && infos.length) {
		    	for (var i = 0; i < infos.length; i++) {
		    		addDataRule(infos[i].quota, infos[i].couponIds, infos[i].couponAmounts);
		    	}
	    	} else {
	    		addRule();
	    	}
	    	if("${rule.source}" == 8){
	    		$('#birthdayDate').show();
	    		$('#templateGroup').show();
	    		$('#shareCouponid').hide();
	    		$('#chooseBonusId').show();
	    		$('#chooseIncreaseId').show();
	    		$('#giveStrategy').hide();
	    		$('#silverQuantity').show();
	    	}else if("${rule.source}" == 6){
	    		$('#shareCouponid').show();
	    		$('#birthdayDate').hide();
	    		$('#templateGroup').hide();
	    		$('#shareCouponid').show();
	    		$('#chooseBonusId').hide();
	    		$('#chooseIncreaseId').hide();
	    		$('#giveStrategy').show();
	    		$('#inviteGiveStrategy').hide();
    			$('#shareGiveStrategy').show();
    			$('#silverQuantity').hide();
			}else{
	    		if("${rule.source}" == 3 || "${rule.source}" == 4 ){
	    			$('#giveStrategy').show();
	    			$('#inviteGiveStrategy').show();
	    			$('#shareGiveStrategy').hide();
	    		}else {
	    			$('#giveStrategy').hide();
	    		}
	    		$('#silverQuantity').show();
	    		$('#birthdayDate').hide();
	    		$('#templateGroup').hide();
	    		$('#shareCouponid').hide();
	    		$('#chooseBonusId').show();
	    		$('#chooseIncreaseId').show();
	    	}
	    	$('input[name=giveCondition][value=${rule.giveCondition}]').attr("checked",true);
			$('#templateGroup').find('input:radio').click(function(){
				if($.trim($(this).attr('prot')) == 0){
					$('#templateConcent').val('');
					$('#templateConcent').removeClass('validate[required]');
				}else{
					showTemplateDialog();
					$('#templateConcent').addClass('validate[required]');
					$('#templateConcent').val('');
				}
			});
			if($.trim('${rule.template.id}')=='0') {
				$('#templateGroup').find('input:radio').eq(0).attr('checked','checked');
			}else{
				$('#templateGroup').find('input:radio').eq(1).attr('checked','checked');
				$('#templateConcent').val('${rule.template.content}');
			} 
		    
			$('#fm').validationEngine('attach', { 
		        promptPosition: 'centerRight', 
		        scroll: false,
		        showOneMessage : true
		   	});
			if('${operation}' == 'edit'){
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">优惠券规则</a>&nbsp;/&nbsp;编辑优惠券规则</li>');
				$('#save').show();
			}else{
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">优惠券规则</a>&nbsp;/&nbsp;查看优惠券规则</li>');
				$('#save').hide();
				readOnly();
			}
		});
	    
	    $('#templateGroup').find('input:radio').click(function(){
			if($.trim($(this).attr('prot')) == 0){
				$('#templateConcent').val('');
				$('#templateConcent').removeClass('validate[required]');
			}else{
				showTemplateDialog();
				$('#templateConcent').addClass('validate[required]');
				$('#templateConcent').val('');
			}
		});
	 
		function showBonusDialog(category, ruleNum){
			if (ruleNum >= 0) {
				getBonus(1, category, ruleNum);
				$('#bonus').modal('show');
			} else {
				if(flag <= 19){
					getBonus(1, category);
					$('#bonus').modal('show');
				}else{
					alert('您一次不能添加更多的优惠券了!');
				}
			}
		}
		
		function quit(){
			window.location.href='${pageContext.request.contextPath}/coupon/bonus/rule/list';
		}
		
		$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">优惠券规则</a>&nbsp;/&nbsp;编辑优惠券规则</li>');
			
		$('#fm').validationEngine('attach', { 
	        promptPosition: 'centerRight', 
	        scroll: false,
	        showOneMessage : true
	    });
		
		function getBonus(page, category, ruleNum){
			var type = -1;
			if(('${rule.source}' == 8 || '${rule.source}' == 6)&& category == 0){
				type = 1;
				category = -1;
			}
			$.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/'+ page,{"category": category, "type" : type}, function(result){
			   if (result.total > 0) {
				   	$('#bonusBody').html("");
					var company = '';
					if(category == 4){
						company = '%';
					}else{
						company = '元';
					}
					for (var i = 0; i < result.bonus.length; i++) {
						var b = result.bonus[i];
						$('#bonusBody').append('<tr>');
						$('#bonusBody').append('<td class="hidden">'+b.id+'</td>');
						$('#bonusBody').append('<td>'+(i+1)+'</td>');
						$('#bonusBody').append('<td>'+b.condition+'</td>');
			    	    if (b.donation == 0) {
			    	   		$('#bonusBody').append('<td>不可转赠</td>');
			    	   	} else {
			    	   		$('#bonusBody').append('<td>可转赠</td>');
			    	   	}
			    	   	if (b.lifeCycle == 0) {
			    	   		$('#bonusBody').append('<td>一万年有效</td>');
			    	   	} else if (b.lifeCycle == 1) {
			    	   		$('#bonusBody').append('<td>'+b.expiresPoint+'到期</td>');
			    	   	} else if (b.lifeCycle == 2) { 
			    	   		$('#bonusBody').append('<td>自领取后'+b.expiresPoint+'天过期</td>');
			    	   	}else {
			    	   		$('#bonusBody').append('<td></td>');
			    	   	}
						if(category == 4){
							$('#bonusBody').append('<td>'+b.amount+company+' '+b.increaseDays+'天'+'</td>');
						}else{
							$('#bonusBody').append('<td>'+b.amount+company+'</td>');
						}
						
						$('#bonusBody').append('<td><a href=javascript:choiceBonus('+b.id+','+b.increaseDays+',"'+b.amount+'","'+ b.name+'",'+b.category+','+ruleNum+');>选择</a></td>');
						$('#bonusBody').append('</tr>');
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
			            	getBonus(page, category, ruleNum);
			            }  
				    };
					$('#bonus-page').bootstrapPaginator(options);
		       }else{
		    	   $('#bonusBody').html('<tr><td colspan="5">请先添加优惠券</td></tr>');	
		       }
           });
		}
		
		function startValidate() {
			var source  = '${rule.source}';
			if (source == 10) {
				var quotaArray = [0];
				var ruleCouponAmounts = null;
				for(var i = 0; i < ruleNum; i++) {
					var quota = $('#ruleQuota'+i).val();
					quotaArray.push(quota);
					var ruleCouponIds = $('#ruleCouponIds'+i).val();
					if (!ruleCouponIds) {
						alert('每个规则请至少选择一个优惠券');
						return false;
					}
					ruleCouponAmounts += $('#couponAmounts'+i).val();
				}
				var values = null;
				$("input[name='couponAmounts']").each(function(){
					values += $(this).attr('value');
				});
				if(values.indexOf('元') == -1) {
					alert('请至少选择一个红包');
					return false;
				}
				var nary=quotaArray.sort(); 
	
				for(var i=0;i< quotaArray.length;i++){
					if (i != quotaArray.length -1 && nary[i]==nary[i+1]){ 
						alert('不同的规则回款金额不能相同');
						return false;
					} 
				} 		
				var result = $('#fm').validationEngine('validate');
			 	if (result) {
			 		return true;
			 	}
			} else {
				var result = $('#fm').validationEngine('validate');
			 	if (result) {
					var couponQuantitys = $.trim($('#couponQuantitys').val());
					if(couponQuantitys == 0){
						alert('请至少选择一个优惠券');
						return false;
					}
					var values = null;
					$("input[name='couponAmounts']").each(function(){
						values += $(this).attr('value');
					});
					if(values.indexOf('元') == -1) {
						alert('请至少选择一个红包');
						return false;
					}
					var quantity = $('#quantity').val();
					if(quantity==''){
						$('#quantity').val(0);
					}
					return true;
			 	}
			}
		 	return false;
		}
		
		function showTemplateDialog() {
			getTemplate(1);
			$('#template').modal('show');
		}
		
		function getTemplate(page){
			$.post('${pageContext.request.contextPath}/coupon/bonus/template/list/'+ page, function(result){
			   if (result.total > 0) {
				   $('#templateBody').html("");
			       for (var i = 0; i < result.templates.length; i++) {
			    	   var template = result.templates[i];
			    	   $('#templateBody').append('<tr>');
			    	   $('#templateBody').append('<td class="hidden">'+template.id+'</td>');
			    	   $('#templateBody').append('<td>'+(i+1)+'</td>');
			    	   $('#templateBody').append('<td>'+template.content+'</td>');
			    	   //去掉换行和空格
			    	   var _t = template.content;
			    	   _t = _t.replace(' ', '');
			    	   $('#templateBody').append('<td><a href=javascript:choiceTemplate('+template.id+',"'+_t+'");>选择</a></td>');
			    	   $('#templateBody').append('</tr>');
				   }
			       
			       var totalPages = Math.ceil(result.total/15);
			       var options = {
				        currentPage: result.newsPage,
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
			            	getTemplate(page);
			            }  
				    };
					$('#template-page').bootstrapPaginator(options);
		       }else{
		    	   $('#templateBody').html('<tr><td colspan="3">请先添加消息模板</td></tr>');	
		       }
           });
		}
		
		function choiceTemplate(templateId,tempConcent){
			$('#templateId').val(templateId);
			$('#templateGroup').find('input:radio').eq(1).trigger('click');
			$('#templateConcent').val(tempConcent);
			$('#template').modal('hide');
		}
		
		function choiceBonus(couponId, financePeriod, amount, condition, category, ruleNum){
			if (ruleNum >= 0) {
				var couponIds = $('#ruleCouponIds'+ruleNum).val();
				if (couponIds) {
					var conponInfos = couponIds.split(',');
					if (conponInfos && conponInfos.length >= 5) {
						alert('您一次不能添加更多的优惠券了!');
						return ;
					}
				}
			} else {
				if(flag > 19){
					alert('您一次不能添加更多的优惠券了!');
					return ;
				}
			}
			var company = '';
			if(category >= 4){
	 	   		company = '%('+financePeriod+'天)';
	 	   	}else{
				company = '元';
	 	   	}
			if (ruleNum >= 0) {
				if ($('#ruleCouponIds'+ruleNum).val()) {
					$('#ruleCouponIds'+ruleNum).val($('#ruleCouponIds'+ruleNum).val()+','+couponId);
				} else {
					$('#ruleCouponIds'+ruleNum).val(couponId);
				}
				if ($('#ruleCouponAmounts'+ruleNum).val()) {
					$('#ruleCouponAmounts'+ruleNum).val($('#ruleCouponAmounts'+ruleNum).val()+','+amount+company);
				} else {
					$('#ruleCouponAmounts'+ruleNum).val(amount+company);
				}
				$('#paybackRuleGroup'+ruleNum).append('<a href="javascript:remove(div'+index+', '+ruleNum+', '+couponId+', '+"'"+amount+company+"'"+')" id="div'+index+'" amount="'+amount+'"><input id="couponIds'+index+'" name="couponIds"  value="'+couponId+'" type="hidden" ><input id="couponAmount'+index+'" name="couponAmounts"  value="'+amount+company+'" type="hidden" ><input id="coupons'+index+'" name="coupons"  value="'+couponId+'*'+amount+company+'" type="hidden" ><span class="label label-important" style="height:22px;width:75px;margin-top: 1px;margin-left: 5px;padding-top: 8px" title="点击可删除">'+ amount + company +' </span></span></a>');
			} else {
				if($('#couponQuantitys').val() != ''){
					$('#couponQuantitys').val(parseInt($('#couponQuantitys').val()) + 1);
				}else{
					$('#couponQuantitys').val(1);
				}
				$('#quantityGroup').append('<a href="javascript:remove(div'+index+')" id="div'+index+'" amount="'+amount+'"><input id="couponIds'+index+'" name="couponIds"  value="'+couponId+'" type="hidden" ><input id="couponAmount'+index+'" name="couponAmounts"  value="'+amount+company+'" type="hidden" ><input id="coupons'+index+'" name="coupons"  value="'+couponId+'*'+amount+company+'" type="hidden" ><span class="label label-important" style="height:22px;width:75px;margin-top: 1px;padding-top: 8px" title="点击可删除">'+ amount + company +' </span></span></a>');
	
				$('#quantityGroup').append(' ');
				index++;
				flag++;
				$('#couponQuantitys').blur();
			}
		}
		
		function remove(id, ruleNum, couponId, couponAmount){
			if (ruleNum >= 0) {
				var couponIds = $('#ruleCouponIds'+ruleNum).val();
				var couponAmounts = $('#ruleCouponAmounts'+ruleNum).val();
				if (couponIds) {
					couponIds = couponIds.replace(couponId, '');
					couponIds = couponIds.replace(',,', ',');
					if (couponIds.substr(0,1)==',') {
						couponIds = couponIds.substr(1);
					}
					var reg=/,$/gi;
					couponIds = couponIds.replace(reg, '');
					$('#ruleCouponIds'+ruleNum).val(couponIds);
				}
				if (couponAmounts) {
					couponAmounts = couponAmounts.replace(couponAmount, '');
					couponAmounts = couponAmounts.replace(',,', ',');
					if (couponAmounts.substr(0,1)==',') {
						couponAmounts = couponAmounts.substr(1);
					}
					var reg=/,$/gi;
					couponAmounts = couponAmounts.replace(reg, '');
					$('#ruleCouponAmounts'+ruleNum).val(couponAmounts);
				}
			} else {
				flag --;
				$('#couponQuantitys').val(parseInt($('#couponQuantitys').val()) - parseInt(1));
				$('#couponQuantitys').blur();
			}
			$(id).remove();
		}
		
		function showCouponDialog(){
			getCoupon(1);
			$('#bonus').modal('show');
		}
		
		function getCoupon(page){
			$.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/'+page, {"category":-1,"type":1}, function(result){
			   if (result.total > 0) {
				   $('#bonusBody').html("");
			       for (var i = 0; i < result.bonus.length; i++) {
			    	   var b = result.bonus[i];
			    	   $('#bonusBody').append('<tr>');
			    	   $('#bonusBody').append('<td class="hidden">'+b.id+'</td>');
			    	   $('#bonusBody').append('<td>'+(i+1)+'</td>');
			    	   $('#bonusBody').append('<td>'+b.condition+'</td>');
			    	   $('#bonusBody').append('<td style="width:45%">'+b.condition+'</td>');
			    	   if (b.donation == 0) {
			    	   		$('#bonusBody').append('<td>不可转赠</td>');
			    	   	} else {
			    	   		$('#bonusBody').append('<td>可转赠</td>');
			    	   	}
			    	   	if (b.lifeCycle == 0) {
			    	   		$('#bonusBody').append('<td>一万年有效</td>');
			    	   	} else if (b.lifeCycle == 1) {
			    	   		$('#bonusBody').append('<td>'+b.expiresPoint+'到期</td>');
			    	   	} else if (b.lifeCycle == 1) { 
			    	   		$('#bonusBody').append('<td>自领取后'+b.expiresPoint+'天过期</td>');
			    	   	}else {
			    	   		$('#bonusBody').append('<td></td>');
			    	   	}
			    	   $('#bonusBody').append('<td>'+b.amount+'元</td>');
			    	   $('#bonusBody').append('<td><a href=javascript:choiceCoupon('+b.id+','+b.financePeriod+',"'+b.amount+'","'+ b.name+','+b.category+');>选择</a></td>');
			    	   $('#bonusBody').append('</tr>');
				   }
			       
			       var totalPages = Math.ceil(result.total/15);
			       var options = {
				        currentPage: result.newsPage,
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
			            	getCoupon(page);
			            }  
				    };
					$('#bonus-page').bootstrapPaginator(options);
		       }else{
		    	   $('#bonusBody').html('<tr><td colspan="5">请先添加红包</td></tr>');	
		       }
           });
		}
		
		function choiceCoupon(couponId, financePeriod, amount, condition, category, ruleNum){
			var company = '';
			if(category >= 4){
	 	   		company = '%('+financePeriod+'天)';
	 	   	}else{
				company = '元';
	 	   	}
			$('#bonus').modal('hide');
			$('#couponQuantitys').val(1);
			if (ruleNum >= 0) {
				if ($('#ruleCouponIds'+ruleNum).val()) {
					$('#ruleCouponIds'+ruleNum).val($('#ruleCouponIds'+ruleNum).val()+','+couponId);
				} else {
					$('#ruleCouponIds'+ruleNum).val(couponId);
				}
				if ($('#ruleCouponAmounts'+ruleNum).val()) {
					$('#ruleCouponAmounts'+ruleNum).val($('#ruleCouponAmounts'+ruleNum).val()+','+amount+company);
				} else {
					$('#ruleCouponAmounts'+ruleNum).val(amount+company);
				}
				$('#paybackRuleGroup'+ruleNum).empty();
				//$('#paybackRuleGroup'+ruleNum).append('<a href="javascript:remove(div'+index+')" id="div'+index+'" amount="'+amount+'"><input id="couponIds'+index+'" name="couponIds"  value="'+couponId+'" type="hidden" ><input id="couponAmount'+index+'" name="couponAmounts"  value="'+amount+company+'" type="hidden" ><input id="coupons'+index+'" name="coupons"  value="'+couponId+'*'+amount+company+'" type="hidden" ><span class="label label-important" style="height:22px;width:75px;margin-top: 1px;margin-left: 5px;padding-top: 8px" title="点击可删除">'+ amount + company +' </span></span></a>');
				$('#paybackRuleGroup'+ruleNum).append('<a href="javascript:  (div'+index+', '+ruleNum+', '+couponId+', '+"'"+amount+company+"'"+')" id="div'+index+'" amount="'+amount+'"><input id="couponIds'+index+'" name="couponIds"  value="'+couponId+'" type="hidden" ><input id="couponAmount'+index+'" name="couponAmounts"  value="'+amount+company+'" type="hidden" ><input id="coupons'+index+'" name="coupons"  value="'+couponId+'*'+amount+company+'" type="hidden" ><span class="label label-important" style="height:22px;width:75px;margin-top: 1px;padding-top: 8px" title="点击可删除">'+ amount + company +' </span></span></a>');
				
				$('#paybackRuleGroup'+ruleNum).append(' ');
				$('#couponQuantitys').blur();
			} else {
				$('#quantityGroup').empty();
				$('#quantityGroup').append('<a href="javascript:remove(div'+index+')" id="div'+index+'" amount="'+amount+'"><input id="couponIds'+index+'" name="couponIds"  value="'+couponId+'" type="hidden" ><input id="couponAmount'+index+'" name="couponAmounts"  value="'+amount+company+'" type="hidden" ><input id="coupons'+index+'" name="coupons"  value="'+couponId+'*'+amount+company+'" type="hidden" ><span class="label label-important" style="height:22px;width:75px;margin-top: 1px;padding-top: 8px" title="点击可删除">'+ amount + company +' </span></span></a>');
				$('#quantityGroup').append(' ');
				$('#couponQuantitys').blur();
			}
		}
		
		function readOnly(){   
	        var a = document.getElementsByTagName("input");   
	        for(var i=0; i<a.length; i++){   
	           if(a[i].type=="checkbox" || a[i].type=="radio" || a[i].type=="text"){
	        	   a[i].readOnly = true;
	        	   a[i].disabled = "disbaled";
	           }     
	        }
		}
		var ruleNum = 0;
		$('#add').click(function(){
			if(ruleNum == 6) {
				alert('亲，赠送规则最高只能添加6个层次！');
				return false;
			}
			
			addRule()
			
		});
		
		function addRule() {
			var html = '<div id="rule'+ruleNum+'"><div class="controls" style="margin-top: 10px;">';
			html += '<label class="control-label">回款金额满</label>';
			html += '<div class="controls">';
			html += '<input type="hidden" id="ruleCouponIds'+ruleNum+'" name="rules['+ruleNum+'].couponIds" >';
			html += '<input type="hidden" id="ruleCouponAmounts'+ruleNum+'" name="rules['+ruleNum+'].couponAmounts" >';
			html += '<input type="text"  style="width: 80px;" id="ruleQuota'+ruleNum+'" name="rules['+ruleNum+'].quota"  class="validate[required,min[1],custom[integer],max[9999999]] text-input"/>';
			html += '<span>元，奖励红包</span>';
			html += '<input type="text"  style="width: 120px;" onclick="showBonusDialog(0, '+ruleNum+')" readonly class="text-input"/>';
			html += '<span>奖励加息券</span>';
			html += '<input type="text"  style="width: 120px;" onclick="showBonusDialog(4, '+ruleNum+')" readonly class="text-input"/>';
			if (ruleNum > 0) {
				html += '<input type="button" class="btn btn-lg" value="删除" onclick="delHtml('+ruleNum+')">';
			}
			
			html += '<div class="control-group" style="margin-left: -165px;" >';
			html += '<label class="control-label"><span class="required">*</span>优惠券预览</label>';
			html += '<div class="controls" style="margin-top:5px;" id="paybackRuleGroup'+ruleNum+'">';
			html += '</div></div>';
			html += '</div></div></div>';
			$('#list').append(html);
			ruleNum++;
		}
		
		
		function delHtml(num) {
			$('#rule'+num).remove();
			ruleNum--;
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
</html>