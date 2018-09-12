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
                    	<form id="search" action="${pageContext.request.contextPath}/product/contract/list/1" method="post"></form>
                    	<div class="block">
                    	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a id="450" href="${pageContext.request.contextPath}/product/contract/add"><button class="btn btn-lg btn-success">新增</button></a>
                                 <a href="javascript:detail()" id="451"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                                 <a href="javascript:setStatus('1')"  id="452"><button class="btn btn-lg btn-primary" >启用</button></a>
                                 <a href="javascript:setStatus('0')"  id="453"><button class="btn btn-lg btn-primary">禁用</button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="contract" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>合同名称</th>
	                                            <th>状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(contracts) > 0}">
                                            <c:forEach var="contract" items="${contracts}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="contractId${contract.id}">
                                                <td class="hiddenid">${contract.id}</td>
                                                <td>${status.count}</td>
                                                <td><p class="lia">${contract.name}</p></td>
                                                
                                                <td>
                                                <c:if test="${contract.status == 0}">
                                                	禁用
                                                </c:if>
                                                 <c:if test="${contract.status == 1}">
                                                 	启用
                                                </c:if>
                                              
                                                </td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="4">暂时还没有合同列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                        	<tr>
                                        		<td colspan="18"><div id="contract-page"></div></td>
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
		$(document).ready(function(){
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;产品合同管理</li>');
			$('[rel="tooltip"]').tooltip();
			$('td.hiddenid').hide();
			$('#453').hide();
			$('#452').hide();
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/product/contract/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#contract-page').bootstrapPaginator(options);
			}
			
		});
		
		$('#451').hide();
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#453').hide();
				$('#452').hide();
				$('#451').hide();
				rowId = 0;
			} else {
				$('#451').show();
				$('#contractId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				status = tr.getElementsByTagName('td')[3].innerHTML;
				buttonShowOrHide(status);
			}
		
		}
		
		function buttonShowOrHide(status){
			if($.trim(status) == '启用'){
				$('#453').show();
				$('#452').hide();
			}else{
				$('#453').hide();
				$('#452').show();
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/product/contract/detail/'+rowId;
			} else {
				alert('请先选择您想查看的数据!');
			}
		}
		
		function setStatus(statue){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/product/contract/'+rowId+'/'+statue;
			}else{
				alert('请先选择您想启用或中止的行！');
			}
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>