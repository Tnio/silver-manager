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
                           	<form id="search" action="${pageContext.request.contextPath}/coupon/invite/activity/detail/list/${activityId}" method="post" >
                           		<input type="hidden" id="size" name="size" value="${size}" />
                           		<input type="hidden" id="page" name="page" value="1" />
                           		<div class="input-group" style="height:0px">
                               		<span style="vertical-align: 3px">邀请者手机号</span>
                                   	<input class="horizontal marginTop" type="text" style="width:90px" id="cellphone" name="cellphone" value="${cellphone}" class="span3" />
                                 	<span style="vertical-align: 3px">被邀请者手机号</span>
                                 	<input class="horizontal marginTop" type="text" style="width:90px" id="inviteCellphone" name="inviteCellphone" value="${inviteCellphone}" class="span3" />
                                 	<span style="vertical-align: 3px">理财期限</span>
                                 	<input class="horizontal marginTop" type="text" style="width:90px" id="period" name="period" value="${period}" class="span3" />
                                    <span style="vertical-align: 3px">
										<select id="type" name="type" class="horizontalType marginTop" style="width:150px">
									      	<option value="reg_time" <c:if test="${type == 'reg_time'}"> selected="selected" </c:if>>注册时间</option>
									      	<option value="grant_time" <c:if test="${type == 'grant_time'}"> selected="selected" </c:if>>红包发放时间</option>
										</select>
									</span>
	                                <span>开始时间:</span>
									<input id="beginTime" class="datepicker marginTop" style="background:white;width:90px" onkeypress="return false" name="beginTime" type="text" value="${beginTime}" />
                                   	<span>至结束时间:</span>
									<input id="endTime" class="datepicker marginTop" style="background:white;width:90px" onkeypress="return false" name="endTime" type="text" value="${endTime}" />
                                   	<input type="submit" class="btn btn-default" style="margin-top: -10px" value="查询"/>
                                   	<input type="reset" class="btn btn-default" style="margin-top: -10px" value="重置" onclick="resetData()" />
                                 </div>
                            </form>
                        </div>
                    	<div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                           
                            </div>
                            <!-- <form id="search" action=""></form> -->
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table class="table">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>邀请人</th>
	                                            <th>被邀请人</th>
	                                            <th>注册时间</th>
	                                            <th>红包发放时间</th>
	                                            <th>首投本金</th>
	                                            <th>理财期限</th>
	                                            <th>邀请红包金额</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(logs) > 0}">
                                            <c:forEach var="log" items="${logs}" varStatus="status">
                                            <tr>
                                                <td class="hidden">${log.id}</td>
                                                <td>${status.count}</td>
                                                <td>${log.user.cellphone}</td>
                                                <td><c:if test="${log.customer != ''}">${log.customer.cellphone}</c:if></td>
                                                <td><fmt:formatDate value="${log.regTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td><fmt:formatDate value="${log.grantTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td>${log.buyAmount}</td>
                                                <td>${log.financePeriod}</td>
                                                <td>${log.couponAmount}</td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="8">暂时还没有邀请活动明细列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                         <tfoot>
                                         	<tr>
	                                        	<td colspan="4">邀请人数:${total}</td>
	                                    	</tr>
                                        	<tr>
                                        		<td colspan="4">
                                        		    <div id="log-page"></div>
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
		$('#beginTime').datetimepicker({
			format:'Y-m-d',
		  	lang:'ch',
          	timepicker:false,
          	onSelectDate:function() {
        	  	var fromDate = $('#beginTime').val();
				var startDate = new Date(Date.parse(fromDate.replace(/-/g,"/")));
				$('#endTime').datetimepicker({
					format:'Y-m-d',
					minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
					lang:'ch',
					timepicker:false
				});
		  	}
	  	});
		  
		$('#endTime').datetimepicker({
			format:'Y-m-d',
  			lang:'ch',
        	timepicker:false,
        	onSelectDate:function() {
      	  		getEndTime();
  			}
 		});
 		function getEndTime(){
   			var toDate = $('#endTime').val();
			var endDate = new Date(Date.parse(toDate.replace(/-/g,"/")));
			$('#beginTime').datetimepicker({
				format:'Y-m-d',
				maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
				lang:'ch',
				timepicker:false
			});
  		}
		$(document).ready(function(){
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">邀请赠送管理</a>&nbsp;/&nbsp;中奖明细</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/invite/activity/detail/list/${activityId}');
		                $('#search').submit();										   
		            }
			    };
				$('#log-page').bootstrapPaginator(options);
			}
		});
		
		function quit() {
		   window.location.href='${pageContext.request.contextPath}/coupon/invite/activity/list/1';
	    }
		
		function resetData() {
			$('#cellphone').val('');
			$('#inviteCellphone').val('');
			$('#beginTime').val('');
			$('#endTime').val('');
			$('#period').val(0);
			$('#type').val('');
			$('#search').attr('action','${pageContext.request.contextPath}/coupon/invite/activity/detail/list/${activityId}');
            $('#search').submit();
		}
	</script>
	<c:import url="/authority" />
</html>