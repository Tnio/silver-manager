<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
						<input name="parent.id" value="${product.id}" type="hidden">
						<input name="page" value="${page}" type="hidden">
						<input name="size" value="${size}" type="hidden">
						<input name="actualAmount" value="0" type="hidden">
						<input id="productCategoryProperty" name="category.property" type="hidden" value="${product.category.property}">
						<input name="productName" value="${productName}" type="hidden">
						<input name="productStatue" value="${statue}" type="hidden">
						<input name="productRisk" value="${risk}" type="hidden">
						<input name="productFinancePeriod" value="${financePeriod}" type="hidden">
						<input name="productCategoryId" value="${categoryId}" type="hidden">
						<input name="backView" value="TREASURE" type="hidden">
						<!-- <input name="displayPlatform" value="1,2,3,4" type="hidden"> -->
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
													<label class="control-label"><span class="required">*</span> 父产品</label>
													<div class="controls"><input type="text" name="parent.name"  value="${product.name}" class="span12" readonly="readonly"/></div>
												</div>
											</div>
											<div class="span6">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 募集金额</label>
													<div class="controls"><input type="text" id="totalAmount" name="totalAmount" class="validate[required,custom[number],min[1],max[99999999]] text-input span11" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 元</div>
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="control-group">
												<label class="control-label"><span class="required">*</span>关联商户</label>
												<div class="controls">
													<select id="merchant.id" name="merchant.id" class="span12" required>
		                                            <c:forEach items="${merchants}" var="merchant">
			                                            <option value="${merchant.id}">${merchant.name}</option>
		                                            </c:forEach>	
													</select>
												</div>
											</div>
										</div>
										<div class="control-group" id="innerContent">
											<label class="control-label"><span class="required">*</span>项目介绍</label>
											<div class="controls">
												<textarea cols="80" id="productDesc" name="productDesc"></textarea>
											</div>
										</div>
										<div class="control-group">
									       <label class="control-label">担保方介绍</label>
									       <div class="controls">
									       	<textarea id="securedPartyDesc" name="securedPartyDesc"  class="span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
									       </div>
								        </div>
								        <div class="control-group">
									      <label class="control-label">机构介绍</label>
									      <div class="controls">
									      	<textarea id="institutionDesc" name="institutionDesc" rows="2" class="span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
									      </div>
								        </div>
								        <div class="control-group" id="innerContent">
											<label class="control-label">债权列表</label>
											<div class="controls">
												<textarea cols="80" id="obligatoryRight" name="obligatoryRight" class="span12" required></textarea>
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
		    var obligatoryRight = '';
			var productDesc = '';
		    $('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit()">活期产品管理</a>&nbsp;/&nbsp;新增活期产品子产品</li>');
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
				obligatoryRight = UE.getEditor('obligatoryRight');
				productDesc = UE.getEditor('productDesc');
			});
						
			var r = 0;
			$("#addReport").click(function() {
			    $('#reportUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="report'+r+'"><div style="height:270px; width: 217px;" id="report-'+r+'"></div><input id="report_'+r+'" name="report'+r+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delReport('+r+')"/></</a>');  
			    $('#report_'+r).trigger('click');
			    r = r + 1;  
			});
			function delReport(o){ 
			    $('#report'+o).remove();  
			}
			
			var p = 0;
			$("#addProtocol").click(function() { 
			    $('#protocolUploader').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="protocol'+p+'"><div style="height:270px; width: 217px;" id="protocol-'+p+'"></div><input id="protocol_'+p+'" name="protocol'+p+'" type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delProtocol('+p+')"/></</a>');  
			    $('#protocol_'+p).trigger('click');
			    p = p + 1;  
			});
			function delProtocol(o){ 
			    $('#protocol'+o).remove();  
			}
			
			var c = 0;
			$("#addContract").click(function(event) {
			    $('#contractUploader').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="contract'+c+'"><div style="height:270px; width: 217px;" id="contract-'+c+'"></div><input  id="contract_'+c+'" name="contract'+c+'" type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delContract('+c+')"/></a>');  
			    $('#contract_'+c).trigger('click');
			    c = c + 1;  
			});

			function delContract(o){  
			    $('#contract'+o).remove();  
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
						if($('#totalAmount').val() != null && $.trim($('#totalAmount').val()) != ''){
							if(parseInt($('#totalAmount').val())%parseInt('${product.lowestMoney}') != 0){
								alert('子产品的募集金额必须是父产品起投金额: ${product.lowestMoney} 的整数倍!');
								flag = false;
							}
						} 
						if(flag){
						   var txt = productDesc.getContent();
						    if($.trim(txt) == ''){
						    	$('#productDesc').addClass('validate[required]');
						    }else if(txt.length > 10000){
						    	 alert('项目介绍字数超出限制');
						    	 flag = false;
						    }else{
						    	$('#productDesc').removeClass('validate[required]');
						    }
					    }
						if(flag){
					    	if($.trim($('#securedPartyDesc').val()) == '' && $.trim($('#institutionDesc').val()) == ''){
					    		alert("担保方介绍和机构介绍请至少填写一个!");
					    		flag = false;
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