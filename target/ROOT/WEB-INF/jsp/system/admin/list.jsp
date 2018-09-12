<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="${pageContext.request.contextPath}/header"
	flush="true" />
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu"
		flush="true" />
	<div class="container-fluid">
		<div class="row-fluid">
			<jsp:include page="${pageContext.request.contextPath}/sidebar"
				flush="true" />
			<div class="span10" id="content">
				<!-- content begin -->
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<jsp:include page="${pageContext.request.contextPath}/breadcrumb"
							flush="true" />
						<div id="authorityButton" class="navbar navbar-inner block-header">
							<a href="javascript:add();" id="100"><button type="button"
									class="btn btn-success">新增</button></a> <a
								href="javascript:edit();" id="101"><button type="button"
									class="btn btn-primary">编辑</button></a> <a
								href="javascript:resetTotp();" id="107"><button
									type="button" class="btn btn-primary">重置银狐令</button></a> <a
								href="javascript:enable(1);" id="103"><button
									id="buttonId103" type="button" class="btn btn-primary">启用
								</button></a> <a href="javascript:enable(0);" id="104"><button
									type="button" class="btn btn-primary">禁用</button></a> <a
								href="javascript:deleted();" id="106"><button type="button"
									class="btn">删除</button></a>
						</div>
						<div class="block-content collapse in">
							<div class="span12">
								<form id="search"
									action="${pageContext.request.contextPath}/system/admin/list/1"
									method="post">
									<table id="admins" cellpadding="0" cellspacing="0" border="0"
										class="table">
										<thead>
											<tr>
												<th>序号</th>
												<th>用户名</th>
												<th>角色</th>
												<th>真实姓名</th>
												<th>手机</th>
												<th>状态</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${fn:length(admins) > 0}">
													<c:forEach var="admin" items="${admins}" varStatus="status">
														<tr onclick="getRow(this, '#BFBFBF')"
															id="adminId${admin.id}">
															<td class="hidden">${admin.id}</td>
															<td>${status.count}</td>
															<td>${admin.name}</td>
															<td>${admin.role.name}</td>
															<td>${admin.realName}</td>
															<td>${admin.cellphone}</td>
															<td><c:if test="${admin.status < 1}">禁用</c:if> <c:if
																	test="${admin.status > 0}">启用</c:if></td>
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="10">暂时没有管理员数据</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="10"><div id="admin-page"></div></td>
											</tr>
										</tfoot>
									</table>
								</form>
							</div>
						</div>
					</div>
					<!-- /block -->
				</div>
				<!-- content end -->
			</div>
		</div>
	</div>
	<jsp:include page="${pageContext.request.contextPath}/footer"
		flush="true" />
</body>
<script type="text/javascript">
	var rowId = 0;
	var state = '';
	var lock = '';
	$(document).ready(
			function() {
				$('.breadcrumb').html(
						'<li class="active">系统管理&nbsp;/&nbsp;操作员管理</li>');
				$('[rel="tooltip"]').tooltip();
				var totalPages = '${pages}';
				if (totalPages > 0) {
					var options = {
						currentPage : '${page}',
						totalPages : totalPages,
						size : 'normal',
						alignment : 'center',
						tooltipTitles : function(type, page, current) {
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
								return (page === current) ? '当前页 ' + page
										: '跳到 ' + page;
							}
						},
						onPageClicked : function(event, originalEvent, type,
								page) {
							$('#search').attr(
									'action',
									'${pageContext.request.contextPath}/system/admin/list/'
											+ page);
							$('#search').submit();
						}
					};
					$('#admin-page').bootstrapPaginator(options);
				}
				$('#104').hide();
				$('#103').hide();
				$('#107').hide();
			});

	$('#106').hide();
	//$('#102').hide();
	$('#101').hide();
	function getRow(tr, color) {
		if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
			$(tr).css('background-color', 'white');
			rowId = 0;
			$('#104').hide();
			$('#103').hide();
			$('#106').hide();
			//$('#102').hide();
			$('#101').hide();
			$('#107').hide();
		} else {
			$('#107').show();
			$('#106').show();
			//$('#102').show();
			$('#101').show();
			$('#adminId' + rowId).css('background-color', 'white');
			$(tr).css('background-color', color);
			rowId = tr.getElementsByTagName('td')[0].innerHTML;
			state = tr.getElementsByTagName('td')[6].innerHTML;
			/* if(tr.getElementsByTagName('td')[7].innerHTML == 0){
				$('#106').hide();
				$('#104').hide();
				$('#103').hide();
			}else{ */
			$('#106').show();
			if ($.trim(state) == '禁用') {
				$('#103').show();
				$('#104').hide();
			} else if ($.trim(state) == '启用') {
				$('#103').hide();
				$('#104').show();
			} else {
				$('#104').hide();
				$('#103').hide();
			}
			//}
		}
	}

	function add() {
		window.location.href = '${pageContext.request.contextPath}/system/admin/add/${page}/${size}';
	}

	function edit() {
		if (rowId > 0) {
			window.location.href = '${pageContext.request.contextPath}/system/admin/'
					+ rowId + '/edit/${page}/${size}';
		} else {
			alert('请选择一条要修改的数据!');
		}
	}

	function resetTotp() {
		if (rowId > 0) {
			if (confirm("确认要对该用户重置银狐令吗?")) {
				$
						.post(
								'${pageContext.request.contextPath}/system/admin/'
										+ rowId + '/reset/totp',
								function(result) {
									if (result) {
										alert('银狐令重置成功');
										window.location.href = '${pageContext.request.contextPath}/system/admin/list/${page}';
									}
								});
			}
		} else {
			alert('请先选择一条需要重置银狐令的数据!');
		}
	}

	function deleted() {
		if (rowId > 0) {
			if (confirm("确认要删除本条记录吗?")) {
				$
						.post(
								'${pageContext.request.contextPath}/system/admin/'
										+ rowId + '/delete',
								function(result) {
									if (result) {
										window.location.href = '${pageContext.request.contextPath}/system/admin/list/${page}';
									}
								});
			}
		} else {
			alert('请选择一条要删除的数据!');
		}
	}

	function enable(status) {
		if (rowId > 0) {
			if ((state == '启用' && status == 1)
					|| (state == '禁用' && status == 2)) {
				alert('已启用/禁用过,不需要再次启用/禁用!');
			} else {
				$
						.ajax({
							type : 'post',
							async : true,
							url : '${pageContext.request.contextPath}/system/admin/enable',
							data : {
								'id' : rowId,
								'status' : status
							},
							success : function(data) {
								if (data == 'false') {
									alert('操作失败!');
								} else {
									window.location.href = '${pageContext.request.contextPath}/system/admin/list/${page}';
								}
							}
						});
			}
		} else {
			alert('请选择一条要(启用/禁用)的数据!');
		}
	}
</script>
<jsp:include page="${pageContext.request.contextPath}/authority"
	flush="true" />
</html>