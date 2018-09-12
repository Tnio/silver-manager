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
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form id="search" action="${pageContext.request.contextPath}/client/customer/${userId}/frozen/1" method="post" >
                                <table id="frozens" cellpadding="0" cellspacing="0" border="0" class="table" >
                                    <thead>
                                    <tr>
                                        <th class="center">序号</th>
                                        <th class="center">交易时间</th>
                                        <th class="center">订单号</th>
                                        <th class="center">类型</th>
                                        <th class="center">产品</th>
                                        <th class="center">交易金额</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${fn:length(frozens) > 0}">
                                            <c:forEach var ="frozen" items="${frozens}" varStatus="status">
                                                <tr>
                                                    <td class="hidden">${frozen.orderNO}</td>
                                                    <td>${status.count}</td>
                                                    <td><fmt:formatDate value="${frozen.orderTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                    <td>${frozen.orderNO}</td>
                                                    <td>购买</td>
                                                    <td>${frozen.product.name}</td>
                                                    <td>${frozen.principal}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6">暂时没有余额数据</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <td colspan="9"><div id="frozen-page"></div></td>
                                    </tr>
                                    </tfoot>
                                </table>
                            </form>
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
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.marginTop').css('margin', '2px auto auto auto');
        $('.marginDivTop').css('margin', '10px auto auto auto');
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;<a href="${pageContext.request.contextPath}/client/customer/list/1">用户管理</a>&nbsp;/&nbsp;账户余额</li>');
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
                    $('#search').attr('action','${pageContext.request.contextPath}/client/customer/${userId}/frozen/'+page);
                    $('#search').submit();
                }
            };
            $('#frozen-page').bootstrapPaginator(options);
        }
    });
</script>
</html>