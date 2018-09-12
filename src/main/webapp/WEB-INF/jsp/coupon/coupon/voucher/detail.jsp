<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<c:import url="/header" />
	<body>
		<c:import url="/menu"></c:import>
        <div class="container-fluid">
            <div class="row-fluid">
                <c:import url="/sidebar"></c:import>
                <div class="span10" id="content">
                    <c:import url="/breadcrumb"></c:import>
                    <!-- content begin -->
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                        	<form id="search" action="${pageContext.request.contextPath}/coupon/coupon/voucher/exchange/record/${couponId}" method="post">
	                    		<input type="hidden" id="page" name="page" value="${page}" />
	                    		<input type="hidden" id="size" name="size" value="${size}" />
	                    		<div class="navbar navbar-inner block-header">
	                    			<div style="margin:2px auto auto auto">
		                            	<span style="vertical-align: 3px">手机号</span>
										<input class="span2" id="cellphone" name="cellphone" value="${cellphone}" type="text" onkeyup="this.value=this.value.trim()" />&nbsp;
		                            	&nbsp;
		                            	<span style="vertical-align: 3px">是否使用</span>
										<select id="status" name="status" class="span2">
											<option value="-1">全部</option>
											<option value="0">未使用</option>
											<option value="1">已使用</option>
										</select>
										&nbsp;
										<input type="submit" value="查询" style="margin-top: -10px" class="btn btn-default" />
									</div>
                      			</div>
	                        </form>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="coupon" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr align="center">
	                                            <th>序号</th>
	                                            <th>手机号</th>
	                                            <th>加息券领取时间</th>
	                                            <th>加息券使用时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(customerCoupons) > 0}">
                                            <c:forEach var="coupon" items="${customerCoupons}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="couponId${coupon.id}">
                                                <td>${status.count}</td>
                                                <td>${coupon.customer.cellphone}</td>
                                                <td><fmt:formatDate value="${coupon.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td><c:if test="${coupon.used == 0}">未使用</c:if><c:if test="${coupon.used == 1}"><fmt:formatDate value="${coupon.usedTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></c:if></td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="9">暂时还没有兑换记录列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                        	<c:if test="${fn:length(customerCoupons) > 0}">
	                                            <tr>
	                                        		<td colspan="10">
	                                        		总计:${total}
	                                        		</td>
	                                        	</tr>
                                       	    </c:if>
                                            <tr>
                                       		    <td colspan="9"><div id="coupon-page"></div></td>
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
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
	    var beforeDate = "";
	    var rowId = 0;
	    var id = 0;
	    var status = 0;
	    $('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="${pageContext.request.contextPath}/coupon/coupon/list">券码库</a>&nbsp;/&nbsp;加息兑换券兑换明细</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/coupon/voucher/exchange/record/${couponId}');
		            	$('#page').val(page);
		                $('#search').submit();
		            }  
			    };
				$('#coupon-page').bootstrapPaginator(options);
			}
			$('#status').find("option[value='${status}']").attr("selected",true);
		});
	</script>
	<c:import url="/authority"></c:import>
</html>