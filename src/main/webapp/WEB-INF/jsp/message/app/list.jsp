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
                    <div class="row-fluid">
                    	<form id="search" action="${pageContext.request.contextPath}/message/app/list/1" method="post" class="form-search">
	                        <input type="hidden" id="size" name="size" value="${size}" />
                        </form>
                    	<div class="block">
               				<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    	    <div id="authorityButton" class="navbar navbar-inner block-header" style="border-top: none;">
                                <a href="javascript:add();" id="280"><button type="button" class="btn btn-success">新增 </button></a>
	                            <a href="javascript:detail()" id="281"><button class="btn btn-lg btn-primary" >查看</button></a>
	                            <a href="javascript:edit();" id="282"><button type="button" class="btn btn-primary">编辑 </button></a>
	                            <a href="javascript:audit();" id="283"><button type="button" class="btn btn-primary">审核</button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="product" cellpadding="0" cellspacing="0" border="0" class="table">
                                        <thead>
                                             <tr>
	                                             <th width="5%">序号</th>
	                                             <th width="60%">消息标题</th>
	                                             <th width="10%">状态</th>
	                                             <th width="25%">添加时间</th>
                                             </tr>
                                        </thead>
                                        <tbody>
	                                        <c:choose>
	                                            <c:when test="${fn:length(messages) > 0}">
		                                            <c:forEach var="message" items="${messages}" varStatus="status">
			                                            <tr onclick="getRow(this, '#BFBFBF')" id="message${message.id}">
			                                            	<td class="hidden">${message.id}</td>
			                                            	<td class="hidden">${message.status}</td>
			                                                <td>${status.count}</td>
			                                                <td>${message.news.title}</td>
			                                                <td>
			                                                	<c:choose>
			                                                		<c:when test="${message.status == 1}">审核通过</c:when>
			                                                		<c:when test="${message.status == 2}">审核不通过</c:when>
																	<c:otherwise>未审核</c:otherwise>			                                                	
			                                                	</c:choose>
			                                                </td>
			                                                <td><fmt:formatDate value="${message.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			                                             </tr>
		                                            </c:forEach>
	                                            </c:when>
	                                            <c:otherwise>
	                                        	    <tr>
	                                                    <td colspan="4">暂时还没有APP消息</td>
	                                                </tr>  
	                                            </c:otherwise>
	                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                       		    <td colspan="4"><div id="message-page"></div></td>
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
		var rowId = 0;
		var status = '';
		
		$(document).ready(function(){ 
			$('#282').hide();
			$('#283').hide();
			
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">消息管理&nbsp;/&nbsp;APP消息管理</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/message/app/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#message-page').bootstrapPaginator(options);
			}
		});
		
		$('#281').hide();
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$('#281').hide();
				$(tr).css('background-color', 'white');
				rowId = 0;
				$('#282').hide();
				$("#283").hide();
			} else {
				$('#281').show();
				$('#message'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				status = tr.getElementsByTagName('td')[1].innerHTML;
				if(status==1) {
					$('#282').hide();
					$("#283").hide();
				}else {
					$('#282').show();
					$("#283").show();
				}
			}
		}
		
		function add(){
			$('#search').attr('action','${pageContext.request.contextPath}/message/app/add/${page}/${size}');
            $('#search').submit();
		}
		
		function edit() {
			if (rowId > 0) {
				$('#search').attr('action','${pageContext.request.contextPath}/message/app/edit/'+rowId+'/${page}/${size}');
	            $('#search').submit();
			} else {
				alert('请先选择您想编辑的行!');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/message/app/detail/'+rowId+'/${page}/${size}';
			} else {
				alert('请先选择要查看的数据!');
			}
		}
		
		function audit(){
			if(rowId > 0){
				$('#authorizationDiv').modal('show');
			}else{
				alert('请先选择一条记录!');
			}
		}
		
		function setStatus(status){
			if(rowId > 0){
					$.post('${pageContext.request.contextPath}/message/app/audit/'+rowId, {'status': status}, function(result){
						if (result) {
		 					window.location.href = '${pageContext.request.contextPath}/message/app/list/${page}';
						}
					}, 'json');
			}else{
				alert('请先选择您想审核的消息！');
			}
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>