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
                    <!-- content begin -->
                    <div class="row-fluid">
                    	<form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post"  action="${pageContext.request.contextPath}/faq/save"  autocomplete="off">
                    		<input id="id" name="id" value="0" type="hidden">
                    		<div class="well" style="padding-bottom: 20px; margin: 0;">
	                    		<div class="control-group">
									<label class="control-label"><span class="required">*</span>问题名称</label>
									<div class="controls"><input type="text" name="ask" class="validate[required,minSize[6],maxSize[40],ajax[ajaxFaqName]] text-input span9"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="6~40个字"/></div>
								</div>
								<!-- <div class="control-group">
									<label class="control-label"><span class="required"></span>排序</label>
									<div class="controls"><input type="text" id="sortNumber" name="sortNumber"  class="validate[required,custom[integer],min[1],max[999]] text-input span9" onkeyup="this.value=this.value.replace(/^0[0|1|2|3|4|5|6|7|8|9]/g, this.value.substring(this.value.length - 1, this.value.length)).trim()" value="999"/></div>
								</div> -->
								<div class="control-group">
									<label class="control-label"><span class="required">*</span>回答</label>
									<div class="controls">
									 <textarea id="institutionDesc" name="question" class="validate[required,minSize[2],maxSize[1000]] text-input span9" rows="5" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
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
		        promptPosition:'bottomLeft',
		        showOneMessage: true,
		        focusFirstField:true,
		        scroll: true
		    });
		});
		$('.breadcrumb').html('<li class="active">内容管理&nbsp;/&nbsp;<a href="javascript:quit();">常见问题管理</a>&nbsp;/&nbsp;新增常见问题</li>');
		function quit(){
			window.location.href='${pageContext.request.contextPath}/faq/list';
		}
	</script>
</html>