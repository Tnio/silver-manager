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
            <div id="content">
                <!-- content begin -->
                <div class="row-fluid">
                    <!-- block -->
                    <div class="block">
                        <div id="authorityButton" class="navbar navbar-inner block-header">
                            <a id="172" href="javascript:resetCard()"><button class="btn btn-lg btn-success">注销银行卡</button></a>
                        </div>
                        <div class="block-content collapse in">
                            <table cellpadding="0" cellspacing="0" border="0" class="div_table" id="orders">
                                <thead>
                                <tr>
                                    <th class="center">序号</th>
                                    <th class="center">银行卡号</th>
                                    <th class="center">银行名称</th>
                                    <th class="center">使用状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(customerCards) > 0}">
                                        <c:forEach var="card" items="${customerCards}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="cardId${card.id}">
                                                <td class="hiddenid">${card.id}</td>
                                                <td class="hiddenid">${card.status}</td>
                                                <td>${status.count}</td>
                                                <td>****${fn:substring(card.cardNO, (fn:length(card.cardNO) - 4), fn:length(card.cardNO))}&nbsp;<c:if test="${card.status == 2}"><span style="background-color:#06823b;border-radius:2px;color:white;">转出专用</span></c:if></td>
                                                <td>${card.bankName}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${card.status == 0}">
                                                            已注销
                                                        </c:when>
                                                        <c:otherwise>
                                                            使用中
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="5"></td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                    <!-- /block -->
                </div>
                <!-- content end -->
            </div>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
<%-- <script src="${pageContext.request.contextPath}/js/json.js"></script> --%>
<script type="text/javascript">
    var rowId = 0;
    var status = '';
    $(document).ready(function(){
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;<a href="${pageContext.request.contextPath}/client/customer/list/1">用户管理</a>&nbsp;/&nbsp;银行卡列表</li>');
        $('[rel="tooltip"]').tooltip();
        $('td.hiddenid').hide();
        $('#172').hide();
    });

    function getRow(tr, color) {
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            $('#172').hide();
            rowId = 0;
        } else {
            $('#cardId'+rowId).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = tr.getElementsByTagName('td')[0].innerHTML;
            statusId = tr.getElementsByTagName('td')[1].innerHTML;
            status = tr.getElementsByTagName('td')[5].innerHTML;
            buttonShowOrHide(status);
        }

    }

    function buttonShowOrHide(status){
        if($.trim(status) == '使用中' && statusId == 2){
            $('#172').show();
        }else{
            $('#172').hide();
        }
    }

    function resetCard(){
        if(rowId > 0){
            if(confirm("确认要注销此银行卡吗?")){
                $.post('${pageContext.request.contextPath}/client/customer/card/reset',{id:rowId},function(){
                    window.location.href='${pageContext.request.contextPath}/client/customer/card/list/${customerId}';
                });
            }

        }else{
            alert('请选择一张在 使用中 的银行卡');
        }
    }

    function quit() {
        window.location.href='${pageContext.request.contextPath}/client/customer/list/1';
    }
</script>
</body>
</html>