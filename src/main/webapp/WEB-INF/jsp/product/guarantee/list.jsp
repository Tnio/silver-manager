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
                    	<form id="search" action="${pageContext.request.contextPath}/product/guarantee/list" method="post"></form>
                    	<div class="block">
                    	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a id="991" href="${pageContext.request.contextPath}/product/guarantee/add"><button class="btn btn-lg btn-success">新增</button></a>
                                 <a id="993" href="javascript:detail()" ><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                                 <a id="992" href="javascript:edit()" ><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                                 <a id="994" href="javascript:setStatus('1')" ><button class="btn btn-lg btn-primary" >启用</button></a>
                                 <a id="995" href="javascript:setStatus('0')" ><button class="btn btn-lg btn-primary">禁用</button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="contract" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr>
	                                            <th>名称</th>
	                                            <th>状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(guarantees) > 0}">
                                            <c:forEach var="guarantee" items="${guarantees}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="guaranteelId${guarantee.id}">
                                                <td class="hiddenid">${guarantee.id}</td>
                                                <td><p class="lia">${guarantee.name}</p></td>
                                                <td>
                                                <c:if test="${guarantee.status == 0}">
                                                	禁用
                                                </c:if>
                                                 <c:if test="${guarantee.status == 1}">
                                                 	启用
                                                </c:if>
                                              
                                                </td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="5">暂时还没有担保函列表</td>
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
		var status = '';
		$(document).ready(function(){
			$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;担保函管理</li>');
			$('[rel="tooltip"]').tooltip();
			$('td.hiddenid').hide();
			$('#992').hide();
			$('#993').hide();
			$('#994').hide();
			$('#995').hide();
		});
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#992').hide();
				$('#993').hide();
				$('#994').hide();
				$('#995').hide();
				rowId = 0;
			} else {
				$('#991').show();
				$('#guaranteelId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				status = tr.getElementsByTagName('td')[2].innerHTML;
				buttonShowOrHide(status);
			}
		
		}
		
		function buttonShowOrHide(status){
			if($.trim(status) == '启用'){
				$('#993').show();
				$('#995').show();
				$('#992').hide();
				$('#994').hide();
				
			}else{
				$('#992').show();
				$('#994').show();
				$('#993').show();
				$('#995').hide();
			}
		}
		
		function edit() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/product/guarantee/edit/'+rowId;
			} else {
				alert('请先选择您想编辑的数据!');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/product/guarantee/detail/'+rowId;
			} else {
				alert('请先选择您想查看的数据!');
			}
		}
		
		function setStatus(statue){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/product/guarantee/'+rowId+'/'+statue;
			}else{
				alert('请先选择您想启用或中止的行！');
			}
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>