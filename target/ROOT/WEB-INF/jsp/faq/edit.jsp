<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                    <jsp:include page="${pageContext.request.contextPath}/navbar" flush="true" />
                    <!-- content begin -->
                    <div class="row-fluid">
                    	<form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post"  action="${pageContext.request.contextPath}/faq/save"  autocomplete="off">
                    		<input type="hidden" id="id" name="id" value="${faq.id}">
                    		<div class="well" style="padding-bottom: 20px; margin: 0;">
	                    		<div class="control-group">
									<label class="control-label"><span class="required">*</span>问题名称</label>
									<div class="controls"><input type="text" name="ask" value="${faq.ask}" class="validate[required,minSize[6],maxSize[40],ajax[ajaxFaqName]] text-input span9"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="6~40个字"/></div>
								</div>
								<%-- <div class="control-group">
									<label class="control-label"><span class="required"></span>排序</label>
									<div class="controls"><input type="text" id="sortNumber" name="sortNumber"  value="${faq.sortNumber}" class="validate[required,custom[integer],min[1],max[999]] text-input span9" onkeyup="this.value=this.value.replace(/^0[0|1|2|3|4|5|6|7|8|9]/g, this.value.substring(this.value.length - 1, this.value.length)).trim()" value="999"/></div>
								</div> --%>
								<div class="control-group">
									<label class="control-label"><span class="required">*</span>回答</label>
									<div class="controls">
										<textarea id="question" name="question" rows="5"  class="validate[required,minSize[2],maxSize[1000]] text-input span9" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')">${faq.question}</textarea>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"></label>
									<div class="controls">
										<button type="submit" id="save" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
										<a type="reset" class="btn btn-icon btn-default glyphicons circle_remove" href="javascript:quit()"><i></i>返回</a>
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
			if('${operation}' == 'edit'){
				$('.breadcrumb').html('<li class="active">内容管理&nbsp;/&nbsp;<a href="javascript:quit();">常见问题管理</a>&nbsp;/&nbsp;编辑常见问题</li>');
				$('#save').show();
			}else{
				$('.breadcrumb').html('<li class="active">内容管理&nbsp;/&nbsp;<a href="javascript:quit();">常见问题管理</a>&nbsp;/&nbsp;查看常见问题</li>');
				$('#save').hide();
				readOnly();
			}
		});
		
		function   readOnly()   
		{   
	        var  a =  document.getElementsByTagName("input");   
	        for(var   i=0;   i<a.length;   i++)   {   
	           if(a[i].type=="checkbox" || a[i].type=="radio" || a[i].type=="text"){
	        	   a[i].readOnly = true;
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
		
		function quit(){
			window.location.href='${pageContext.request.contextPath}/faq/list';
		}
	</script>
</html>