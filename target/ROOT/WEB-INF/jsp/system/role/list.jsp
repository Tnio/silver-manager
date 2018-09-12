<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
	<link href="${pageContext.request.contextPath}/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" media="screen">
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
                       			<a href="javascript:add();" id="110"><button type="button" class="btn btn-success">新增</button></a>
                       			<a href="javascript:edit();"  id="111"><button type="button" class="btn btn-primary">编辑 </button></a>
                       			<a href="javascript:authorization();" id="112"><button type="button" class="btn btn-primary">授权 </button></a>
                       			<a href="javascript:enable(1);" id="113"><button type="button" class="btn btn-primary">启用 </button></a>
                       			<a href="javascript:enable(0);" id="114"><button type="button" class="btn btn-primary">禁用 </button></a>
                            </div>
                            <div class="block-content collapse in">
	                            <div class="span12">
		                          	<form id="search" action="${pageContext.request.contextPath}/system/role/list/1" method="post">
		                            	<table id="roles" cellpadding="0" cellspacing="0" border="0" class="table">
			                                <thead>
			                                    <tr>
			                                        <th>序号</th>
			                                        <th>角色名称</th>
			                                        <th>状态</th>
			                                        <th>描述</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                	<c:choose>
			                                   		<c:when test="${fn:length(roles) > 0}">
			                                   			<c:forEach var ="role" items="${roles}" varStatus="status">
															<tr onclick="getRow(this, '#BFBFBF')" id="roleId${role.id}">
	                                       						<td class="hidden">${role.id}</td>
	                                       						<td class="shortcss">${status.count}</td>
			                                   					<td class="numbercss">${role.name}</td>
			                                   					<td class="shortcss"><c:if test="${role.status > 0}">启用</c:if><c:if test="${role.status < 1}">禁用</c:if></td>
			                                   					<td class="longcss">${role.remark}</td>
			                                   				</tr>
			                                   			</c:forEach>
			                                   		</c:when>
				                                   	<c:otherwise>
			                                   			<tr>
			                                   				<td colspan="4">暂时没有角色数据</td>
			                                   			</tr>
			                                   		</c:otherwise>
			                                 	</c:choose>
		                                     </tbody>
		                                     <tfoot>
		                                     	<tr>
		                                        	<td colspan="4"><div id="role-page"></div></td>
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
        <div class="modal hide fade" id="authorizationDiv" role="dialog">
			<form id="fmg" class="modal-content form-horizontal password-modal" >
				<div class="zTreeDemo">
					<ul id="treeDemo" class="ztree" ></ul>
				</div>
				<div class="modal-footer">
		            <button type="button" onclick="saveauthorization()" class="btn btn-primary">确认</button>
		            <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
		        </div>
			</form>		 
		</div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/js/jquery.ztree.core-3.5.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/jquery.ztree.excheck-3.5.min.js"></script>
	</body>
	<script type="text/javascript">
		var rowId = 0;
		var state = '';
		$('#114').hide();
		$('#111').hide();
		$('#112').hide();
		$('#113').hide();
		$(document).ready(function(){
			$('.breadcrumb').html('<li class="active">系统管理&nbsp;/&nbsp;角色管理</li>');
			$('[rel="tooltip"]').tooltip();
			$('.shortcss').css({width:10,align:'center'});
			$('.numbercss').css({width:30,align:'center'});
			$('.longcss').css({width:350,align:'center'});
			$('.zTreeDemo').css({height:'500px',overflow:'auto',width:'550px'});
			/* setCheck();
			$('#py').bind('change', setCheck);
			$('#sy').bind('change', setCheck);
			$('#pn').bind('change', setCheck);
			$('#sn').bind('change', setCheck); */
		});
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				rowId = 0;
				$('#114').hide();
				$('#113').hide();
				$('#112').hide();
				$('#111').hide();
			} else {
				$('#112').show();
				$('#111').show();
				$('#roleId'+rowId).css('background-color', 'white');
			    $(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				state = tr.getElementsByTagName('td')[3].innerHTML;
				if(rowId != 1){
					if(state == '禁用'){
						$('#113').show();
						$('#114').hide();
					}else if(state == '启用'){
						$('#113').hide();
						$('#114').show();
					}else{
						$('#114').hide();
						$('#113').hide();	
					}
				}else{
					$('#114').hide();
					$('#113').hide();
				}
			}
	    }

		function add() {
			window.location.href='${pageContext.request.contextPath}/system/role/add';
		}
		
		function edit() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/system/role/'+rowId+'/edit';
			} else {
				alert('请您先选择一条要修改的数据!');
			}
		}
		
		function authorization(){
			if(rowId > 0){
				if(rowId != 1){
					$.ajax({ 
						type:'post', 
						async: false,
						url: '${pageContext.request.contextPath}/system/resource/'+rowId+'/all',
						success: function(data){
							if(JSON.stringify(data[0].id) == undefined){
								window.location.href='${pageContext.request.contextPath}/system/role/list';
							}else{
								$.fn.zTree.init($('#treeDemo'), setting, data);
					    		$('#authorizationDiv').modal('show');
								$('#fmg').validationEngine();
							}
						}
					});
				}else{
					alert('超级管理员拥有所有权限不需要分配!');
				}
			}else{
				alert('请您先选择一条要分配权限的数据!');
			}
		}
		
		function enable(status){
			if (rowId > 0) {
				$.ajax({ 
					type:'post', 
					async: true,
					url: '${pageContext.request.contextPath}/system/role/enable', 
					data:{
						'id' : rowId,
						'status' : status
					},
					success: function(data){
						if(data == 'false'){  
							alert('操作失败!');
		                } else { 
		                	window.location.href='${pageContext.request.contextPath}/system/role/list';
		                }
					}	
				});
			} else {
				alert('请选择一条要(启用/禁用)的数据!');
			}
		}
		
		var code;
		
		/* function setCheck() {
			var zTree = $.fn.zTree.getZTreeObj('treeDemo'),
			py = $('#py').attr('checked')? 'p':'',
			sy = $('#sy').attr('checked')? 's':'',
			pn = $('#pn').attr('checked')? 'p':'',
			sn = $('#sn').attr('checked')? 's':'',
			type = { 'Y':py + sy, 'N':pn + sn};
			if(zTree != null){
				zTree.setting.check.chkboxType = type;
				showCode('setting.check.chkboxType = { "Y" : "' + type.Y + '", "N" : "' + type.N + '" };');
			}
		} */
		
		function showCode(str) {
			if (!code) code = $('#code');
			code.empty();
			code.append('<li>'+str+'</li>');
		}
		
		var setting = {
			check: {
				enable: true,
				chkboxType: { 'Y' : 'ps', 'N' : 's' }
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};
		
		function saveauthorization(){
			var treeObj = $.fn.zTree.getZTreeObj('treeDemo');
			var nodes = treeObj.getCheckedNodes(true);
			var resourceIds = [];
			if (nodes && nodes.length > 0) {
				for ( var i = 0; i < nodes.length; i++) {
					resourceIds.push(nodes[i].id);
				}
			}
			if(resourceIds.length > 0) {
				$.ajax({
					type:'post',
					async: true,
					url: '${pageContext.request.contextPath}/system/resource/save/authorization', 
					data:{
						'id' : rowId,
						'resourceIds' : resourceIds.toString()
					},
					success: function(message){
						if(message){  
							$('#authorizationDiv').modal('hide');
							$.fn.zTree.destroy();
							alert('操作成功!');
		                } else { 
		                	alert('操作失败!');
		                }
					}	
				}); 
			} else {
				alert('亲，请至少选择一个权限！');
			}
		}

	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>