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
            <!-- content begin -->
            <div class="row-fluid">
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form id="search" action="${pageContext.request.contextPath}/client/lender/list/1" method="post">
                        </form>
                        <div class="span12">
                            <table id="lenders" cellpadding="0" cellspacing="0" border="0" class="div_table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>姓名</th>
                                    <th>手机号</th>
                                    <th>借款金额</th>
                                    <th>借款期限</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(lenders) > 0}">
                                        <c:forEach var ="lender" items="${lenders}" varStatus="status">
                                            <tr id="lenderId${lender.id}">
                                                <td class="hidden">${lender.id}</td>
                                                <td class="vertical" >${status.count}</td>
                                                <td class="vertical">${lender.name}</td>
                                                <td class="vertical">${lender.cellphone}</td>
                                                <td class="vertical" ><fmt:formatNumber value="${lender.loanAmount}" pattern="#,##0" /></td>
                                                <td class="vertical" >${lender.loanPeriod}</td>
                                                <td class="vertical">
                                                    <c:if test="${lender.productId > 0}">
                                                        <span>已借</span>
                                                    </c:if>
                                                    <c:if test="${lender.productId == 0}">
                                                        <span>未借</span>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="10">暂时没有个人借款用户数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <c:if test="${fn:length(lenders) > 0}">
                                    <tr>
                                        <td colspan="10">
                                            总计:${total}
                                        </td>
                                    </tr>
                                </c:if>
                                <tr>
                                    <td colspan="10"><div id="lender-page"></div></td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /block -->
            </div>
            <!-- content end -->
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script type="text/javascript">
    $('.vertical').css('vertical-align', 'middle');
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;个人借款管理</li>');
        $('[rel="tooltip"]').tooltip();
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
                    $('#search').attr('action','${pageContext.request.contextPath}/client/lender/list/'+page);
                    $('#search').submit();
                }
            };
            $('#lender-page').bootstrapPaginator(options);
        }
    });
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>