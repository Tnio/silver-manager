<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	                            <form id="fm" onsubmit="return validate()" action="${pageContext.request.contextPath}/system/admin/save" method="post" class="form-horizontal" >
								<div class="well" style="padding-bottom: 20px; margin: 0;">
									<div class="control-group">
										<input id="id" name="id" value="0" type="hidden">
										<input name="page" value="${page }" type="hidden">
		                    			<input name="size" value="${size }" type="hidden">
		                    		</div>
			                    	<div class="control-group">
										<label class="control-label"><span class="required">*</span>用户名</label>
										<div class="controls">
											<input type="text" id="name" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" name="name" class="validate[required,minSize[4],maxSize[20],custom[notSpecialCharacterAndChinese],ajax[ajaxValidateAdminName]] text-input span3" />
										</div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span>真实姓名</label>
										<div class="controls">
											<input type="text" id="realName" onkeyup="this.value=this.value.replace(/[^\u4E00-\u9FA5]/g,'')" onblur="this.value=this.value.replace(/[^\u4E00-\u9FA5]/g,'')" name="realName" class="validate[required,minSize[4],maxSize[8],custom[chinese]] text-input span3" />
										</div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span>手机</label>
										<div class="controls">
											<input type="text" id="cellphone" name="cellphone" class="validate[required,custom[cellphone],ajax[ajaxValidateAdminCellphone]] text-input span3" />
										</div>
									</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span>角色类型</label>
										<div class="controls">
											<select id="roleId" name="role.id" class="validate[required] span3">
	                                        	<option value="">请选择</option>
		                                        <c:forEach var="role" items="${roleList}" varStatus="s">
		                                           <option value="${role.id}" >${role.name}</option>
		                                       </c:forEach>
		                                	</select>
	                                	</div>
									</div>
									<hr class="separator" />
									<div class="form-actions">
										<button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
										<a href="javascript:quit();"><button type="button" class="btn">返回</button></a>
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
			$('.breadcrumb').html('<li class="active">系统管理&nbsp;/&nbsp;<a href="javascript:quit();">操作员管理</a>&nbsp;/&nbsp;新增操作员</li>');
			$('#fm').validationEngine('attach', { 
		        promptPosition: 'centerRight', 
		        scroll: false,
		        showOneMessage : true
		   }); 
		});
		
		function validate(){
			var flag = true;
			$.ajaxSettings.async = false;
			$.getJSON('${pageContext.request.contextPath}/system/admin/validate/name', {
				   id: 0, 
				   fieldId: 0, 
				   fieldValue: $('#name').val()
			}, function(data){
			   if(data && data.length>0 && data[1]){
				   $.getJSON('${pageContext.request.contextPath}/system/admin/validate/cellphone', {
						   id: 0, 
						   fieldId: 0, 
						   fieldValue: $('#cellphone').val()
					}, function(data){
					   if(data && data.length>0 && data[1]){
						  flag = true;
					   }else{
						   $('#cellphone').focus();
						   alert('【'+$('#cellphone').val()+'】此手机号已被使用请重新选择!');
						   flag = false;
					   }
					});
			   }else{
				   $('#name').focus();
				   alert('【'+$('#name').val()+'】此名称已被使用请重新选择!');  
				   flag = false;
			   }
			});
			$.ajaxSettings.async = true;
			return flag;
		}
		
		function quit() {
			window.location.href='${pageContext.request.contextPath}/system/admin/list/1';
	    }
	</script>
</html>