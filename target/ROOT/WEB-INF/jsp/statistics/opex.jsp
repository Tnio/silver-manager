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
                     	<form id="search" onsubmit="return validate();" action="${pageContext.request.contextPath}/statistics/opex/list/1" method="post">
                    		<input type="hidden" id="size" name="size" value="${size}" />
                	  		<div class="input-group pull-left">
								<span>起始日期</span>
                       			<input type="text" id="beginDate" name="beginDate" style="background:white;" value="${beginDate}" class="horizontal marginTop" onkeypress="return false"/>
                           		<span>结束日期</span>
                           		<input type="text" id="endDate" name="endDate" style="background:white;" value="${endDate}" class="horizontal marginTop" onkeypress="return false"/>
                        		<input type="submit" value="查询" class="btn btn-default" />
                        		<input type="button" onclick="resetData()" value="重置" class="btn btn-default" />
                     		</div>
                 		</form>
                    </div>
                    <div class="row-fluid">
                       	<div class="block">
                       		<div class="navbar navbar-inner block-header">
                       		</div>
	                        <!-- block -->
                            <div class="block-content collapse in">
                                <div class="span12">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th>序号</th>
                                               <th>日期</th>
                                               <th>红包费用(元)</th>
                                               <th>加息费用（元）</th>
                                               <th>加息券费用(元)</th>
                                               <th>支付手续费（元）</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       	<c:choose>
                                       		<c:when test="${fn:length(opexs) > 0}">
                                       			<c:forEach var ="opex" items="${opexs}" varStatus="status">
                                       				<tr>
														<td>${status.count}</td>
                                       					<td>${opex.consumeTime}</td>
                                       					<td><fmt:formatNumber value="${opex.couponAmount}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${opex.interestAmount}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${opex.couponInterest}" pattern="#,##0.00" /></td>
                                       					<td><fmt:formatNumber value="${opex.feeAmount}" pattern="#,##0.00" /></td>
                                       				</tr>
                                       			</c:forEach>
                                       		</c:when>
                                       		<c:otherwise>
                                       			<tr>
                                       				<td colspan="7">暂时没有运营费用信息</td>
                                       			</tr>
                                       		</c:otherwise>
                                       	</c:choose>
                                       </tbody>
                                       <tfoot>
                                       	  <tr>
                                        	  <td colspan="7">红包费用:<fmt:formatNumber value="${coupons}" pattern="#,##0.00" />元
                                        	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加息费用:<fmt:formatNumber value="${interests}" pattern="#,##0.00" />元
                                        	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加息券费用:<fmt:formatNumber value="${couponInterests}" pattern="#,##0.00" />元
                                        	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;支付手续费:<fmt:formatNumber value="${fees}" pattern="#,##0.00" />元</td>
	                                      </tr>
	                                      <tr>
                                        	  <td colspan="7">
                                        		  <div id="opex-page"></div>
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
		$('.breadcrumb').html('<li class="active">统计管理&nbsp;/&nbsp;运营费用</li>');
		$('.marginTop').css('margin', '2px auto auto auto');
		
		$(document).ready(function(){
			/* var totalPages = '${pages}';
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/statistics/opex/list/'+page);
		                $('#search').submit();
		            }  
				};
				$('#opex-page').bootstrapPaginator(options);
	   		} */
			
			$('#beginDate').datetimepicker({
			      format:'Y-m-d',
				  lang:'ch',
		          timepicker:false,
		          maxDate:subDate(new Date(), 1),
		          onSelectDate:function() {
		        	  getBeginTime();
				  }
			  });
			  
			  $('#endDate').datetimepicker({
			      format:'Y-m-d',
				  lang:'ch',
		          timepicker:false,
		          maxDate:subDate(new Date(), 1),
		          onSelectDate:function() {
		        	  getEndTime();
				  }
			  });
			  
			  getBeginTime();
			  getEndTime();
	    });
		
		function addDaysToDate(myDate,days) {
			return new Date(myDate.getTime() + days*24*60*60*1000);
		}
		  
		function getBeginTime(){
			var fromDate = $('#beginDate').val();
			if (fromDate) {
				var startDate = new Date(Date.parse(fromDate.replace(/-/g,"/")));
				var endDate = addDaysToDate(startDate, 30);
				$('#endDate').datetimepicker({
					format:'Y-m-d',
					minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
					//maxDate:new Date().toLocaleDateString(),
					maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
					lang:'ch',
					timepicker:false
				});
			}
		}
		
		function getEndTime(){
			var toDate = $('#endDate').val();
			if (toDate) {
				var endDate = new Date(Date.parse(toDate.replace(/-/g,"/")));
				var startDate = addDaysToDate(endDate, -30);
				$('#beginDate').datetimepicker({
					format:'Y-m-d',
					minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
					maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
					lang:'ch',
					timepicker:false
				});
			}
		}
		
		  function validate() {
			  if ($('#beginDate').val() || $('#endDate').val()) {
				  if (!$('#beginDate').val()) {
			          alert('起始日期不能为空！');
			          return false;
				  }
				  if (!$('#endDate').val()) {
			          alert('结束日期不能为空！');
			          return false;
				  }
			  }
			  return true;
		  }
		  
		  function subDate(date, num){
			   date = date.getTime() - num * 24 * 60 * 60 * 1000;
			   date = new Date(date);
			   var month = date.getMonth() + 1;
			   if(month.toString().length == 1){
				   month='0'+month;
			   }
			   var day = date.getDate();
			   if(day.toString().length == 1){
				   day = '0' + day;
			   }
			   return date.getFullYear() + '/' + month + '/' + day;
		   }
		  
		  function resetData() {
			  $('#beginDate').val('');
			  $('#endDate').val('');
			  $('#search').attr('action','${pageContext.request.contextPath}/statistics/opex/list/1');
	          $('#search').submit(); 
		  }
	</script>
</html>