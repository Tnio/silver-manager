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
                    	<form id="search" action="${pageContext.request.contextPath}/message/news/list/1" method="post" class="form-search">
	                        <input type="hidden" id="size" name="size" value="${size}" />
                        </form>
                    	<div class="block">
               				<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    	    <div id="authorityButton" class="navbar navbar-inner block-header" style="border-top: none;">
                                 <a href="javascript:add()" id="290"><button class="btn btn-success">新增</button></a>
                                 <a href="javascript:detail()" id="291"><button class="btn btn-lg btn-primary">查看</button></a>
                                 <a href="javascript:edit()" id="292"><button class="btn btn-primary" >编辑</button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="product" cellpadding="0" cellspacing="0" border="0" class="table">
                                        <thead>
                                             <tr>
	                                             <th width="5%">序号</th>
	                                             <th width="70%">新闻标题</th>
	                                             <th width="25%">添加时间</th>
                                             </tr>
                                        </thead>
                                        <tbody>
	                                        <c:choose>
	                                            <c:when test="${fn:length(newsList) > 0}">
		                                            <c:forEach var="news" items="${newsList}" varStatus="status">
			                                            <tr onclick="getRow(this, '#BFBFBF')" id="news${news.id}">
			                                            	<td class="hidden">${news.id}</td>
			                                                <td>${status.count}</td>
			                                                <td>${news.title}</td>
			                                                <td><fmt:formatDate value="${news.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			                                             </tr>
		                                            </c:forEach>
	                                            </c:when>
	                                            <c:otherwise>
	                                        	    <tr>
	                                                    <td colspan="3">暂时还没有新闻素材</td>
	                                                </tr>  
	                                            </c:otherwise>
	                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                       		    <td colspan="3"><div id="message-page"></div></td>
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
		var status = '';
		$('.marginTop').css('margin', '5px auto auto auto');
		
		$(document).ready(function(){ 
			$('#292').hide();
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">消息管理&nbsp;/&nbsp;新闻素材管理</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/message/news/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#message-page').bootstrapPaginator(options);
			}
		});
		
		$('#291').hide();
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$('#291').hide();
				$(tr).css('background-color', 'white');
				rowId = 0;
				$('#292').hide();
			} else {
				$('#291').show();
				$('#news'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				$('#292').show();
			}
		}
		
		function add(){
			$('#search').attr('action','${pageContext.request.contextPath}/message/news/add/${page}/${size}');
            $('#search').submit();
		}
		
		function edit() {
			if (rowId > 0) {
				$('#search').attr('action','${pageContext.request.contextPath}/message/news/edit/'+rowId+'/${page}/${size}');
	            $('#search').submit();
			} else {
				alert('请先选择您想编辑的行!');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/message/news/detail/'+rowId+'/${page}/${size}';
			} else {
				alert('请先选择要查看的数据!');
			}
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>