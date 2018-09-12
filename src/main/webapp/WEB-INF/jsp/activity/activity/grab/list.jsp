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
                <form id="search" action="${pageContext.request.contextPath}/activity/grab/list/1" method="post" class="form-search">
                    <input type="hidden" id="size" name="size" value="${size}" />
                </form>
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div id="authorityButton" class="navbar navbar-inner block-header" style="border-top: none;">
                        <a href="javascript:add();" id="546"><button type="button" class="btn btn-success">新增 </button></a>
                        <a href="javascript:detail()" id="547"><button type="button" class="btn btn-lg btn-primary" >查看</button></a>
                        <a href="javascript:edit();" id="548"><button type="button" class="btn btn-primary">编辑 </button></a>
                        <a href="javascript:audit();" id="549"><button type="button" class="btn btn-primary">审核</button></a>
                        <a href="javascript:record();" id="550"><button type="button" class="btn btn-primary">查看明细</button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>活动名称</th>
                                    <th>红包金额(元)</th>
                                    <th>红包数量(个)</th>
                                    <th>开始时间</th>
                                    <th>审核状态</th>
                                    <th>活动状态</th>
                                </tr>
                                </thead>
                                <tbody class="activitySortable">
                                <c:choose>
                                    <c:when test="${fn:length(couponActivities) > 0}">
                                        <c:forEach var="couponActivity" items="${couponActivities}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="couponActivity${couponActivity.id}">
                                                <td class="hidden">${couponActivity.id}</td>
                                                <td class="hidden">${couponActivity.status}</td>
                                                <td>${status.count}</td>
                                                <td>${couponActivity.name}</td>
                                                <td style="width:40%">
                                                    <c:choose>
                                                        <c:when test="${fn:length(fn:split(couponActivity.couponAmounts,',')) > 0}">
                                                            <c:forEach var="coupons" items="${fn:split(couponActivity.couponAmounts,',')}" varStatus="statuss">
                                                                <c:forEach var="couponId" items="${fn:split(couponActivity.couponIds,',')}" varStatus="statuses">
                                                                    <c:if test="${statuss.index == statuses.index}">
                                                                        <a href="javascript:showDialog(${couponId});"><span class="label btn-danger" style="height:22px;width:75px;margin-top: 1px;padding-top: 8px" >${coupons}元</span></a>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:forEach>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${couponActivity.quantity}</td>
                                                <td>${couponActivity.beginTime}</td>
                                                <td>
                                                    <c:if test="${couponActivity.status == 0}">未审核</c:if>
                                                    <c:if test="${couponActivity.status == 1 or couponActivity.status > 2}">审核通过</c:if>
                                                    <c:if test="${couponActivity.status == 2}">审核不通过</c:if>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${couponActivity.status == 3}">
                                                            未开始
                                                        </c:when>
                                                        <c:when test="${couponActivity.status == 4}">
                                                            进行中
                                                        </c:when>
                                                        <c:when test="${couponActivity.status == 5}">
                                                            已结束
                                                        </c:when>
                                                        <c:otherwise>
                                                            --
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8">暂时还没有抢红包活动信息</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="8"><div id="couponActivity-page"></div></td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                    <div class="modal hide fade" id="authorizationDiv" role="dialog" style="margin-top: 200px">
                        <form id="fmg" class="modal-content form-horizontal password-modal" >
                            <input type="hidden" id="id" name="id">
                            <input type="hidden" id="customer" name="customer" value="${sessionsilverfoxkey.admin.id}">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">审核意见</h4>
                            </div>
                            <div class="modal-body">
                                请确认审核结果！
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" onclick="setStatus(1)">通过</button>
                                    <button type="button" class="btn btn-default" onclick="setStatus(2)">不通过</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal hide fade" id="couponDialog" role="dialog" >
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h4 class="modal-title" id="myModalLabel"></h4>
                                </div>
                                <div class="modal-body">
                                    <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
                                        <!-- <thead>
                                            <tr id="head">
                                            </tr>
                                       </thead> -->
                                        <tbody id="couponBody">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
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
    var rowId = 0;
    var status = '';
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;抢红包活动</li>');
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
                    $('#search').attr('action','${pageContext.request.contextPath}/activity/grab/list/'+page);
                    $('#search').submit();
                }
            };
            $('#couponActivity-page').bootstrapPaginator(options);
        }
    });

    $('#547').hide();
    $('#548').hide();
    $('#549').hide();
    $('#550').hide();
    function getRow(tr, color) {
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
            $('#547').hide();
            $('#548').hide();
            $('#549').hide();
            $('#550').hide();
        } else {
            $('#couponActivity'+rowId).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = tr.getElementsByTagName('td')[0].innerHTML;
            status = tr.getElementsByTagName('td')[1].innerHTML;
            $('#547').show();
            if(status == 0){
                $('#548').show();
                $('#549').show();
                $('#550').hide();
            }else if(status == 2){
                $('#548').show();
                $('#549').hide();
                $('#550').hide();
            }else{
                $('#548').hide();
                $('#549').hide();
                $('#550').show();
            }
        }
    }

    function showDialog(couponId){
        $('#couponDialog').modal('show');
        getCoupon(couponId);
    }

    function add(){
        window.location.href= '${pageContext.request.contextPath}/activity/grab/add/${page}/${size}';
    }

    function edit() {
        if (rowId > 0) {
            window.location.href= '${pageContext.request.contextPath}/activity/grab/edit/'+rowId+'/${page}/${size}';
        } else {
            alert('请先选择您想编辑的行!');
        }
    }

    function record(){
        if(rowId > 0){
            window.location.href='${pageContext.request.contextPath}/coupon/grab/record/'+rowId;
        }else{
            alert('请先选择一条记录！');
        }
    }

    function detail() {
        if (rowId > 0) {
            window.location.href='${pageContext.request.contextPath}/activity/grab/detail/'+rowId+'/${page}/${size}';
        } else {
            alert('请先选择要查看的数据!');
        }
    }

    function audit(){
        if(rowId > 0){
            $('#authorizationDiv').modal('show');
        }else{
            alert('请先选择一条记录!');
        }
    }

    function setStatus(status){
        var flog = 0;
        if(status == 1){
            $.ajax({
                type : 'post',
                url : '${pageContext.request.contextPath}/activity/grab/validate/time/'+rowId,
                async : false,
                success : function(result){
                    if(!result){
                        flog = 1;
                        $('#authorizationDiv').modal('hide');
                        alert('活动时间段不能与审核通过的活动时间段重叠!');
                    }
                }
            });
        }
        if(flog == 0){
            $.post('${pageContext.request.contextPath}/activity/grab/audit/'+rowId+'/'+status, function(res){
                if(!res){
                    alert('审核失败!');
                }else{
                    $('#search').attr('action','${pageContext.request.contextPath}/activity/grab/list/${page}');
                    $('#search').submit();
                }
            })
        }
    }

    function getCoupon(couponId){
        $('#head').html("");
        $.get('${pageContext.request.contextPath}/coupon/coupon/detail',{couponId:couponId} , function(result){
            if (result != null) {
                $('#myModalLabel').empty().html('优惠券信息');
                $('#couponBody').html("");
                $('#couponBody').append('<tr>');
                $('#couponBody').append('<td width="80">使用条件</td>');
                $('#couponBody').append('<td>'+result.condition+'</td>');
                $('#couponBody').append('</tr>');
                $('#couponBody').append('<tr>');
                $('#couponBody').append('<td>红包类型</td>');
                if(result.category == 0){
                    $('#couponBody').append('<td>'+'固定红包'+'</td>');
                }
                if(result.category == 1){
                    $('#couponBody').append('<td>'+'概率红包'+'</td>');
                }
                $('#couponBody').append('</tr>');
                $('#couponBody').append('<tr>');
                $('#couponBody').append('<td>红包金额</td>');
                $('#couponBody').append('<td>'+result.amount+'元</td>');
                $('#couponBody').append('</tr>');
                $('#couponBody').append('<tr>');
                $('#couponBody').append('<td>可否转赠</td>');
                if (result.donation == 0) {
                    $('#couponBody').append('<td>不可转赠</td>');
                } else {
                    $('#couponBody').append('<td>可转赠</td>');
                }
                $('#couponBody').append('</tr>');
                $('#couponBody').append('<tr>');
                $('#couponBody').append('<td>有效期限</td>');
                if(result.lifeCycle == 0){
                    $('#couponBody').append('<td>'+'一万年有效'+'</td>');
                }
                if(result.lifeCycle == 1){
                    $('#couponBody').append('<td>'+result.expiresPoint+'到期</td>');
                }
                if(result.lifeCycle == 2){
                    $('#couponBody').append('<td>'+'自领取后'+result.expiresPoint+'天</td>');
                }
                $('#couponBody').append('</tr>');
                $('#couponBody').append('<tr>');
                $('#couponBody').append('<td>投资金额</td>');
                if(result.moneyLimit == 0){
                    $('#couponBody').append('<td>'+'不限制 </td>');
                }
                if(result.moneyLimit == 1){
                    $('#couponBody').append('<td>单笔满'+result.tradeAmount+'元可用 </td>');
                }
                if(result.moneyLimit == 2){
                    $('#couponBody').append('<td>累计满'+result.tradeAmount+'元可用 </td>');
                }
                $('#couponBody').append('</tr>');
                $('#couponBody').append('<tr>');
                $('#couponBody').append('<td>理财期限</td>');
                if(result.financePeriod == 0){
                    $('#couponBody').append('<td>'+'不限制 </td>');
                }else{
                    $('#couponBody').append('<td>'+result.financePeriod+'天及以上 </td>');
                }
                $('#couponBody').append('</tr>');
                $('#couponBody').append('<tr>');
                $('#couponBody').append('<td>备注</td>');
                $('#couponBody').append('<td>'+result.remark+'</td>');
                $('#couponBody').append('</tr>');
            }else{
                $('#couponBody').html('<tr><td colspan="2">请先添加优惠券</td></tr>');
            }
        });
    }

    function IndexOfn(tr, n) {
        //alert('='+tr);
        //alert('==-=-=='+n);
        var it = -1;
        var sytr = ',';
        var sub = tr;
        if (tr.IndexOf(sytr) >= 0) {
            for (var t = 0; t < n; t++){
                if (sub.IndexOf(sytr) < 0){
                    break;
                }
                it = it + sub.IndexOf(sytr) + sytr.Length;
                sub = sub.Substring(sub.IndexOf(sytr) + sytr.Length);
            }
            it = it + 1 - sytr.Length;
        }
        return it;
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>