<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
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
			                    <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/product/guarantee/save">
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<input id="id" name="id" value="0" type="hidden">
										<div class="row-fluid">
											<div class="span12">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>名称</label>
													<div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="30个字符以内" class="validate[required, minSize[1], maxSize[30], ajax[ajaxguaranteeName]] text-input span12" id="name" name="name" /></div>
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="row-fluid">
												<label class="control-label"><span class="required">*</span>质押担保函</label>
												<div class="controls">
													<div id="guaranteeUpload"></div>
												    <a class="thumbnail" style="float: left; height:300px; width: 217px;">
														<div style="height:270px; width: 217px;"></div>
														<button type="button" id="addGuarantee" class="btn btn-lg">添加</button>
													</a>
											    </div>
										    </div>
									    </div>
										<div class="form-actions">
											<button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
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
		<script type="text/javascript">
			var protocol = '';
		    $(function() {
		    	$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">担保函管理&nbsp;</a>/&nbsp;担保函新增</li>');
		    	$('#fm').validationEngine('attach', { 
			        promptPosition: 'bottomLeft', 
			        scroll: false,
			        showOneMessage : true
			    });
		    	$('#name').focus();
		   });
		   
		    var ge = 0;
		    var geCount = 0;
			$("#addGuarantee").click(function() {
				if(geCount <= 4){
					$('#guaranteeUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="guarantee'+ge+'"><div style="height:270px; width: 217px;" id="guarantee-'+ge+'"></div><input id="guarantee_'+ge+'" name="guarantee'+ge+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delGuarantee('+ge+')"/></</a>');  
				    $('#guarantee_'+ge).trigger('click');
				    ge = ge + 1;
				    geCount = geCount + 1;
				}else{
					 alert('担保函数量不超过5张!');
				}
			});
			
			function delGuarantee(o){ 
			    $('#guarantee'+o).remove();
			    geCount = geCount - 1;
			}
		   
		   function startValidate() {
			    var flag = true;
			    $.ajaxSettings.async = false;
				$.getJSON('${pageContext.request.contextPath}/product/guarantee/duplicate/name', {
					   id: 0, 
					   fieldId: 0, 
					   fieldValue: $('#name').val() 
				}, function(data){
				   if(data && data.length>0 && data[1]){
					   if(flag){
						   if(flag){
						    	var countGuarantee = 0;
								$('input[name^="guarantee"]').each(function(){
									if($(this).val() != ''){
										countGuarantee = countGuarantee + 1;
									}
								});
								if(countGuarantee <= 0){
									alert('担保函不能为空 ');
									flag = false;
								}
						    } 
					   }
				   }else{
					   alert('【'+$('#name').val()+'】此名称已被使用请重新选择!');
					   flag = false;
				   }
				});
				$.ajaxSettings.async = true;
				return flag;
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
		   
		   function quit() {
			   window.location.href='${pageContext.request.contextPath}/product/guarantee/list';
		   }
		</script>
	</body>
</html>