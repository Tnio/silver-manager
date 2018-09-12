<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			                    <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/product/contract/save">
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<input id="id" name="id" value="0" type="hidden">
				                    	<input name="page" value="${page }" type="hidden">
				                    	<input name="size" value="${size }" type="hidden">
										<div class="row-fluid">
											<div class="span12">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 合同名称</label>
													<div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="6~40个字符" class="validate[required, minSize[6], maxSize[40], ajax[ajaxcontractName]] text-input span9" id="name" name="name" value="${productContract.name}"/></div>
												</div>
											</div>
										</div>
										<div class="row-fluid">
												<label class="control-label"><span class="required">*</span>合同</label>
												<div class="controls">
												<div id="contractUploader">
												<c:forEach items="${productContract.attachments}" var="attachment">
											        <c:if test="${attachment.category == 9}">
														<a id="${attachment.id}" class="thumbnail" style="float: left; height:270px; width: 217px;">
											        		<span ><img  name="CONTRACTIMG" style="height:270px; width: 217px;" src="${attachment.url}"/></span>
												      	</a>
											      	</c:if>
										        </c:forEach>
												</div>
										      </div>
										</div>
									    <div class="row-fluid">
											<label class="control-label"><span class="required"></span>监管报告</label>
											<div class="controls">
											<div id="reportUpload">
											<c:forEach items="${productContract.attachments}" var="attachment">
												<c:if test="${attachment.category == 7}">
													<a id="${attachment.id}" class="thumbnail" style="float: left; height:270px; width: 217px;">
												        <span ><img  name="REPORTIMG" style="height:270px; width: 217px;" src="${attachment.url}"/></span>
												    </a>
											    </c:if>
										    </c:forEach>
											</div>
										    </div>
										</div>
									 	<div class="row-fluid">
											<label class="control-label"><span class="required"></span>资金监管协议</label>
											<div class="controls">
											<div id="protocolUploader">
											<c:forEach items="${productContract.attachments}" var="attachment">
										        <c:if test="${attachment.category == 8}">
													<a id="${attachment.id}" class="thumbnail" style="float: left; height:270px; width: 217px;">
										        		<span ><img  name="PROTOCOLIMG" style="height:270px; width: 217px;" src="${attachment.url}"/></span>
											      	</a>
										      	</c:if>
									        </c:forEach>
											</div>
									    	</div>
										</div>
										<div class="form-actions">
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
		<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
		<script type="text/javascript">
		   $('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">产品合同管理&nbsp;</a>/&nbsp;产品合同查看</li>');
		   var workImg=document.getElementsByTagName('img'); 
			for(var i=0; i<workImg.length; i++) {
				workImg[i].onclick=ImgShow;
			}
		   function quit() {
			   window.location.href='${pageContext.request.contextPath}/product/contract/list/1';
		   }
		</script>
	</body>
</html>