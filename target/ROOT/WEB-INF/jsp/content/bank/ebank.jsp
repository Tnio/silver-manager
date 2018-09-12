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
                                 <a href="javascript:setStatus('1')"  id="2000"><button class="btn btn-lg btn-primary" >启用</button></a>
                                 <a href="javascript:setStatus('0')"  id="2001"><button class="btn btn-lg btn-primary">禁用</button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="product" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>银行名称</th>
	                                            <th>银行编号</th>
	                                            <!-- <th>单笔限额（元）</th>
	                                            <th>单日限额（元）</th>
	                                            <th>单月限额（元）</th> -->
	                                            <th>状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(banks) > 0}">
                                            <c:forEach var="bank" items="${banks}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="bankId${bank.id}">
                                                <td class="hiddenid">${bank.id}</td>
                                                <td>${status.count}</td>
                                                <td>${bank.bankName}</td>
                                                <td>${bank.bankNO}</td>
                                                <%-- <td>${bank.singleLimit}</td>
                                                <td>${bank.dayLimit}</td>
                                                <td>${bank.monthLimit}</td> --%>
                                                <td>
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
                                                <td colspan="8">暂时还没有个人网银信息</td>
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
			$('.breadcrumb').html('<li class="active">客户专区&nbsp;/&nbsp;网银支付银行管理</li>');
			$('[rel="tooltip"]').tooltip();
			$('.hiddenid').hide();
			
			$('#2000').hide();
			$('#2001').hide();
		});
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#2000').hide();
				$('#2001').hide();
				rowId = 0;
			} else {
				$('#bankId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				status = tr.getElementsByTagName('td')[4].innerHTML;
				if ($.trim(status) == '启用') {
					$('#2000').hide();
					$('#2001').show();
				} else {
					$('#2000').show();
					$('#2001').hide();
				}
			}
		
		}
		
		function setStatus(statue){
			if(rowId > 0){
				window.location.href='${pageContext.request.contextPath}/ebank/'+rowId+'/'+statue;
			}else{
				alert('请先选择您想启用或禁用的数据！');
			}
			
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>