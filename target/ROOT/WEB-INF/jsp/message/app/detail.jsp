<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                    <!-- content begin -->
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div class="block-content collapse in">
	                        <form id="fm" action="" method="post" class="form-horizontal" >
								 <div class="well" style="padding-bottom: 20px; margin: 0;">
									<div class="control-group">
										<input id="id" name="id" value="${message.id }" type="hidden">
										<input name="page" value="type" value="${message.type }" type="hidden">
										<input name="page" value="${page}" type="hidden">
		                    			<input name="size" value="${size}" type="hidden">
		                    		</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span>消息内容</label>
										<div class="controls">
											<input type="text" id="news_content" class="text-input span8" value="${message.news.title }" readonly />
											<a class="btn btn-icon btn-default" href="javascript:preview();">预览</a>
											<input type="hidden" id="contentId" name="news.id" value="${message.news.id }">	
										</div>
									</div>
									<div class="form-actions">
										<a type="button" class="btn btn-icon btn-default" href="javascript:quit();">返回</a>
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
		 <div class="modal hide fade" id="preview" role="dialog" style="width:320px;height:568px;">
		  	<div class="modal-dialog modal-lg">
		    	<div class="modal-content">
		      		<div class="modal-header">
		        		<a type="button" class="close" data-dismiss="modal" aria-label="Close">
		        			<span aria-hidden="true">&times;</span>
		        		</a>
		        		<h3 id="message_title">${message.news.title }</h3>
		      		</div>
		      		<div class="modal-body" style="padding:0px;min-height:450px;">
		      			<p style="padding: 5px 0;">
		      				<span>来源：${message.news.source }</span>&nbsp;&nbsp;&nbsp;&nbsp;
		      				<span><fmt:formatDate value="${message.news.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></span>
		      			</p>
                        <c:choose>
                        	<c:when test="${message.news.type==1 }">
                        		<p>${message.news.content }</p>
                        	</c:when>
                        	<c:otherwise>
                        		<iframe src="${message.news.link }" style="border:none;width:320px;min-height:410px;" scrolling="auto"></iframe>
                        	</c:otherwise>
                        </c:choose>
		      		</div>
		      		<div class="modal-footer">
                        <a class="btn" data-dismiss="modal" aria-hidden="true">关闭</a>
		      		</div>
		    	</div>
		    </div>
		</div> 
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
		$(function(){
			$('.breadcrumb').html('<li class="active">消息管理&nbsp;/&nbsp;<a href="javascript:quit();">APP消息管理</a>&nbsp;/&nbsp;查看APP消息</li>');
			$('#title').val('${message.news.title}');
			$('#news_content').val('${message.news.title}');
		});
		
		function preview(){
			$('#preview').modal('show');
		}
		
		function quit() {
		   window.location.href='${pageContext.request.contextPath}/message/app/list/${page}';
	    }
	</script>
</html>