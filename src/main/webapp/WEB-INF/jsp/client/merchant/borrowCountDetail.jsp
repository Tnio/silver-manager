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
                    <!-- <div class="navbar navbar-inner block-header">
                        <a href="javascript:quit();"><button type="button" class="btn">返回</button></a>
                       </div> -->
                    <div class="well">
                        <form id="search" action='${pageContext.request.contextPath}/client/merchant/borrowCountDetail/1' method="post">
                            <input type="hidden"  name="idcard" value="${idcard}" />
                            <input type="hidden"  name="type" value="${type}" />
                            <div class="input-group">
                                <span>借款状态</span>
                                <select  name="status" style="position:relative; top:5px;" id="selectStatus" >
                                    <option value="8" <c:if test="${status == 8 }">selected</c:if>>全部</option>
                                    <option value="1" <c:if test="${status == 1 }">selected</c:if>>已借</option>
                                    <option value="2" <c:if test="${status == 2 }">selected</c:if>>已还</option>
                                </select>&nbsp;&nbsp;
                                <input type="submit" value="查询"  class="btn btn-default" />
                            </div>
                        </form>
                    </div>
                    <div class="block-content collapse in">
                        <table class="table" id="merchantLoan">
                            <thead>
                            <tr>
                                <th class="center">序号</th>
                                <th class="center">借款人姓名</th>
                                <th class="center">手机号</th>
                                <th class="center">借款金额(元)</th>
                                <th class="center">借款期限(天)</th>
                                <th class="center">借款状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${fn:length(Lender) > 0}">
                                    <c:forEach var="p" items="${Lender}" varStatus="status">
                                        <tr>
                                            <td class="hidden">${order.id}</td>
                                            <td>${status.count}</td>
                                            <td>${p.name}</td>
                                            <td>${p.cellphone}</td>
                                            <td><fmt:formatNumber value="${p.loanAmount}" pattern="#,##0" /></td>
                                            <td>${p.loanPeriod}</td>
                                            <td>
                                                <c:if test="${p.status == 1}">已借</c:if>
                                                <c:if test="${p.status == 2}">已还</c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="12">暂时还没有借款信息</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="10">总数:<fmt:formatNumber value="${total}" pattern="#,##0" />人
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;待还本金:<fmt:formatNumber value="${totalMoney}" pattern="#,##0" />元
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8"><div id="merchant-page"></div></td>
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
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<script src="${pageContext.request.contextPath}/js/json.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;<a href="javascript:quit();">借款人管理</a>&nbsp;/&nbsp;借款明细</li>');
        $('.waring-borrow').css('background-color', '#46A3FF');
        $('.serious-borrow').css('background-color', '#FFFF37');
        $('.danger-borrow').css('background-color', '#FF5151');
        var totalPages = '${pages}';
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
                    $('#search').attr('action','${pageContext.request.contextPath}/client/merchant/borrowCountDetail/'+page);
                    $('#search').submit();
                }
            };
            $('#merchant-page').bootstrapPaginator(options);
        }
    });

    function quit() {
        window.location.href='${pageContext.request.contextPath}/client/merchant/list/1';
    }
</script>
</body>
</html>