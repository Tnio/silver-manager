<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
	<body>
		<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
        <div class="container-fluid">
            <div class="row-fluid">
                <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
                <div class="span10">
                    <!-- content begin -->
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div class="block-content collapse in">
	                            <form id="fm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/message/news/save" method="post" class="form-horizontal" onsubmit="return validate()" >
								<div class="well" style="padding-bottom: 20px; margin: 0;">
									<div class="control-group">
										<input id="id" name="id" value="0" type="hidden">
										<input name="page" value="${page}" type="hidden">
		                    			<input name="size" value="${size}" type="hidden">
		                    		</div>
			                    	<div class="control-group">
										<label class="control-label"><span class="required">*</span>新闻标题</label>
										<div class="controls">
											<input type="text" id="title" name="title" class="validate[required,maxSize[60]] text-input span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
										</div>
									</div>
									<div class="row-fluid">
										<div class="span6">
											<div class="control-group">
												<label class="control-label"><span class="required">*</span>新闻来源</label>
												<div class="controls">
													<input type="text" id="source" name="source" class="validate[required,maxSize[16]] text-input span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
												</div>
											</div>
										</div>
										<div class="span6">
											<div class="control-group">
												<label class="control-label"><span class="required">*</span>新闻日期</label>
												<div class="controls">
													<input type="text" id="newsDate" name="newsDate" class="validate[required] text-input span12" onkeypress="return false"/>
												</div>
											</div>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">关键字</label>
										<div class="controls">
											<input type="text" id="keywords" name="keywords" placeholder="30个汉字以内" class="validate[maxSize[60]] text-input span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">缩略图</label>
										<div class="controls">
										    <div id="pledgeUpload">
										    	<a class="thumbnail" style="float: left; height:300px; width: 217px;">
													<div style="height:270px; width: 217px;" id="img-url"></div>
													<input id="img_url" name="img" type="file" accept="image/*" onchange="setImagePreview(this.id)" />
												</a>
											</div>
									    </div>
									    <span><font class="msg">（图片建议尺寸：360*240，png或者jpg格式）</font></span>
									</div>
									<div class="control-group">
										<label class="control-label">新闻简介</label>
										<div class="controls">
											<input type="text" id="remark" name="remark" placeholder="50个汉字以内" class="validate[maxSize[100]] text-input span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
										</div>
									</div>
									<div class="control-group" id="newsType">
										<label class="control-label"><span class="required">*</span>新闻类型</label>
										<div class="controls">
											<div class="row-fluid">
												<div class="span2">
													<input type="radio" name="type" value="1" checked="checked" class="validate[required] radio span4">
													<span>内部上传</span>
												</div>
												<div class="span2">
													<input type="radio" name="type" value="2" class="validate[required] radio span4">
													<span>外部链接</span>
												</div>
											</div>
										</div>
									</div>
									<div class="control-group" id="linkWrap">
										<label class="control-label"><span class="required">*</span>链接地址</label>
										<div class="controls">
											<input type="text" id="link" name="link" value="http://" class="validate[required] text-input span12" />
										</div>
									</div>
									<div class="control-group" id="contentWrap">
										<label class="control-label"><span class="required">*</span>新闻内容</label>
										<div class="controls">
											<textarea cols="80" id="content" name="content" class="text-input span12"></textarea>
										</div>
									</div>
									<div class="form-actions">
										<button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
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
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script type="text/javascript">
		    var content = '';
			$(function(){
				$('.breadcrumb').html('<li class="active">消息管理&nbsp;/&nbsp;<a href="javascript:quit();">新闻素材管理</a>&nbsp;/&nbsp;新增新闻素材</li>');
				$('#linkWrap').hide();
				
				$('#fm').validationEngine('attach', { 
					 promptPosition:'bottomLeft',
				     showOneMessage: true,
				     focusFirstField: true,
				     scroll: true
			    });
				
				$('#newsType').find('input:radio').click(function(){
					var v=$(this).val();
					if(v==1){
						$('#linkWrap').hide();
						$('#contentWrap').show();
					}
					if(v==2){
						$('#linkWrap').show();
						$('#contentWrap').hide();
					}
				});
				
				$('#newsDate').datetimepicker({
					format:'Y-m-d',
					lang:'ch',
					scrollInput:false,
					timepicker:false,
					maxDate:new Date().toLocaleDateString()
				});	
				content = UE.getEditor('content');
			});
			
			function validate() {
				if($('#title').val().length<=0){
		    		return false;
				}
				if($('#source').val().length<=0){
		    		return false;
				}
				if($('#newsDate').val().length<=0){
		    		return false;
				}
				
				var type = $('input:radio[name=type]:checked').val();
		    	if(type==1){
		    		var txt = content.getContent();
				    if($.trim(txt) == ''){
				    	$('#content').addClass('validate[required]');
				    } else{
				    	$('#content').removeClass('validate[required]');
				    }
		    	}
		    	if(type==2 && $('#link').val().length<=0){
		    		return false;
		    	}
		    	
		    	var _s = $('#source').val();
		    	$('#source').val(_s.replace(' ', ''));
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
			
			function quit() {
			    window.location.href='${pageContext.request.contextPath}/message/news/list/${page}';
		    }
		</script>
</body>
</html>