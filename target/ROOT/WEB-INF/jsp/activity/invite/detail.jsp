<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
<!--
.combo-select {
  position: relative;
  max-width: 200px;
  min-width: 200px;
  /* margin-bottom: 15px; */
  font: 100% Helvetica, Arial, Sans-serif;
  border: 1px #ccc solid;
  border-radius: 3px;
  display:inline-block;
  vertical-align: top;
   } 
-->
</style>
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
			                  <input type="hidden" id="page" name="page" value="${page }">
			                  <input type="hidden" id="cellphone" name="cellphone" value="${cellphone }">
		                        <div class="block">
		                            <div class="block-content collapse in">
		                                <table class="table">
                                        	<thead>
                                       			<tr>
	                                                <th class="center">序号</th>
	                                                <th class="center">好友手机号</th>
	                                                <th class="center">姓名</th>
	                                                <th class="center">好友类型</th>
	                                                <th class="center">投资金额</th>
	                                                <th class="center">理财期限(天)</th>
	                                                <th class="center">产品名称</th>
	                                                <th class="center">投资时间</th>
                                            	</tr>
                                        	</thead>
                                        	<tbody>
	                                        	<c:choose>
	                                            	<c:when test="${fn:length(inviterRewardEntities)>0}">
	                                                	<c:forEach var="inviterRewardEntity" items="${inviterRewardEntities}" varStatus="status">
										       				<tr onclick="" id="${inviterRewardEntity.id}">
	                                                			<td>${status.count}</td>
	                                                			<td>${inviterRewardEntity.cellphone}</td>
	                                                			<td>${inviterRewardEntity.name}</td>
	                                                			<td> 
	                                                			   <c:if test="${inviterRewardEntity.inviterLevel == 1}">一级好友</c:if>
	                                                			   <c:if test="${inviterRewardEntity.inviterLevel == 2}">二级好友</c:if>
	                                                			</td>
	                                                			<td>${inviterRewardEntity.principal}</td>
	                                                			<td>${inviterRewardEntity.financePeriod}</td>
	                                                			<td>${inviterRewardEntity.productName}</td>
			                                                	<td>
			                                                		<c:if test="${inviterRewardEntity.orderTime != 'Thu Jan 01 00:00:00 GMT+08:00 1970' and inviterRewardEntity.orderTime != 'Thu Jan 01 00:00:00 CST 1970'}">
    	                                    							<fmt:formatDate value="${inviterRewardEntity.orderTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
   	                                    							</c:if>
   	                                    						</td>
                                            				</tr>
	                                            		</c:forEach>
	                                        		</c:when>
			                                        <c:otherwise>
		                                        		<tr>
		                                                	<td colspan="7">暂时还没有记录</td>
		                                            	</tr>  
		                                        	</c:otherwise>
                                       		 	</c:choose>
                                    		</tbody>
		                                    <tfoot>
		                                	</tfoot>
                            			</table>
<!--                                         <div class="row-fluid"> -->
<!-- 										  	<div class="span12" align="center"> -->
<!-- 										  		<button  type="reset" class="btn btn-default btn-lg" onclick="quit()">返回</button>	 -->
<!-- 										  	</div> -->
<!-- 										</div> -->
	                    			</div>
	                			</div>
		            		</div>
	            	</div>
	    	</div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;<a href="${pageContext.request.contextPath}/activity/inviter/list/1">邀请奖励管理 &nbsp</a> /&nbsp;奖励明细</li>');
				$('.horizontalType').css({width:120});
		   });
		   $('.horizontal').css({width:100});
// 		   function quit(){
// 			   var cellphone= $("#cellphone").val();
// 			   window.location.href='${pageContext.request.contextPath}/activity/inviter/list/'+${page}+'?cellphone='+cellphone;
// 		   }
		</script>
	</body>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>