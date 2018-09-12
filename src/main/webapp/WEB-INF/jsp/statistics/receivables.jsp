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
                  	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="well">
                     	<form id="search" action="${pageContext.request.contextPath}/statistics/receivables/list/${id}/1" method="post">
                	  		<div class="input-group pull-left">
								<span>选择商户</span>
                     			<select id="id" name="id">
									<option value="1" <c:if test="${id == 1}">selected</c:if> >嘉华融资租赁有限公司</option>
									<option value="2" <c:if test="${id == 2}">selected</c:if>>浙江嘉远微银科技有限公司</option>
									<option value="3" <c:if test="${id == 3}">selected</c:if>>宁波弘丰聚富投资合伙企业（有限合伙）</option>
									<option value="4" <c:if test="${id == 4}">selected</c:if>>浙江禅文投资管理有限公司</option>
								</select>
                     		</div>
                 		</form>
                    </div>
                    <div class="row-fluid">
                       	<div class="block">
                       		<div class="navbar navbar-inner block-header" style="min-height:0px">
                       		</div>
                            <div class="block-content collapse in">
                                <div class="span12">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th>时间</th>
                                               <th>放款金额</th>
                                               <th>还款金额</th>
                                               <th>产品收益</th>
                                               <th>单月待收总计</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       	<c:choose>
                                       		<c:when test="${fn:length(receivablesEntityList) > 0}">
                                       			<c:forEach var ="receivablesEntity" items="${receivablesEntityList}" varStatus="status">
                                       				<tr>
														<td>${receivablesEntity.dueDate}</td>
                                       					<td><fmt:formatNumber value="${receivablesEntity.payAmount}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${receivablesEntity.backAmount}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${receivablesEntity.productIncome}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${receivablesEntity.monthReceivables}" pattern="#,##0.00" /></td>
                                       				</tr>
                                       			</c:forEach>
                                       		</c:when>
                                       		<c:otherwise>
                                       			<tr>
                                       				<td colspan="10">暂时没有待收统计信息</td>
                                       			</tr>
                                       		</c:otherwise>
                                       	</c:choose>
                                       </tbody>
                                       <tfoot>
                                       	  <tr>
                                        	  <td colspan="10">累计待收:<fmt:formatNumber value="${totalIncome }" pattern="#,##0.00" />元
                                        	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;截止日期: ${yesterday} 
                                        	  </td>
	                                      </tr>
	                                      <tr>
		                                     <td colspan="8">
		                                       	<div id="receivables-page"></div>
		                                     </td>
		                                  </tr>
                                       </tfoot>
                                   </table>
                                </div>
                            </div>
                        </div>
                        <!-- /block -->
                    </div>
                    <!-- content end -->
                </div>
            </div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
	    $(document).ready(function(){
			$('.marginTop').css('margin', '2px auto auto auto');
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">统计管理&nbsp;/&nbsp;待收统计</li>');
			$('.horizontalType').css({width:120});
			$('#id').change(function() {
				var value = $('#id').val();
				window.location.href='${pageContext.request.contextPath}/statistics/receivables/list/'+value+'/1';
		    });
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/statistics/receivables/list/${id}/'+page);
		                $('#search').submit();
		            }  
				};
				$('#receivables-page').bootstrapPaginator(options);
	   		}
	    });
	</script>
</html>