<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
	<body>
		<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
        <div class="container-fluid">
            <div class="row-fluid">
                <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
                <div class="span10" id="content1">
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div class="block-content collapse in">
			                    <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" >
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<input id="id" name="id" value="0" type="hidden">
				                    	<input name="page" value="${page }" type="hidden">
				                    	<input name="size" value="${size }" type="hidden">
				                    	<input id="url" name="url" type="hidden">
				                    	<input type="hidden" name="versionSearch" value="${version}">
				                    	<input type="hidden" name="contentSearch" value="${content}">
										<div class="row-fluid">
											<div class="span6">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 版&nbsp;&nbsp;本&nbsp;&nbsp;号</label>
													<div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="1~10个字符" class="validate[required, minSize[1], maxSize[10], ajax[ajaxVersionNumber]] text-input span9" id="version" name="version" /></div>
													<span><font class="msg">&nbsp;&nbsp;&nbsp;&nbsp;（名称请严格按以下格式：如：1.0.0、V1.0.0)</font></span>
												</div>
											</div>
										</div>
										<div class="control-group">
												<label class="control-label"><span class="required">*</span> 升级方式</label>
												<div class="row-fluid">
													<div class="span3">
														<div class="control-group ">
															<input id="optional" type="radio" name="type" checked="checked" value="optional" class=" radio span4" >
															<span >可选升级</span>
														</div>
													</div>
													<div class="span3">
														<div class="control-group ">
															<input type="radio" name="type" value="compulsive" class=" radio span4" >
															<span >强制升级</span>
														</div>
													</div>
												</div>
										</div>
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> APP上传</label>
											<div class="controls">
												 <input id="app" type="file" name="app" onchange="fileSelected();"/>
												 <span><font class="msg">（APP名称中不能含有中文)</font></span>
											</div>
										</div>
										<div class="control-group" id="progress">
											<div class="controls" id="fileName"></div>
										    <div class="controls" id="fileSize"></div>
										    <div class="controls">
										    	<div class="progress">
											    	<div class="progress-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width:0%;background-color:red;">
											      		<span class="sr-only">0% 完成</span>
											   		</div>
											   </div>
										    </div>
										</div>
										<div class="control-group">
											<label class="control-label"><span class="required">*</span>更新内容</label>
											<div class="controls"><textarea id="content" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')"  onblur="this.value=this.value.replace(/(\s*$)/g,'')" name="content" rows="5" class="validate[required, minSize[2], maxSize[440]] textarea span8" ></textarea></div>
										</div>
										<div class="form-actions">
											<button type="button" id="save" onclick="uploadFile()" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
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
			$('input[name=type]').change(function(){
				var value = $('[name=type]').filter(':checked').attr('value');
				if (value == 'compulsive') {
					if (confirm('亲，您确定要强制升级吗？') == false){
						$('input[name=type][value=optional]').prop('checked',true);
					}
				}
		    });
		    $(function() {
		    	$('.msg').css('color', 'red');
		    	$('#progress').hide();
		    	$('#version').focus();
		    	$('#fm').validationEngine('attach', { 
		    		 promptPosition:'bottomLeft',
			        inlineValidation: true, 
			        validationEventTriggers:'click blur', 
			        showOneMessage: true,
			        focusFirstField:true,
			        scroll: true
			   }); 
		   });
		   $('.breadcrumb').html('<li class="active">APP升级管理&nbsp;/&nbsp;<a href="javascript:quit();">版本管理</a>&nbsp;/&nbsp;新增版本</li>');
		   function startValidate() {
			   if (!$('#app').val()) {
				   alert('请选择要上传的APP');
				   return false; 
			   }
			   if (!$('#content').val() || $('#content').val().lenght > 200) {
				   return false;
			   }
			   return true;
		   }

		   function quit() {
			   window.location.href='${pageContext.request.contextPath}/upgrade/version/list/1';
		   }
		   
		   function fileSelected() {
	           var file = document.getElementById('app').files[0];
	           $('#progress').hide();
	           if (file) {
	        	   if(/.*[\u4e00-\u9fa5]+.*$/.test(file.name)) {  
		               alert('APP文件名中不能含有中文！'); 
		               $('#app').val('');
		               return false;  
	               }  
	        	   var suffix = file.name.split('.').pop().toLowerCase();
	        	   if (suffix == 'apk' || suffix == 'ipa') {
		        	   $('#progress').show();
		               var fileSize = 0;
		               if (file.size > 1024 * 1024) {
		                  fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
		               } else {
		                  fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';
		               }
		               document.getElementById('fileName').innerHTML = '文件名称: ' + file.name;
		               document.getElementById('fileSize').innerHTML = '文件大小: ' + fileSize;
	        	   } else {
	        		   alert('请选择apk文件或apk文件！');
	        		   $('#app').val('');
		               return false;
	        	   } 
	           }
	       }
		   
		   function uploadFile() {
			   $.getJSON('${pageContext.request.contextPath}/upgrade/version/duplicate/number', {
				   id: 0, 
				   fieldId: 0, 
				   fieldValue: $('#version').val() 
			   }, function(data){
				   if(data && data.length>0 && data[1]){
					   if (startValidate()) {
					       var fd = new FormData();
					       $('#save').attr('disabled','disabled');
					       fd.append('fileToUpload', document.getElementById('app').files[0]);
					       var xhr = new XMLHttpRequest();
					       xhr.upload.addEventListener('progress', uploadProgress, false);
					       xhr.addEventListener('load', uploadComplete, false);
					       xhr.open('POST', '${pageContext.request.contextPath}/upgrade/web/upload');
					       xhr.send(fd);
					   }
				   }else{
					   $('#version').focus();
					   alert('您所填写的版本号已存在!');
				   }
			   });
		   }
		   
		   function uploadProgress(evt) {
		       if (evt.lengthComputable) {
		           var percentComplete = Math.round(evt.loaded * 100 / evt.total);
		           $('.progress-bar').css('width', percentComplete.toString() + '%');
		           $('.sr-only').html(percentComplete.toString() + '% 完成');
		       }
		   }
		      
		   function uploadComplete(evt) {
			   $.getJSON('${pageContext.request.contextPath}/upgrade/version/duplicate/number', {
				   id: 0, 
				   fieldId: 0, 
				   fieldValue: $('#version').val() 
			   }, function(data){
				   if(data && data.length>0 && data[1]){
					   if (startValidate()) {
						   $('#url').val(evt.target.responseText);
					   	   $('#fm').attr('action', '${pageContext.request.contextPath}/upgrade/version/save');
			               $('#fm').submit();
					   }
				   }else{
					   alert('您所填写的版本号已存在!');
				   }
			   });
			  
		   }
		</script>
	</body>
</html>