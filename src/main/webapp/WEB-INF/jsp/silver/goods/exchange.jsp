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
                            <input type="hidden" id="achieveAmount" name="achieveAmount" value="${achieveAmount}" />

                            <div style="margin-left: 10px">
                                <span>商品名称</span>
                                <input class="horizontal marginTop" style="width:100px;" type="text" id="goodsName" name="goodsName" value="${goodsName}" class="span3" />
                                <span>手机号</span>
                                <input class="horizontal marginTop" style="width:100px;" type="text" id="cellphone" name="cellphone" value="${cellphone}" class="span3" />
                                <span>选择时间</span>
                                <input type="text" id="beginTime" name="beginDate" style="background:white;width:100px;" value="${beginDate}" class="horizontal marginTop" onkeypress="return false"/>
                                <span>-</span>
                                <input type="text" id="endTime" name="endDate" style="background:white;width:100px;" value="${endDate}" class="horizontal marginTop" onkeypress="return false"/>
                                <span>商品类型</span>
                                <select id="type" name="type" class="span1" style="width: 100px;">
                                    <option></option>
                                    <%-- <option value="0" <c:if test="${type == 0}"> selected </c:if> >所有<option> --%>
                                    <option value="1" <c:if test="${type == 1}"> selected </c:if> >虚拟商品</option>
                                    <option value="2" <c:if test="${type == 2}"> selected </c:if> >实物商品</option>
                                    <option value="3" <c:if test="${type == 3}"> selected </c:if> >第三方券码</option>
                                </select>&nbsp;
                                <input type="submit" class="btn btn-lg" value="查询" onclick="seach()" class="marginTop span1" />
                                <a type="reset" class="btn btn-default" href="javascript:quit()"><i></i>返回</a>
                            </div>
                        </form>
                        <div id="authorityButton" style="margin-top:-50px;margin-left:950px;">
                            <a id="206" href="javascript:exportData()"><button class="btn btn-lg btn-primary">导出Excel</button></a>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>手机号</th>
                                    <th>商品名称</th>
                                    <th>消耗银子（两）</th>
                                    <th>兑换码</th>
                                    <th>收货人</th>
                                    <th>收货人手机号</th>
                                    <th>地址</th>
                                    <th>兑换时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(convertibilitys) > 0}">
                                        <c:forEach var="convertibility" items="${convertibilitys}" varStatus="s">
                                            <tr>
                                                <td class="hidden">${convertibility.orderNo}</td>
                                                <td class="hidden">${convertibility.status}</td>
                                                <td>${s.count}</td>
                                                <td>${convertibility.customer.cellphone}</td>
                                                <td>${convertibility.goods.name}</td>
                                                <td>${convertibility.goods.consumeSilver}</td>
                                                <td>${convertibility.thirdpartyNo}</td>
                                                <td>${convertibility.name}</td>
                                                <td>${convertibility.cellphone}</td>
                                                <td style="width: 30%;">${convertibility.address}</td>
                                                <td><fmt:formatDate value="${convertibility.exchangeTime}" type="both" pattern="yyyy-MM-dd HH:mm" /></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="7">暂时还没有兑换信息</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="7"><div id="convertibility-page"></div></td>
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
    var orderNo = '';
    var status = '';

    function exportData() {
        var count = 50000;
        if($.trim('${total}') > 0){
            if($.trim('${total}') <= count){
                $('#search').attr('action','${pageContext.request.contextPath}/silver/goods/exchange/export');
                $('#search').submit();
            }else{
                alert('查询结果集超过Excel导出最大限制 '+ count +' 条,请精确查询条件!');
            }
        }else{
            alert('没有查询，或查询结果为空，不用导出!');
        }
    }
    $(document).ready(function(){
        var beforeDate = new Date();
        beforeDate.setTime(beforeDate.getTime()-1000*60*60*24*6);
        var totalPages = parseInt('${pages}');
        $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">银子商城管理</a>&nbsp;/&nbsp;兑换明细</li>');
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
                    $('#search').attr('action','${pageContext.request.contextPath}/silver/goods/exchange/record/${goodsId}');
                    $('#page').val(page);
                    $('#search').submit();
                }
            };
            $('#convertibility-page').bootstrapPaginator(options);
            $('#showModel').hide();
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

    function seach() {
        $('#search').attr('action','${pageContext.request.contextPath}/silver/goods/exchange/record/${goodsId}');
        $('#search').submit();
    }

    function getRow(tr, color) {
        if (orderNo == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            $('#end').hide();
            $('#using').hide();
            orderNo = '';
            $('#showModel').hide();
        } else {
            $('#goodId'+orderNo).css('background-color', 'white');
            $(tr).css('background-color', color);
            orderNo = tr.getElementsByTagName('td')[0].innerHTML;
            if(1 == tr.getElementsByTagName('td')[1].innerHTML){
                $('#showModel').hide();
            } else {
                $('#showModel').show();
            }
        }

    }

    function quit(){
        $('#search').attr('action','${pageContext.request.contextPath}/silver/goods/list');
        $('#search').validationEngine('attach', {
            binded : false
        });
        $('#search').attr('onsubmit','true');
        $('#search').submit();
        //window.location.href='${pageContext.request.contextPath}/silver/goods/list';
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>