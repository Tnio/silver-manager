<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
<body>
<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
<div class="container-fluid">
    <div class="row-fluid">
        <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
        <div class="span10" id="content">
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div id="authorityButton" class="navbar navbar-inner block-header">
                        <a href="javascript:add();" id="380"><button type="button" class="btn btn-success" >新增 </button></a>
                        <a href="javascript:edit();" id="381"><button type="button" class="btn btn-primary">编辑 </button></a>
                        <a href="javascript:detail();" id="382"><button type="button" class="btn btn-primary">查看 </button></a>
                        <a href="javascript:audit();" id="383"><button type="button" class="btn btn-primary">审核 </button></a>
                        <a href="javascript:lotteryDetail();" id="385"><button type="button" class="btn btn-primary">中奖明细 </button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form id="search" action="${pageContext.request.contextPath}/bonus/lottery/list/1" method="post">
                                <table id="lotterys" cellpadding="0" cellspacing="0" border="0" class="table">
                                    <thead>
                                    <tr>
                                        <th>序号</th>
                                        <th>活动名称</th>
                                        <th>活动类型</th>
                                        <th>活动开始时间</th>
                                        <th>活动结束时间</th>
                                        <th>当前状态</th>
                                        <th>使用场景</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${fn:length(lotterys) > 0}">
                                            <c:forEach var ="lottery" items="${lotterys}" varStatus="status">
                                                <tr onclick="getRow(this, '#BFBFBF')" id="lotteryId${lottery.id}">
                                                    <td class="hidden" >${lottery.id}</td>
                                                    <td class="hidden" >${lottery.status}</td>
                                                    <td class="shortcss" >${status.count}</td>
                                                    <td class="longcss" >${lottery.name}</td>
                                                    <td class="numbercss" ><c:if test="${lottery.category == 1}">刮刮卡</c:if><c:if test="${lottery.category == 2}">大转盘</c:if></td>
                                                    <td class="numbercss" >${lottery.begin}</td>
                                                    <td class="numbercss" >${lottery.end}</td>
                                                    <td class="numbercss" >
                                                        <c:if test="${lottery.status == 0}">待审核</c:if>
                                                        <c:if test="${lottery.status == 1}">审核通过</c:if>
                                                        <c:if test="${lottery.status == 2}">审核不通过</c:if>
                                                    </td>
                                                    <td class="numbercss" ><c:if test="${lottery.scene == 1}">银子商城</c:if><c:if test="${lottery.scene == 2}">日常活动</c:if><c:if test="${lottery.scene == 3}">渠道活动</c:if><c:if test="${lottery.scene == 4}">翻牌活动</c:if></td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6">暂时没有抽奖活动数据</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <td colspan="6"><div id="lottery-page"></div></td>
                                    </tr>
                                    </tfoot>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /block -->
        </div>
        <!-- content end -->
    </div>
</div>
<div class="modal hide fade" id="authorizationDiv" role="dialog" style="margin-top: 200px">
    <form id="fmg" class="modal-content form-horizontal password-modal" >
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
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script type="text/javascript">
    function audit(){
        if(rowId > 0){
            $('#authorizationDiv').modal('show');
        }else{
            alert('请先选择一条记录!');
        }
    }

    var rowId = 0;
    var sceneId = '';
    var state = '';
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;抽奖管理</li>');
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
                    $('#search').attr('action','${pageContext.request.contextPath}/bonus/lottery/list/'+page);
                    $('#search').submit();
                }
            };
            $('#lottery-page').bootstrapPaginator(options);
        }
        $("#381").hide();
        $("#382").hide();
        $("#383").hide();
        $("#384").hide();
        $("#385").hide();
        $('.shortcss').css({width:10});
        $('.numbercss').css({width:50});
        $('.longcss').css({width:100});
    });

    function getRow(tr, color) {
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
            sceneId = 0;
            $('#381').hide();
            $('#382').hide();
            $('#383').hide();
            $('#385').hide();
        } else {
            $('#lotteryId'+rowId).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = tr.getElementsByTagName('td')[0].innerHTML;
            var status = tr.getElementsByTagName('td')[1].innerHTML;
            if (status == 0) {
                $('#383').show();
            } else {
                $('#383').hide();
            }
            state = tr.getElementsByTagName('td')[6].innerHTML;
            sceneId = tr.getElementsByTagName('td')[7].innerHTML;
            $('#381').show();
            $('#382').show();
            $('#385').show();
        }
    }

    function countEnable(){
        var res = false;
        if (sceneId == '银子商城'){
            sceneId = 1;
        }else if(sceneId == '日常活动'){
            sceneId = 2;
        }else if (sceneId == '渠道活动'){
            sceneId = 3;
        }else if (sceneId == '翻牌活动'){
            sceneId = 4;
        }else {
            return true;
        }
        $.ajax({
            type:'post',
            async: false,
            url: '${pageContext.request.contextPath}/bonus/lottery/count/enable/'+sceneId,
            success: function(data){
                res = data;
            }
        });
        return res;
    }

    function add() {
        window.location.href='${pageContext.request.contextPath}/bonus/lottery/add/${page}/${size}';
    }

    function edit() {
        if (rowId > 0) {
            window.location.href='${pageContext.request.contextPath}/bonus/lottery/'+rowId+'/edit/${page}/${size}';
        } else {
            alert('请选择一条要修改的数据');
        }
    }

    function detail() {
        if (rowId > 0) {
            window.location.href='${pageContext.request.contextPath}/bonus/lottery/'+rowId+'/detail/${page}/${size}';
        } else {
            alert('请选择一条要查看的数据');
        }
    }

    function lotteryDetail(){
        if (rowId > 0) {
            $('#search').attr('action','${pageContext.request.contextPath}/bonus/lottery/detail/list/'+rowId);
            $('#search').submit();
        } else {
            alert('请先选择一个活动');
        }
    }

    function setStatus(status){
        if (rowId > 0) {
            $.ajax({
                type:'post',
                async: true,
                url: '${pageContext.request.contextPath}/bonus/lottery/status',
                data:{
                    'id' : rowId,
                    'status' : status
                },
                success: function(data){
                    if(data == 'false'){
                        alert('操作失败!');
                    } else {
                        window.location.href='${pageContext.request.contextPath}/bonus/lottery/list/${page}';
                    }
                }
            });
        } else {
            alert('请选择一条要(启用/禁用)的数据!');
        }
    }
</script>
<c:import url="/authority" />
</html>