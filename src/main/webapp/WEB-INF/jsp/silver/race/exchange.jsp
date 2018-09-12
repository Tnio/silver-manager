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
                    <div  class="well" style="height:30px;">
                        <form id="search" action="" method="post" class="form-search">
                            <input type="hidden" id="id" name="id">
                            <input type="hidden" id="size" name="size" value="${size}" />
                            <input type="hidden" id="page" name="page" value="${page}" />
                            <div style="margin-left: 10px">
                                <span>手机号</span>
                                <input class="horizontal marginTop" style="width:120px;" type="text" id="cellphone" name="cellphone" value="${cellphone}" class="span3" />
                                <input type="submit" class="btn btn-lg" value="查询" onclick="seach()" class="marginTop span1" />
                                <a type="reset" class="btn btn-default" href="javascript:quit()"><i></i>返回</a>
                            </div>
                        </form>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>手机号</th>
                                    <th>商品名称</th>
                                    <th>参与号码</th>
                                    <th>参与时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(raceLogs) > 0}">
                                        <c:forEach var="raceLog" items="${raceLogs}" varStatus="s">
                                            <tr>
                                                <td>${s.count}</td>
                                                <td>${raceLog.cellphone}</td>
                                                <td>${raceLog.goods.name}</td>
                                                <td>${raceLog.joinCode}<c:if test="${raceLog.winning == 1}"><span style="background-color:#06823b;border-radius:2px;color:white;">中奖</span></c:if></td>
                                                <td><fmt:formatDate value="${raceLog.createTime}" type="both" pattern="yyyy-MM-dd HH:mm" /></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8">暂时还没有夺宝记录</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="8"><div id="raceLog-page"></div></td>
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
        var beforeDate = new Date();
        beforeDate.setTime(beforeDate.getTime()-1000*60*60*24*6);
        var totalPages = parseInt('${pages}');
        $('.breadcrumb').html('<li class="active">银子管理 &nbsp;/&nbsp;<a href="javascript:quit();">0元夺宝</a>&nbsp;/&nbsp;夺宝记录</li>');
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
                    $('#search').attr('action','${pageContext.request.contextPath}/silver/race/exchange/record/${goodsId}');
                    $('#page').val(page);
                    $('#search').submit();
                }
            };
            $('#raceLog-page').bootstrapPaginator(options);

        }

    });

    function seach() {
        $('#search').attr('action','${pageContext.request.contextPath}/silver/race/exchange/record/${goodsId}');
        $('#search').submit();
    }

    function quit(){
        window.location.href='${pageContext.request.contextPath}/silver/race/list';
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>