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
                	<div class="well">
                		<form id="search" action="${pageContext.request.contextPath}/notice/list/1" method="post">
                    		<input type="hidden" id="size" name="size" value="${size}" />
                      		<div class="input-group pull-left">
								<span>标题</span>
								<input class="horizontal marginTop" id="title" name="title" type="text"  value="${title}" />
								<span >类型</span>
	              				<select class="marginTop" id="type" name="type">
	              					<c:if test="${type <= 0}">
	              						<option value="0" selected="selected">全部</option>
	              						<option value="1" >网站公告</option>
	              						<option value="3" >媒体报道</option>
	              						<option value="4" >行业资讯</option>
	              						<option value="6" >理财专栏</option>
	              					</c:if>
	              					<c:if test="${type == 1 }">
	              						<option value="0">全部</option>
	              						<option value="1" selected="selected">网站公告</option>
	              						<option value="3" >媒体报道</option>
	              						<option value="4" >行业资讯</option>
	              						<option value="6" >理财专栏</option>
	              					</c:if>
	                            	<c:if test="${type == 3 }">
	              						<option value="0" >全部</option>
	              						<option value="1" >网站公告</option>
	              						<option value="3" selected="selected" >媒体报道</option>
	              						<option value="4" >行业资讯</option>
	              						<option value="6" >理财专栏</option>
	              					</c:if>
	                            	<c:if test="${type == 4 }">
	              						<option value="0" >全部</option>
	              						<option value="1" >网站公告</option>
	              						<option value="3" >媒体报道</option>
	              						<option value="4" selected="selected" >行业资讯</option>
	              						<option value="6" >理财专栏</option>
	              					</c:if>
	                       			<c:if test="${type == 6 }">
	              						<option value="0" >全部</option>
	              						<option value="1" >网站公告</option>
	              						<option value="3" >媒体报道</option>
	              						<option value="4" >行业资讯</option>
	              						<option value="6" selected="selected">理财专栏</option>
	              					</c:if>
						    	</select>
						    	<a href="javascript:search();"><button type="button" style="margin-top: -10px" class="btn">查询</button></a>
                              	<!-- <input type="reset" value="重置" style="margin-top: -10px" onclick="resetData()" class="btn btn-default" /> -->
                         		</div>
                    	</form>
			         </div>
                    <div class="row-fluid">
                    	<div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a href="${pageContext.request.contextPath}/notice/add" id="250"><button class="btn btn-lg btn-success">新增</button></a>
                                 <a href="javascript:edit()" id="251"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                                 <a href="javascript:detail()" id="255"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                                 <a href="javascript:setStatus('enable')" id="252"><button class="btn btn-lg btn-primary" >启用</button></a>
                                 <a href="javascript:setStatus('disabled')" id="253"><button class="btn btn-lg btn-primary">禁用</button></a>
                                 <a href="javascript:deleted()" id="254"><button class="btn btn-lg">删除<i class=""></i></button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="notice" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>公告标题</th>
	                                            <!-- <th>公告内容</th> 
	                                            <th>创建时间</th> -->
	                                            <th>类型</th> 
	                                            <!-- <th>排序</th> -->
	                                            <th>公告状态</th>
                                            </tr>
                                        </thead>
                                        <tbody class="noticeSortable">
                                        <c:choose>
                                          <c:when test="${fn:length(notices) > 0}">
                                            <c:forEach var="notice" items="${notices}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="noticeId${notice.id}N${notice.sortNumber}">
                                                <td class="hiddenid">${notice.id}</td>
                                                 <td class="hiddenid">${notice.sortNumber}</td>
                                                <td style="width:30px;">${status.count}</td>
                                                <td class="vertical"><p class="lia">${notice.news.title}</p></td>
                                                <td class="vertical">
                                                <c:if test="${notice.type == 1}">
                                                	网站公告
                                                </c:if>
                                                <c:if test="${notice.type == 2}">
                                                 	银狐动态
                                                </c:if>
                                                <c:if test="${notice.type == 3}">
                                                 	媒体报道
                                                </c:if>
                                                <c:if test="${notice.type == 4}">
                                                 	行业资讯 
                                                </c:if>
                                                <c:if test="${notice.type == 6}">
                                                 	理财专栏 
                                                </c:if>
                                                </td>
                                               <%--  <td class="vertical">${notice.sortNumber}</td> --%>
                                                <td class="vertical">
                                                <c:if test="${notice.status == 0}">
                                                	禁用
                                                </c:if>
                                                 <c:if test="${notice.status == 1}">
                                                 	启用
                                                </c:if>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="8">暂时还没有公告列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                        	<tr>
                                        		<td colspan="8"><div id="notice-page"></div></td>
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
		var rowId = 0;
		var sortNumber = 0;
		var status = '';
		$('.vertical').css('vertical-align', 'middle');
		$(".lia").css({'width':'400px','display':'block','overflow':'hidden','word-break':'keep-all','white-space':'nowrap','text-overflow':'ellipsis'});
		$(document).ready(function(){
			$('.breadcrumb').html('<li class="active">消息管理&nbsp;/&nbsp;新闻公告管理</li>');
			var totalPages = '${pages}';
			$('[rel="tooltip"]').tooltip();
			$('td.hiddenid').hide();
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/notice/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#notice-page').bootstrapPaginator(options);
			}
			$('td.hiddenid').hide();
			$('#253').hide();
			$('#252').hide();
			
			changeSort('${pageContext.request.contextPath}/notice/change/sort','noticeSortable','tr:contains("\u542f\u7528")',/noticeId/g,'N');
			$(".noticeSortable" ).sortable("disable");
		});
		
		$('#254').hide();
		$('#251').hide();
		$('#255').hide();
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#253').hide();
				$('#252').hide();
				$('#254').hide();
				$('#251').hide();
				$('#255').hide();
				rowId = 0;
			} else {
				$('#254').show();
				$('#255').show();
				$('#251').show();
				$('#noticeId'+rowId+'N'+ sortNumber).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId =  $.trim(tr.getElementsByTagName('td')[0].innerHTML);
				sortNumber = $.trim(tr.getElementsByTagName('td')[1].innerHTML);
				status =  $.trim(tr.getElementsByTagName('td')[5].innerHTML);
				buttonShowOrHide(status);
			}
		}
		
		function buttonShowOrHide(status){
			if($.trim(status) == '启用'){
				$('#253').show();
				$('#252').hide();
				$('#254').hide();
				$('#251').hide();
			}else{
				$('#253').hide();
				$('#252').show();
				$('#254').show();
				$('#251').show();
			}
		}
		
		function edit() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/notice/edit/'+rowId;
			} else {
				alert('请先选择您想编辑的行!');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/notice/detail/'+rowId;
			} else {
				alert('请先选择要查看的数据!');
			}
		}
		
		
		function deleted() {
			if (rowId > 0) {
				if(confirm("确认要删除本条记录吗?")){
					window.location.href='${pageContext.request.contextPath}/notice/delete/'+rowId;	
				}
			} else {
				alert('请先选择您想删除的行!');
			}
		}
		
		function setStatus(statue){
			if(rowId > 0){
				$.post('${pageContext.request.contextPath}/notice/status',{id:rowId,status:statue},function(){
					$('#search').attr('action','${pageContext.request.contextPath}/notice/list/1');
		            $('#search').submit();
				})
			}else{
				alert('请先选择您想启用或中止的行！');
			}
			
		}
		
		function resetData(){
			$('#title').val('');
			$('#search').attr('action','${pageContext.request.contextPath}/notice/list/1');
            $('#search').submit();
		}
		
		function search() {
			$('#search').attr('action','${pageContext.request.contextPath}/notice/list/1');
            $('#search').submit(); 
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>