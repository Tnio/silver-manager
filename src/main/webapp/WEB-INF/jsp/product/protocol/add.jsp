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
			                    <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/product/protocol/save">
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<input id="id" name="id" value="0" type="hidden">
										<div class="row-fluid">
											<div class="span12">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>名称</label>
													<div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="30个字符以内" class="validate[required, minSize[1], maxSize[30], ajax[ajaxprotocolName]] text-input span12" id="name" name="name" /></div>
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="control-group">
												<label class="control-label"><span class="required">*</span>类型</label>
												<div class="controls">
												    <select id="category"  name="category" class="validate[required] span12">
													    <option></option>
			                                            <option value="1">支付协议</option>
			                                            <option value="2">风险揭示书</option>
			                                            <option value="3">三方协议</option>
													</select>
											    </div>
											</div>
									    </div>
									    <div class="row-fluid">
											<div class="control-group">
										       <label class="control-label"><span class="required">*</span>协议</label>
										       <div class="controls">
										       	<textarea id="protocol" name="content" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
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
		    	$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">产品协议管理&nbsp;</a>/&nbsp;产品协议新增</li>');
		    	$('#fm').validationEngine('attach', { 
			        promptPosition: 'bottomLeft', 
			        scroll: false,
			        showOneMessage : true
			    });
		    	$('#name').focus();
		    	protocol = UE.getEditor('protocol');
		   });
		    
		   
		   function startValidate() {
			    var flag = true;
			    $.ajaxSettings.async = false;
				$.getJSON('${pageContext.request.contextPath}/product/protocol/duplicate/name', {
					   id: 0, 
					   fieldId: 0, 
					   fieldValue: $('#name').val() 
				}, function(data){
				   if(data && data.length>0 && data[1]){
					   if(flag){
						    var len = protocol.getContentLength(true,[]);
						    if(len <= 0){
						    	$('#protocol').addClass('validate[required]');
						    }else if(len > 10000){
						    	 alert('产品协议字数超出限制');
						    	 flag = false;
						    }else{
						    	$('#protocol').removeClass('validate[required]');
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
			   window.location.href='${pageContext.request.contextPath}/product/protocol/list';
		   }
		</script>
	</body>
</html>