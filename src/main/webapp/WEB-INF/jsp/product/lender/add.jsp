<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
	<link href="${pageContext.request.contextPath}/plugin/select/select2.css" rel="stylesheet" />
	<body>
		<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
        <div class="container-fluid">
            <div class="row-fluid">
                <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
                <div class="span10" id="content">
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div class="block-content collapse in">
			                    <form class="form-horizontal" style="margin-bottom: 0;" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/product/lender/save">
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<input id="id" name="id" value="0" type="hidden">
				                    	<input name="page" value="${page }" type="hidden">
				                    	<input type="hidden" value='${lender.idcardUrl}' name="idcardUrl"/>
				                    	<input name="size" value="${size }" type="hidden">
										<div class="row-fluid">
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 姓名</label>
													<div class="controls"><input type="text" id="name" name="name" value="${lender.name}" placeholder="20个字符以内" class="validate[required,maxSize[20]] text-input span9" /></div>
												</div>
											</div>
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 身份证号码</label>
													<div class="controls"><input type="text" id="idcard" name="idcard" value="${lender.idcard}" class="validate[required,minSize[15],maxSize[18]] text-input span9" /></div>
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 借款期限</label>
													<div class="controls"><input type="text" id="loanPeriod" name="loanPeriod"  class="validate[required,custom[number],min[1],max[999]] text-input span9" />&nbsp;&nbsp;天</div>
												</div>
											</div>
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 借款金额</label>
													<div class="controls"><input type="text" id="loanAmount" name="loanAmount"  class="validate[required,custom[number],min[1],max[200000]] text-input span9" />&nbsp;&nbsp;元</div>
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 手机号</label>
													<div class="controls"><input type="text" id="cellphone" name="cellphone" value="${lender.cellphone}" class="validate[required,custom[cellphone]] text-input span9"/></div>
												</div>
											</div>
										</div>
										<div class="control-group">
											<label class="control-label">联系地址</label>
											<div class="controls"><input type="text" id="address" name="address" value="${lender.address}" class="validate[maxSize[100]] text-input span9"  placeholder="不超过100个字符"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
										</div>
										<div class="row-fluid">
											<div class="span4" id="licensesDiv">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 身份证照片</label>
													 <div class="controls">
													 	<a class="thumbnail" style="float: left; height:300px; width: 217px;">
															<div style="height:270px;width:217px;" id="preview_idcardImg" >
															  <c:if test="${not empty lender.idcardUrl}">
															   <img style="height:270px; width: 217px;" src='${lender.idcardUrl}'/>
															  </c:if>
															</div>
															<input type="hidden" value='${lender.idcardUrl}' name = "idcardPhoto" id="idcardPhoto"/>
															<input id="idcardImg" name="idcardImg" type="file" accept="image/*" style="width:163px" onchange="setContractPreview(this.id)"/>
														</a>
													 </div>
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="row-fluid">
												<label class="control-label"><span class="required"></span> 其他资料</label>
												<div class="controls">
													<div id="commitmentUpload"></div>
												    <a class="thumbnail" id="addDiv" style="float: left; height:300px; width: 217px;">
														<div style="height:270px; width: 217px;"></div>
														<button type="button" id="addCommitment" class="btn btn-lg">添加</button>
													</a>
											    </div>
										    </div>
									    </div>
										<div class="form-actions">
											<button type="submit" id="saveButton" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
											<a href="javascript:quit();"><button type="button" class="btn">返回</button></a>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
                </div>
            </div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
		<script type="text/javascript">
			var workImg=document.getElementsByTagName('img'); 
		    for(var i=0; i<workImg.length; i++) {
			   workImg[i].onclick=ImgShow;
		    }		
		
			var ge = 0;
		    var geCount = 0;
			$("#addCommitment").click(function() {
				if(geCount < 10){
					$('#commitmentUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="commitment'+ge+'"><div style="height:270px; width: 217px;" id="commitment-'+ge+'"></div><input id="commitment_'+ge+'" name="commitment'+ge+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delGuarantee('+ge+')"/></</a>');  
				    $('#commitment_'+ge).trigger('click');
				    ge = ge + 1;
				    geCount = geCount + 1;
				    if (geCount < 10) {
				    	$('#addDiv').show();
				    } else {
				    	$('#addDiv').hide();
				    }
				}else{
					 alert('其他资料数量不超过10张!');
				}
			});
			
			function delGuarantee(o){ 
			    $('#commitment'+o).remove();
			    geCount = geCount - 1;
			    $('#addDiv').show();
			}	
		
			function setContractPreview(fileInput) {
				var urlObj = $('#'+fileInput)[0];
				if(urlObj){
					var suffix = urlObj.files[0].name.split('.').pop().toLowerCase();
					if (suffix == 'png' || suffix == 'jpg') {
						if(urlObj.files[0].size <= (2102957)){
							if(urlObj.files && urlObj.files[0]){
								 var img = $('<img style="height:270px; width: 217px;" src="'+window.URL.createObjectURL(urlObj.files[0])+'">');
					             $('#preview_'+fileInput).empty().append(img);
					             $('#idcardPhoto').val("");
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
		
		
		    $(function() {
		    	$('#fm').validationEngine('attach', {
			        promptPosition:'bottomRight',
			        inlineValidation: true, 
			        validationEventTriggers:'click blur', 
			        showOneMessage: true,
			        focusFirstField:true,
			        scroll: true
			    });
		    	
			    $('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">债权管理</a>&nbsp;/&nbsp;新增债权</li>');
			    setup();
		   });
			   
		   /*  function startValidate() {
				var flag = true;
				if (!$('#idcardImg').val()) {
				   if(flag){
					   alert('请选择身份证照片');
					   flag = false;  
				   } 
			    }
				return flag;
		     
		   } */
		    function startValidate() {
		    	var idcardImg = $('#idcardImg').val();
		    	var photo = $('#idcardPhoto').val();
		    	if(photo==""){
		    		if(idcardImg==""){
		    			alert('请选择身份证照片');
		    		 	return false;
		    		}else{
		    			var b = document.getElementById('saveButton');
				        b.disabled = 'disbaled';   
		    			return true;
		    		}
		     	}else{
		     		var b = document.getElementById('saveButton');
			        b.disabled = 'disbaled';
		    		return true;
		     	}
		   }
		   
		   function quit() {
			   window.location.href='${pageContext.request.contextPath}/product/lender/list/1';
		   }
		</script>
	</body>
</html>