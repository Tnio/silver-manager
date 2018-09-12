<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
	<body>
		<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
        <div class="container-fluid">
            <div class="row-fluid">
                <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
                <div class="span10" id="content">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="row-fluid">
                    	<form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/unionpay/bank/save">
                    		<input id="id" name="id" value="${bank.id}" type="hidden">
                    		<div class="well" style="padding-bottom: 20px; margin: 0;">
	                    		<div class="control-group">
									<label class="control-label"><span class="required">*</span>银行名称</label>
									<div class="controls"><input type="text" id="name" name="bankName" value="${bank.bankName}" class="validate[required,minSize[2],maxSize[12]] text-input span9"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="6个汉字之内"/></div>
								</div>
	                    		<div class="control-group">
									<label class="control-label"><span class="required">*</span>银行logo</label>
									<div class="controls" id="imageChoice">
										
										<div id="imgPreview">
										<c:if test="${not empty bank.logoUrl}"> 
											<img name="image" style="height:220px; width: 300px;" src="${bank.logoUrl}"/>
										</c:if> 
										</div>
										<c:if test="${not empty bank.logoUrl}">
											<div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain()">重新上传</button></div>
										</c:if>
									    <input id="logoUrl" type="hidden" name="logoUrl" value="${bank.logoUrl}"/>
										<input id="urls" type="file" name="urls" accept="image/png, image/jpg" onchange="setImagePreview(this.id)" />
										<span><font style="color: red;">（建议尺寸：XX*XX，PNG或JPG格式的图片）</font></span>
									</div>
								</div>
								<div class="row-fluid">
									<div class="span5">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 单笔限额</label>
											<div class="controls"><input id="singleLimit" name="singleLimit" class="validate[required, min[0], max[99999999], custom[integer]] text-input span6" value="${bank.singleLimit}" onblur="getSingleLimit()" type="text" />（元）</div>
										</div>
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 单月限额</label>
											<div class="controls"><input id="singleMonthLimit" name="monthLimit" class="validate[required, min[0], max[99999999], custom[integer]] text-input span6" value="${bank.monthLimit}" type="text" onblur="getSingleMonthLimit()" />（元）</div>
										</div>
									</div>
									<div class="span5">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 单日限额</label>
											<div class="controls"><input type="text" id="singleDayLimit" name="dayLimit" class="validate[required, min[0], max[99999999], custom[integer]] text-input span6" value="${bank.dayLimit}" onblur="getSingleDayLimit()" />（元）</div>
										</div>
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 排序</label>
											<div class="controls"><input type="text" name="sortNumber" class="validate[required, min[1], max[999], custom[integer]] text-input span6" value="${bank.sortNumber}" /></div>
										</div>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"></label>
									<div class="controls">
										<button type="submit" id="save" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
										<button type="button" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit();"><i></i>返回</button>
									</div>
								</div>
                    		</div>
                    	</form>
                    </div>
                    <!-- content end -->
                </div>
            </div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
        <script src="${pageContext.request.contextPath}/res/js/show.original.image.js"></script>
	</body>
	<script type="text/javascript">
		function uploadAgain(){
		   $('#urls').trigger('click');
	    }
		
		function setImagePreview(fileInput) {
			var urlObj = $('#'+fileInput)[0];
			if(urlObj){
				var suffix = urlObj.files[0].name.split('.').pop().toLowerCase();
				if (suffix == 'png' || suffix == 'jpg') {
					if(urlObj.files[0].size <= (2102957)){
						if(urlObj.files && urlObj.files[0]){
							 var img = $('<img style="height:220px; width: 290px;" src="'+window.URL.createObjectURL(urlObj.files[0])+'">');
				             $('#imgPreview').empty().append( img );
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
	
		function getSingleMonthLimit() {
			if ($('#singleDayLimit').val()) {
				$('#singleMonthLimit').removeClass();
				$('#singleMonthLimit').addClass('validate[required, monLimitMin['+$("#singleDayLimit").val()+'], max[99999999], custom[integer]] text-input span6');
			} else if ($('#singleLimit').val()) {
				$('#singleMonthLimit').removeClass();
				$('#singleMonthLimit').addClass('validate[required, dayLimitMin['+$("#singleLimit").val()+'], max[99999999], custom[integer]] text-input span6');
			}
		}
	
		function getSingleLimit() {
			if ($('#singleDayLimit').val()) {
				$('#singleLimit').removeClass();
				$('#singleLimit').addClass('validate[required, min[0], limitMax['+$("#singleDayLimit").val()+'], custom[integer]] text-input span6');
			} else if ($('#singleMonthLimit').val()) {
				$('#singleLimit').removeClass();
				$('#singleLimit').addClass('validate[required, min[0], dayLimitMax['+$("#singleMonthLimit").val()+'], custom[integer]] text-input span6');
			}
			$('#singleDayLimit').focus();
			$('#singleDayLimit').blur();
		}
		
		function getSingleDayLimit() {
			if ($('#singleLimit').val() && $('#singleMonthLimit').val()) {
				$('#singleDayLimit').removeClass();
				$('#singleDayLimit').addClass('validate[required, dayLimitMin['+$("#singleLimit").val()+'], dayLimitMax['+$("#singleMonthLimit").val()+'], custom[integer]] text-input span6');
			} else if ($('#singleMonthLimit').val()) {
				$('#singleDayLimit').removeClass('validate[required, min[0], max[99999999], custom[integer]]');
				$('#singleDayLimit').addClass('validate[required, min[0], dayLimitMax['+$("#singleMonthLimit").val()+'], custom[integer]] text-input span6');
			} else if ($('#singleLimit').val()) {
				$('#singleDayLimit').removeClass();
				$('#singleDayLimit').addClass('validate[required, dayLimitMin['+$("#singleLimit").val()+'], max[99999999], custom[integer]] text-input span6');
			}
			$('#singleMonthLimit').focus();
			$('#singleMonthLimit').blur();
		}
	
		$(function() {
			$('#fm').validationEngine('attach', {
		        promptPosition:'bottomRight',
		        showOneMessage: true,
		        focusFirstField:true,
		        scroll: true
		    });
			
			var bankLogo = '${bank.logoUrl}';
			if (bankLogo) {
				$('#urls').hide();
			}
			
			var workImg=document.getElementsByTagName('img'); 
			for(var i=0; i<workImg.length; i++) {
				workImg[i].onclick=ImgShow;
			}
		});
		
		if('${operation}' == 'edit'){
			$('.breadcrumb').html('<li class="active">内容管理&nbsp;/&nbsp;<a href="javascript:quit();">银行限额管理</a>&nbsp;/&nbsp;修改银行</li>');
			$('#save').show();
		}else{
			$('.breadcrumb').html('<li class="active">内容管理&nbsp;/&nbsp;<a href="javascript:quit();">银行限额管理</a>&nbsp;/&nbsp;查看银行</li>');
			$('#save').hide();
			readOnly();
		}
		
		function quit(){
			window.location.href='${pageContext.request.contextPath}/unionpay/bank/list';
		}
		
		function startValidate() {
			var singleLimit = $('#singleLimit').val();
			if (singleLimit >= 10000) {
				singleLimit = singleLimit / 10000;
				singleLimit=singleLimit+'万';
			}
			var singleDayLimit = $('#singleDayLimit').val();
			if (singleDayLimit >= 10000) {
				singleDayLimit = singleDayLimit / 10000;
				singleDayLimit=singleDayLimit+'万';
			}
			var singleMonthLimit = $('#singleMonthLimit').val();
			if (singleMonthLimit >= 10000) {
				singleMonthLimit = singleMonthLimit / 10000;
				singleMonthLimit=singleMonthLimit+'万';
			}
	    	//$('#remark').val(singleLimit+'/'+singleDayLimit+'/'+singleMonthLimit);
	    	return true;
		}
		
		function readOnly() {   
	        var a = document.getElementsByTagName('input');   
	        for(var i=0; i<a.length; i++) {   
	           if(a[i].type=='checkbox' || a[i].type=='radio' || a[i].type=='text'){
	        	   a[i].readOnly = true;
	        	   a[i].disabled = 'disabled';
	           }     
	        }
		}
	</script>
</html>