<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div class="block-content collapse in">
			                    <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/product/guarantee/save">
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<input id="id" name="id" value="${guarantee.id}" type="hidden">
										<div class="row-fluid">
											<div class="span12">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>名称</label>
													<div class="controls"><input type="text" id="name" name="name" value="${guarantee.name}"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="30个字符以内" class="validate[required, minSize[1], maxSize[30], ajax[ajaxguaranteeName]] text-input span12" /></div>
												</div>
											</div>
										</div>
									    <div class="row-fluid">
											<div class="row-fluid">
												<label class="control-label"><span class="required">*</span>质押担保函</label>
												<div class="controls">
													<div id="guaranteeUpload">
														<c:forEach items="${guarantee.attachments}" var="attachment">
													        <c:if test="${attachment.category == 5}">
																<a id="${attachment.id}" class="thumbnail" style="float: left; height:300px; width: 217px;">
													        		<span ><img  name="GUARANTEE" style="height:270px; width: 217px;" src="${attachment.url}"/></span>
													        		<div align="right"><button type="button" class="btn btn-lg" onclick="javascript:deleteAttachment(${attachment.id}, '${attachment.url}')">删除</button></div>
														      	</a>
													      	</c:if>
												        </c:forEach>
													</div>
												    <a class="thumbnail" style="float: left; height:300px; width: 217px;">
														<div style="height:270px; width: 217px;"></div>
														<button type="button" id="addGuarantee" class="btn btn-lg">添加</button>
													</a>
											    </div>
										    </div>
									    </div>
										<div class="form-actions">
											<button type="submit" id="save" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
											<a class="btn btn-default btn-lg" onclick="quit()">返回</a>
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
		    	//$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">产品协议管理&nbsp;</a>/&nbsp;产品协议编辑</li>');
		    	$('#fm').validationEngine('attach', { 
			        promptPosition: 'bottomLeft', 
			        scroll: false,
			        showOneMessage : true
			    });
		    	
		    	if('${operation}' == 'edit'){
		    		$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">担保函管理&nbsp;</a>/&nbsp;担保函编辑</li>');
					$('#name').focus();
					$('#save').show();
				}else{
					$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">担保函管理&nbsp;</a>/&nbsp;担保函查看</li>');
					$('#save').hide();
					readOnly();
				}
		   });
		   
		    var ge = 0;
		    var geCount = document.getElementsByName('GUARANTEE').length;
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
					   id: $('#id').val(), 
					   fieldId: $('#id').val(), 
					   fieldValue: $('#name').val()
				}, function(data){
				   if(data && data.length>0 && data[1]){
					   if(flag){
					    	var countGuarantee = 0;
							$('input[name^="guarantee"]').each(function(){
								if($(this).val() != ''){
									countGuarantee = countGuarantee + 1;
								}
							});
							if((document.getElementsByName('GUARANTEE').length + countGuarantee) <= 0){
								alert('担保函不能为空 ');
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
		   
		   function deleteAttachment(id, url){
				var msg = '您确认要删除此图片吗,删除后无法恢复?'; 
				if (confirm(msg)==true){ 
					$.post('${pageContext.request.contextPath}/product/attachment/delete/'+id, {'attachmentUrl':url}, function(r){
						if(r){
							document.getElementById(id).style.display = 'none';
							document.getElementById(id).parentNode.removeChild(document.getElementById(id));
							geCount = geCount - 1;
						}else{
							alert('图片删除失败请联系管理员');
						}
					});
				}
		   }
		   
		   function quit() {
			   window.location.href='${pageContext.request.contextPath}/product/guarantee/list';
		   }
		   
		   function readOnly(){   
		        var  a =  document.getElementsByTagName("input");   
		        for(var   i=0;   i<a.length;   i++)   {   
		           if(a[i].type=="checkbox" || a[i].type=="radio" || a[i].type=="text"){
		        	   a[i].disabled = "disabled";
		           }     
		        }
		        
		        var  b  =  document.getElementsByTagName("select");   
		        for(var i=0; i<b.length; i++)   {   
		              b[i].disabled="disabled";   
		        }
		        
		        var c = document.getElementsByTagName("textarea");
		        for   (var   i=0;   i<c.length;   i++)   
		        {   
		              c[i].disabled="disabled";   
		        }
		        
		        var d = document.getElementsByTagName("button");
		        for   (var   i=0;   i<d.length;   i++)   
		        {   
		              d[i].disabled="disabled";   
		        }
			}
		</script>
	</body>
</html>