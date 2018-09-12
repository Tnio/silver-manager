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
                    <div class="row-fluid">
                    	<div class="well">
                           	<form id="search" action="${pageContext.request.contextPath}/channel/order/list/1" method="post" class="form-search">
                           		<input type="hidden" id="size" name="size" value="${size}" />
                           		<div class="input-group" style="height:0px">
                               		<span>渠道</span>
                               		<select id="channelID" name="channelID" class="span2 marginTop">
                                   		<option value="0">全部</option>
								      	<option value="4">天翼流量800</option>
								      	<option value="53">流量全网通</option>
								      	<option value="62">富爸爸金融</option>
									</select>
									<span>手机号</span>
                                   	<input class="horizontal marginTop" type="text" id="cellphone" name="cellphone" value="${cellphone}" class="span3" />
									<span>流水号</span>
                                   	<input class="horizontal marginTop" type="text" id="requestNO" name="requestNO" value="${requestNO}" class="span3" />
                                    <input type="submit" class="btn btn-default" style="margin-top: -10px" value="查询"/>
                                 </div>
                              </form>
                          </div>
                    	<div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table class="table">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>流水号</th>
	                                            <th>渠道名称</th>
	                                            <th>手机号</th>
	                                            <th>赠送奖品</th>
	                                            <th>状态</th>
	                                            <th>时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(orders) > 0}">
                                            <c:forEach var="order" items="${orders}" varStatus="status">
                                            <tr>
                                                <td class="hidden">${order.id}</td>
                                                <td>${status.count}</td>
                                                <td>${order.requestNO}</td>
                                                <td>${order.channel.name}</td>
                                                <td>${order.cellphone}</td>
                                                <td>${order.goods}</td>
                                                <td>
                                                    <c:choose>
	                                                <c:when test="${order.channel.id==4}">
	                                                 	<c:set var="resultCode" value="${fn:split(order.result,':')[0]}"></c:set>
	                                                    <c:forEach var="code" items="${flow800Result}" varStatus="status">
	                                                    	<c:if test="${code.key==resultCode}">
	                                                    	    [${code.key}]${code.value}
	                                                    	</c:if>
	                                                    </c:forEach>
	                                                </c:when>
	                                                <c:otherwise>
	                                                	${order.result}
	                                                </c:otherwise>
	                                                </c:choose>
                                                </td>
                                                <td>
                                                  <fmt:formatDate value="${order.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
                                                </td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="8">暂时还没有赠送信息</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                         <tfoot>
                                        	<tr>
                                        		<td colspan="8">
                                        		    <div id="orders-page"></div>
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
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
		var rowId = 0;
		var status = '';
		$(document).ready(function(){
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">订单管理&nbsp;/&nbsp;渠道订单</li>');
			$('[rel="tooltip"]').tooltip();
			$('.thumbnailSize').css('height', '40px');
			$('#channelID').find('option[value="${channelID}"]').attr('selected','selected');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/channel/order/list/'+page);
		                $('#search').submit();
		            }
			    };
				$('#orders-page').bootstrapPaginator(options);
			}
		});
	</script>
</html>