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
            <div class="well" style="height:70px">
                <form id="search" onsubmit="return validate();" action="${pageContext.request.contextPath}/client/user/list/1" method="post" >
                    <input type="hidden" id="size" name="size" value="${size}" />
                    <div class="input-group">
                        <div class="input-group">
                            <span>手机号</span>
                            <input type="text" id="name" name="name" value="${name}" class="marginTop span2"  style="width: 180px"/>
                            <span>&nbsp;&nbsp;渠道来源</span>
                            <select class="marginTop" id="areaNO" name="areaNO" style="width: 163px">
                                <option value="">全部</option>
                                <c:choose>
                                    <c:when test="${fn:length(channels) > 0}">
                                        <c:forEach var="channel" items="${channels}" varStatus="status">
                                            <option value="${channel.id}">${channel.name}</option>
                                        </c:forEach>
                                    </c:when>
                                </c:choose>
                            </select>
                            <span>&nbsp;&nbsp;交易次数&nbsp;</span><input type="text" id="firstTrades" name="firstTrades" value="${firstTrades}" class="marginTop span1" style="width:45px" /> - <input type="text" id="lastTrades" name="lastTrades" value="${lastTrades}" class="marginTop span1" style="width:45px"/>
                        </div>
                        <div class="input-group marginDivTop" >
                            <select id="timeType" name="timeType" class="span2 marginTop" style="width: 226px">
                                <option value="register_time" >注册时间</option>
                                <option value="first_trade_time" >首次交易时间</option>
                                <option value="latest_trade_time" >最后交易时间</option>
                                <option value="login_time" >最后登录时间</option>
                            </select>
                            <span>&nbsp;&nbsp;选择时间</span> <input type="text" id="beginTime" name="beginTime" value="${beginTime}" class="marginTop span2" onkeypress="return false" style="background: white; width:163px" readOnly/> - <input type="text" id="endTime" name="endTime"  value="${endTime}" class="marginTop span2" onkeypress="return false" style="background: white; width:163px"  readOnly/>
                            <span>&nbsp;&nbsp;排序</span>
                            <select id="sort" name="sort" class="span2 marginTop">
                                <option value="" >默认</option>
                                <option value="silver_number" >按银子从大到小</option>
                                <option value="total_trade_amount" >按交易次数从大到小</option>
                                <option value="total_trade_money" >按投资总金额从大到小</option>
                                <option value="total_trade_income" >按收益总金额从大到小</option>
                            </select>
                            <input type="submit" class="btn btn-default span1" value="查询"/>
                            <input type="reset" value="重置" onclick="resetData()" class="btn btn-default" />
                        </div>
                    </div>
                </form>
            </div>
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <a href="javascript:detail()" id="271"><button class="btn btn-lg btn-primary">查看<i class=""></i></button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table id="users" cellpadding="0" cellspacing="0" border="0" class="table" >
                                <thead>
                                <tr>
                                    <th class="center">序号</th>
                                    <th class="center">手机号</th>
                                    <th class="center">真实姓名</th>
                                    <th class="center">当前银子</th>
                                    <th class="center">注册渠道</th>
                                    <th class="center">交易次数</th>
                                    <th class="center">交易总金额（元）</th>
                                    <th class="center">收益总金额（元）</th>
                                    <th class="center">
                                        <c:if test="${timeType=='register_time' || timeType==''}">注册时间</c:if>
                                        <c:if test="${timeType=='first_trade_time'}">首次交易时间</c:if>
                                        <c:if test="${timeType=='latest_trade_time'}">最后交易时间</c:if>
                                        <c:if test="${timeType=='login_time'}">最后登录时间</c:if>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(users) > 0}">
                                        <c:forEach var ="user" items="${users}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="${user.id}">
                                                <td class="hidden">${user.id}</td>
                                                <td>${status.count}</td>
                                                <td><c:if test="${!empty user.cellphone}">${fn:substring(user.cellphone, 0, 3)}****${fn:substring(user.cellphone, fn:length(user.cellphone) - 4, fn:length(user.cellphone))}</c:if></td>
                                                <td>${user.name}</td>
                                                <td>${user.silverNumber}</td>
                                                <td>
                                                        ${user.channel.name}
                                                </td>
                                                <td><fmt:formatNumber value="${user.totalTradeAmount}" pattern="#,##0"/></td>
                                                <td><fmt:formatNumber value="${user.totalTradeMoney}" pattern="#,##0"/></td>
                                                <td><fmt:formatNumber value="${user.totalTradeIncome}" pattern="#,##0.00"/></td>
                                                <td>
                                                    <c:if test="${timeType=='register_time' || timeType==''}"><fmt:formatDate value="${user.registerTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                                                    <c:if test="${timeType=='first_trade_time'}"><fmt:formatDate value="${user.firstTradeTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                                                    <c:if test="${timeType=='latest_trade_time'}"><fmt:formatDate value="${user.latestTradeTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                                                    <c:if test="${timeType=='login_time'}"><fmt:formatDate value="${user.loginTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="9">暂时没有用户数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <c:if test="${fn:length(users) > 0}">
                                    <tr>
                                        <td colspan="9">
                                            总计:${total}
                                        </td>
                                    </tr>
                                </c:if>
                                <tr>
                                    <td colspan="9"><div id="user-page"></div></td>
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
    $('#areaNO').find('option[value=${areaNO}]').attr('selected',true);
    $('#sort').find('option[value=${sort}]').attr('selected',true);
    $('#timeType').find('option[value=${timeType}]').attr('selected',true);
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.marginTop').css('margin', '2px auto auto auto');
        $('.marginDivTop').css('margin', '10px auto auto auto');
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;注册用户管理</li>');
        $('[rel="tooltip"]').tooltip();
        var date = new Date();
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
                    $('#search').attr('action','${pageContext.request.contextPath}/client/user/list/'+page);
                    $('#search').submit();
                }
            };
            $('#user-page').bootstrapPaginator(options);
        }
        $('#sort').find('option[value="${sort}"]').attr('selected',true);
        $('.horizontal').css({width:80,align:'center'});
        $('.shortcss').css({width:20,align:'center'});
        $('.numbercss').css({width:40,align:'center'});
        $('.phonecss').css({width:40,align:'center'});
        $('.longnumber').css({width:80,align:'center'});

        $('#beginTime').datetimepicker({
            format:'Y-m-d',
            maxDate:new Date().toLocaleDateString(),
            lang:'ch',
            timepicker:false,
            scrollInput:false,
            onShow:function() {
                if ($('td').hasClass('xdsoft_other_month')) {
                    $('td').removeClass('xdsoft_other_month');
                }
            },
            onSelectDate:function() {
                var beginTime = $('#beginTime').val();
                beginTime = new Date(Date.parse(beginTime.replace(/-/g,"/")));
                $('#endTime').datetimepicker({
                    format:'Y-m-d',
                    maxDate:new Date().toLocaleDateString(),
                    minDate:beginTime.getFullYear()+'/'+(beginTime.getMonth()+1)+'/'+beginTime.getDate(),
                    lang:'ch',
                    timepicker:false,
                    scrollInput:false
                });
            }
        });

        $('#endTime').datetimepicker({
            format:'Y-m-d',
            maxDate:new Date().toLocaleDateString(),
            lang:'ch',
            timepicker:false,
            scrollInput:false,
            onShow:function() {
                if ($('td').hasClass('xdsoft_other_month')) {
                    $('td').removeClass('xdsoft_other_month');
                }
            },
            onSelectDate:function() {
                var beginTime = $('#beginTime').val();
                beginTime = new Date(Date.parse(beginTime.replace(/-/g,"/")));
                $('#endTime').datetimepicker({
                    format:'Y-m-d',
                    maxDate:new Date().toLocaleDateString(),
                    minDate:beginTime.getFullYear()+'/'+(beginTime.getMonth()+1)+'/'+beginTime.getDate(),
                    lang:'ch',
                    timepicker:false,
                    scrollInput:false,
                    onShow:function() {
                        if ($('td').hasClass('xdsoft_other_month')) {
                            $('td').removeClass('xdsoft_other_month');
                        }
                    }
                });
            }
        });
    });



    function resetData() {
        $('#beginTime').val('');
        $('#endTime').val('');
        $('#name').val('');
        $('#areaNO').val('');
        $('#firstTrades').val('');
        $('#lastTrades').val('');
        $('#sort').val('');
        $('#timeType').val('');
        $('#search').attr('action','${pageContext.request.contextPath}/client/user/list/1');
        $('#search').submit();
    }

    function validate() {
        if ($('#beginTime').val() || $('#endTime').val()) {
            if (!$('#beginTime').val()) {
                $('#beginTime').val('2015-07-01');
            }
            if (!$('#endTime').val()) {
                $('#endTime').val(new Date().toLocaleDateString().replace('/', '-').replace('/', '-'));
            }
        }
        return true;
    }

    $('#271').hide();
    var row = '';
    function getRow(tr, color) {
        if (row == tr.getElementsByTagName('td')[0].innerHTML) {
            $('#271').hide();
            $(tr).css('background-color', 'white');
            row = '';
        } else {
            $('#271').show();
            $('#'+row).css('background-color', 'white');
            $(tr).css('background-color', color);
            row = tr.getElementsByTagName('td')[0].innerHTML;
        }
    }

    function detail(){
        if (row != '') {
            window.location.href='${pageContext.request.contextPath}/client/user/detail/'+row;
        } else {
            alert('请先选择要查看的数据!');
        }
    }
</script>
</html>