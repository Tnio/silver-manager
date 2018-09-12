<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                   <div class="row-fluid">
                    <!-- content begin -->
                    <form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post" onsubmit="return startValidateAndUpload();" action="${pageContext.request.contextPath}/product/save"  autocomplete="off">
						 <div class="well" style="padding-bottom: 20px; margin: 0;">
						    <input id="id" name="id" value="0" type="hidden">
						    <input name="actualAmount" value="0" type="hidden">
						    <input id="productCategoryProperty" name="category.property" type="hidden" value="">
						  	<input name="page" value="${page }" type="hidden">
                    		<input name="size" value="${size }" type="hidden">
                    		<input name="productName" value="${productName }" type="hidden">
							<input name="productStatue" value="${statue}" type="hidden">
							<input name="productRisk" value="${risk}" type="hidden">
							<input name="productFinancePeriod" value="${financePeriod}" type="hidden">
							<input name="productCategoryId" value="${categoryId}" type="hidden">
							<input name="parent.id" value="${product.id}" type="hidden">
							<input name ="institutionDesc" value="${product.institutionDesc}" type="hidden">
							<!-- <input id="pd" name ="productDesc" value="" type="hidden"> -->
							<input name ="securityDesc" value="${product.securityDesc}" type="hidden">
							<input name ="assetsSafety" value="${product.assetsSafety}" type="hidden">
							<input name ="label" value="${product.label}" type="hidden">
	                    	<div class="control-group">
								<label class="control-label"><span class="required">*</span> 产品名称</label>
								<div class="controls"><input type="text" id="name" name="name" class="validate[required,maxSize[20],ajax[checkProductName]] text-input span12" placeholder="不超过10个汉字" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
							</div>
							<div class="row-fluid">
								<div class="span6">
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 产品类型</label>
										<div class="controls">
										    <select id="category"  name="category.id" class="validate[required] span12" onchange="valuation(this.value)">
										    <option></option>
                                            <c:forEach items="${categorys}" var="category">
                                            		<option id="${category.id}" value="${category.id}" label="${category.property}" >${category.name}</option>
                                           	</c:forEach>
											</select>
									    </div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 募集金额</label>
										<div class="controls"><input type="text" id="totalAmount" name="totalAmount"   value="<fmt:formatNumber type="currency" value="${product.totalAmount - product.actualAmount}" currencySymbol="" pattern="#"/>" class="validate[required,custom[number],min[1],max[${product.totalAmount - product.actualAmount}]] text-input span11" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" disabled="disabled"/> 元</div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 上架时间</label>
										<div class="controls"><input type="text" id="shippedTime" name="shippedTime"  class="validate[required] text-input span12" onkeypress="return false"/></div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 起投金额</label>
										<div class="controls">
											<select id="lowestMoney" name="lowestMoney" class="span11" required>
                                            	<c:forEach items="${lowestMoneys}" var="lowestMoney">
                                            		<option value="${lowestMoney.value}" >${lowestMoney.value}</option>
                                            	</c:forEach>
											</select> 元
										</div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required"></span> 列表排序</label>
										<div class="controls"><input type="text" name="sortNumber" class="validate[custom[integer],min[1],max[999]] text-input span12" value="999" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/></div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 起息时间</label>
										<div class="controls"><input type="text" id="interestDate"id="interestDate" name ="interestDate" onblur="colcDateTime()"  class="validate[required] text-input span12" onkeypress="return false"/></div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 到期时间</label>
										<div class="controls"><input type="text" id="dueTime" name="dueTime"   class="span12" placeholder="根据起息时间和理财期限自动计算" readonly="readonly"/></div>
									</div>
								</div>
								<div class="span6">
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 年化收益</label>
										<div class="controls"><input type="text" id="yearIncome" name="yearIncome"   class="validate[required,custom[numberSp],min[0.01],max[36]] text-input span11" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" placeholder="输入的数字不大于 36" /> %</div>
									</div>
									<div class="control-group" id="increaseInterestGroup">
										<label class="control-label"> 产品加息</label>
										<div class="controls"><input type="text" id="increaseInterest" name="increaseInterest" class="validate[custom[numberSp],min[0],max[20]] text-input span11" value="0" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" placeholder="输入的数字不大于 20"/> %</div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 父产品</label>
										<div class="controls"><input type="text" name="parent.name"  value="${product.name}" class="span12" readonly="readonly"/></div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 风险程度</label>
										<div class="controls">
										    <select name="risk" class="span12" required>
                                            <c:forEach items="${risks}" var="risk">
	                                            <option value="${risk.value}">${risk.value}</option>
                                             </c:forEach>
											</select>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 募集周期</label>
										<div class="controls"><input type="text" id="raisePeriod" name="raisePeriod"  class="validate[required,custom[integer],min[1],max[30]] text-input span11" onblur="colcDateTime()" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 天</div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 理财期限</label>
										<div class="controls">
											<input type="text" id="financePeriod" name="financePeriod" class="validate[required,custom[onlyNumberSp],min[1],max[999]] text-input span11" onblur="colcDateTime()"  onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 天
										</div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span> 活动优惠</label>
										<div class="controls">
											<select id="bonus" name="bonus.id" class="span12" >
											<option value="0" selected="selected">无</option>
                                            <c:forEach items="${bonus}" var="b">
	                                            <option value="${b.key}">${b.value}</option>
                                            </c:forEach>
											</select>
										</div>
									</div>
									<div class="control-group" style="display: none">
										<label class="control-label">回款方式</label>
										<div class="controls">
											<select name="refund" class="span12" required>
                                            <c:forEach items="${refunds}" var="refund">
                                            		<option value="${refund.key}">${refund.value}</option>
                                           	</c:forEach>	
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">其他备注</label>
								<div class="controls">
									<textarea id="remark" name="remark" class="validate[maxSize[600]] span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" ></textarea>
								</div>
						    </div>
							<hr class="separator" />
							<div class="form-actions">
								<button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
								<button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit()"><i></i>返回</button>
							</div>
						</div>
					</form>
                    <!-- content end -->
                </div>
              </div>
            </div>
        </div>       
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script type="text/javascript">
			var d = new Date();
			$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">定期产品管理</a>&nbsp;/&nbsp;定期产品拆分</li>');
			$('#shippedTime').datetimepicker({
				format:'Y-m-d H:00:00',
				/* minDate:beforeDate.getFullYear()+'/'+(beforeDate.getMonth()+1)+'/'+beforeDate.getDate(), */
				minDate:new Date().toLocaleDateString(),
				minTime:d.getHours()+1+":00",
				lang:'ch',
				timepicker:true,
				scrollInput:false,
				onShow:function() {
					if ($('td').hasClass('xdsoft_other_month')) {
						$('td').removeClass('xdsoft_other_month');
					} 
				},
				onSelectDate:function() {
					var beginTime = $('#shippedTime').val();
					var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
					if($.trim('${systemTime}'.split(" ")[0]) == $.trim(beginTime.split(" ")[0])){
						$('#shippedTime').datetimepicker({
							format:'Y-m-d H:00:00',
							minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
							minTime:beginDate.getHours()+1+":00",
							lang:'ch',
							timepicker:true,
							onShow:function() {
								if ($('td').hasClass('xdsoft_other_month')) {
									$('td').removeClass('xdsoft_other_month');
								} 
							}
						});
						if(($.trim('${systemTime}').split(" ")[1].split(":")[0] == beginTime.split(" ")[1].split(":")[0])){
							var dateTime =  new Date(Date.parse((beginDate.getFullYear()+'-'+(beginDate.getMonth()+1)+'-'+beginDate.getDate()+" "+fix((parseInt(beginDate.getHours())+1),2)+":00:00").replace(/-/g,"/")));
							$('#shippedTime').val(dateTime.getFullYear()+'-'+(dateTime.getMonth()+1)+'-'+dateTime.getDate()+" "+fix(dateTime.getHours(),2)+":00:00");
						}
					}else{
						$('#datetimepicker4').datetimepicker('reset');
						$('#shippedTime').datetimepicker({
							format:'Y-m-d H:00:00',
							minDate:'${systemTime}',
							minTime:'00:00',
							lang:'ch',
							timepicker:true,
							onShow:function() {
								if ($('td').hasClass('xdsoft_other_month')) {
									$('td').removeClass('xdsoft_other_month');
								} 
							}
						});
					}
					
				}
			});
			
			$('#interestDate').datetimepicker({
				format:'Y-m-d',
				lang:'ch',
				scrollInput:false,
				timepicker:false
			});
			
			$(function() {
				$('#category').find('option[label="EXPERIENCE"]').attr('disabled','disabled');
				$('#category').find('option[label="NOVICE"]').attr('disabled','disabled');
				$('#fm').validationEngine('attach', { 
			        promptPosition: 'bottomLeft', 
			        scroll: false 
			    });
			});
			
			function valuation (value){
				var label ="";
				if(value == 0){
					lable ="COMMON";
					
				}else{
					label = document.getElementById(value).label;
				}
				$('#productCategoryProperty').val(label);
			}
			
			function startValidateAndUpload() {
				 var flag = true;
				  $.ajaxSettings.async = false;
				  $.getJSON('${pageContext.request.contextPath}/product/check/name', {
					   id: 0, 
					   fieldId: 0, 
					   fieldValue: $('#name').val() 
				   }, function(data){
					   if(data && data.length>0 && data[1]){
						    if(flag){
						    	if($('#shippedTime').val() != ''){
									if('${systemTime}' > $('#shippedTime').val()){
										alert("上架时间不能小于当前时间,请修改上架时间!");
										flag = false;
									}
								}
						    }
						    if(flag){
						    	if($('#productCategoryProperty').val() != null && $('#productCategoryProperty').val() != 'EXPERIENCE' && $('#productCategoryProperty').val() != 'NOVICE'){
									if($('#totalAmount').val() % $('#lowestMoney').val() != 0){
										alert("募集金额必须是起购金额的整数倍!");
										flag = false;
									}
								}
						    }
						    if(flag){
						    	if($('#productCategoryProperty').val() != null && $('#productCategoryProperty').val() != 'EXPERIENCE' && $('#productCategoryProperty').val() != 'NOVICE'){
						    		if($('#highestMoney').val() != null && $.trim($('#highestMoney').val()) != '' && $('#lowestMoney').val() != null){
										if(parseInt($('#highestMoney').val()) < parseInt($('#lowestMoney').val())){
											alert("投资上限不能小于起购金额!");
											flag = false;
										}
									}
								}
						    }
					   }else{
						   $('#name').focus();
						   alert('【'+$('#name').val()+'】此名称已被使用请重新选择!');
						   $.ajaxSettings.async = true;
						   flag = false;
					   }
				   });
				  $.ajaxSettings.async = true;
				 /*  $('#pd').val('${product.productDesc}'); */
				  return flag;
			}   
				
			function colcDateTime(){
				if($('#financePeriod').val() != '' && $('#interestDate').val() != '' ){
					  var returnDate = "";
					  if(parseInt($('#financePeriod').val()) >= 0){
						  returnDate = addDate($('#interestDate').val(), $('#financePeriod').val());
						  $('#dueTime').val(returnDate);
					  }  
				}
			}     
				   
			function addDate(date,num){
				time = date.split(' ')[1];
		   		date = new Date(date.split(' ')[0]).valueOf();
		   		date = date + num * 24 * 60 * 60 * 1000;
		   		date = new Date(date);
		   		var month = date.getMonth() + 1;
				if(month.toString().length == 1){
					month='0'+month;
		   		}
				var day = date.getDate();
		   		if(day.toString().length == 1){
			   		day = '0' + day;
		   		}
		   		return date.getFullYear() + '-' + month + '-' + day;
			}
			
			function fix(num, length) {
			  return ('' + num).length < length ? ((new Array(length + 1)).join('0') + num).slice(-length) : '' + num;
			}
			
			function quit() {
				window.location.href='${pageContext.request.contextPath}/product/1';
		    }
		</script>
	</body>
</html>