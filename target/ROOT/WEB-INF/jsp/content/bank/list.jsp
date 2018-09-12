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
                                 <a href="javascript:detail()" id="391"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                                 <a href="javascript:edit()" id="392"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                                 <a href="javascript:setStatus('1')"  id="393"><button class="btn btn-lg btn-primary" >启用</button></a>
                                 <a href="javascript:setStatus('0')"  id="394"><button class="btn btn-lg btn-primary">禁用</button></a>
                            </div>
                            <div class="block-content collapse in"> 
                                <div class="span12">
                                    <table id="product" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>银行logo</th>
	                                            <th>银行名称</th>
	                                            <th>单笔限额（元）</th>
	                                            <th>单日限额（元）</th>
	                                            <th>单月限额（元）</th>
	                                            <th>排序</th>
	                                            <th>状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(banks) > 0}">
                                            <c:forEach var="bank" items="${banks}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="bankId${bank.id}">
                                                <td class="hiddenid">${bank.id}</td>
                                                <td class="hiddenid">${bank.enable}</td>
                                                <td class="vertical">${status.count}</td>
                                                <td class="vertical"><c:if test="${not empty bank.logoUrl}"><img class="thumbnail" src="${bank.logoUrl }" style="height: 60px;width: 100px"/></c:if></td>
                                                <td class="vertical">${bank.bankName}</td>
                                                <td class="vertical">
                                                	<c:if test="${bank.singleLimit >= 10000}"><fmt:formatNumber value="${bank.singleLimit/10000}" pattern="##0" maxFractionDigits="2"/>万</c:if>
                                                	<c:if test="${bank.singleLimit < 10000}">${bank.singleLimit}</c:if>
                                                </td>
                                                <td class="vertical">
                                                	<c:if test="${bank.dayLimit >= 10000}"><fmt:formatNumber value="${bank.dayLimit/10000}" pattern="##0" maxFractionDigits="2"/>万</c:if>
                                                	<c:if test="${bank.dayLimit < 10000}">${bank.dayLimit}</c:if>
                                                </td>
                                                <td class="vertical">
                                                	<c:if test="${bank.monthLimit >= 10000}"><fmt:formatNumber value="${bank.monthLimit/10000}" pattern="##0" maxFractionDigits="2"/>万</c:if>
                                                	<c:if test="${bank.monthLimit < 10000}">${bank.monthLimit}</c:if>
                                                </td>
                                                <td class="vertical">${bank.sortNumber}</td>
                                                <td class="vertical">
	                                                <c:if test="${bank.enable == 0}">
	                                                	禁用
	                                                </c:if>
	                                                 <c:if test="${bank.enable == 1}">
	                                                 	启用
	                                                </c:if>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="8">暂时还没有银行限额列表</td>
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
		$('.vertical').css('vertical-align', 'middle');
		$(document).ready(function(){
			$('.breadcrumb').html('<li class="active">内容管理&nbsp;/&nbsp;银行限额管理</li>');
			$('[rel="tooltip"]').tooltip();
			$('.hiddenid').hide();
			
			$('#391').hide();
			$('#392').hide();
			$('#393').hide();
			$('#394').hide();
		});
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#391').hide();
				$('#392').hide();
				$('#393').hide();
				$('#394').hide();
				rowId = 0;
			} else {
				$('#391').show();
				$('#bankId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				status = tr.getElementsByTagName('td')[1].innerHTML;
				$('#392').show();
				if (status == 1) {
					$('#393').hide();
					$('#394').show();
				} else {
					$('#393').show();
					$('#394').hide();
				}
			}
		
		}
		
		function edit() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/unionpay/bank/edit/'+rowId;
			} else {
				alert('请先选择您想编辑的行!');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/unionpay/bank/detail/'+rowId;
			} else {
				alert('请先选择您想查看的数据!');
			}
		}
		
		function setStatus(statue){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/unionpay/bank/'+rowId+'/'+statue;
			}else{
				alert('请先选择您想启用或禁用的数据！');
			}
			
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>