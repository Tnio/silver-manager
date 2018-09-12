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
                        	<form id="search" action="${pageContext.request.contextPath}/coupon/exchange/codes/${couponExchangeId}" method="post">
	                    		<input type="hidden" id="page" name="page" value="${page}" />
	                    		<input type="hidden" id="size" name="size" value="${size}" />
	                    		<div class="navbar navbar-inner block-header">
	                    			<div style="margin:2px auto auto auto">
		                            	<span>选择时间</span>
	                         			<input type="text" id="beginTime" name="beginTime" style="background:white;width:120px;" value="${beginTime}" class="horizontal marginTop" onkeypress="return false"/>
	                             		<span>-</span>
	                             		<input type="text" id="endTime" name="endTime" style="background:white;width:120px;" value="${endTime}" class="horizontal marginTop" onkeypress="return false"/>
		                            	&nbsp;
		                            	<%-- <span style="vertical-align: 3px">类型</span>
										<select id="type" name="type" class="span2">
											<option></option>
											<option value="0" <c:if test="${type == 0}">selected</c:if> >红包</option>
											<option value="1" <c:if test="${type == 1}">selected</c:if> >加息券</option>
										</select>
		                            	&nbsp; --%>
		                            	<span style="vertical-align: 3px">是否使用</span>
										<select id="used" name="used" class="span2">
											<option value="-1" <c:if test="${used == -1}">selected</c:if> >全部</option>
											<option value="0" <c:if test="${used == 0}">selected</c:if> >未使用</option>
											<option value="1" <c:if test="${used == 1}">selected</c:if>>已使用</option>
											<option value="2" <c:if test="${used == 2}">selected</c:if>>已转赠</option>
										</select>
										&nbsp;
										<a href="javascript:search();" ><button type="button" style="margin-top: -10px" class="btn">查询</button></a>
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
	                                           <!--  <th>券码名称</th> -->
	                                            <th>兑换号</th>
	                                            <th>红包金额  / 加息收益</th>
	                                            <th>是否使用</th>
	                                            <th>兑换时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(customerCoupons) > 0}">
                                            <c:forEach var="coupon" items="${customerCoupons}" varStatus="status">
                                            <tr id="couponId${coupon.id}">
                                                <td>${status.count}</td>
                                                <td>${coupon.user.cellphone}</td>
                                                 <%-- <td>${coupon.coupon.name}</td> --%>
                                                <td>${coupon.coupon.condition}</td>
                                                <td>
                                                	<c:if test="${coupon.coupon.category <= 3}"><fmt:formatNumber value="${coupon.amount}" pattern="#,##0" /></c:if>
                                                	<c:if test="${coupon.coupon.category > 3}"><fmt:formatNumber value="${coupon.amount}" pattern="#,##0.00" />%</c:if>
                                                </td>
                                                <td>
                                                	<c:if test="${coupon.used == 0}">未使用</c:if>
                                                	<c:if test="${coupon.used == 1}">已使用</c:if>
                                                	<c:if test="${coupon.used == 2}">已转赠</c:if>
                                                </td>
                                            	<td><fmt:formatDate value="${coupon.usedTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
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
                                            <tr>
                                       		    <td colspan="7"><div id="exchange-page"></div></td>
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
	    $('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="${pageContext.request.contextPath}/coupon/exchange/list">兑换券管理</a>&nbsp;/&nbsp;兑换券码记录</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/exchange/codes/${couponExchangeId}');
		            	$('#page').val(page);
		                $('#search').submit();
		            }  
			    };
				$('#exchange-page').bootstrapPaginator(options);
			}
			$('#status').find("option[value='${status}']").attr("selected",true);
			
			$('#beginTime').datetimepicker({
				format:'Y-m-d',
				//minDate:beforeDate.getFullYear()+'/'+(beforeDate.getMonth()+1)+'/'+beforeDate.getDate(),
				maxDate:new Date().toLocaleDateString(),
				lang:'ch',
				scrollInput:false,
				timepicker:false,
				onShow:function() {
					if ($('td').hasClass('xdsoft_other_month')) {
						$('td').removeClass('xdsoft_other_month');
					} 
				},
				onSelectDate:function() {
					var beginTime = $('#beginTime').val();
					var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
					var afterDate = new Date();
					afterDate.setTime(beginDate.getTime()+1000*60*60*24*6);
					$('#endTime').datetimepicker({
						format:'Y-m-d',
						minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
						//maxDate:afterDate.getFullYear()+'/'+(afterDate.getMonth()+1)+'/'+afterDate.getDate(),
						maxDate:new Date().toLocaleDateString(),
						lang:'ch',
						scrollInput:false,
						timepicker:false,
						onShow:function() {
							if ($('td').hasClass('xdsoft_other_month')) {
								$('td').removeClass('xdsoft_other_month');
							}  
						}
					});
				}
			});
			
			$('#endTime').datetimepicker({
				 format:'Y-m-d',
				 maxDate:new Date().toLocaleDateString(),
				 lang:'ch',
				 scrollInput:false,
				 timepicker:false,
				 onShow:function() {
					if ($('td').hasClass('xdsoft_other_month')) {
						$('td').removeClass('xdsoft_other_month');
					}  
				},
				onSelectDate:function() {
					var endTime = $('#endTime').val();
					var endDate = new Date(Date.parse(endTime.replace(/-/g,"/")));
					beforeDate.setTime(endDate.getTime()-1000*60*60*24*6);
					$('#beginTime').datetimepicker({
						format:'Y-m-d',
						//minDate:beforeDate.getFullYear()+'/'+(beforeDate.getMonth()+1)+'/'+beforeDate.getDate(),
						maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
						lang:'ch',
						scrollInput:false,
						timepicker:false,
						onShow:function() {
							if ($('td').hasClass('xdsoft_other_month')) {
								$('td').removeClass('xdsoft_other_month');
							}  
						}
					});
				}
			});
		});
		
		function search() {
			$('#page').val(1);
            $('#search').submit(); 
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>