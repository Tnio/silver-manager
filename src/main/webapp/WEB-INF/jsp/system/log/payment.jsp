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
	               		 <form id="search" action="${pageContext.request.contextPath}/system/log/payment/1" method="post">
	                   		<input type="hidden" id="size" name="size" value="${size}" />
							<div class="input-group pull-left">
								<span>订单号</span>
								<input class="horizontal marginTop" id="orderNo" name="orderNo" type="text"  value="${orderNo}" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" />
								<span>产品名称</span>
								<input class="horizontal marginTop" id="productName" name="productName" type="text" value="${productName}" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" />
								<span>持卡人</span>
								<input class="horizontal marginTop" id="customerName" name="customerName" type="text" value="${customerName}" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" />
	                            <input type="submit" value="查询" class="btn btn-default" />
	                            <input type="reset" value="重置" onclick="resetData()" class="btn btn-default" />
	                   		</div>
	                   	</form>
	                 </div>
                     <div class="row-fluid">
                       	<div class="block">
                       		<div class="navbar navbar-inner block-header">
                       		</div>
                            <div class="block-content collapse in">
                                <div class="span12">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th>序号</th>
                                               <th>订单号</th>
                                               <th>放款原因</th>
                                               <th>持卡人</th>
                                               <th>银行名称</th>
                                               <th>放款金额</th>
                                               <%--<th>时间</th>--%>
                                               <th>结果</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       	<c:choose>
                                       		<c:when test="${fn:length(logs) > 0}">
                                       			<c:forEach var ="log" items="${logs}" varStatus="status">
                                       				<tr>
														<td>${status.count}</td>
                                       					<td>${log.orderNo}</td>
                                       					<td>
                                       						<c:if test="${log.flagCard == 0}">${log.productName}</c:if>
                                       						<c:if test="${log.flagCard == 1}">商户放款</c:if>
                                       					</td>
                                       					<td>${log.customerName}</td>
                                       					<td>${log.bankName}</td>
                                       					<td><fmt:formatNumber value="${log.amount}" pattern="#,##0.00" /></td>
                                       					<%--<td><fmt:formatDate value="${log.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>--%>
                                       					<td>${log.result}</td>
                                       				</tr>
                                       			</c:forEach>
                                       		</c:when>
                                       		<c:otherwise>
                                       			<tr>
                                       				<td colspan="9">暂时没有记录</td>
                                       			</tr>
                                       		</c:otherwise>
                                       	</c:choose>
                                       </tbody>
                                       <tfoot>
                                       	<tr>
                                       		<td colspan="9"><div id="log-page"></div></td>
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
		$('.marginTop').css('margin', '2px auto auto auto');
		$('.datepicker').css({width:120});
	    $('.horizontal').css({width:120});
		$(document).ready(function(){
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">系统管理&nbsp;/&nbsp;放款日志</li>');
			
			$('#search').validationEngine('attach', {
		        promptPosition:'bottomLeft',
		        showOneMessage: true,
		        scroll: false
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
		            	$('#search').attr('action', '${pageContext.request.contextPath}/system/log/payment/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#log-page').bootstrapPaginator(options);
			}
		});
		
		function resetData() {
			$('#orderNo').val('');
		 	$('#productName').val('');
		 	$('#customerName').val('');
		 	$('#search').attr('action','${pageContext.request.contextPath}/system/log/payment/1');
		    $('#search').submit(); 
		}
	</script>
</html>