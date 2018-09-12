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
                           	<form id="search" action="${pageContext.request.contextPath}/statistics/product/trade" method="post" >
                           		<div class="input-group" style="height:0px">
                           			<span style="vertical-align: 3px">统计分类</span>
                                 	<select id="type" name="type" onchange="search()" style="vertical-align: 3px">
										<option value="1" <c:if test="${type == 1 }">selected="selected"</c:if> >按已回款订单统计</option>
										<option value="2" <c:if test="${type == 2 }">selected="selected"</c:if>>按未回款订单统计</option>
									</select>&nbsp;
									<span style="vertical-align: 3px">开始时间</span> 
                                    <input type="text" id="beginDate" name="beginTime" value="${beginTime}" class="span2 marginTop" onkeypress="return false" style="vertical-align: 3px"/>
								    <span style="vertical-align: 3px">结束时间</span> 
								    <input type="text" id="endDate" name="endTime"  value="${endTime}" class="span2 marginTop" onkeypress="return false" style="vertical-align: 3px"/>
                                    <input type="submit" class="btn btn-default" style="vertical-align: 3px" value="查询"/>
                                 </div>
                              </form>
                         </div>
                       	<div class="block">
                       		<div class="navbar navbar-inner block-header" style="min-height:0px">
                       		</div>
                            <div class="block-content collapse in">
                                <div class="span12">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th>理财期限</th>
                                               <th>进账金额</th>
                                               <th>出账金额</th>
                                               <th>进出账比(金额)</th>
                                               <th>进账笔数</th>
                                               <th>出账笔数</th>
                                               <th>进出账比(笔数)</th>
                                               <th>进账人数</th>
                                               <th>出账人数</th>
                                               <th>进出账比(人数)</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       	<c:choose>
                                       		<c:when test="${fn:length(productTradeEntitys) > 0}">
                                       			<c:forEach var ="tradeEntity" items="${productTradeEntitys}" varStatus="status">
                                       				<tr>
                                       				   <c:if test="${status.count == 1 }">
                                       						<td><c:out value=" < 30天"></c:out></td>
                                       				   </c:if>
                                       				   <c:if test="${status.count == 2 }">
                                       						<td><c:out value=" >= 30天  < 70 天"></c:out></td>
                                       				   </c:if>
                                       				   <c:if test="${status.count == 3 }">
                                       						<td><c:out value=" >= 70天  < 180 天"></c:out></td>
                                       				   </c:if>
                                       				   <c:if test="${status.count == 4 }">
                                       						<td><c:out value=" >= 180 天"></c:out></td>
                                       				   </c:if>
		                                               <td><fmt:formatNumber value="${tradeEntity.inMoney}" pattern="#,##0" /></td>
		                                               <td><fmt:formatNumber value="${tradeEntity.outMoney}" pattern="#,##0.00" /></td>
		                                               <td>
			                                               <c:if test="${tradeEntity.outMoney <= 0}">
			                                               		--
			                                               </c:if>
			                                               <c:if test="${tradeEntity.outMoney > 0}">
			                                               		 <fmt:formatNumber value="${tradeEntity.inMoney / tradeEntity.outMoney * 100}" pattern="#,##0.00" /> %
			                                               </c:if>
		                                               </td>
		                                               <td><fmt:formatNumber value="${tradeEntity.inTotal}" pattern="#,##0" /></td>
		                                               <td><fmt:formatNumber value="${tradeEntity.outTotal}" pattern="#,##0" /></td>
		                                               <td>
			                                               <c:if test="${tradeEntity.outTotal <= 0}">
			                                               		--
			                                               </c:if>
			                                               <c:if test="${tradeEntity.outTotal > 0}">
			                                               		 <fmt:formatNumber value="${tradeEntity.inTotal / tradeEntity.outTotal * 100}" pattern="#,##0.00" /> %
			                                               </c:if>
		                                               </td>
		                                               <td><fmt:formatNumber value="${tradeEntity.inPeople}" pattern="#,##0" /></td>
		                                               <td><fmt:formatNumber value="${tradeEntity.outPeople}" pattern="#,##0" /></td>
		                                               <td>
			                                               <c:if test="${tradeEntity.outPeople <= 0}">
			                                               		--
			                                               </c:if>
			                                               <c:if test="${tradeEntity.outPeople > 0}">
			                                               		 <fmt:formatNumber value="${tradeEntity.inPeople / tradeEntity.outPeople * 100}" pattern="#,##0.00" /> %
			                                               </c:if>
		                                               </td>
                                       				</tr>
                                       			</c:forEach>
                                       		</c:when>
                                       		<c:otherwise>
                                       			<tr>
                                       				<td colspan="10">暂时没有产品统计信息</td>
                                       			</tr>
                                       		</c:otherwise>
                                       	</c:choose>
                                       </tbody>
                                       <tfoot>
                                       	 
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
			$('.breadcrumb').html('<li class="active">统计管理&nbsp;/&nbsp;产品统计</li>');
			if('${type}' == 2){
				$('#beginDate').datetimepicker({
					format:'Y-m-d',
					lang:'ch',
					timepicker:false,
					scrollInput:false,
					minDate:new Date(),
					onShow:function() {
						if ($('td').hasClass('xdsoft_other_month')) {
							$('td').removeClass('xdsoft_other_month');
						} 
					},
					onSelectDate:function() {
						getBeginDate2();
					}
				});
				
				$('#endDate').datetimepicker({
					 format:'Y-m-d',
					 lang:'ch',
					 timepicker:false,
					 scrollInput:false,
					 /* minDate:new Date(), */
					 onShow:function() {
						if ($('td').hasClass('xdsoft_other_month')) {
							$('td').removeClass('xdsoft_other_month');
						} 
					},
					onSelectDate:function() {
						getEndDate2();
					}
				});
				getBeginDate2();
				getEndDate2();
			}else{
				$('#beginDate').datetimepicker({
					format:'Y-m-d',
					lang:'ch',
					timepicker:false,
					scrollInput:false,
					onShow:function() {
						if ($('td').hasClass('xdsoft_other_month')) {
							$('td').removeClass('xdsoft_other_month');
						} 
					},
					onSelectDate:function() {
						getBeginDate1();
					}
				});
				
				$('#endDate').datetimepicker({
					 format:'Y-m-d',
					 lang:'ch',
					 timepicker:false,
					 scrollInput:false,
					 onShow:function() {
						if ($('td').hasClass('xdsoft_other_month')) {
							$('td').removeClass('xdsoft_other_month');
						} 
					},
					onSelectDate:function() {
						getEndDate1();
					}
				});
				getBeginDate1();
				getEndDate1();
			}
	    });
	    
	    function search(){
	    	$('#beginDate').val('');
	    	$('#endDate').val('');
	    	$('#search').submit();
	    }
	    
	    function getBeginDate1(){
			  var fromDate = $('#beginDate').val();
				var startDate = new Date(Date.parse(fromDate.replace(/-/g,"/")));
				$('#endDate').datetimepicker({
					format:'Y-m-d',
					minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
					maxDate:new Date().toLocaleDateString(),
					lang:'ch',
					timepicker:false
				});
		  }
		  
		  function getEndDate1(){
			  var toDate = $('#endDate').val();
				var endDate = new Date(Date.parse(toDate.replace(/-/g,"/")));
				$('#beginDate').datetimepicker({
					format:'Y-m-d',
					maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
					lang:'ch',
					timepicker:false
				});
		  }
		  
		  function getBeginDate2(){
			  var fromDate = $('#beginDate').val();
				var startDate = new Date(Date.parse(fromDate.replace(/-/g,"/")));
				$('#endDate').datetimepicker({
					format:'Y-m-d',
					minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
					//maxDate:new Date().toLocaleDateString(),
					lang:'ch',
					timepicker:false
				});
		  }
		  
		  function getEndDate2(){
			  var toDate = $('#endDate').val();
				var endDate = new Date(Date.parse(toDate.replace(/-/g,"/")));
				$('#beginDate').datetimepicker({
					format:'Y-m-d',
					//maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
					lang:'ch',
					timepicker:false
				});
		  }
	    
	</script>
</html>