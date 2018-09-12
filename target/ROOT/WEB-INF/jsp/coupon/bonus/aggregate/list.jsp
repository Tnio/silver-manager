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
                	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="row-fluid">
                    	<div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                            	<a id="481" href="javascript:detail()"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                           		<a id="482" href="javascript:edit()"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                           		<!-- <a id="483" href="javascript:setStatus(1)"><button class="btn btn-lg btn-primary" >启用<i class=""></i></button></a>
                           		<a id="484" href="javascript:setStatus(0)"><button class="btn btn-lg btn-primary" >禁用<i class=""></i></button></a>   -->
                            </div>
                            <!-- </form>  -->
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="coupon" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr align="center">
	                                            <th>序号</th>
	                                            <th>红包来源</th>
	                                            <!-- <th>状态</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(coupons) > 0}">
                                            <c:forEach var="coupon" items="${coupons}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="couponId${coupon.id}">
                                                <td class="hiddenid">${coupon.id}</td>
                                                <td class="hiddenid">${coupon.status}</td>
                                                <td class="hiddenid">${coupon.category}</td>
                                                <td>${status.count}</td>
                                                <td>邀请奖励</td>
                                                <%-- <td><c:if test="${coupon.status == 0}">禁用</c:if><c:if test="${coupon.status == 1}">启用</c:if></td> --%>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="7">暂时还没有累计红包列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>		
                    </div>
                </div>
                <div class="span10" id="content">
                    <div class="row-fluid">
                    	<div class="block">
                    	<form id="search" action="${pageContext.request.contextPath}/coupon/bonus/aggregate/list" method="post">
                    		<input type="hidden" id="size" name="size" value="${size}" />
                    		<input type="hidden" id="page" name="page" value="1" />
                            <div class="navbar navbar-inner block-header">
                            	<div style="margin:2px auto auto auto">
	                            	<span style="vertical-align: 3px">邀请累计红包记录</span>
	                            	&nbsp;
	                            	<span style="vertical-align: 3px">手机号</span>
									<input class="span2" id="cellphone" name="cellphone" value="${cellphone}" type="text" onkeyup="this.value=this.value.trim()" />&nbsp;
	                            	&nbsp;
									<select id="sort" name="sort" class="span2">
										<option value=""></option>
										<option value="totalMoney">按红包累计总金额排序</option>
										<option value="remainMoney">按红包剩余总金额排序</option>
										<option value="usedMoney">按红包使用总金额排序</option>
										<option value="inviter">按邀请人数排序</option>
										<option value="trade">按成功交易人数排序</option>
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
	                                            <th>红包累计总金额</th>
	                                            <th>红包剩余金额</th>
	                                            <th>已使用金额</th>
	                                            <th>邀请人数</th>
	                                            <th>成功交易人数</th>
	                                            <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(bonusAggregates) > 0}">
                                            <c:forEach var="aggregates" items="${bonusAggregates}" varStatus="status">
                                            <tr>
                                                <td class="hiddenid">${aggregates.userId}</td>
                                                <td>${status.count}</td>
                                                <td>${aggregates.cellphone}</td>
                                                <td><c:if test="${not empty aggregates.totalMoney}"><fmt:formatNumber value="${aggregates.totalMoney}" pattern="#,##0.00"/></c:if><c:if test="${empty aggregates.totalMoney}">0.00</c:if></td>
                                                <td><c:if test="${not empty (aggregates.totalMoney + aggregates.usedMoney)}"><fmt:formatNumber value="${(aggregates.totalMoney + aggregates.usedMoney)}" pattern="#,##0.00"/></c:if><c:if test="${empty (aggregates.totalMoney + aggregates.usedMoney)}">0.00</c:if></td>
                                                <td><c:if test="${not empty aggregates.usedMoney}"><fmt:formatNumber value="${aggregates.usedMoney}" pattern="#,##0.00"/></c:if><c:if test="${empty aggregates.usedMoney}">0.00</c:if></td>
                                                <td><c:if test="${not empty aggregates.inviter}"><fmt:formatNumber value="${aggregates.inviter}" pattern="#,##0"/></c:if><c:if test="${empty aggregates.inviter}">0</c:if></td>
                                                <td><c:if test="${not empty aggregates.trade}"><fmt:formatNumber value="${aggregates.trade}" pattern="#,##0"/></c:if><c:if test="${empty aggregates.trade}">0</c:if></td>
                                                <td><a href="${pageContext.request.contextPath}/coupon/bonus/aggregate/detail/customer/${aggregates.userId}" >查看明细</a></td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="9">暂时还没有累计红包列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                       		    <td colspan="9"><div id="aggregate-page"></div></td>
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
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
		$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;累计红包管理</li>');
		var rowId = 0;
		var initStatus = -1;
		var category = '';
		$(function() {
			$('td.hiddenid').hide();
			$('#sort').find("option[value='${sort}']").attr('selected',true);
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/aggregate/list');
		            	$('#page').val(page);
		                $('#search').submit();
		            }  
			    };
				$('#aggregate-page').bootstrapPaginator(options);
			}
			
			$('#481').hide();
			$('#482').hide();
			$('#483').hide();
			$('#484').hide();
		})
	
		function search(){
			$('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/aggregate/list');
            $('#search').submit(); 
		}
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#481').hide();
				$('#482').hide();
				$('#483').hide();
				$('#484').hide();
				rowId = 0;
			}else{
				$('#couponId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				initStatus = tr.getElementsByTagName('td')[1].innerHTML;
				category = tr.getElementsByTagName('td')[2].innerHTML;
				buttonShowOrHide();
			}
		
		}
		
		function buttonShowOrHide(){
			$('#481').show();
			$('#482').show();
			$('#483').hide();
			$('#484').hide();
			if(initStatus == 0){
				$('#483').show();
			} if (initStatus == 1) {
				$('#484').show();
			}
		}
		
		function detail(){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/coupon/bonus/aggregate/detail/'+rowId;
			}else{
				alert('请先选择一条记录！');
			}
		}
		
		function edit(){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/coupon/bonus/aggregate/edit/'+rowId;
			}else{
				alert('请先选择一条记录！');
			}
		}
		
		function setStatus(status){
			if(rowId > 0){
				if(initStatus > 1){
					if (confirm('要确认本次修改吗?')) {
						$.getJSON('${pageContext.request.contextPath}/coupon/bonus/status', {bonusId:rowId, status:status, initStatus: initStatus},function(result){
						   if(!result){
								alert('更新失败，红包状态已被更改!');
						   }else{
							   $('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/aggregate/list');
				                $('#search').submit();
						   }
						});
					}
				}else{
					$.getJSON('${pageContext.request.contextPath}/coupon/bonus/status', {bonusId:rowId, status:status, initStatus: initStatus},function(result){
						if(!result){
							alert('更新失败，红包状态已被更改!');
					   }else{
						   $('#search').attr('action','${pageContext.request.contextPath}/coupon/bonus/aggregate/list');
			                $('#search').submit();
					   }
					});
				}
			}else{
				alert('请先选择一条记录！');
			}	
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>