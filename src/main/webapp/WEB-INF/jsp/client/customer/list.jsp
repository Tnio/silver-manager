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
            <div class="well" style="height:110px;">
                <form id="search" action="${pageContext.request.contextPath}/client/customer/list/1" method="post">
                    <input type="hidden" id="size" name="size" value="${size}" />
                    <div class="input-group" >
                        <div class="span3" >
                            <span>姓名</span>
                            <input class="horizontal marginTop" id="name" name="name" type="text" value="${name}"/>
                        </div>
                        <div class="span3">
                            <span>手&nbsp;&nbsp;&nbsp;&nbsp;机&nbsp;&nbsp;&nbsp;</span>
                            <input class="horizontal marginTop" id="cellphone" name="cellphone" type="text" value="${cellphone}" />
                        </div>
                        <div class="span3">
                            <span>身&nbsp;&nbsp;份&nbsp;&nbsp;证</span>
                            <input class="horizontal marginTop" id="idcard" name="idcard" type="text" value="${idcard}" />
                        </div>
                        <div class="span3">
	                                   		<span class="span4" style="margin-top: 5px">
	                                   			<span>渠道名称</span>
	                                   		</span>
                            <span class="span6" style="width:145px" >
	                                   			<select id="channelId" name="channelId">
													<option value="-1" >全部</option>
		                                          	<c:forEach items="${channels}" var="cl">
                                                        <option value="${cl.id}" >${cl.name}</option>
                                                    </c:forEach>
												</select>
	                                   		</span>
                        </div>
                    </div>
                    <div class="input-group">
                        <div class="span3">
                            <span>时间</span>
                            <select id="timeType" name="timeType" class="horizontalType marginTop" style="width:160px">
                                <option value="register_time" >注册时间</option>
                                <option value="first_trade_time" >首次交易时间</option>
                            </select>
                        </div>
                        <div class="span3">
                            <span>开始时间</span>
                            <input type="text" id="beginTime" name="beginTime" value="${beginTime}" class="horizontal marginTop" onkeypress="return false"/>
                        </div>
                        <div class="span3">
                            <span>&nbsp;结束时间</span>
                            <input type="text" id="endTime" name="endTime"  value="${endTime}" class="horizontal marginTop" onkeypress="return false"/>
                        </div>
                        <div class="span3">
                             <div class="span4">
                               <span>排&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;序</span>
                             </div>
                             <span class="span6" style="margin-left: 5px" >
                            <div class="span9" >
                              <select id="sort" name="sort" style="width:145px">
                                <option value="" ></option>
                                <option value="total_trade_money">交易总金额</option>
                                <option value="silver_number">银子数量</option>
                                <option value="latest_sign_time">签到时间</option>
                              </select>
                             </div>
                             </span>
                        </div>
                    </div>
                    <div class="input-group">
                        <div class="span12">
                            <div class="span3">
                            <span>交易次数</span>
                            <input class="span3" type="text"  id="startAmount" name="startAmount" value="${startAmount}" class="validate[custom[integer]] text-input  horizontal marginTop"  placeholder="请输入整数"onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="6" onpaste="return !clipboardData.getData('text').match(/\D/)"  ondragenter="return false" style="ime-mode:Disabled"/>
                            <span>至</span>
                            <input  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false" style="ime-mode:Disabled" class="span3" type="text" id="endAmount" name="endAmount"  value="${endAmount}" class="validate[custom[integer]] text-input  horizontal marginTop" maxlength="6" placeholder="请输入整数"/>
                            </div>
                        <div class="span3">
                            <span>VIP等级&nbsp;&nbsp;</span>
                         <select id="vipLevel" name="vipLevel" style="width:165px">
                                <option value="" >全部</option>
                                <option value="0">非会员</option>
                                <option value="1">vip1</option>
                                <option value="2">vip2</option>
                                <option value="3">vip3</option>
                                <option value="4">vip4</option>
                                <option value="5">vip5</option>
                                <option value="6">vip6</option>
                                <option value="7">vip7</option>
                                <option value="8">vip8</option>
                            </select>
                        </div>
                            <div class="span6">
                            <input  type="button" value="查询" class="btn btn-default" onclick="search();" />
                            <input  type="reset" value="重置" class="btn btn-default" onclick="resetData()" />
                            <a href="javascript:exportOrders();" class="authoritySettings" id="170"><button type="button" class="btn buttonHidden">导出EXCEL</button></a>
                            </div>
                        </div>
                        
                    </div>
                   
                </form>
            </div>
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <div id="authorityButton" class="navbar navbar-inner block-header">
                        <a href="javascript:detail()" class="authoritySettings" id="545"><button class="btn btn-lg btn-primary buttonHidden">查看<i class=""></i></button></a>
                        <a href="javascript:setVip()" class="authoritySettings" id="2045"><button class="btn btn-lg btn-primary buttonHidden">设置为高级用户<i class=""></i></button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table id="customers" cellpadding="0" cellspacing="0" border="0" class="div_table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>手机号</th>
                                    <th>vip等级</th>
                                    <th>银子数</th>
                                    <th>交易总金额(元)</th>
                                    <th>待收总金额(元)</th>
                                    <th>最后一次签到</th>
                                    <th><span class="register">注册时间</span><span class="first">首次交易时间</span></th>
                                    <th>渠道名称</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(customers) > 0}">
                                        <c:forEach var ="customer" items="${customers}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="customerId${customer.id}">
                                                <td class="hidden">${customer.id}</td>
                                                <td class="hidden">${customer.isVip}</td>
                                                <td class="shortcss" >${status.count}</td>
                                                <td class="noType">${customer.cellphone}</td>
                                                <td class="longcss">
                                                  <c:if test="${customer.vipLevel eq 0 }" >
                                                    <span>非会员 </span> 
                                                 </c:if>
                                                 <c:if test="${customer.vipLevel ne 0 }" >
                                                    <span>VIP${customer.vipLevel}</span> 
                                                 </c:if>
                                                 </td>
                                                <td class="idcardcss" ><a href="${pageContext.request.contextPath}/silver/${customer.id}/detail/1">${customer.silverNumber}</a></td>
                                                <td class="numbercss" ><fmt:formatNumber value="${customer.totalTradeMoney}" pattern="#,##0" /></td>
                                                <td class="numbercss" ><fmt:formatNumber value="${customer.totalTradeIncome}" pattern="#,##0" /></td>
                                                <td class="longcss">
                                                    <c:if test="${customer.latestSignTime != 'Thu Jan 01 00:00:00 GMT+08:00 1970' and customer.latestSignTime != 'Thu Jan 01 00:00:00 CST 1970'}">
                                                        <fmt:formatDate value="${customer.latestSignTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
                                                    </c:if>
                                                </td>
                                                <td class="longcss">
                                                    <c:if test="${customer.registerTime != 'Thu Jan 01 00:00:00 GMT+08:00 1970' and customer.registerTime != 'Thu Jan 01 00:00:00 CST 1970'}">
                                                        <span class="register"><fmt:formatDate value="${customer.registerTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                                                    </c:if>
                                                    <c:if test="${customer.firstTradeTime != 'Thu Jan 01 00:00:00 GMT+08:00 1970' and customer.firstTradeTime != 'Thu Jan 01 00:00:00 CST 1970'}">
                                                        <span class="first"><fmt:formatDate value="${customer.firstTradeTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                                                    </c:if>
                                                </td>
                                                <td class="idcardcss" ><c:if test="${not empty customer.channel }"> ${customer.channel.name}</c:if></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="10">暂时没有投资客数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <c:if test="${fn:length(customers) > 0}">
                                    <tr>
                                        <td colspan="10">
                                            总计:${total}
                                        </td>
                                    </tr>
                                </c:if>
                                <tr>
                                    <td colspan="10"><div id="customer-page"></div></td>
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
    var rowId = 0;
    var isVip = 1;
    $(document).ready(function(){
        $('#channelId').find('option[value=${channelId}]').attr('selected',true);
        $('#channelId').comboSelect();
        $('.marginTop').css('margin', '2px auto auto auto');
        $('.marginDivTop').css('margin', '10px auto auto auto');
        $('.horizontal').css({width:150});
        $('.horizontalType').css({width:160});
        /* $('.noType').css({width:'40px'}); */
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;用户管理</li>');
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
                    $('#search').attr('action','${pageContext.request.contextPath}/client/customer/list/'+page);
                    $('#search').submit();
                }
            };
            $('#customer-page').bootstrapPaginator(options);
        }
        $('#sort').find("option[value='${sort}']").attr("selected",true);
        $('#timeType').find("option[value='${timeType}']").attr("selected",true);
        $('#vipLevel').find("option[value='${vipLevel}']").attr("selected",true);

        if('${timeType}' == 'first_trade_time'){
            $('.register').hide();
            $('.first').show();
        }else{
            $('.register').show();
            $('.first').hide();
        }

        $('#545').hide();
        $('#2045').hide();
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
                var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
                if(((date.getTime() -beginDate)/(1000*60*60*24) >= 31)){
                    $('#endTime').datetimepicker({
                        format:'Y-m-d',
                        minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
                        //maxDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+2)+'/'+beginDate.getDate(),
                        lang:'ch',
                        scrollInput:false,
                        timepicker:false,
                        onShow:function() {
                            if ($('td').hasClass('xdsoft_other_month')) {
                                $('td').removeClass('xdsoft_other_month');
                            }
                        }
                    });
                }else{
                    $('#endTime').datetimepicker({
                        format:'Y-m-d',
                        minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
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
                var endTime = $('#endTime').val();
                var endDate = new Date(Date.parse(endTime.replace(/-/g,"/")));
                $('#beginTime').datetimepicker({
                    format:'Y-m-d',
                    //minDate:endDate.getFullYear()+'/'+(endDate.getMonth())+'/'+endDate.getDate(),
                    maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
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
        $('#search').validationEngine('attach', {
            promptPosition:'bottomLeft',
            showOneMessage: true,
            focusFirstField:true,
            scroll: false
        });
    });

    function getRow(tr, color) {
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            $('#545').hide();
            $('#2045').hide();
            rowId = 0;
        } else {
            $('#customerId'+rowId).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = tr.getElementsByTagName("td")[0].innerHTML;
            isVip = tr.getElementsByTagName("td")[1].innerHTML;
            if(isVip == 0){
                $('#2045').show();
            }else{
                $('#2045').hide();
            }
            $('#545').show();
        }
    }

    function search() {
        $('#search').attr('action','${pageContext.request.contextPath}/client/customer/list/1');
        $('#search').submit();
    }

    function exportOrders() {
        var count = 50000;
        if($.trim('${total}') > 0){
            if($.trim('${total}') <= count){
                $('#search').attr('action','${pageContext.request.contextPath}/client/customer/export');
                $('#search').submit();
            }else{
                alert('查询结果集超过Excel导出最大限制 '+ count +' 条,请精确查询条件!');
            }
        }else{
            alert('没有查询，或查询结果为空，不用导出!');
        }
    }

    //function getOrders(account) {
    //	$('#search').attr('action','${pageContext.request.contextPath}/client/customer/'+account+'/trade/1');
    //    $('#search').submit();
    //}

    function resetTurnOut(status){
        if (rowId > 0) {
            $.ajax({
                type:'post',
                async: true,
                url: '${pageContext.request.contextPath}/client/customer/reset/'+rowId+'/turnout/bank',
                success: function(data){
                    if(data == 'false'){
                        alert('执行失败,请重试!');
                    }else{
                        alert('操作成功!');
                    }
                }
            });
        } else {
            alert('请选择一条数据!');
        }
    }

    function setVip(){
        if (rowId > 0 && isVip == 0) {
            if(confirm("确认要将此用户设置为高级用户吗?")){
                $.ajax({
                    type:'post',
                    async: true,
                    url: '${pageContext.request.contextPath}/client/customer/set/vip/'+rowId,
                    success: function(data){
                        if(data == 'false'){
                            alert('执行失败,请重试!');
                        }else{
                            $('#search').submit();
                        }
                    }
                });
            }

        } else {
            alert('请选择一条数据!');
        }
    }

    function detail(){
    	$('#vipLevelId').val('');
    	
    	
    	
        if (rowId != '') {
            $('#search').attr('action','${pageContext.request.contextPath}/client/user/detail/'+rowId);
            $('#search').attr('method','get');
            $('#search').submit();

        } else {
            alert('请先选择要查看的数据!');
        }
    }

    function resetData() {
        $('#name').val('');
        $('#cellphone').val('');
        $('#idcard').val('');
        $('#beginTime').val('');
        $('#endTime').val('');
        $('#startAmount').val('');
        $('#endAmount').val('');
        $('#timeType').val('');
        $('#sort').val('');
        $('#channelId').val('');
        $('#vipLevelId').val('');
        $('#vipLevel').val('');
        $('#search').attr('action','${pageContext.request.contextPath}/client/customer/list/1');
        $('#search').submit();
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>