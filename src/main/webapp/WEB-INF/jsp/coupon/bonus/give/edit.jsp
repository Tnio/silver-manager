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
                    <form class="form-horizontal"  id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/coupon/bonus/give/save" >
                    <input id="id" name="id" value="${dispatchingBonusLog.id}" type="hidden">
                    <input id="status" name="status" value="0" type="hidden">
                    <input id="quantity" name="quantity" value="${dispatchingBonusLog.quantity}" type="hidden">
                    <input id="category" name="category" value="${dispatchingBonusLog.category}" type="hidden">
                    <div class="accordion" id="accordion2">
					  <div class="accordion-group">
					    <div class="accordion-heading">
					      <a class="accordion-toggle btn-info" data-toggle="collapse" data-parent="#accordion2" style="text-decoration: none; ">
					       		优惠券赠送管理
					      </a>
					    </div>
					    <div id="collapseOne" class="accordion-body collapse in">
					      <div class="accordion-inner">
					      	<div class="well" style="margin: 0;">
					      		<div class="row-fluid">
				      				<div class="control-group">
										<label class="control-label"><span class="required">*</span> 选择用户</label>
										<div class="span2">
											<div class="control-group ">
												<input type="radio" id="condition" name="choiceType" value="0" class="validate[required] radio span4">
												<span >按条件筛选</span>
											</div>
										</div>
										<div class="span2">
											<div class="control-group ">
												<input type="radio" id="custom" name="choiceType" value="1" class="validate[required] radio span4">
												<span >自定义筛选</span>
											</div>
										</div>
									</div>
				      			</div>
				      			<div id="conditionId">
									<%-- <div class="row-fluid">
										<label class="control-label"><span class="required">*</span>时间筛选</label>
										<div class="span4">
											<div class="control-group">
												<label class="control-label span3"><span class="required">*</span> 开始时间</label>
												<div class="controls"><input type="text" id="beginDate" name="beginDate" value="${dispatchingBonusLog.beginDate}" class="validate[custom[date],past[#endDate]] text-input span12" onkeypress="return false"/></div>
											</div>
										</div>
										<div class="span4">
											<div class="control-group">
												<label class="control-label span3"><span class="required">*</span> 结束时间</label>
												<div class="controls"><input type="text" id="endDate" name="endDate" value="${dispatchingBonusLog.endDate}" class="validate[custom[date],future[#beginDate]] text-input span12" onkeypress="return false"/></div>
											</div>
										</div>
						      		</div> --%>
					      			<div class="control-group">
										<label class="control-label"><span class="required">*</span>条件筛选</label>
										<div class="controls">
											<select id="satisfyType" style="width: 150px;" name="satisfyType" class="span3">
												<option value="1" <c:if test="${dispatchingBonusLog.satisfyType ==1 }"> selected="selected"</c:if>>单笔投资满(元)</option>
		                                    	<option value="2" <c:if test="${dispatchingBonusLog.satisfyType ==2 }"> selected="selected"</c:if>>累计投资满(元)</option>
		                                    	<option value="3" <c:if test="${dispatchingBonusLog.satisfyType ==3 }"> selected="selected"</c:if>>回款金额满(元)</option>
		                                    	<option value="4" <c:if test="${dispatchingBonusLog.satisfyType ==4 }"> selected="selected"</c:if>>投资数满(次)</option>
		                                    	<option value="5" <c:if test="${dispatchingBonusLog.satisfyType ==5 }"> selected="selected"</c:if>>待收区间满</option>
											</select>
											<span><input type="text" style="width: 120px;" id="satisfyInitialAmount" name="satisfyInitialAmount" value="${dispatchingBonusLog.satisfyInitialAmount}" class="validate[required, custom[integer],min[1],max[9999999]] text-input span3"></span>-
											<span><input type="text" style="width: 120px;" id="satisfyEndAmount" name="satisfyEndAmount" value="${dispatchingBonusLog.satisfyEndAmount}" class="validate[required, custom[integer],min[1],max[9999999]] text-input span3"></span>
										</div>
						      		</div>
					      		</div>
					      		<div class="row-fluid" id="timeFilter">
						      		<div class="span6">
							      		<div class="control-group">
											<label class="control-label"><span class="required">*</span>时间筛选</label>
											<div class="controls">
												<input type="text" id="beginDate" value="${dispatchingBonusLog.beginDate}" name="beginDate" class="validate[required, custom[date]] text-input span4" onkeypress="return false"/>
												<span>-</span>
												<input type="text" id="endDate" value="${dispatchingBonusLog.endDate}" name="endDate" class="validate[required, custom[date]] text-input span4" onkeypress="return false"/>
											</div>
										</div>
									</div>
					      		</div>
					      		<div class="row-fluid" id="timePoint" style="display: none;">
					      			<div class="span6">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span>时间筛选</label>
											<div class="controls">
												<input type="text" id="datePoint" value="${dispatchingBonusLog.endDate}" name="datePoint" class="validate[required, custom[date]] text-input span6" onkeypress="return false"/>
											</div>
										</div>
									</div>
								</div>
					      		<div id="cellphoneIds">
						      		<div class="row-fluid">
					      				<div class="control-group">
											<label class="control-label"><span class="required">*</span> 手机号</label>
											<div class="controls">
												<textarea  id="cellphones" name="cellphones" rows="2" class="validate[required, custom[numberSemicolon], maxSize[599]] span10" placeholder="不同手机号之间以英文“;”间隔，最多50个">${dispatchingBonusLog.cellphones}</textarea>
											</div>
										</div>
					      			</div>
					      		</div>
					      		<div class="row-fluid">
					      			<div class="span6">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 赠送日期</label>
											<div class="controls">
												<input type="text" id="giveDate" name ="giveDate" value="${dispatchingBonusLog.giveDate}" class="validate[custom[date]] text-input span6" onkeypress="return false"/>
											</div>
										</div>
									</div>
								</div>
					      		<div class="row-fluid">
					      			<div class="span6">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span>选择红包</label>
											<div class="controls">
												<input type="text" class="text-input span6" readonly onclick="showBonusDialog(0)"/>
											</div>
										</div>
					      			</div>
					      		</div>
					      		<div class="row-fluid">
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
												<c:forEach var="couponId" items="${fn:split(dispatchingBonusLog.couponIds,',')}" varStatus="status">
													<c:forEach var="couponAmount" items="${fn:split(dispatchingBonusLog.couponAmounts,',')}" varStatus="statuss">
														<c:if test="${status.index == statuss.index}">
															<a <c:if test="${operation == 'edit'}"> href="javascript:remove(div${status.count})"</c:if><c:if test="${operation == 'detail'}"> href="javascript:showDialog(${couponId})"</c:if> id="div${status.count}">
															<input id="couponIds${status.count}" name="couponIds" value="${couponId}" type="hidden" >
															<input id="couponAmount${status.count}" name="couponAmounts"  value="${couponAmount}" type="hidden" >
															<span class="label label-important" style="height:22px;width:75px;margin-top: 1px;padding-top: 8px" title="点击可删除"> 
																${couponAmount}
															</span></a>
														</c:if>
													</c:forEach>
                                           		</c:forEach>
											</div>
										</div>
					      			</div>
					      		</div>
				      			<div class="row-fluid">
				      				<div class="control-group">
										<label class="control-label"><span class="required">*</span> 赠送原因</label>
										<div class="controls">
											<textarea  id="reason" name="reason" rows="2" class="validate[required, maxSize[100]] span10" placeholder="50个汉字以内">${dispatchingBonusLog.reason}</textarea>	
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
												<input type="radio" id="templateId" prot="1" name="template.id" value="${dispatchingBonusLog.template.id}" class="validate[required] span1" style="margin-top: -1px">
												<span> 是   <input type="text" id="templateConcent" class="text-input span7" readonly onclick="showTemplateDialog()"/> </span>
											</div>
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
					  		<a class="btn btn-default btn-lg" href="${pageContext.request.contextPath}/coupon/bonus/give/list">返回</a>
					  	</div>
					</div>
					</form>
                    <!-- content end -->
                    <div class="modal hide fade" id="bonus" role="dialog" style="top:3%;width: 800px;" >
					  	<div class="modal-dialog modal-lg">
					    	<div class="modal-content">
					      		<div class="modal-header">
					        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					        			<span aria-hidden="true">&times;</span>
					        		</button>
					        		<h4 class="modal-title" id="myModalLabel">选择优惠券</h4>
					      		</div>
					      		<div class="modal-body" style="max-height:350px;">
			                        <table class="table table-striped" >
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
					      		<div class="modal-header" >
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
	    var index = $.trim('${dispatchingBonusLog.couponIds}').split(',').length + 1;
	    var flag = $.trim('${dispatchingBonusLog.couponIds}').split(',').length;
	    var type = '${dispatchingBonusLog.satisfyType}';
	    if (type == 5) {
	    	$('#timePoint').show();	
			$('#timeFilter').hide();	
		} else {
			$('#timePoint').hide();	
			$('#timeFilter').show();	
		}
	    var choiceType = '${dispatchingBonusLog.choiceType}'
	    if (choiceType == 1) {
	    	 $('#timeFilter').hide();
	    }
	    $('#satisfyType').change(function(){
			var value = $(this).val();
			if (value == 5) {
				$('#timePoint').show();	
				$('#timeFilter').hide();	
			} else {
				$('#timePoint').hide();	
				$('#timeFilter').show();	
			}
		});
	    $(function() {
			$('input[name=choiceType]').change(function(){
			   var value = $('[name=choiceType]').filter(':checked').attr('value');
			   if (value == 0) {
				   $('#cellphones').val('');
				   $('#cellphoneIds').hide();
				   $('#conditionId').show();
				   $('#timeFilter').show();
				   $('#satisfyInitialAmount').val('');
				   $('#satisfyEndAmount').val('');
			   } else {
				   $('#satisfyInitialAmount').val(0);
				   $('#satisfyEndAmount').val(0);
				   $('#beginDate').val('');
				   $('#endDate').val('');
				   $('#cellphoneIds').show();
				   $('#conditionId').hide();
				   $('#timeFilter').hide();
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
			if('${dispatchingBonusLog.cellphones}' !='' && '${dispatchingBonusLog.cellphones}' != null ){
				$('#cellphoneIds').show();
				$('#conditionId').hide();
				$('#custom').attr("checked",true);
			}else{
				$('#cellphoneIds').hide();
				$('#conditionId').show();
				$('#condition').attr("checked",true);
			}
			if($.trim('${dispatchingBonusLog.template.id}')=='0') {
				$('#templateGroup').find('input:radio').eq(0).attr('checked','checked');
			}else{
				$('#templateGroup').find('input:radio').eq(1).attr('checked','checked');
				$('#templateConcent').val('${dispatchingBonusLog.template.content}');
			} 
			
			$('#fm').validationEngine('attach', { 
		        promptPosition: 'centerRight', 
		        scroll: false,
		        showOneMessage : true
		   	});
			if('${operation}' == 'edit'){
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">优惠券赠送管理</a>&nbsp;/&nbsp;编辑优惠券赠送</li>');
				$('#save').show();
			}else{
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">优惠券赠送管理</a>&nbsp;/&nbsp;查看优惠券赠送</li>');
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
	    
		function showBonusDialog(category){
			if(flag <= 19){
				getBonus(1, category);
				$('#bonus').modal('show');
			}else{
				alert('您一次不能添加更多的优惠券了!');
			}
		}
		
		function quit(){
			window.location.href='${pageContext.request.contextPath}/coupon/bonus/give/list';
		}
		$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">优惠券赠送管理</a>&nbsp;/&nbsp;编辑优惠券赠送</li>');
			
		$('#fm').validationEngine('attach', { 
	        promptPosition: 'centerRight', 
	        scroll: false,
	        showOneMessage : true
	    });
		
		function getBonus(page, category){
			$.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/'+ page,{"category": category}, function(result){
			   	if (result.total > 0) {
					$('#bonusBody').html("");
					var company = '';
					if(category == 0){
						company = '元';
					}else{
						company = '%';
					}
					for (var i = 0; i < result.bonus.length; i++) {
						var b = result.bonus[i];
						$('#bonusBody').append('<tr>');
						$('#bonusBody').append('<td class="hidden">'+b.id+'</td>');
						$('#bonusBody').append('<td>'+(i+1)+'</td>');
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
			    	   	} else if (b.lifeCycle == 2) { 
			    	   		$('#bonusBody').append('<td>自领取后'+b.expiresPoint+'天过期</td>');
			    	   	}else {
			    	   		$('#bonusBody').append('<td></td>');
			    	   	}
						if(category != 0){
			    	   		$('#bonusBody').append('<td>'+b.amount+company+' '+b.increaseDays+'天'+'</td>');
			    	   	}else{
			    	   		$('#bonusBody').append('<td>'+b.amount+company+'</td>');
			    	   	}
						$('#bonusBody').append('<td><a href=javascript:choiceBonus('+b.id+','+b.increaseDays+','+b.amount+',"'+ b.condition+'",'+category+');>选择</a></td>');
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
			            	getBonus(page, category);
			            }  
				    };
					$('#bonus-page').bootstrapPaginator(options);
		       }else{
		    	   $('#bonusBody').html('<tr><td colspan="5">请先添加活动优惠券</td></tr>');	
		       }
           });
		}
		
		$('#datePoint').datetimepicker({
			format:'Y-m-d',
			maxDate:addDate(new Date().toLocaleDateString(), -1),
			lang:'ch',
			scrollInput:false,
			timepicker:false
		});
		$('#beginDate').datetimepicker({
			format:'Y-m-d',
			maxDate:addDate(new Date().toLocaleDateString(), -1),
			lang:'ch',
			scrollInput:false,
			timepicker:false,
			onShow:function() {
				if ($('td').hasClass('xdsoft_other_month')) {
					$('td').removeClass('xdsoft_other_month');
				} 
			},
			onSelectDate:function() {
				var beginTime = $('#beginDate').val();
				var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
				$('#endDate').datetimepicker({
					format:'Y-m-d',
					minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
					maxDate:addDate(new Date().toLocaleDateString(),-1),
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
		
		function addDate(date, days){ 
			var d=new Date(date); 
			d.setDate(d.getDate()+days); 
			var month=d.getMonth()+1; 
			var day = d.getDate(); 
			if(month<10){ 
			month = '0'+month; 
			} 
			if(day<10){ 
			day = '0'+day; 
			} 
			var val = d.getFullYear()+'/'+month+'/'+day; 
			return val; 
		}
		
		$('#endDate').datetimepicker({
			 format:'Y-m-d',
			 maxDate:addDate(new Date().toLocaleDateString(), -1),
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
				$('#beginDate').datetimepicker({
					format:'Y-m-d',
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
		
		$('#giveDate').datetimepicker({
			format:'Y-m-d',
			lang:'ch',
			scrollInput:false,
			timepicker:false,
			minDate:new Date()
		});
		
		function startValidate() {
			var flag = true;
			var result = $('#fm').validationEngine('validate');
		 	if (result) {
				var quantity = $.trim($('#quantity').val());
				if(quantity == 0){
					alert('请至少选择一个优惠券');
					flag = false;
			    	return flag;
				}
				var value = $('[name=choiceType]').filter(':checked').attr('value');
				if(value == 1){
					var cellphones = $.trim($('#cellphones').val());
					if (cellphones && cellphones.length > 0) {
						var cellarry = cellphones.split(';');
						for (var i = 0; i < cellarry.length; i++) {
							if (cellarry[i].length == 11) {
								cellphones = cellphones.replace(cellarry[i], '');
								if (cellphones.indexOf(cellarry[i]) > -1) {
									alert('输入的手机号：'+cellarry[i]+'重复');
									return false;
								}
							} else {
								alert('输入的手机号：'+cellarry[i]+'无效');
								return false;
							}
						}
						
						$.ajaxSettings.async = false;
						$.post('${pageContext.request.contextPath}/coupon/user/exist', {'cellphones':$.trim($('#cellphones').val())}, function(result){
						    if (result && result.code == 200) {
						    	flag = true;
						    } else {
						    	alert(result.msg + '未注册');
						    	flag = false;
						    	return flag;
						    }
			            });
					} else {
						alert('手机号不能为空');
						flag = false;
				    	return flag;
					}
				}
				var rea = $.trim($('#reason').val());
				if(!rea){
					flag = false;
					alert('赠送原因不能为空');
					return flag;
				}
				return flag;
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
		
		function choiceBonus(couponId, financePeriod, amount, condition, category){
			if(flag > 19){
				alert('您一次不能添加更多的优惠券了!');
				return ;
			}
			var company = '';
			if(category == 0){
				company = '元';
	 	   	}else{
	 	   		company = '%('+financePeriod+'天)';
	 	   	}
			if($('#quantity').val() != ''){
				$('#quantity').val(parseInt($('#quantity').val()) + 1);
			}else{
				$('#quantity').val(1);
			}
			//$('#bonus').modal('hide');
			$('#quantityGroup').append('<a href="javascript:remove(div'+index+')" id="div'+index+'" amount="'+amount+'"><input id="couponIds'+index+'" name="couponIds"  value="'+couponId+'" type="hidden" ><input id="couponAmount'+index+'" name="couponAmounts"  value="'+amount+company+'" type="hidden" ><input id="coupons'+index+'" name="coupons"  value="'+couponId+'*'+amount+company+'" type="hidden" ><span class="label label-important" style="height:22px;width:70px;margin-top: 1px;padding-top: 8px" title="点击可删除">'+ amount + company +'</span></a>');
			$('#quantityGroup').append(' ');
			index++;
			flag++;
			$('#quantity').blur();
		}
		
		function remove(id){
			flag --;
			$('#quantity').val(parseInt($('#quantity').val()) - parseInt(1));
			$('#quantity').blur();
			$(id).remove();
		}
		
		function readOnly(){   
	        var a = document.getElementsByTagName("input");   
	        for(var i=0; i<a.length; i++){   
	           if(a[i].type=="checkbox" || a[i].type=="radio" || a[i].type=="text"){
	        	   a[i].readOnly = true;
	        	   a[i].disabled = "disbaled";
	           }     
	        }
	        
	        var c = document.getElementsByTagName("textarea");
	        for (var i=0; i<c.length; i++){   
	        	c[i].disabled="disabled";   
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
</html>