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
                    <div class="row-fluid">
                    	<div class="block">
                    	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a href="javascript:detail()"  id="2011"><button class="btn btn-lg btn-primary">查看</button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="product" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>手机号</th>
	                                            <th>原卡</th>
	                                            <th>新卡</th>
	                                            <th>提交时间</th>
	                                            <th>状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(logs) > 0}">
                                            <c:forEach var="log" items="${logs}" varStatus="status">
	                                            <tr onclick="getRow(this, '#BFBFBF')" id="logId${log.id}">
	                                                <td class="hiddenid">${log.id}</td>
	                                                <td class="hiddenid">${log.status}</td>
	                                                <td>${status.count}</td>
	                                                <td><c:if test="${not empty log.oldBank and not empty log.oldBank.customer}">${log.oldBank.customer.cellphone }</c:if> </td>
	                                            	<td><c:if test="${not empty log.oldBank and not empty log.oldBank.cardNO}">${log.oldBank.bankName}（尾号${fn:substring(log.oldBank.cardNO, (fn:length(log.oldBank.cardNO) - 4), fn:length(log.oldBank.cardNO))}）</c:if></td>
	                                            	<td><c:if test="${not empty log.newBank and not empty log.newBank.cardNO}">${log.newBank.bankName}（尾号${fn:substring(log.newBank.cardNO, (fn:length(log.newBank.cardNO) - 4), fn:length(log.newBank.cardNO))}）</c:if></td>
	                                           		<td><fmt:formatDate value="${log.createTime}" type="both" pattern="yyyy-MM-dd HH:mm" /></td>
	                                            	<td>
	                                            		<c:if test="${log.status == 0}">待审核</c:if>
	                                            		<c:if test="${log.status == 1}">审核通过</c:if>
	                                            		<c:if test="${log.status == 2}">审核不通过</c:if>
	                                            	</td>
	                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="8">没有数据~</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
	                                     	<tr>
	                                        	<td colspan="8"><div id="ebankLog-page"></div></td>
	                                        </tr>
	                                     </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>		
                    </div>
                </div>
            </div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
		var rowId = 0;
		var status = -1;
		$(document).ready(function(){
			$('.breadcrumb').html('<li class="active">客户专区&nbsp;/&nbsp;更换银行卡</li>');
			$('[rel="tooltip"]').tooltip();
			$('.hiddenid').hide();
			
			$('#2011').hide();
			
			var totalPages = '${pages}';
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
		            	window.location.href='${pageContext.request.contextPath}/ebank/log/list/'+page;
		            }  
			    };
				$('#ebankLog-page').bootstrapPaginator(options);
			}
		});
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#2011').hide();
				rowId = 0;
			} else {
				$('#logId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				$('#2011').show();
			}
		
		}
		
		function detail(){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/ebank/log/detail/'+rowId;
			}else{
				alert('请先选择您想要查看的数据！');
			}
			
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>