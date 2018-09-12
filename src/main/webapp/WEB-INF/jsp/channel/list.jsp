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
                           	<form id="search" action="${pageContext.request.contextPath}/thirdparty/channel/list/1" method="post" >
                           		<input type="hidden" id="size" name="size" value="${size}" />
                           		<div class="input-group" style="height:0px">
                               		<%-- <span style="vertical-align: 3px">渠道名称</span>
                                   	<input class="span2 marginTop" type="text" id="name" name="channelName" value="${channelName}" class="span2" /> --%>
                                   	<div class="span3">
                                   		<span class="span3" style="margin-top: 5px">
                                   			<span>渠道来源</span>
                                   		</span>
                                   		<span class="span9" style="margin-left: -1px">
                                   			<select id="name" name="channelName">
		                             			<option value="" >全部</option>
												<c:choose>
		                                        	<c:when test="${fn:length(channelsUse) > 0}">
		                                            	<c:forEach var="channel" items="${channelsUse}" varStatus="status">
		                                            		<option value="${channel.name}">${channel.name}</option>
		                                            	</c:forEach>
		                                            </c:when>
		                                        </c:choose>
											</select>
                                   		</span>
                                   	</div>
									<span style="vertical-align: 3px">渠道类型</span>
									<select id="category" style="width: 120px;" name="category">
								      	<option value="-1" >全部渠道</option>
								      	<option value="0" >一类渠道</option>
								      	<option value="1" >二类渠道</option>
								      	<option value="2" >三类渠道</option>
									</select>
									<%-- <span style="vertical-align: 3px" >开始时间</span> 
                                    <input type="text" id="beginTime" name="beginTime" style="width: 120px;" value="${beginTime}" class="span2 marginTop" onkeypress="return false"/>
								    <span style="vertical-align: 3px" >结束时间</span> 
								    <input type="text" id="endTime" name="endTime" style="width: 120px;" value="${endTime}" class="span2 marginTop" onkeypress="return false"/> --%>
                                    <input type="submit" class="btn btn-default" style="margin-top: -10px" value="查询"/>
                                    <input type="reset" value="重置" onclick="resetData()" style="margin-top: -10px" class="btn btn-default" />	
                                 </div>
                              </form>
                          </div>
                    	<div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a id="301" href="javascript:detail()" ><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                                 <a id="302" href="javascript:edit()"><button class="btn btn-lg btn-primary">编辑<i class=""></i></button></a>
                                 <!-- <a id="307" href="javascript:statistics()"><button class="btn btn-lg btn-primary">页面统计<i class=""></i></button></a> -->
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table cellpadding="0" cellspacing="0" border="0" class="table" id="orders">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>渠道名称</th>
	                                            <!-- <th>渠道ID</th> -->
	                                           <!--  <th>交易总金额</th> -->
	                                            <!-- <th>注册用户总数</th>
	                                            <th>投资客总数</th>
	                                            <th>总体转化率</th> -->
	                                           <!--  <th>新增注册用户</th>
	                                            <th>新增转化投资客</th>
	                                            <th>新增投资客</th>
	                                            <th>新增转化率</th>
	                                            <th>活跃投资客</th> -->
	                                            <th>渠道类型</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(channels) > 0}">
                                           <c:forEach var="channel" items="${channels}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="channelId${channel.id}">
                                                <td class="hidden">${channel.id}</td>
                                                <td>${status.count}</td>
                                                <td>${channel.name}</td>
                                                <%-- <td><c:if test="${not empty channel.totalTradeMoney}"><fmt:formatNumber value="${channel.totalTradeMoney}" pattern="#,##0"/></c:if><c:if test="${empty channel.totalTradeMoney}">0</c:if></td>  --%>
                                                <%-- <td>${channel.id}</td> --%>
                                                <%-- <td><c:if test="${not empty channel.allTradeMoney}"><fmt:formatNumber value="${channel.allTradeMoney}" pattern="#,##0"/></c:if><c:if test="${empty channel.allTradeMoney}">0</c:if></td>
                                                <td><c:if test="${not empty channel.allRegisterCount}"><fmt:formatNumber value="${channel.allRegisterCount}" pattern="#,##0"/></c:if><c:if test="${empty channel.allRegisterCount}">0</c:if></td>
                                                <td><c:if test="${not empty channel.allCustomerCount}"><fmt:formatNumber value="${channel.allCustomerCount}" pattern="#,##0"/></c:if><c:if test="${empty channel.allCustomerCount}">0</c:if></td>
                                                <td>
                                                	<c:choose>
                                                		<c:when test="${channel.allRegisterCount > 0 && channel.allCustomerCount > 0}">
                                                			<fmt:formatNumber value="${channel.allCustomerCount / channel.allRegisterCount * 100}" pattern="#,##0.00"/> %
                                                		</c:when>
                                                		<c:otherwise>
                                                			0.00%
                                                		</c:otherwise>
                                                	</c:choose>
                                                </td> --%>
                                               <%--  <td><c:if test="${not empty channel.newRegisterCount}"><fmt:formatNumber value="${channel.newRegisterCount}" pattern="#,##0"/></c:if><c:if test="${empty channel.newRegisterCount}">0</c:if></td>
                                                <td><c:if test="${not empty channel.newConvertRates}"><fmt:formatNumber value="${channel.newConvertRates}" pattern="#,##0"/></c:if><c:if test="${empty channel.newConvertRates}">0</c:if></td>
                                                <td><c:if test="${not empty channel.newCustomerCount}"><fmt:formatNumber value="${channel.newCustomerCount}" pattern="#,##0"/></c:if><c:if test="${empty channel.newCustomerCount}">0</c:if></td>
                                                <td>
                                                	<c:choose>
                                                		<c:when test="${channel.newRegisterCount > 0 && channel.newCustomerCount > 0}">
                                                			<fmt:formatNumber value="${channel.newCustomerCount / channel.newRegisterCount * 100}" pattern="#,##0.00"/> %
                                                		</c:when>
                                                		<c:otherwise>
                                                			0.00%
                                                		</c:otherwise>
                                                	</c:choose>
                                                </td>
                                                <td><c:if test="${not empty channel.activeCustomerCount}"><fmt:formatNumber value="${channel.activeCustomerCount}" pattern="#,##0"/></c:if><c:if test="${empty channel.activeCustomerCount}">0</c:if></td> --%>
                                            	<td>
                                            		<c:if test="${channel.category == 0}">一类渠道</c:if>
                                            		<c:if test="${channel.category == 1}">二类渠道</c:if>
                                            		<c:if test="${channel.category == 2}">三类渠道</c:if>
                                            	</td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="12">暂时还没有渠道列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                         <tfoot>
                                        	<tr>
                                        		<td colspan="12">
                                        		    <div id="channels-page"></div>
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
		var rowId = '';
		var name = '';
		var date = new Date();
		$(document).ready(function(){
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">渠道管理&nbsp;/&nbsp;渠道管理</li>');
			$('[rel="tooltip"]').tooltip();
			$('.thumbnailSize').css('height', '40px');
			$('#301').hide();
			$('#302').hide();
			$('#307').hide();
			$('#sort').find('option[value="${sortType}"]').attr('selected','selected');
			$('#category').find('option[value="${category}"]').attr('selected','selected');
			$('#name').find('option[value=${channelName}]').attr('selected',true);
			$('#name').comboSelect();
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/thirdparty/channel/list/'+page);
		                $('#search').submit();
		            }
			    };
				$('#channels-page').bootstrapPaginator(options);
			}
			
			
			/* $('#beginTime').datetimepicker({
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
					getBeginTime();
					
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
					
					getEndTime();
				}
			});
			getBeginTime();
			getEndTime(); */
		});
		
		/*function getBeginTime(){
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
		
		function getEndTime(){
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
		} */
		
		function resetData() {
			$('#name').val('');
			$('#sort').val('');
			$('#beginTime').val('');
			$('#endTime').val('');
			$('#category').val(-1);
			$('#search').attr('action','${pageContext.request.contextPath}/thirdparty/channel/list/1');
            $('#search').submit();
		}
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				rowId = '';
			} else {
				$('#channelId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
			}
			name = tr.getElementsByTagName('td')[2].innerHTML;
			buttonShowOrHide(rowId);
			
		}
		
		function buttonShowOrHide(rowId){
			if(rowId >= 0 && rowId != ''){
				$('#301').show();
				$('#302').show();
				$('#307').show();
			}else{
				$('#301').hide();
				$('#302').hide();
				$('#307').hide();
			}
		}
		
		function add(){
			window.location.href='${pageContext.request.contextPath}/thirdparty/channel/add/${page}';
		}   
	
		function edit() {
			if (rowId >= 0) {
				window.location.href='${pageContext.request.contextPath}/thirdparty/channel/edit/'+rowId+'/'+'${page}';
			} else {
				alert('请先选择一种渠道!');
			}
		}
		
		function detail() {
			if (rowId >= 0) {
				window.location.href='${pageContext.request.contextPath}/thirdparty/channel/detail/'+rowId+'/'+'${page}';
			} else {
				alert('请先选择一种渠道!');
			}
		}
		
	    function statistics(){
	    	if (rowId >= 0) {
				window.location.href='${pageContext.request.contextPath}/thirdparty/channel/statistics/'+rowId;
			} else {
				alert('请先选择一种渠道!');
			}
	    }
	    
		
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>