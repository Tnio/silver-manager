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
                    	<form class="form-horizontal" id="fm" method="post">
                    		<input id="id" name="id" value="${bank.id}" type="hidden">
                    		<div class="well">
								<div class="row-fluid">
									<div class="span6">
										<div class="control-group">
											<label class="control-label">手机号</label>
											<div class="controls"><input class="text-input span6" value="${ebankLog.oldBank.customer.cellphone}" readonly type="text" /></div>
										</div>
									</div>
									<div class="span6">
										<div class="control-group">
											<label class="control-label">身份证号码</label>
											<div class="controls"><input type="text" class="=text-input span6" value="${ebankLog.oldBank.customer.idcard}" readonly type="text" /></div>
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="span6">
										<div class="control-group">
											<label class="control-label">原卡所属银行</label>
											<div class="controls"><input class="text-input span6" value="${ebankLog.oldBank.bankName}" readonly type="text" /></div>
										</div>
									</div>
									<div class="span6">
										<div class="control-group">
											<label class="control-label">原卡卡号</label>
											<div class="controls"><input type="text" class="=text-input span6" value="${ebankLog.oldBank.cardNO}" readonly type="text" /></div>
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="span6">
										<div class="control-group">
											<label class="control-label">新卡所属银行</label>
											<div class="controls"><input class="text-input span6" value="${ebankLog.newBank.bankName}" readonly type="text" /></div>
										</div>
									</div>
									<div class="span6">
										<div class="control-group">
											<label class="control-label">新卡卡号</label>
											<div class="controls"><input type="text" class="=text-input span6" value="${ebankLog.newBank.cardNO}" readonly type="text" /></div>
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="span6">
										<div class="control-group">
											 <label class="control-label">原卡注销证明</label>
											 <div class="controls">
											 	<a class="thumbnail" style="float: left; height:300px; width: 217px;">
											 		<div style="height:270px;width:217px;"><img style="height:270px; width: 217px;" src="${ebankLog.logoutImg}"/></div>
												</a>
											</div>
										</div>
									</div>
									<div class="span6">
										<div class="control-group">
											<label class="control-label">三合一照片</label>
											<div class="controls">
											 	<a class="thumbnail" style="float: left; height:300px; width: 217px;">
											 		<div style="height:270px;width:217px;"><img style="height:270px; width: 217px;" src="${ebankLog.validateImg}"/></div>
												</a>
											</div>
										</div> 
									</div>
								</div>
								<div class="row-fluid">
									<div class="span6">
										<div class="control-group">
											 <label class="control-label">身份证正面照片</label>
											 <div class="controls">
											 	<a class="thumbnail" style="float: left; height:300px; width: 217px;">
											 		<div style="height:270px;width:217px;"><img style="height:270px; width: 217px;" src="${ebankLog.idcardFacade}"/></div>
												</a>
											</div>
										</div>
									</div>
									<div class="span6">
										<div class="control-group">
											<label class="control-label">身份证反面照片</label>
											<div class="controls">
											 	<a class="thumbnail" style="float: left; height:300px; width: 217px;">
											 		<div style="height:270px;width:217px;"><img style="height:270px; width: 217px;" src="${ebankLog.idcardBack}"/></div>
												</a>
											</div>
										</div> 
									</div>
								</div>
								<c:if test="${ebankLog.status != 0 }">
									<div class="row-fluid">
							      		<div class="control-group span8">
											<label class="control-label"><span class="required"></span>备注</label>
											<div class="controls span8">
												<textarea  id="remark" name="remark" readonly rows="2" class="validate[maxSize[600]] span12">${ebankLog.remark}</textarea>
											</div>
										</div>
						      		</div>
								</c:if>
								<div class="control-group">
									<label class="control-label"></label>
									<div class="controls">
										<button type="button" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit();"><i></i>返回</button>
										<span id="authorityButton">
											<a type="button" id="2010" class="btn" class="btn btn-primary glyphicons circle_ok" href="javascript:audit();">审核 </a>
										</span>
									</div>
								</div>
                    		</div>
                    	</form>
                    </div>
                    <!-- content end -->
                </div>
            </div>
        </div>
        <div class="modal hide fade" style="width:500px; height:280px;" id="authorizationDiv" role="dialog" >
			<form id="fmg" class="modal-content form-horizontal password-modal" >
           	  <input type="hidden" id="id" name="id">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4>请确认审核结果！</h4>
		      </div>
		      <div class="modal-body span6">
			      	<div class="row-fluid">
						<div class="span4">
							<div class="control-group">
								<input type="radio" id="toplaywith" name="result" value="1" checked="checked">
								<span>通过</span>
							</div>
						</div>
						<div class="span4">
							<div class="control-group">
								<input type="radio" id="auditdidnotpass" name="result" value="2">
								<span>不通过</span>
							</div>
						</div>
				  </div>
			  </div>
			  <div style="margin-left:50px;">
				  <textarea id="remark" name="remark" style="width: 320px;" rows="3" cols="260" placeholder="备注信息" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" class="validate[maxSize[250]]"></textarea>
			  </div>
		      <div style="margin-left:80px;margin-top: 15px;">
		        <button type="button" style="vertical-align:middle;" class="btn btn-primary" onclick="confirmed()">确认</button>
		        <button type="button" class="btn btn-default" onclick="quitAudition()">取消</button>
		      </div>
			</form>		   
		</div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/res/js/show.original.image.js"></script>
	</body>
	<script type="text/javascript">
		$('.breadcrumb').html('<li class="active">客户专区&nbsp;/&nbsp;<a href="javascript:quit();">更换银行卡</a>&nbsp;/&nbsp;查看</li>');
		
		function quit(){
			window.location.href='${pageContext.request.contextPath}/ebank/log/list/1';
		}
		
		var workImg=document.getElementsByTagName('img'); 
	   for(var i=0; i<workImg.length; i++) {
		   workImg[i].onclick=ImgShow;
	   }
	   
	   function audit(){
		   $('#authorizationDiv').modal('show');
	   }
	
		function quitAudition() {
			$('#authorizationDiv').modal('hide');
		}
		
		function confirmed() {
			var result = $('[name=result]').filter(':checked').attr('value');
			var remark = $('#remark').val();
			$.post('${pageContext.request.contextPath}/ebank/log/audit/${ebankLog.id}', {'result':result, 'remark':remark}, function(result){
				if (result) {
			        window.location.href='${pageContext.request.contextPath}/ebank/log/list/1';
				} else {
				    alert('审核失败，请重试!');
			    }
		   });
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
	<script type="text/javascript">
		var status = '${ebankLog.status}';
		if (status != 0) {
			$('#2010').hide();
		} 
	</script>
</html>