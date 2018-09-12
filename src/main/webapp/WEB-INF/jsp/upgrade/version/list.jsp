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
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                        	<div class="well">
			                    <form id="search" action="${pageContext.request.contextPath}/upgrade/version/list/1" method="post">
				                	<input type="hidden" id="size" name="size" value="${size}" />
				                   	<div class="input-group pull-left">
				                    	<span>版本号:</span>
				                        <input class="horizontal marginTop" id="version" name="versionSearch" type="text" value="${version}" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
				                        <span>更新内容:</span>
										<input class="horizontal marginTop" id="content" name="contentSearch" type="text"  value="${content}" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
		                              	<input type="submit" style="margin-top: -10px" value="查询" class="btn btn-default" />
				                    </div>
				                </form>
		                    </div>
                       	<div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
	                            <a href="javascript:add();" id="260"><button type="button" class="btn btn-success">新增 </button></a>
	                            <a href="javascript:detail()" id="261"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
	                            <a href="javascript:edit();" id="262"><button type="button" class="btn btn-primary">编辑 </button></a>
	                            <a href="javascript:addPatch();" id="265"><button type="button" class="btn btn-primary">新增补丁</button></a>
	                            <a href="javascript:enable(1);" id="263"><button type="button" class="btn btn-primary">启用</button></a>
	                            <a href="javascript:enable(0);" id="264"><button type="button" class="btn btn-primary">禁用</button></a>
                            </div>
                            <div class="block-content collapse in">
                                <div class="span12">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th>序号</th>
                                               <th>版本号</th>
                                               <th>版本补丁号</th>
                                               <th>更新内容</th>
                                               <th class="text-right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       	<c:choose>
                                       		<c:when test="${fn:length(appVersions) > 0}">
                                       			<c:forEach var ="appVersion" items="${appVersions}" varStatus="status">
                                       				<tr onclick="getRow(this, '#BFBFBF')" id="appId${appVersion.id}">
                                       					<td class="hidden">${appVersion.id}</td>
														<td style="width:10%;">${status.count}</td>
                                       					<td style="width:10%;">${appVersion.version}</td>
                                       					<td style="width:10%;">${appVersion.patchNO}</td>
                                       					<td style="width:50%;">${appVersion.content}</td>
                                       					<td style="width:20%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:if test="${appVersion.status > 0}">启用</c:if><c:if test="${appVersion.status < 1}">禁用</c:if></td>
                                       				</tr>
                                       			</c:forEach>
                                       		</c:when>
                                       		<c:otherwise>
                                       			<tr>
                                       				<td colspan="6">暂时没有版本数据</td>
                                       			</tr>
                                       		</c:otherwise>
                                       	</c:choose>
                                       </tbody>
                                       <tfoot>
                                       	<tr>
                                       		<td colspan="6"><div id="version-page"></div></td>
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
		$('.breadcrumb').html('<li class="active">APP升级管理&nbsp;/&nbsp;版本管理</li>');
		$(document).ready(function(){
			$('#262').hide();
			$('#263').hide();
			$('#264').hide();
			$('#265').hide();
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
		            	window.location.href = '${pageContext.request.contextPath}/upgrade/version/list/'+page;
		            }  
			    };
				$('#version-page').bootstrapPaginator(options);
			}
		});
		
		function add() {
			window.location.href = '${pageContext.request.contextPath}/upgrade/version/add/${page}/${size}';
		}
		
		function edit() {
			if (rowId > 0) {
				window.location.href = '${pageContext.request.contextPath}/upgrade/version/edit/' + rowId + '/${page}/${size}';
			} else {
				alert('请选择一条要修改的数据');
			}
		}
		
		function addPatch(){
			if (rowId > 0) {
				window.location.href = '${pageContext.request.contextPath}/upgrade/version/patch/' + rowId + '/${page}/${size}';
			} else {
				alert('请选择一条要查看的数据');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href = '${pageContext.request.contextPath}/upgrade/version/detail/' + rowId + '/${page}/${size}';
			} else {
				alert('请选择一条要查看的数据');
			}
		}
		
		var rowId = 0;
		$('#261').hide(); 
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				rowId = 0;
				$('#261').hide();
				$('#262').hide();
				$('#263').hide();
				$('#264').hide();
				$('#265').hide();
			} else {
				$('#261').show();
				$('#appId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName("td")[0].innerHTML;
				var status = tr.getElementsByTagName('td')[5].innerHTML;
				if (status.replace(/\&nbsp;/g,'') == '禁用') {
					$('#262').show();
					$('#263').show();
					$('#264').hide();
					$('#265').hide();
				} else {
					$('#262').hide();
					$('#263').hide();
					$('#264').show();
					$('#265').show();
				}
			}
	    }
		
		function enable(status) {
			var msg = '';
			if(status == 1){
				msg = '启用';
			}else{
				msg = '禁用';
			}
			if (confirm('确认要'+msg+'此APP版本吗?')) {
				$.post('${pageContext.request.contextPath}/upgrade/version/enable/'+rowId+'/'+status, function(result){
					if (result) {
	 					window.location.href = '${pageContext.request.contextPath}/upgrade/version/list/${page}';
					}
				});
			}
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>