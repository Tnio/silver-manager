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
                    <!-- content begin -->
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div class="block-content collapse in">
	                            <form id="fm" action="${pageContext.request.contextPath}/system/role/save" method="post" class="form-horizontal" >
									<input id="id" name="id" value="${role.id}" type="hidden">
									<div class="well" style="padding-bottom: 20px; margin: 0;">
				                    	<div class="control-group">
											<label class="control-label"><span class="required">*</span>角色名称</label>
											<div class="controls">
												<input type="text" id="name" name="name" value="${role.name}" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" class="validate[required,maxSize[12],custom[anotherNotSpecialCharacter],ajax[ajaxValidateRoleName]] span8" />
												<!-- <span ><input type="checkbox" name="privacy" value="1" style="vertical-align: -2px">&nbsp;手机号码可见</span> -->
											</div>
										</div>
										<div class="control-group">
									        <label class="control-label">描述</label>
									        <div class="controls">
									        	<textarea id="remark" name="remark" rows="4" class="validate[maxSize[60]] span8" >${role.remark}</textarea>
									        </div>
								        </div>
										<hr class="separator" />
										<div class="form-actions">
											<button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
											<button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit()"><i></i>返回</button>
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
	</body>
	<script type="text/javascript">
		$(function(){
			$('.breadcrumb').html('<li class="active">系统管理&nbsp;/&nbsp;<a href="javascript:quit();">角色管理</a>&nbsp;/&nbsp;编辑角色</li>');
			$('#fm').validationEngine('attach', { 
		        promptPosition: 'bottomRight', 
		        scroll: false 
		    });
			$('#name').focus();
			if('${role.privacy}' == 1){
				$('input[name="privacy"]').prop('checked', true);
			}
		});
		
		function validate(){
			var flag = true;
			$.ajaxSettings.async = false;
			$.getJSON('${pageContext.request.contextPath}/system/role/validate/name', {
				   id: $('#id').val(), 
				   fieldId:$('#id').val(), 
				   fieldValue: $('#name').val()
			}, function(data){
			   if(data && data.length>0 && data[1]){
				  flag = true;
			   }else{
				   alert('【'+$('#name').val()+'】此名称已被使用请重新选择!');
				   flag = false;
			   }
			});
			$.ajaxSettings.async = true;
			return flag;
		}
		
		function quit() {
			window.location.href='${pageContext.request.contextPath}/system/role/list';
	    }
	</script>
</html>