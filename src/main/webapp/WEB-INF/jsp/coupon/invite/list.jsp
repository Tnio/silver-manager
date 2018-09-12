<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
	<body>
		<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
        <div class="container-fluid">
            <div class="row-fluid">
            	<jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
                <div class="span10" id="content">
                    <!-- content begin -->
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                        	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            	<div id="authorityButton" class="navbar navbar-inner block-header">
                          			<a href="javascript:add();" id="2026"><button type="button" class="btn btn-success" >新增 </button></a>
                          			<a href="javascript:edit();" id="2027"><button type="button" class="btn btn-primary">编辑 </button></a>
                          			<a href="javascript:detail();" id="2028"><button type="button" class="btn btn-primary">查看 </button></a>
                          			<a href="javascript:audit();" id="2029"><button type="button" class="btn btn-primary">审核 </button></a>
                          			<a href="javascript:activityDetail();" id="2030"><button type="button" class="btn btn-primary">查看明细 </button></a>
		                        </div>
		                        <div class="block-content collapse in">
		                            <div class="span12">
			                          	<form id="search" action="${pageContext.request.contextPath}/coupon/invite/activity/list/1" method="post">
			                            	<table id="activitys" cellpadding="0" cellspacing="0" border="0" class="table">
				                                <thead>
				                                    <tr>
				                                        <th>序号</th>
				                                        <th>活动名称</th>
				                                        <th>活动开始时间</th>
				                                        <th>活动结束时间</th>
				                                        <th>当前状态</th>
				                                        <th>审核状态</th>
				                                    </tr>
				                                </thead>
				                                <tbody>
				                                	<c:choose>
				                                   		<c:when test="${fn:length(activitys) > 0}">
				                                   			<c:forEach var ="activity" items="${activitys}" varStatus="status">
																<tr onclick="getRow(this, '#BFBFBF')" id="activityId${activity.id}">
		                                       						<td class="hidden" >${activity.id}</td>
		                                       						<td class="hidden" >${activity.auditStatus}</td>
		                                       						<td class="shortcss" >${status.count}</td>
				                                   					<td class="longcss" >${activity.name}</td>
				                                   					<td class="numbercss" >${activity.beginDate}</td>
				                                   					<td class="numbercss" >${activity.endDate}</td>
				                                   					<td class="numbercss" >
																		<c:choose>
						                                                	<c:when test="${activity.auditStatus == 1}">
						                                                		<c:choose>
						                                               		  	   <c:when test="${activity.beginDate > systemTime}">
																			   			<span style="color:#3498DB;">待上线</span> 
																				   </c:when>
																				   <c:when test="${activity.beginDate <= systemTime && systemTime <= activity.endDate}">
																				   		<span style="color:#E74C3C;">使用中</span> 
																				   </c:when>
																				   <c:otherwise>
																				   		失效
																				   </c:otherwise>
						                                               		  	</c:choose>
						                                                	</c:when>
						                                                	<c:otherwise>
						                                                		<span style="color:green;">--</span> 
						                                                	</c:otherwise>
																		</c:choose>
																	</td>
				                                   					<td class="numbercss" >
				                                   						<c:if test="${activity.auditStatus == 0}">待审核</c:if>
				                                   						<c:if test="${activity.auditStatus == 1}">审核通过</c:if>
				                                   						<c:if test="${activity.auditStatus == 2}">审核不通过</c:if>
				                                   					</td>
				                                   				</tr>
				                                   			</c:forEach>
				                                   		</c:when>
					                                   	<c:otherwise>
				                                   			<tr>
				                                   				<td colspan="6">暂时没有邀请活动数据</td>
				                                   			</tr>
				                                   		</c:otherwise>
				                                 	</c:choose>
			                                     </tbody>
			                                     <tfoot>
			                                     	<tr>
			                                        	<td colspan="6"><div id="activity-page"></div></td>
			                                        </tr>
			                                     </tfoot>
			                                </table>
		                                </form>
		                        	</div>
		                        </div>
                            </div>
                        </div>
                        <!-- /block -->
                    </div>
                    <!-- content end -->
                </div>
            </div>
             <div class="modal hide fade" id="authorizationDiv" role="dialog" style="margin-top: 200px">
				<form id="fmg" class="modal-content form-horizontal password-modal" >
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title">审核意见</h4>
				      </div>
				      <div class="modal-body">
				      	请确认审核结果！
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary" onclick="setStatus(1)">通过</button>
				        <button type="button" class="btn btn-default" onclick="setStatus(2)">不通过</button>
				      </div>
				    </div>
				</form>		   
			</div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
		function audit(){
			if(rowId > 0){
				$('#authorizationDiv').modal('show');
			}else{
				alert('请先选择一条记录!');
			}
		}
	
		var rowId = 0;
		$(document).ready(function(){
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">券码管理&nbsp;/&nbsp;邀请赠送管理</li>');
			$('[rel="tooltip"]').tooltip();
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/invite/activity/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#activity-page').bootstrapPaginator(options);
			}
			$("#2027").hide();
			$("#2028").hide();
			$("#2029").hide();
			$("#2030").hide();
			$('.shortcss').css({width:10});
			$('.numbercss').css({width:50});
			$('.longcss').css({width:100});
		});
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				rowId = 0;
				$('#2027').hide();
				$('#2028').hide();
				$('#2029').hide();
				$('#2030').hide();
			} else {
				$('#activityId'+rowId).css('background-color', 'white');
			    $(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				var status = tr.getElementsByTagName('td')[1].innerHTML;
				if (status == 0) {
					$('#2029').show();
				} else {
					$('#2029').hide();
				}
				if(status == 1 ){
					$('#2027').hide();
				}else{
					$('#2027').show();	
				}
				$('#2028').show();
				$('#2030').show();
			}
	    }
		
		function add() {
			window.location.href='${pageContext.request.contextPath}/coupon/invite/activity/add/${page}/${size}';
		}
		
		function edit() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/coupon/invite/activity/'+rowId+'/edit/${page}/${size}';
			} else {
				alert('请选择一条要修改的数据');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/coupon/invite/activity/'+rowId+'/detail/${page}/${size}';
			} else {
				alert('请选择一条要查看的数据');
			}
		}
		
		function activityDetail(){
			if (rowId > 0) {
				$('#search').attr('action','${pageContext.request.contextPath}/coupon/invite/activity/detail/list/'+rowId);
                $('#search').submit();
			} else {
				alert('请先选择一个邀请活动');
			}
		}
		
		function setStatus(status){
			if (rowId > 0) {
				var flog = 0;
				if(status == 1){
				    $.ajax({ 
				    	type : 'post',
					    url : '${pageContext.request.contextPath}/coupon/invite/activity/validate/time/'+rowId,
					    async : false,
					    success : function(result){
					    	if(!result){
						   		flog = 1;
						   		$('#authorizationDiv').modal('hide');
						   		alert('活动时间段不能与审核通过的活动时间段重叠!');
						   	}
					    }
				    });
				}
			   	if(flog == 0){
			   		$.ajax({ 
						type:'post', 
						async: true,
						url: '${pageContext.request.contextPath}/coupon/invite/activity/status', 
						data:{
							'id' : rowId,
							'status' : status
						},
						success: function(data){
							if(data == 'false'){  
								alert('操作失败!');
			                } else { 
			                	window.location.href='${pageContext.request.contextPath}/coupon/invite/activity/list/${page}';
			                }
						}
					});
			   	}
			} else {
				alert('请选择一条要审核的数据!');
			}
		}
	</script>
	<c:import url="/authority" />
</html>