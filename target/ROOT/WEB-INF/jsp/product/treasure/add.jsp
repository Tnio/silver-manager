<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
	<body>
		<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
            <div class="row-fluid">
                <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
                <div class="span9" id="content">
                	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <!-- content begin -->
                    <div class="row-fluid">
                    <form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post"  enctype="multipart/form-data" onsubmit="return startValidateAndUpload();" action="${pageContext.request.contextPath}/product/save"  autocomplete="off">
						<input id="id" name="id" value="0" type="hidden">
						<input name="page" value="${page}" type="hidden">
						<input name="size" value="${size}" type="hidden">
						<input name="actualAmount" value="0" type="hidden">
						<input id="productCategoryProperty" name="category.property" type="hidden" value="">
						<input name="productName" value="${productName}" type="hidden">
						<input name="productStatue" value="${statue}" type="hidden">
						<input name="productRisk" value="${risk}" type="hidden">
						<input name="productFinancePeriod" value="${financePeriod}" type="hidden">
						<input name="productCategoryId" value="${categoryId}" type="hidden">
						<input name="backView" value="TREASURE" type="hidden">
						<input name="displayPlatform" value="1,2,3,4" type="hidden">
						<div class="span12" style="margin-left: -2px">
						<div id="product" class="accordion">
			                <div class="accordion-group" id="base">
			                  <div class="accordion-heading">
			                    <a id="product-base-a" href="#" data-parent="#product" data-toggle="collapse" class="accordion-toggle collapsed " style="text-decoration: none">
			                     	 产品基本属性
			                    </a>
			                  </div>
			                  <div class="accordion-body collapse in" id="product-base">
			                    <div class="accordion-inner">
			                    	    <div class="well" style="padding-bottom: 20px; margin: 0;">
			                    		<div class="control-group">
											<label class="control-label"><span class="required">*</span> 产品名称</label>
											<div class="controls"><input type="text" id="name" name="name" class="validate[required,maxSize[20],ajax[checkProductName]] text-input span12"  placeholder="不超过10个汉字"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
										</div>
										<div class="row-fluid">
											<div class="span6">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 产品类型</label>
													<div class="controls">
													    <select id="category"  name="category.id" class="validate[required] span12">
				                                            <c:forEach items="${categorys}" var="category">
					                                            <option value="${category.id}" data="${category.property}" selected="selected">${category.name}</option>
				                                            </c:forEach>
														</select>
												    </div>
												</div>
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 上架时间</label>
													<div class="controls"><input type="text" id="shippedTime" name="shippedTime" class="validate[required]  text-input span12" onkeypress="return false"/></div>
												</div>
												<div class="control-group" id="sInterestDateGroup">
													<label class="control-label"><span class="required">*</span> 起息时间</label>
													<div class="controls"><input type="text"  class="text-input span12" value="购买当天起息" disabled="disabled"/></div>
												</div>
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 风险程度</label>
													<div class="controls">
													    <select id="risk" name="risk" class="span12" required>
			                                            <c:forEach items="${risks}" var="risk">
				                                            <option value="${risk.value}">${risk.value}</option>
			                                            </c:forEach>
														</select>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 基础年化</label>
													<div class="controls"><input type="text" id="yearIncome" name="yearIncome" class="validate[required,custom[numberSp],min[0.01],max[30]] text-input span11"   onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" placeholder="输入的数字不大于30"/> %</div>
												</div>
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>转出费用</label>
													<div class="controls"><input type="text" id="fee" name="fee"  class="validate[required,custom[numberSp],min[1],max[99]] text-input span9"   onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 元/笔</div>
												</div>
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>转出最低份数</label>
													<div class="controls"><input type="text" id="minPortion" name="minPortion"  class="validate[required,custom[integer],min[1],max[9]] text-input span11" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 份</div>
												</div>
											</div>
											<div class="span6">
											    <div class="control-group" id="lowestMoneyGroup">
													<label class="control-label"><span class="required">*</span> 起投金额</label>
													<div class="controls">
														<select id="lowestMoney" name="lowestMoney"  class="span11">
			                                            	<c:forEach items="${lowestMoneys}" var="lowestMoney">
				                                            	<option value="${lowestMoney.value}">${lowestMoney.value}</option>
			                                            	</c:forEach>
														</select> 元
													</div>
												</div>
												<div class="control-group" id="sRaisePeriodGroup">
													<label class="control-label"><span class="required">*</span> 募集周期</label>
													<div class="controls"><input type="text"  class="validate[text-input span11" value="无限制" disabled="disabled"/> 天</div>
												</div>
							      				<div class="control-group">
													<label class="control-label"><span class="required">*</span> 理财期限</label>
													<div class="controls">
														<input type="text" id="financePeriod" name="financePeriod" class="validate[required,custom[integer],min[1],max[999]] text-input span8" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 天后可转出
													</div>
												</div>
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 列表排序</label>
													<div class="controls"><input type="text" id="sortNumber" name="sortNumber"  class="validate[required,custom[integer],min[1],max[999]] text-input span12" value="999" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/></div>
												</div>
												<div class="control-group" id="bonusGroup">
													<label class="control-label"><span class="required">*</span>返利活动</label>
													<div class="controls">
														<select id="bonus" name="bonus.id" class="validate[required] span12" >
														<option value="0" selected="selected">无</option>
			                                            <c:forEach items="${bonus}" var="b">
				                                            <option value="${b.key}">${b.value}</option>
			                                            </c:forEach>
														</select>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>每月前</label>
													<div class="controls"><input type="text" id="freeAmount" name="freeAmount"  class="validate[required,custom[integer],min[0],max[99]] text-input span10" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 次免费</div>
												</div>
											</div>
										</div>
										<div class="control-group" id="innerContent">
											<label class="control-label"><span class="required">*</span>产品介绍</label>
											<div class="controls">
												<textarea cols="80" id="productDesc" name="productDesc" class="validate[required] text-input span12"></textarea>
											</div>
										</div>
										<div class="control-group">
											<label class="control-label"><span class="required"></span>存取说明</label>
											<div class="controls">
											<textarea  id="remark" name="remark" rows="2" class="validate[maxSize[600]] span12" placeholder="最多不能超过600个字符"></textarea>
											</div>
										</div>
										<div class="control-group">
									       <label class="control-label">风险提示</label>
									       <div class="controls">
									       	<textarea id="riskWarning" name="riskWarning" rows="2" class="span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
								           </div>
								        </div>
								        <div class="control-group">
									       <label class="control-label">资金安全</label>
									       <div class="controls">
									       	<textarea id="securityDesc" name="securityDesc" rows="2" class="span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
								           </div>
								        </div>
								        <div class="control-group">
									       <label class="control-label"><span class="required">*</span>产品协议</label>
									       <div class="controls">
									       	<textarea id="serviceProtocol" name="serviceProtocol" rows="2" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
								           </div>
								        </div>
								        <div class="row-fluid">
											<div class="control-group">
												<label class="control-label"><span class="required"></span>关联合同</label>
												<div class="controls">
													<select id="contract.id" name="contract.id" class="span12" onchange="showContract(this.value)">
													<option value="0">无</option>
		                                            <c:forEach items="${contracts}" var="contract" >
		                                            	<option value="${contract.id}">${contract.name}</option>
		                                            </c:forEach>	
													</select>
												</div>
											</div>
										</div>
								        <div class="row-fluid">
											<label class="control-label"><span class="required"></span>合同</label>
											<div class="controls">
											<div id="contractUploader"></div>
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
						  		<button  type="reset" class="btn btn-default btn-lg" onclick="quit()">返回</button>	
						  	</div>
						  </div>
						</div>
						</form>
                    <!-- content end -->
                </div>
            </div>
        </div>      
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
		<script type="text/javascript">
		    var d = new Date();
		    var totalSubmit = 0;
		    var serviceProtocol = '';
		    $('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit()">活期产品管理</a>&nbsp;/&nbsp;新增活期产品</li>');
			$('#shippedTime').datetimepicker({
				format:'Y-m-d H:00:00',
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
							minDate:d.getFullYear()+'/'+(d.getMonth()+1)+'/'+d.getDate(),
							minTime:d.getHours()+1+":00",
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
				$('#name').focus();
				$('#fm').validationEngine('attach', {
			        promptPosition:'bottomLeft',
			        showOneMessage: true,
			        focusFirstField:true,
			        scroll: false
			    }); 
			   
				var workImg=document.getElementsByTagName('img'); 
				for(var i=0; i<workImg.length; i++) {
					workImg[i].onclick=ImgShow;
				}
				colcDateTime();
				$('#productCategoryProperty').val('TREASURE');
				serviceProtocol = UE.getEditor('serviceProtocol');
			});			
			
			
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
							if(!$.trim($('#productDesc').val())) {
								alert('产品介绍不能为空');
							    flag = false;
							}
						}
						if(flag){
						   var txt = serviceProtocol.getContent();
						    if($.trim(txt) == ''){
						    	$('#serviceProtocol').addClass('validate[required]');
						    }else if(txt.length > 10000){
						    	 alert('产品协议字数超出限制');
						    	 flag = false;
						    }else{
						    	$('#serviceProtocol').removeClass('validate[required]');
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
		   		date = date + num * 24 * 60 * 60 * 1000
		   		date = new Date(date);
		   		var month = date.getMonth() + 1;
				if(month.toString().length == 1){
					month='0'+month;
		   		}
				var day = date.getDate();
		   		if(day.toString().length == 1){
			   		day = '0' + day;
		   		}
		   		return date.getFullYear() + "-" + month + "-" + day;
			}
		  
			function setImagePreview(fileInput) {
				var urlObj = $('#'+fileInput)[0];
				if(urlObj){
					var suffix = urlObj.files[0].name.split('.').pop().toLowerCase();
					if (suffix == 'png' || suffix == 'jpg') {
						if(urlObj.files[0].size <= (2102957)){
							if(urlObj.files && urlObj.files[0]){
								 var img = $('<img style="height:270px; width: 217px;" src="'+window.URL.createObjectURL(urlObj.files[0])+'">');
					             $('#'+(fileInput.split('_')[0]+'-'+fileInput.split('_')[1])).empty().append( img );
							}
						}else{
							$('#'+fileInput).val('');
			        		   alert('单个图片大小不能超过2M！');
						}
						
	        		} else {
	        		   $('#'+fileInput).val('');
	        		   alert('请选择建议的图片格式！');
		               return false;
	        		}
				}
				return true;
			}
			
			function showContract(id){
				$.ajaxSettings.async = false;
				$('#contractUploader').empty(); 
				var c = 0
				$.post('${pageContext.request.contextPath}/product/get/contract/'+id,{},function(result){
					if(result != null && result.attachments != null){
						$(result.attachments).each(function(index,element){
							if(element.category == 'CONTRACT'){
								$('#contractUploader').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="contract'+c+'"><span ><img  name="CONTRACTIMG" style="height:270px; width: 217px;" src="'+element.url+'"/></span></a>');  
								c++;
							}
						});
					}
				});
				
				var workImg=document.getElementsByTagName('img'); 
				for(var i=0; i<workImg.length; i++) {
					workImg[i].onclick=ImgShow;
				}
				$.ajaxSettings.async = true;
			}
			
			function fix(num, length) {
			  return ('' + num).length < length ? ((new Array(length + 1)).join('0') + num).slice(-length) : '' + num;
			}
			
			function quit() {
				window.location.href='${pageContext.request.contextPath}/product/treasure/list/1';
		    }
		</script>
	</body>
</html>