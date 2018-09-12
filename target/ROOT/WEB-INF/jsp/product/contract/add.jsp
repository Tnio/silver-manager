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
			                    <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/product/contract/save">
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<input id="id" name="id" value="0" type="hidden">
				                    	<input name="page" value="${page }" type="hidden">
				                    	<input name="size" value="${size }" type="hidden">
										<div class="row-fluid">
											<div class="span12">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 合同名称</label>
													<div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="6~40个字符" class="validate[required, minSize[6], maxSize[40], ajax[ajaxcontractName]] text-input span9" id="name" name="name" /></div>
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<label class="control-label"><span class="required">*</span>合同</label>
											<div class="controls">
											<div id="contractUploader"></div>
									        <a class="thumbnail" style="float: left; height:300px; width: 217px;">
								        		<div style="height:270px; width: 217px;"></div>
								        		<button type="button" id="addContract" class="btn btn-lg" >添加</button>
											</a>
									      </div>
									    </div>
									    <div class="row-fluid">
											<label class="control-label"><span class="required"></span>监管报告</label>
											<div class="controls">
												<div id="reportUpload"></div>
										    	<a class="thumbnail" style="float: left; height:300px; width: 217px;">
													<div style="height:270px; width: 217px;"></div>
													<button type="button" id="addReport" class="btn btn-lg">添加</button>
												</a>
									    	</div>
									 	</div>
									 	<div class="row-fluid">
											<label class="control-label"><span class="required"></span>资金监管协议</label>
											<div class="controls">
											<div id="protocolUploader"></div>
									        	<a class="thumbnail" style="float: left; height:300px; width: 217px;">
													<div style="height:270px; width: 217px;"></div>
													<button type="button" id="addProtocol" class="btn btn-lg">添加</button>
												</a>
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
		    $(function() {
		    	$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">产品合同管理&nbsp;</a>/&nbsp;产品合同新增</li>');
		    	$('#fm').validationEngine('attach', { 
			        promptPosition: 'centerRight', 
			        scroll: false,
			        showOneMessage : true
			    });
		    	$('#name').focus();
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
		   
		   function startValidate() {
			    var flag = true;
			    $.ajaxSettings.async = false;
				$.getJSON('${pageContext.request.contextPath}/product/contract/duplicate/name', {
					   id: 0, 
					   fieldId: 0, 
					   fieldValue: $('#name').val() 
				}, function(data){
				   if(data && data.length>0 && data[1]){
					   if(flag){
					    	var countContract = 0;
							$('input[name^="contract"]').each(function(){
								if($(this).val() != ''){
									countContract = countContract + 1;
								}
							});
							if(countContract <= 0){
								alert('合同不能为空 ');
								flag = false;
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
		   
		   
		   function quit() {
			   window.location.href='${pageContext.request.contextPath}/product/contract/list/1';
		   }
		   
		   function deleteAttachment(id, url){
				var msg = '您确认要删除此图片吗,删除后无法恢复?'; 
				if (confirm(msg)==true){ 
					$.post('${pageContext.request.contextPath}/product/attachment/delete/'+id, {'attachmentUrl':url}, function(r){
						if(r){
							document.getElementById(id).style.display = 'none';
							document.getElementById(id).parentNode.removeChild(document.getElementById(id)); 
						}else{
							alert('图片删除失败请联系管理员');
						}
					});
				}
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
		</script>
	</body>
</html>