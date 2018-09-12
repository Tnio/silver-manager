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
                    	<div class="block">
                    	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a id="240" href="${pageContext.request.contextPath}/faq/add"><button class="btn btn-lg btn-success">新增</button></a>
                                 <a href="javascript:detail()" id="241"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                                 <a href="javascript:edit()" id="242"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                                 <a href="javascript:setStatus('enable')"  id="243"><button class="btn btn-lg btn-primary" >启用</button></a>
                                 <a href="javascript:setStatus('disabled')"  id="244"><button class="btn btn-lg btn-primary">禁用</button></a>
                                 <a href="javascript:deleted()" id="245"><button class="btn btn-lg">删除<i class=""></i></button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="product" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>问题</th>
	                                            <th>回答</th>
	                                            <!-- <th>排序</th> -->
	                                            <th>状态</th>
                                            </tr>
                                        </thead>
                                        <tbody class="faqSortable">
                                        <c:choose>
                                          <c:when test="${fn:length(faqs) > 0}">
                                            <c:forEach var="faq" items="${faqs}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="faqId${faq.id}N${faq.sortNumber}">
                                                <td class="hiddenid">${faq.id}</td>
                                                <td class="hiddenid">${faq.sortNumber}</td>
                                                <td>${status.count}</td>
                                                <td><p class="lia">${faq.ask}</p></td>
                                                <td><p class="liq">${faq.question}</p></td>
                                                <td class="hiddenid">${faq.sortNumber}</td>
                                                <td>
                                                <c:if test="${faq.enable == 0}">
                                                	禁用
                                                </c:if>
                                                 <c:if test="${faq.enable == 1}">
                                                 	启用
                                                </c:if>
                                              
                                                </td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="8">暂时还没有问答列表</td>
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
            </div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
		var rowId = 0;
		var sortNumber = 0;
		var status = '';
		$(".lia").css({'width':'300px','display':'block','overflow':'hidden','word-break':'keep-all','white-space':'nowrap','text-overflow':'ellipsis'});
		$(".liq").css({'width':'500px','display':'block','overflow':'hidden','word-break':'keep-all','white-space':'nowrap','text-overflow':'ellipsis'});
		$(document).ready(function(){
			$('.breadcrumb').html('<li class="active">内容管理&nbsp;/&nbsp;常见问题管理</li>');
			$('[rel="tooltip"]').tooltip();
			$('td.hiddenid').hide();
			$('#244').hide();
			$('#243').hide();
			$('#242').hide();
			
			changeSort('${pageContext.request.contextPath}/faq/change/sort','faqSortable','tr:contains("\u542f\u7528")',/faqId/g,'N');
			$( ".faqSortable" ).sortable("disable");
		});
		
		$('#245').hide();
		$('#242').hide();
		$('#241').hide();
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#244').hide();
				$('#243').hide();
				$('#245').hide();
				$('#242').hide();
				$('#241').hide();
				rowId = 0;
			} else {
				$('#245').show();
				$('#242').show();
				$('#241').show();
				$('#faqId'+rowId+'N'+sortNumber).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = $.trim(tr.getElementsByTagName('td')[0].innerHTML);
				sortNumber = $.trim(tr.getElementsByTagName('td')[1].innerHTML)
				status = tr.getElementsByTagName('td')[6].innerHTML;
				buttonShowOrHide(status);
			}
		
		}
		
		function buttonShowOrHide(status){
			if($.trim(status) == '启用'){
				$('#244').show();
				$('#243').hide();
				$('#242').hide();
			}else{
				$('#244').hide();
				$('#243').show();
				$('#242').show();
			}
		}
		
		function edit() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/faq/edit/'+rowId;
			} else {
				alert('请先选择您想编辑的行!');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/faq/detail/'+rowId;
			} else {
				alert('请先选择您想查看的数据!');
			}
		}
		
		function deleted() {
			if (rowId > 0) {
				if(confirm("确认要删除本条记录吗?")){
					window.location.href='${pageContext.request.contextPath}/faq/delete/'+rowId;	
				}
			} else {
				alert('请先选择您想删除的行!');
			}
		}
		
		function setStatus(statue){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/faq/'+rowId+'/'+statue;
			}else{
				alert('请先选择您想启用或中止的行！');
			}
			
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>