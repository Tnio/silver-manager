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
                    <form id="search" action="" method="post" class="form-search">
                        <input type="hidden" id="size" name="size" value="${size}" />
                        <input type="hidden" id="page" name="page" value="${page }" />
                    </form>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>券码号</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(goodsCouponCodes) > 0}">
                                        <c:forEach var="goodsCouponCode" items="${goodsCouponCodes}" varStatus="s">
                                            <tr>
                                                <td>${s.count}</td>
                                                <td>${goodsCouponCode.code}</td>
                                                <td><c:if test="${goodsCouponCode.used == 0}">未使用</c:if><c:if test="${goodsCouponCode.used == 1}">已使用</c:if></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8">暂时还没有券码信息</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="8"><div id="goodsCouponCodes-page"></div></td>
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
    $(document).ready(function(){
        var totalPages = parseInt('${pages}');
        $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">银子商城管理</a>&nbsp;/&nbsp;券码号</li>');
        $('[rel="tooltip"]').tooltip();
        $('.marginTop').css('margin', '2px auto auto auto');
        if(totalPages > 0) {
            var options = {
                currentPage: parseInt('${page}'),
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
                    $('#search').attr('action','${pageContext.request.contextPath}/silver/goods/codes/detail/${goodsId}');
                    $('#page').val(page);
                    $('#search').submit();
                }
            };
            $('#goodsCouponCodes-page').bootstrapPaginator(options);

        }

    });
    function quit(){
        window.location.href='${pageContext.request.contextPath}/silver/goods/list';
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>