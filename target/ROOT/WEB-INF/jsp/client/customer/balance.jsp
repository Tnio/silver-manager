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
                            <form id="search" action="${pageContext.request.contextPath}/client/customer/${userId}/balance/1" method="post" >
                                <div style="margin-top: 2px">
                                    <span>选择类型</span>
                                    <select id="type" name="type">
                                        <option value="0" >全部</option>
                                        <c:forEach items="${types}" var="cl">
                                            <c:choose>
                                                <c:when test="${cl.key == type}">
                                                    <option value="${cl.key}" selected="selected">${cl.value}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${cl.key}" >${cl.value}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                    <input type="submit" value="查询" style="margin-top: -10px" class="btn btn-default" />
                                    <a href="javascript:back();"><button type="button" class="btn" style="margin-top: -10px">返回</button></a>
                                </div>
                                <table id="balances" cellpadding="0" cellspacing="0" border="0" class="table" >
                                    <thead>
                                    <tr>
                                        <th class="center">序号</th>
                                        <th class="center">交易时间</th>
                                        <th class="center">类型</th>
                                        <th class="center">涉及金额</th>
                                        <th class="center">渠道</th>
                                        <th class="center">当前账户余额</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${fn:length(balances) > 0}">
                                            <c:forEach var ="balance" items="${balances}" varStatus="status">
                                                <tr>
                                                    <td class="hidden">${balance.id}</td>
                                                    <td>${status.count}</td>
                                                    <td><fmt:formatDate value="${balance.tradeTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                    <td>
                                                        <c:forEach items="${types}" var="so">
                                                            <c:choose>
                                                                <c:when test="${so.key == balance.type}">
                                                                    ${so.value}
                                                                </c:when>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </td>
                                                    <td><fmt:formatNumber value="${balance.amount}" pattern="##0.00"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${balance.channel == 2}">
                                                                IOS
                                                            </c:when>
                                                            <c:when test="${balance.channel == 3}">
                                                                ANDROID
                                                            </c:when>
                                                            <c:when test="${balance.channel == 4}">
                                                                WAP
                                                            </c:when>
                                                            <c:otherwise>
                                                                web
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td><fmt:formatNumber value="${balance.balance}" pattern="##0.##"/></td>
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
                                        <td colspan="9"><div id="balance-page"></div></td>
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
                    $('#search').attr('action','${pageContext.request.contextPath}/client/customer/${userId}/balance/'+page);
                    $('#search').submit();
                }
            };
            $('#balance-page').bootstrapPaginator(options);
        }
    });

    function back(){
        $('#search').attr('action','${pageContext.request.contextPath}/client/user/detail/${userId}');
        $('#search').attr('method','get');
        $('#search').submit();
    }
</script>
</html>