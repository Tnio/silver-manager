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
                        	<form id="search" name="search" action="${pageContext.request.contextPath}/coupon/card/used/record" method="post" enctype="multipart/form-data">
	                    		<input type="hidden" id="page" name="page"/>
	                    		<input type="hidden" id="size" name="size" value="${size}" />
	                    		<input type="hidden" id="used" name="used" value="${used}" />
	                    		<div class="navbar navbar-inner block-header">
	                    			<div style="margin:2px auto auto auto">
		                            	<span>卡号</span>
	                         			<input type="text" id="cardNO" name="cardNO" style="background:white;width:120px;" value="${cardNO}" class="horizontal marginTop"/>
										&nbsp;
										<span>手机号</span>
	                         			<input type="text" id="cardNO" name="cellphone" style="background:white;width:120px;" value="${cellphone}" class="horizontal marginTop"/>
										&nbsp;
                                       	<span>开始时间</span> 
                                       	<input type="text" id="beginTime" name="beginTime" style="background:white;width:120px;" value="${beginTime}" class="horizontal marginTop" onkeypress="return false"/>
								    	<span>&nbsp;结束时间</span> 
								    	<input type="text" id="endTime" name="endTime" style="background:white;width:120px;" value="${endTime}" class="horizontal marginTop" onkeypress="return false"/>
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
	                                            <th>购买订单号</th>
	                                            <th>名称</th>
	                                            <th>卡号</th>
	                                            <th>密码</th>
	                                            <th>卡券金额</th>
	                                            <th>发放时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(couponCards) > 0}">
                                            <c:forEach var="couponCard" items="${couponCards}" varStatus="status">
                                            <tr id="couponId${couponCard.id}">
                                                <td>${status.count}</td>
                                                <td>${couponCard.cellphone}</td>
                                                <td>${couponCard.orderNO}</td>
                                                <td>${couponCard.name}</td>
                                                <td>${couponCard.cardNO}</td>
                                                <td><c:out value="${fn:substring(couponCard.password, 0, 4)}" />****<c:out value="${fn:substring(couponCard.password, fn:length(couponCard.password) - 4,fn:length(couponCard.password))}" /></td>
                                                <td><fmt:formatNumber value="${couponCard.amount}" pattern="#,##0" /></td>
                                                <td><fmt:formatDate value="${couponCard.createTime}" type="both" pattern="yyyy-MM-dd HH:mm" /></td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="9">暂时还没有第三方卡券发放明细列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                       		    <td colspan="9"><div id="couponCard-page"></div></td>
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
                <div class="modal hide fade" id="couponDialog" role="dialog" >
				  	<div class="modal-dialog modal-lg">
				    	<div class="modal-content">
				      		<div class="modal-header">
				        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				        			<span aria-hidden="true">&times;</span>
				        		</button>
				        		<h4 class="modal-title" id="myModalLabel"></h4>
				      		</div>
				      		<div class="modal-body">
		                        <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
				                   <tbody id="couponBody">
		                     	   </tbody>
		                     	   <tfoot>
		                      	        <tr>
		                      				<td colspan="2">
		                      					<div id="tfoot" align="right"></div>
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
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
	    var beforeDate = "";
	    var rowId = 0;
	    var id = 0;
	    var status = 0;
	    $('.breadcrumb').html('<li class="active">券码管理&nbsp;&nbsp;/&nbsp;第三方卡券发放明细</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/card/used/record');
		            	$('#page').val(page);
		                $('#search').submit();
		            }  
			    };
				$('#couponCard-page').bootstrapPaginator(options);
			}
		});
		
		$('#beginTime').datetimepicker({
			format:'Y-m-d',
			maxDate:new Date().toLocaleDateString(),
			lang:'ch',
			timepicker:false,
			scrollInput:false,
			onShow:function() {
				if ($('td').hasClass('xdsoft_other_month')) {
					$('td').removeClass('xdsoft_other_month');
				} 
			},
			onSelectDate:function() {
				var beginTime = $('#beginTime').val();
				var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
				if(((date.getTime() -beginDate)/(1000*60*60*24) >= 31)){
					$('#endTime').datetimepicker({
						format:'Y-m-d',
						minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
						//maxDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+2)+'/'+beginDate.getDate(),
						lang:'ch',
						scrollInput:false,
						timepicker:false,
						onShow:function() {
							if ($('td').hasClass('xdsoft_other_month')) {
								$('td').removeClass('xdsoft_other_month');
							} 
						}
					});
				}else{
					$('#endTime').datetimepicker({
						format:'Y-m-d',
						minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
						lang:'ch',
						timepicker:false,
						scrollInput:false,
						onShow:function() {
							if ($('td').hasClass('xdsoft_other_month')) {
								$('td').removeClass('xdsoft_other_month');
							} 
						}
					});
				}
				
			}
		});
		
		$('#endTime').datetimepicker({
			 format:'Y-m-d',
			 maxDate:new Date().toLocaleDateString(),
			 lang:'ch',
			 timepicker:false,
			 scrollInput:false,
			 onShow:function() {
				if ($('td').hasClass('xdsoft_other_month')) {
					$('td').removeClass('xdsoft_other_month');
				} 
			},
			onSelectDate:function() {
				var endTime = $('#endTime').val();
				var endDate = new Date(Date.parse(endTime.replace(/-/g,"/")));
				$('#beginTime').datetimepicker({
					format:'Y-m-d',
					//minDate:endDate.getFullYear()+'/'+(endDate.getMonth())+'/'+endDate.getDate(),
					maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
					lang:'ch',
					timepicker:false,
					scrollInput:false,
					onShow:function() {
						if ($('td').hasClass('xdsoft_other_month')) {
							$('td').removeClass('xdsoft_other_month');
						} 
					}
				});
			}
		});
	</script>
	<c:import url="/authority"></c:import>
</html>