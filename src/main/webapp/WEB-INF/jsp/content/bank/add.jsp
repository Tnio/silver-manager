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
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="row-fluid">
                    	<form class="form-horizontal" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/unionpay/bank/save">
                    		<input id="id" name="id" value="0" type="hidden">
                    		<input id="remark" name="remark" type="hidden" >
                    		<div class="well" style="padding-bottom: 20px; margin: 0;">
	                    		<div class="control-group">
									<label class="control-label"><span class="required">*</span>银行名称</label>
									<div class="controls"><input type="text" id="name" name="name" class="validate[required,minSize[2],maxSize[12], ajax[ajaxBankName]] text-input span9"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="6个汉字之内"/></div>
								</div>
	                    		<div class="control-group">
									<label class="control-label"><span class="required">*</span>银行编码</label>
									<div class="controls"><input type="text" name="bankNO" class="validate[required,maxSize[10],custom[onlyNumberSp]] text-input span9"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="10个字符之内"/></div>
								</div>
								<div class="row-fluid">
									<div class="span5">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 单笔限额</label>
											<div class="controls"><input id="singleLimit" class="validate[required, min[0], max[99999999], custom[integer]] text-input span6" type="text" />（元）</div>
										</div>
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 单月限额</label>
											<div class="controls"><input id="singleMonthLimit" class="validate[required, min[0], max[99999999], custom[integer]] text-input span6" type="text" />（元）</div>
										</div>
									</div>
									<div class="span5">
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 单日限额</label>
											<div class="controls"><input type="text" id="singleDayLimit" class="validate[required, min[0], max[99999999], custom[integer]] text-input span6" />（元）</div>
										</div>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"></label>
									<div class="controls">
										<button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
										<button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit();"><i></i>返回</button>
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
	</body>
	<script type="text/javascript">
		$(function() {
			$('#fm').validationEngine('attach', {
		        promptPosition:'bottomRight',
		        showOneMessage: true,
		        focusFirstField:true,
		        scroll: true
		    });
		});
		$('.breadcrumb').html('<li class="active">内容管理&nbsp;/&nbsp;<a href="javascript:quit();">银行限额管理</a>&nbsp;/&nbsp;新增银行</li>');
		
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
	    	$('#remark').val(singleLimit+'/'+singleDayLimit+'/'+singleMonthLimit);
	    	return true;
		}
	</script>
</html>