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
	                		<div class="well">
		                		<form id="search"  action="${pageContext.request.contextPath}/client/inviter/detail/${cellphone}/1" method="post">
		                    		<input type="hidden" id="size" name="size" value="${size}" />
		                    		<input type="hidden" id="page" name="page" value="${page}" />
		                    		<input type="hidden" id="total" name="total" value="${total}" />
		                    		<input type="hidden" id="cellphone" name="cellphone" value="${cellphone}" />
		                      		<div class="row-fluid" style="margin-left: 0px;">
										<span style="width:60px;margin-left: 10px;">选择类型</span>
										<select id="inviterLevel" name="inviterLevel" style="background:white;width:150px; ">
										   <option value="1">一级好友</option>
										   <option value="2">二级好友</option>
										</select>
		                              	<input type="submit" value="查询" class="btn btn-default" style="margin-top: -15px"/>
	                          		</div>
		                    	</form>
			                </div>
			                <div class="row-fluid">
		                        <div class="block">
		                            <div class="block-content collapse in">
		                                <table class="table">
                                        	<thead>
                                        	    <c:if test="${inviterLevel == 1 }">
	                                       			<tr>
		                                                <th class="center">序号</th>
		                                                <th class="center">一级好友手机号</th>
		                                                <th class="center">一级好友姓名</th>
		                                                <th class="center">一级好友投资总金额(元)</th>
		                                                <th class="center">一级好友注册时间</th>
	                                            	</tr>
                                        	    </c:if>
                                        	    <c:if test="${inviterLevel == 2 }">
	                                       			<tr>
		                                                <th class="center">序号</th>
		                                                <th class="center">一级好友手机号</th>
		                                                <th class="center">二级好友手机号</th>
		                                                <th class="center">二级好友姓名</th>
		                                                <th class="center">二级好友投资总金额(元)</th>
		                                                <th class="center">二级好友注册时间</th>
	                                            	</tr>
                                        	    </c:if>
                                        	</thead>
                                        	<tbody>
                                        	  
	                                        	<c:choose>
	                                            	<c:when test="${fn:length(InviteesEntitylist)>0}">
	                                                	<c:forEach var="InviteesEntity" items="${InviteesEntitylist}" varStatus="status">
										       				<tr onclick="" id="${InviteesEntity.id}">
	                                                			<td>${status.count}</td>
	                                                			<c:if test="${inviterLevel == 2 }">
	                                                			   <td>${InviteesEntity.inviterPhone}</td>
	                                                			</c:if>
	                                                			<td>${InviteesEntity.cellphone}</td>
	                                                			<td>${InviteesEntity.name}</td>
	                                                			<td>${InviteesEntity.totalTradeMoney}</td>
			                                                	<td>
			                                                		<c:if test="${InviteesEntity.registerTime != 'Thu Jan 01 00:00:00 GMT+08:00 1970' and InviteesEntity.registerTime != 'Thu Jan 01 00:00:00 CST 1970'}">
    	                                    							<fmt:formatDate value="${InviteesEntity.registerTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
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
		                                        <tr>
		                                        	<td colspan="7">
		                                        		<div id="order-page"></div>
		                                        	</td>
		                                    	</tr>
		                                	</tfoot>
                            			</table>
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
				var totalPages = '${pages}';
				$('.breadcrumb').html('<li class="active">用户管理&nbsp;/&nbsp;受邀人明细</li>');
				$('.horizontalType').css({width:120});
				 $('#inviterLevel').find('option[value="${inviterLevel}"]').attr('selected','selected');
				if(totalPages > 0) {
					var options = {
				    	currentPage: '${page}',
				        totalPages: totalPages,
				        size: 'normal',
						alignment: 'center',
						tooltipTitles: function (type, page, current) {
							switch (type) {
						    case 'first':
						        return '首页';
						    case 'prev':
						        return '上一页';
						    case 'next':
						        return '下一页';
						    case 'last':
						        return '末页';
						    case 'page':
						        return (page === current) ? '当前页 ' + page : '跳到 ' + page;
						    }
						},
			            onPageClicked: function(event, originalEvent, type, page){
			            	$('#search').attr('action','/client/inviter/detail/'+${cellphone}+'/'+page);
			                $('#search').submit();
			            }  
					};
					$('#order-page').bootstrapPaginator(options);
		   		}
		   });
		   $('.horizontal').css({width:100});
		   $('#search').css('visibility','visible');
		   $('#search').children().show();
		</script>
	</body>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>