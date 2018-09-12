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
                    	<form id="search" action="${pageContext.request.contextPath}/product/project/list/${page}" method="post"></form>
                    	<div class="block">
                    	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a id="2020" href="${pageContext.request.contextPath}/product/project/add"><button class="btn btn-lg btn-success">新增</button></a>
                                 <a id="2022" href="javascript:detail()" ><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                                 <a id="2021" href="javascript:edit()" ><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                                 <a id="2023" href="javascript:audit()" ><button class="btn btn-lg btn-primary" >审核</button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="contract" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr>
                                            	<th>序号</th>
	                                            <th>项目名称</th>
	                                            <th>项目类型</th>
	                                            <th>状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(projects) > 0}">
                                            <c:forEach var="project" items="${projects}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="projectId${project.id}">
                                                <td class="hiddenid">${project.id}</td>
                                                <td class="hiddenid">${project.status}</td>
                                                <td>${status.count}</td>
                                                <td>${project.name}</td>
                                                <td><c:if test="${project.type == 0}">
	                                                	供应链
	                                                </c:if>
	                                                <c:if test="${project.type == 1}">
	                                                 	信用贷
	                                                </c:if>
	                                                <c:if test="${project.type == 2}">
	                                                 	抵押贷
	                                                </c:if>
	                                            </td>
                                                <td>
	                                                <c:if test="${project.status == 0}">
	                                                	待审核
	                                                </c:if>
	                                                <c:if test="${project.status == 1}">
	                                                 	审核通过
	                                                </c:if>
	                                                <c:if test="${project.status == 2}">
	                                                 	审核不通过
	                                                </c:if>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="5">暂时还没有项目列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
	                                     	<tr>
	                                        	<td colspan="5"><div id="project-page"></div></td>
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
        <div class="modal hide fade" id="auditDiv" role="dialog" style="margin-top: 200px">
			<form id="fmg" class="modal-content form-horizontal password-modal" >
			      <div class="modal-header">
			        <h4 class="modal-title">审核意见</h4>
			      </div>
			      <div class="modal-body">
			      	请确认审核结果！
			      <div class="modal-footer">
			      	<a class="btn btn-primary" onclick="setStatus('1')">通过</a>
			      	<a class="btn btn-default" onclick="setStatus('2')">不通过</a>
			      </div>
			    </div>
			</form>		   
		</div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
		function audit(){
			$('#auditDiv').modal('show');
		}
		
		var rowId = 0;
		var status = '';
		$(document).ready(function(){
			$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;项目管理</li>');
			$('[rel="tooltip"]').tooltip();
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/product/project/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#project-page').bootstrapPaginator(options);
			}
			$('td.hiddenid').hide();
			$('#2021').hide();
			$('#2022').hide();
			$('#2023').hide();
		});
		
		function getRow(tr, color) {
			$('#2021').hide();
			$('#2022').hide();
			$('#2023').hide();
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#2021').hide();
				$('#2022').hide();
				$('#2023').hide();
				rowId = 0;
			} else {
				$('#2022').show();
				$('#projectId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				status = tr.getElementsByTagName('td')[1].innerHTML;
				buttonShowOrHide(status);
			}
		
		}
		
		function buttonShowOrHide(status){
			if(status == 0){
				$('#2021').show();
				$('#2023').show();
			} else if (status == 2) {
				$('#2021').show();
				$('#2023').hide();
			} else if (status == 1) {
				$('#2021').hide();
				$('#2023').hide();
			}
		}
		
		function edit() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/product/project/edit/'+rowId;
			} else {
				alert('请先选择您想编辑的数据!');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/product/project/detail/'+rowId;
			} else {
				alert('请先选择您想查看的数据!');
			}
		}
		
		function setStatus(statue){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/product/project/audit/'+rowId+'/'+statue;
			}else{
				alert('请先选择您想启用或中止的行！');
			}
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>