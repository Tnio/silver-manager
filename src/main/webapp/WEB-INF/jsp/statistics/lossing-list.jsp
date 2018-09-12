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
                		<form id="search" action="${pageContext.request.contextPath}/statistics/lossing/customer/list/${paybackDate}/1" method="get">
                      		<div class="input-group" style="height:10px;">
                      			<span>排序</span>
								<select id="sort" name="sort" onchange="search()">
									<option value="tradeMoney" <c:if test="${sort =='tradeMoney' }"> selected="selected"</c:if> >投资金额</option>
                              		<option value="lastTradeTime" <c:if test="${sort =='lastTradeTime' }"> selected="selected"</c:if> >最后投资时间</option>
								</select>
                            </div>
                    	</form>
			         </div>
                    <div class="row-fluid">
                       	<div class="block">
	                        <!-- block -->
                            <div class="block-content collapse in">
                                <div class="span12">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th>序号</th>
                                               <th>手机号</th>
                                               <!-- <th>注册时间</th> -->
                                               <th>投资总金额</th>
                                               <th>渠道名称</th>
                                               <th>最后投资时间</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       	<c:choose>
                                       		<c:when test="${fn:length(customers) > 0}">
                                       			<c:forEach var ="customer" items="${customers}" varStatus="status">
                                       				<tr>
														<td>${status.count}</td>
                                       					<td><a href="${pageContext.request.contextPath}/client/user/detail/${customer.id}">${customer.cellphone}</a></td>
                                       					<%-- <td><fmt:formatDate value="${customer.registerTime }" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td> --%>
                                       					<td><fmt:formatNumber value="${customer.totalTradeMoney}" pattern="#,##0" /></td>
                                       					<td><c:if test="${not empty customer.channel }">${customer.channel.name}</c:if></td>
                                       					<td><fmt:formatDate value="${customer.latestTradeTime }" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                       				</tr>
                                       			</c:forEach>
                                       		</c:when>
                                       		<c:otherwise>
                                       			<tr>
                                       				<td colspan="7">没有流失用户</td>
                                       			</tr>
                                       		</c:otherwise>
                                       	</c:choose>
                                       </tbody>
                                       <tfoot>
                                       	  <tr>
	                                      </tr>
	                                      <tr>
                                        	  <td colspan="7">
                                        		  <div id="customer-page"></div>
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
		$('.breadcrumb').html('<li class="active">统计管理&nbsp;/&nbsp;流失统计明细</li>');
		$('.marginTop').css('margin', '2px auto auto auto');
		
		$(document).ready(function(){
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/statistics/lossing/customer/list/${paybackDate}/'+page);
		    			$('#search').submit();
		            }  
				};
				$('#customer-page').bootstrapPaginator(options);
	   		}
			
	    });
		
		function search(){
			$('#search').attr('action','${pageContext.request.contextPath}/statistics/lossing/customer/list/${paybackDate}/1');
			$('#search').submit();
		}
	</script>
</html>