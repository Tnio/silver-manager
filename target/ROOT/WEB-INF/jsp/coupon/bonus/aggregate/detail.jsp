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
                        	<div id="authorityButton" class="navbar navbar-inner block-header">
                        	<form id="search" action="${pageContext.request.contextPath}/coupon/bonus/aggregate/detail/customer/${customerId}" method="post">
	                    		<input type="hidden" id="bonusPage" name="bonusPage" value="${bonusPage}" />
	                    		<input type="hidden" id="bonusSize" name="bonusSize" value="${bonusSize}" />
	                    		<input type="hidden" id="inviterPage" name="inviterPage" value="${inviterPage}" />
	                    		<input type="hidden" id="inviterSize" name="inviterSize" value="${inviterSize}" />
	                    	    <input type="hidden" id="category" name="category" value="${category}">
	                        </form>
                       		</div>
                            <div class="block-content collapse in">
                                <div class="span12">
                                    <div class="table-toolbar">
                                    	<div class="tabbable">
											<ul class="nav nav-tabs">
												<li class="active"  ><a id="bonus" style="border:1px solid #D3D3D3" href="#tab1" data-toggle="tab" onclick='chooseTable("bonus")'><span>红 包 明 细</span></a></li>
												<li ><a  id="inviter" style="border:1px solid #D3D3D3" href="#tab2" data-toggle="tab" onclick='chooseTable("inviter")'><span>邀 请 明 细</span></a></li>
											</ul>
											<div class="tab-content">
												<div class="tab-pane active" id="tab1">
													<table id="orders" cellpadding="0" cellspacing="0" border="0" class="table">
				                                        <thead>
				                                            <tr>
				                                               <th>序号</th>
				                                               <th>时间</th>
				                                               <th>红包获得/消耗渠道</th>
				                                               <th>红包变化</th> 
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        <c:choose>
				                                          <c:when test="${fn:length(bonusRecords) > 0}">
				                                            <c:forEach var="bonus" items="${bonusRecords}" varStatus="status">
				                                            	<tr>
						                                            <td>${status.count}</td>
						                                            <td><fmt:formatDate value="${bonus.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						                                            <td><c:if test="${bonus.amount >= 0 }">${bonus.cellphone} 投资</c:if><c:if test="${bonus.amount < 0 }"> 购买${bonus.productName}</c:if></td>
						                                            <td><fmt:formatNumber value="${bonus.amount}" pattern="#,##0.0#" /></td>
					                                            </tr>
				                                            </c:forEach>
				                                          </c:when>
				                                          <c:otherwise>
				                                        	<tr>
				                                                <td colspan="5">暂时没有红包明细列表</td>
				                                            </tr>  
				                                          </c:otherwise>
				                                        </c:choose>
				                                        </tbody>
				                                        <tfoot>
				                                            <tr>
				                                       		    <td colspan="5"><div id="bonus-page"></div></td>
				                                          	</tr>
				                                        </tfoot>
				                                    </table>
												</div>
												<div class="tab-pane" id="tab2">
													<table id="orders" class="table">
				                                        <thead>
				                                            <tr>
				                                               <th>序号</th>
				                                               <th>时间</th>
				                                               <th>好友</th>
				                                               <th>是否投资</th>
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        <c:choose>
				                                          <c:when test="${fn:length(inviterRecords) > 0}">
				                                            <c:forEach var="inviter" items="${inviterRecords}" varStatus="status">
				                                               <tr>
					                                               <td>${status.count}</td>
					                                               <td><fmt:formatDate value="${inviter.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					                                               <td>${inviter.cellphone}</td>
					                                               <td><c:if test="${empty inviter.firstTradeTime }">未投资</c:if><c:if test="${not empty inviter.firstTradeTime }">已投资</c:if></td>
					                                           </tr>
				                                            </c:forEach>
				                                          </c:when>
				                                          <c:otherwise>
				                                        	<tr>
				                                                <td colspan="5">暂时没有邀请明细列表</td>
				                                            </tr>  
				                                          </c:otherwise>
				                                        </c:choose>
				                                        </tbody>
				                                        <tfoot>
				                                            <tr>
				                                       		    <td colspan="5"><div id="inviter-page"></div></td>
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
	   	
		$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;<a href="javascript:quit();">累计红包管理</a>&nbsp;/&nbsp;累计红包明细</li>');
		function quit(){
			window.location.href='${pageContext.request.contextPath}/coupon/bonus/aggregate/list';
		}
	    
		$(document).ready(function(){
			var bonusTotal = '${bonusPages}';
			if(bonusTotal > 0) {
				var options = {
			        currentPage: '${bonusPage}',
			        totalPages: '${bonusPages}',
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/aggregate/detail/customer/${customerId}');
		            	$('#bonusPage').val(page);
		                $('#search').submit();
		            }  
			    };
				$('#bonus-page').bootstrapPaginator(options);
			}
			
			var inviterTotal = '${inviterPages}';
			if(inviterTotal > 0) {
				var options = {
			        currentPage: '${inviterPage}',
			        totalPages: '${inviterPages}',
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/aggregate/detail/customer/${customerId}');
		            	$('#inviterPage').val(page);
		                $('#search').submit();
		            }  
			    };
				$('#inviter-page').bootstrapPaginator(options);
			}
			
			if('${category}' == 'bonus'){
				$('.nav-tabs a[href="#tab1"]').tab('show');
			}else if('${category}' == 'inviter'){
				$('.nav-tabs a[href="#tab2"]').tab('show');
			}else{
				$('#category').val('bonus');
				$('.nav-tabs a[href="#tab1"]').tab('show');
			}
			chooseTable($('#category').val());
			$('.right').css('background-color', 'green');
			$('.wrong').css('background-color', 'yellow');
			$('.lost').css('background-color', 'red');
			if('${orderCategory}' == 1){
				$('.checkIn').hide();
				$('.checkOut').show();
			}else{
				$('.checkOut').hide();
				$('.checkIn').show();
			}
			
			//changeBackColor(1);
		});
		
		function chooseTable(tab){
			if(tab == 'inviter'){
				$('#inviter').css('fontWeight', 'bold');
				$('#inviter').css('width', '80px');
				$('#inviter').css('height', '19px');
				$('#inviter').css('background-color', '#08C');
				$('#inviter').css('color', 'white');
				
				$('#bonus').css('background-color', 'white');
				$('#bonus').css('fontWeight', 'normal');
				$('#bonus').css('color', '#08C');
			}else{
				$('#bonus').css('fontWeight', 'bold');
				$('#bonus').css('width', '80px');
				$('#bonus').css('height', '19px');
				$('#bonus').css('background-color', '#08C');
				$('#bonus').css('color', 'white');
				
				$('#inviter').css('background-color', 'white');
				$('#inviter').css('fontWeight', 'normal');
				$('#inviter').css('color', '#08C');
			}
			
			$('#category').val(tab);
		}
	</script>
	<c:import url="/authority"></c:import>
</html>