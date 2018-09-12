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
                    <form id="search" action="${pageContext.request.contextPath}/silver/give/user/detail/${dispatchingBonusLogId}" method="post">
                        <input type="hidden" id="page" name="page" value="${page}" />
                        <input type="hidden" id="size" name="size" value="${size}" />
                        <div class="navbar navbar-inner block-header">
                            <div style="margin:2px auto auto auto">
                                <span>手机号</span>
                                <input type="text" id="cellphone" name="cellphone" style="background:white;width:120px;margin-top: 1px" value="${cellphone}"/>
                                <span>选择时间</span>
                                <input type="text" id="beginTime" name="beginDate" style="background:white;width:120px;margin-top: 1px" value="${beginDate}" onkeypress="return false"/>
                                <span>-</span>
                                <input type="text" id="endTime" name="endDate" style="background:white;width:120px;margin-top: 1px" value="${endDate}"  onkeypress="return false"/>
                                &nbsp;
                                <input type="submit" value="查询" style="margin-top: -10px" class="btn btn-default" />
                            </div>
                        </div>
                    </form>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>手机号</th>
                                    <th>银子数</th>
                                    <th>赠送时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(dispatchingLogs) > 0}">
                                        <c:forEach var="dispatchingLog" items="${dispatchingLogs}" varStatus="s">
                                            <tr>
                                                <td>${s.count}</td>
                                                <td>${dispatchingLog.cellphone}</td>
                                                <td>${dispatchingLog.dispatchingBonusLog.quantity}</td>
                                                <td><fmt:formatDate value="${dispatchingLog.dispatchingDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5">暂时还没有银子赠送信息</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="5"><div id="dispatchingLog-page"></div></td>
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
        $('.breadcrumb').html('<li class="active">银子管理&nbsp;/&nbsp;<a href="javascript:quit();">银子赠送管理</a>&nbsp;/&nbsp;赠送明细</li>');
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
                    $('#search').attr('action','${pageContext.request.contextPath}/silver/give/user/detail/${dispatchingBonusLogId}');
                    $('#page').val(page);
                    $('#search').submit();
                }
            };
            $('#dispatchingLog-page').bootstrapPaginator(options);

        }

        $('#beginTime').datetimepicker({
            format:'Y-m-d',
            //minDate:beforeDate.getFullYear()+'/'+(beforeDate.getMonth()+1)+'/'+beforeDate.getDate(),
            maxDate:new Date().toLocaleDateString(),
            lang:'ch',
            scrollInput:false,
            timepicker:false,
            onShow:function() {
                if ($('td').hasClass('xdsoft_other_month')) {
                    $('td').removeClass('xdsoft_other_month');
                }
            },
            onSelectDate:function() {
                var beginTime = $('#beginTime').val();
                var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
                var afterDate = new Date();
                afterDate.setTime(beginDate.getTime()+1000*60*60*24*6);
                $('#endTime').datetimepicker({
                    format:'Y-m-d',
                    minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
                    //maxDate:afterDate.getFullYear()+'/'+(afterDate.getMonth()+1)+'/'+afterDate.getDate(),
                    maxDate:new Date().toLocaleDateString(),
                    lang:'ch',
                    scrollInput:false,
                    timepicker:false,
                    onShow:function() {
                        if ($('td').hasClass('xdsoft_other_month')) {
                            $('td').removeClass('xdsoft_other_month');
                        }
                    }
                });
            }
        });

        $('#endTime').datetimepicker({
            format:'Y-m-d',
            maxDate:new Date().toLocaleDateString(),
            lang:'ch',
            scrollInput:false,
            timepicker:false,
            onShow:function() {
                if ($('td').hasClass('xdsoft_other_month')) {
                    $('td').removeClass('xdsoft_other_month');
                }
            },
            onSelectDate:function() {
                var endTime = $('#endTime').val();
                var endDate = new Date(Date.parse(endTime.replace(/-/g,"/")));
                beforeDate.setTime(endDate.getTime()-1000*60*60*24*6);
                $('#beginTime').datetimepicker({
                    format:'Y-m-d',
                    //minDate:beforeDate.getFullYear()+'/'+(beforeDate.getMonth()+1)+'/'+beforeDate.getDate(),
                    maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
                    lang:'ch',
                    scrollInput:false,
                    timepicker:false,
                    onShow:function() {
                        if ($('td').hasClass('xdsoft_other_month')) {
                            $('td').removeClass('xdsoft_other_month');
                        }
                    }
                });
            }
        });

    });
    function quit(){
        window.location.href='${pageContext.request.contextPath}/silver/give/list';
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>