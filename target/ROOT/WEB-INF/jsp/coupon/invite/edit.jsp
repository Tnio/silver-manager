<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<c:import url="/header" />
	<body>
		<c:import url="/menu" />
        <div class="container-fluid">
            <div class="row-fluid">
                <c:import url="/sidebar" />
                <div class="span10" id="content">
                    <!-- content begin -->
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                        	<c:import url="/breadcrumb" />
                            <div class="block-content collapse in">
	                            <form id="fm" onsubmit="return validate()" enctype="multipart/form-data" action="${pageContext.request.contextPath}/coupon/invite/activity/save" method="post" class="form-horizontal" >
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<div class="control-group">
											<input id="id" name="id" value="${activity.id }" type="hidden">
											<input id="ruleStr" name="ruleStr" value="" type="hidden">
											<input name="page" value="${page }" type="hidden">
			                    			<input name="size" value="${size }" type="hidden">
			                    		</div>
				                    	<div class="control-group">
											<label class="control-label"><span class="required">*</span>活动名称</label>
											<div class="controls"><input type="text" id="name" name="name" value="${activity.name}" placeholder="3~20个汉字" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" 
												onblur="this.value=this.value.replace(/(\s*$)/g,'')" 
												class="validate[required,minSize[6],maxSize[40],ajax[ajaxValidateInviteActivityName]] span3" /></div>
										</div>
										<div class="row-fluid">
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 开始时间</label>
													<div class="controls"><input type="text" id="beginDate" name="beginDate" value="${activity.beginDate}" class="validate[required,custom[date],future[now],past[#endDate]] text-input span9" onkeypress="return false"/></div>
												</div>
											</div>
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 结束时间</label>
													<div class="controls"><input type="text" id="endDate" name="endDate" value="${activity.endDate}" class="validate[required,custom[date],future[#beginDate]] text-input span9" onkeypress="return false"/></div>
												</div>
											</div>
										</div>
										<div class="control-group">
											<div class="row-fluid"><label class="control-label"><span class="required">*</span> 邀请规则</label></div>
											<div class="controls">
												<label class="control-label">被邀请人首投金额≥</label>
												<input type="text" id="firstTradeAmount" name="firstTradeAmount" value="${activity.firstTradeAmount}" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[required,custom[integer],min[1]] text-input span4" />
											</div>
										</div>
										<div class="control-group">
											<div></div>
											<div class="span11">
												<input type="hidden" id="ruleId0" name="ruleId0" value="0"/>
												<label class="control-label"> 规则一:</label>
												<div class="controls">
													<input type="text" id="startPeriod0" name="startPeriod0" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[360]]" style="width:40px;" /><span>&nbsp;&lt;= 理财期限&nbsp;&lt;&nbsp;</span>
													<input type="text" id="endPeriod0" name="endPeriod0" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[360]]" style="width:40px;" /><span>&nbsp;天&nbsp;&nbsp;&nbsp;</span>
													<span>按照首投金额&nbsp;</span><input type="text" id="interest0" name="interest0" onkeyup="this.value=this.value.replace(/\.\d{2,}$/,value.substr(value.indexOf('.'),3))" class="validate[custom[number],min[0],max[10]]" style="width:40px;" /><span>&nbsp;%返红包&nbsp;&nbsp;&nbsp;</span>
													<span>预算总金额&nbsp;</span><input type="text" id="budgetAmount0" name="budgetAmount0" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0]]" style="width:40px;" />
													<span id="useAmountId0"><span>已扣除金额&nbsp;</span><input type="text" id="useAmount0" name="useAmount0" style="width:40px;" /></span>
												</div>
											</div>
										</div>
										<div class="control-group">
											<div></div>
											<div class="span11">
												<input type="hidden" id="ruleId1" name="ruleId1" value="0"/>
												<label class="control-label"> 规则二:</label>
												<div class="controls">
													<input type="text" id="startPeriod1" name="startPeriod1" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[360]]" style="width:40px;" /><span>&nbsp;&lt;= 理财期限&nbsp;&lt;&nbsp;</span>
													<input type="text" id="endPeriod1" name="endPeriod1" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[360]]" style="width:40px;" /><span>&nbsp;天&nbsp;&nbsp;&nbsp;</span>
													<span>按照首投金额&nbsp;</span><input type="text" id="interest1" name="interest1" onkeyup="this.value=this.value.replace(/\.\d{2,}$/,value.substr(value.indexOf('.'),3))" class="validate[custom[number],min[0],max[10]]" style="width:40px;" /><span>&nbsp;%返红包&nbsp;&nbsp;&nbsp;</span>
													<span>预算总金额&nbsp;</span><input type="text" id="budgetAmount1" name="budgetAmount1" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0]]" style="width:40px;" />
													<span id="useAmountId1"><span>已扣除金额&nbsp;</span><input type="text" id="useAmount1" name="useAmount1" style="width:40px;" /></span>
												</div>
											</div>
										</div>
										<div class="control-group">
											<div></div>
											<div class="span11">
												<input type="hidden" id="ruleId2" name="ruleId2" value="0"/>
												<label class="control-label"> 规则三:</label>
												<div class="controls">
													<input type="text" id="startPeriod2" name="startPeriod2" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[360]]" style="width:40px;" /><span>&nbsp;&lt;= 理财期限&nbsp;&lt;&nbsp;</span>
													<input type="text" id="endPeriod2" name="endPeriod2" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[360]]" style="width:40px;" /><span>&nbsp;天&nbsp;&nbsp;&nbsp;</span>
													<span>按照首投金额&nbsp;</span><input type="text" id="interest2" name="interest2" onkeyup="this.value=this.value.replace(/\.\d{2,}$/,value.substr(value.indexOf('.'),3))" class="validate[custom[number],min[0],max[10]]" style="width:40px;" /><span>&nbsp;%返红包&nbsp;&nbsp;&nbsp;</span>
													<span>预算总金额&nbsp;</span><input type="text" id="budgetAmount2" name="budgetAmount2" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0]]" style="width:40px;" />
													<span id="useAmountId2"><span>已扣除金额&nbsp;</span><input type="text" id="useAmount2" name="useAmount2" style="width:40px;" /></span>
												</div>
											</div>
										</div>
										<div class="control-group">
											<div></div>
											<div class="span11">
												<input type="hidden" id="ruleId3" name="ruleId3" value="0"/>
												<label class="control-label"> 规则四:</label>
												<div class="controls">
													<input type="text" id="startPeriod3" name="startPeriod3" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[360]]" style="width:40px;" /><span>&nbsp;&lt;= 理财期限&nbsp;&lt;&nbsp;</span>
													<input type="text" id="endPeriod3" name="endPeriod3" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[360]]" style="width:40px;" /><span>&nbsp;天&nbsp;&nbsp;&nbsp;</span>
													<span>按照首投金额&nbsp;</span><input type="text" id="interest3" name="interest3" onkeyup="this.value=this.value.replace(/\.\d{2,}$/,value.substr(value.indexOf('.'),3))" class="validate[custom[number],min[0],max[10]]" style="width:40px;" /><span>&nbsp;%返红包&nbsp;&nbsp;&nbsp;</span>
													<span>预算总金额&nbsp;</span><input type="text" id="budgetAmount3" name="budgetAmount3" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0]]" style="width:40px;" />
													<span id="useAmountId3"><span>已扣除金额&nbsp;</span><input type="text" id="useAmount3" name="useAmount3" style="width:40px;" /></span>
												</div>
											</div>
										</div>
										<div class="control-group">
											<div></div>
											<div class="span11">
												<input type="hidden" id="ruleId4" name="ruleId4" value="0"/>
												<label class="control-label"> 规则五:</label>
												<div class="controls">
													<input type="text" id="startPeriod4" name="startPeriod4" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[360]]" style="width:40px;" /><span>&nbsp;&lt;= 理财期限&nbsp;&lt;&nbsp;</span>
													<input type="text" id="endPeriod4" name="endPeriod4" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[360]]" style="width:40px;" /><span>&nbsp;天&nbsp;&nbsp;&nbsp;</span>
													<span>按照首投金额&nbsp;</span><input type="text" id="interest4" name="interest4" onkeyup="this.value=this.value.replace(/\.\d{2,}$/,value.substr(value.indexOf('.'),3))" class="validate[custom[number],min[0],max[10]]" style="width:40px;" /><span>&nbsp;%返红包&nbsp;&nbsp;&nbsp;</span>
													<span>预算总金额&nbsp;</span><input type="text" id="budgetAmount4" name="budgetAmount4" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0]]" style="width:40px;" />
													<span id="useAmountId4"><span>已扣除金额&nbsp;</span><input type="text" id="useAmount4" name="useAmount4" style="width:40px;" /></span>
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="span11" id="contentWrap">
												<label class="control-label"><span class="required">*</span> 活动规则</label>
												<div class="controls">
													<textarea id="ruleContent" name="ruleContent" class="validate[required] text-input span11" rows="5" placeholder="最多1000个汉字">${activity.ruleContent}</textarea>
												</div>
											</div>
										</div>
										<div class="form-actions">
											<button type="submit" id="save" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
											<button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit();"><i></i>返回</button>
										</div>
									</div>
								</form>
                            </div>
                        </div>
                        <!-- /block -->
                    </div>
                    <!-- content end -->
                </div>
            </div>
        </div>
        <c:import url="/footer" />
	</body>
	<script src="${pageContext.request.contextPath}/res/js/show.original.image.js"></script>
	<script type="text/javascript">
		var ruleContent ='';
		$(function(){
			$('#fm').validationEngine('attach', { 
		        promptPosition: 'bottomRight', 
		        scroll: false 
		    });
			if('${operation}' == 'edit'){
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">邀请赠送管理</a>&nbsp;/&nbsp;编辑邀请赠送活动</li>');
				$('#useAmountId0').hide();
				$('#useAmountId1').hide();
				$('#useAmountId2').hide();
				$('#useAmountId3').hide();
				$('#useAmountId4').hide();
				$('#save').show();
			}else{
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">邀请赠送管理</a>&nbsp;/&nbsp;查看邀请赠送活动</li>');
				$('#save').hide();
				readOnly();
			}
			
			var activityId = '${activity.id}';
			$.ajax({
				type:'get', 
				async: false,
				dataType:'json', 
				url: '${pageContext.request.contextPath}/coupon/invite/activity/rule/list/'+activityId, 
				success: function(data){
					for(var i = 0; i < data.length; i++){
						$('#ruleId'+i).val(data[i].id);
						$('#startPeriod'+i).val(data[i].startPeriod);
						$('#endPeriod'+i).val(data[i].endPeriod);
						$('#interest'+i).val(data[i].interest);
						$('#budgetAmount'+i).val(data[i].budgetAmount);
						$('#useAmount'+i).val(data[i].useAmount);
					}
	            }
	        });
			
			ruleContent = UE.getEditor('ruleContent');
		});
		
		$('#beginDate').datetimepicker({
			format:'Y-m-d',
			lang:'ch',
			timepicker:false
		});
		
		$('#endDate').datetimepicker({
			 format:'Y-m-d',
			 lang:'ch',
			 timepicker:false
		});
		
		function validate(){
			var flag = true;
			var txt = ruleContent.getContent();
	       	if($.trim(txt) == ''){
	    	   $('#ruleContent').addClass('validate[required]');
	        }else if(txt.length > 10000){
	    	   alert('字数超出限制');
	    	   flag = false;
	        }else{
	    	   $('#ruleContent').removeClass('validate[required]');
	        }
			var ruleStr = '';
			for(var i = 0;i < 5; i++){
				var ruleId = $('#ruleId'+i).val();
				var startPeriod = $('#startPeriod'+i).val();
				var endPeriod = $('#endPeriod'+i).val();
				var interest = $('#interest'+i).val();
				var budgetAmount = $('#budgetAmount'+i).val();
				if(startPeriod == '' || startPeriod == null){
					startPeriod = 0;
				}
				if(endPeriod == '' || endPeriod == null){
					endPeriod = 0;
				}
				if(interest == '' || interest == null){
					interest = 0;
				}
				if(budgetAmount == '' || budgetAmount == null){
					budgetAmount = 0;
				}
				ruleStr += (ruleId + ',' + startPeriod + ',' + endPeriod + ',' + interest + ',' + budgetAmount +';');
			}
			$('#ruleStr').val(ruleStr);
		    return flag;
		}
		
		function quit() {
		   window.location.href='${pageContext.request.contextPath}/coupon/invite/activity/list/${page}';
	    }
		
		function readOnly() {   
	        var a = document.getElementsByTagName("input");   
	        for(var i=0; i<a.length; i++)   {   
	           if(a[i].type=="text"){
	        	   a[i].readOnly = true;
	        	   a[i].disabled = "disbaled";
	           }     
	        }
	        
	        var c = document.getElementsByTagName("textarea");
	        for (var i=0; i<c.length; i++) {   
	           c[i].disabled="disabled";   
	        }
	        
		}
	</script>
</html>