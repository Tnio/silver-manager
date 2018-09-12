<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<c:import url="/header" />
	<body>
		<c:import url="/menu" />
        <div class="container-fluid">
            <div class="row-fluid">
            	<c:import url="/sidebar" />
                <div class="span10" id="content">
                	<c:import url="/breadcrumb" />
                    <div class="row-fluid">
                    	<div class="well">
                           	<form id="search" action="${pageContext.request.contextPath}/coupon/bonus/${type}/record/${dispatchingBonusLogId}" method="post" >
                           		<input type="hidden" id="size" name="size" value="${size}" />
                           		<input type="hidden" id="page" name="page" value="${page}" />
                           		<div class="input-group" style="height:0px">
                                   	<span style="vertical-align: 3px">类型</span>
                                    <select id="category" name="category" class="span3">
										<option value="-1" <c:if test="${category ==-1 }"> selected="selected"</c:if>>全部</option>
                                    	<option value="0" <c:if test="${category ==0 }"> selected="selected"</c:if>>红包</option>
                                    	<option value="4" <c:if test="${category ==4 }"> selected="selected"</c:if>>加息券</option>
									</select>
									<span style="vertical-align: 3px">是否使用</span>
                                    <select id="used" name="used" class="span3">
										<option value="-1" <c:if test="${used ==-1 }"> selected="selected"</c:if>>全部</option>
                                    	<option value="0" <c:if test="${used ==0 }"> selected="selected"</c:if>>未使用</option>
                                    	<option value="1" <c:if test="${used ==1 }"> selected="selected"</c:if>>已使用</option>
                                    	<option value="2" <c:if test="${used ==2 }"> selected="selected"</c:if>>已转赠</option>
									</select>
                               		<span style="vertical-align: 3px">手机号</span>
                                   	<input class="horizontal marginTop" type="text" id="cellphone" name="cellphone" value="${cellphone}" class="span3" />
                                    <input type="submit" class="btn btn-default" style="margin-top: -10px" value="查询"/>
                                 </div>
                        	</form>
                        </div>
                    	<div class="block">
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table class="table">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>手机号</th>
	                                            <!-- <th>优惠券名称</th> -->
	                                            <th>赠送额度</th>
	                                            <th>是否使用</th>
	                                            <th>赠送时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(customerCoupons) > 0}">
                                            <c:forEach var="record" items="${customerCoupons}" varStatus="status">
                                            <tr>
                                                <td class="hidden">${record.id}</td>
                                                <td>${status.count}</td>
                                                <td>${record.cellphone}</td>
                                                <td><fmt:formatNumber value="${record.amount}" pattern="#.##" /><c:if test="${record.coupon.category == 4}">%</c:if><c:if test="${record.coupon.category != 4}">元</c:if></td>
                                                <td>
                                                	<c:if test="${record.used == 0}">未使用</c:if>
                                                	<c:if test="${record.used == 1}">已使用</c:if>
                                                	<c:if test="${record.used == 2}">已转赠</c:if>
                                                </td>
                                                <td><fmt:formatDate value="${record.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="7">暂时还没有数据列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                         <tfoot>
                                        	<tr>
                                        		<td colspan="7">
                                        		    <div id="detail-page"></div>
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
        </div>
        <c:import url="/footer" />
	</body>
	<script type="text/javascript">
		var rowId = 0;
		var status = '';
		$(document).ready(function(){
			var totalPages = '${pages}';
			var name = '';
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
		            	$('#page').val(page);
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/${type}/record/${dispatchingBonusLogId}');
		                $('#search').submit();
		            }
			    };
				$('#detail-page').bootstrapPaginator(options);
			};
			if(${type == 'rule'}){
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit()" >优惠券规则</a>&nbsp;/&nbsp;查看明细</li>');
			}else {
				$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit()" >优惠券赠送管理</a>&nbsp;/&nbsp;查看明细</li>');
			};
		});
		
		function quit(){
			window.location.href='${pageContext.request.contextPath}/coupon/bonus/${type}/list';
		}
	</script>
	<c:import url="/authority" />
</html>