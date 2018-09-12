<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><spring:message code="system.name" /></title>
	<link type="images/x-icon" rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico">
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" />
	<link rel="Bookmark" href="${pageContext.request.contextPath}/favicon.ico" />
	<!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
    <link href="${pageContext.request.contextPath}/css/validation.jquery.css" rel="stylesheet" media="screen">
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <![endif]-->
  </head>

  <body background="${pageContext.request.contextPath}/images/backgroud.png" style="margin:0;background-size:cover; ">
   <form id="gauth" action="${pageContext.request.contextPath}/gauth" method="post" ><!-- onsubmit="return validate()" -->
    <input id="userName" name="userName" type="hidden" value="${userName}" />
	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
	  <tr>
	    <td height="220">&nbsp;</td>
	    <td width="543">&nbsp;</td>
	    <td width="304">&nbsp;</td>
	    <td width="347">&nbsp;</td>
	    <td width="175">&nbsp;</td>
	  </tr>
	  <tr>
	  	<td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td><img src="${pageContext.request.contextPath}/images/middle.png" style="min-height:336px; min-width:304px" /></td>
	    <td>
	    <table width="347" height="336" border="0" align="left" cellpadding="0" cellspacing="0" background="${pageContext.request.contextPath}/images/from_bg.png">
	      <tr>
	        <td height="46">&nbsp;</td>
	      </tr>
	      <tr>
	        <td height="30"><b>身份验证信息（银狐令） </b></td>
	      </tr>
	      <tr>
	        <td height="40">帐户：${userName}</td>
	      </tr>
	      <tr>
	        <td height="10"></td>
	      </tr>
	      <tr>
	      <tr>
	        <td height="40" colspan="2">
	        <div class="input-group">
	          <input id="authCode" name="authCode" type="text" class="validate[required,minSize[6],maxSize[6],custom[number]] form-control" placeholder="银狐令" >
	        </div>
	        </td>
	      </tr>
	      <tr>
	        <td height="25"><span style="color:red;">&nbsp;&nbsp;${message}</span></td>
	      </tr>
	      <tr>
	        <td height="45">
	          <button id="action" type="button" class="btn btn-large btn-danger" onclick="javascript:doSubmit();">确定</button>&nbsp;&nbsp;&nbsp;&nbsp;
	          <button id="cancel" type="button" class="btn btn-large btn-success" onclick="javascript:doCancel();">返回</button>
	        </td>
	      </tr>
	      <tr>
	        <td height="100">&nbsp;</td>
	      </tr>
	    </table>
	    </td>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	  	<td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	  </tr>
	</table>
   </form>
  </body>
  <script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/jquery.validation.js"></script>
  <script src="${pageContext.request.contextPath}/js/jquery.validation-zh_cn.js"></script>
  <script type="text/javascript">
	var session = '${sessionsilverfoxkey}';
	if(session) {
		window.location.replace('${pageContext.request.contextPath}/main');
	}
	
    $(function() {
    	$('#authCode').focus();
    	$('#action').css({width:100});
    	$('#cancel').css({width:100});
    	$('#gauth').validationEngine('attach',{
    		autoHidePrompt:true,
    		autoHideDelay:3000,
    		promptPosition:'bottomRight'
    	});
	});
    $(document).keypress(function(event){  
        var keycode = (event.keyCode ? event.keyCode : event.which);  
        if(keycode == '13'){  
        	$('#gauth').submit();    
        }  
    });	
	function doSubmit(){
		$('#gauth').submit();
	}
	
	function doCancel(){
		window.location.href = '${pageContext.request.contextPath}/';
	}
  </script>
</html>