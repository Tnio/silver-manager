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
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div id="authorityButton" class="navbar navbar-inner block-header">
                        <a href="javascript:add();" id="190"><button type="button" class="btn btn-success">新增</button></a>
                        <a href="javascript:detail();" id="191"><button type="button" class="btn btn-primary">查看 </button></a>
                        <a href="javascript:edit();" id="192"><button type="button" class="btn btn-primary">编辑 </button></a>
                        <a href="javascript:enable(1);" id="193"><button type="button" class="btn btn-primary">启用 </button></a>
                        <a href="javascript:enable(0);" id="194"><button type="button"  class="btn btn-primary">禁用 </button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form id="search" action="${pageContext.request.contextPath}/bonus/list/1" method="post">
                                <table id="bonuss" cellpadding="0" cellspacing="0" border="0" class="table">
                                    <thead>
                                    <tr>
                                        <th>序号</th>
                                        <th>活动名称</th>
                                        <th>返利类型</th>
                                        <th>当前状态</th>
                                        <th>添加时间</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${fn:length(bonuss) > 0}">
                                            <c:forEach var ="bonus" items="${bonuss}" varStatus="status">
                                                <tr onclick="getRow(this, '#BFBFBF')" id="bonusId${bonus.id}">
                                                    <td class="hidden" >${bonus.id}</td>
                                                    <td class="shortcss" >${status.count}</td>
                                                    <td class="longcss" >${bonus.name}</td>
                                                    <td class="numbercss" >
                                                        <c:choose>
                                                            <c:when test="${bonus.giveType == 1}">
                                                                返银子
                                                            </c:when>
                                                            <c:when test="${bonus.giveType == 2}">
                                                                返红包
                                                            </c:when>
                                                            <c:when test="${bonus.giveType == 3}">
                                                                返加息券
                                                            </c:when>
                                                            <c:when test="${bonus.giveType == 4}">
                                                                返第三方券
                                                            </c:when>
                                                            <c:otherwise>
                                                                无
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="numbercss" ><c:if test="${bonus.status > 0}">启用</c:if><c:if test="${bonus.status < 1}">禁用</c:if></td>
                                                    <td class="numbercss" ><fmt:formatDate value="${bonus.createTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="10">暂时没有返利活动数据</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <td colspan="10"><div id="bonus-page"></div></td>
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
    var rowId = 0;
    var state = '';
    $('#191').hide();
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;返利活动管理</li>');
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
                    $('#search').attr('action','${pageContext.request.contextPath}/bonus/list/'+page);
                    $('#search').submit();
                }
            };
            $('#bonus-page').bootstrapPaginator(options);
        }
        $("#194").hide();
        $("#193").hide();
        $("#192").hide();
        $('.shortcss').css({width:10});
        $('.numbercss').css({width:50});
        $('.longcss').css({width:100});
    });

    function getRow(tr, color) {
        var enabled = $.trim(tr.getElementsByTagName('td')[4].innerHTML);
        if (enabled =='启用') {
            $("#192").hide();
        } else if (enabled == '禁用') {
            $("#192").show();
        } else {
            $("#192").hide();
        }
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
            $('#194').hide();
            $('#193').hide();
            $('#191').hide();
        } else {
            $('#191').show();
            $('#bonusId'+rowId).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = tr.getElementsByTagName('td')[0].innerHTML;
            state = tr.getElementsByTagName('td')[4].innerHTML;
            if(state == '禁用'){
                $('#194').hide();
                $('#193').show();
            }else if(state == '启用'){
                $('#194').show();
                $('#193').hide();
            }else{
                $('#194').hide();
                $('#193').hide();
            }
        }
    }

    function add() {
        window.location.href='${pageContext.request.contextPath}/bonus/add/${page}/${size}';
    }

    function edit() {
        if (rowId > 0) {
            window.location.href='${pageContext.request.contextPath}/bonus/'+rowId+'/edit/${page}/${size}';
        } else {
            alert('请选择一条要修改的数据');
        }
    }

    function detail() {
        if (rowId > 0) {
            window.location.href='${pageContext.request.contextPath}/bonus/'+rowId+'/detail/${page}/${size}';
        } else {
            alert('请选择一条要查看的数据');
        }
    }

    function enable(status){
        if (rowId > 0) {
            var flag = true;
            if(status == 0){
                $.ajax({
                    type:'post',
                    async: false,
                    url: '${pageContext.request.contextPath}/product/validate/bonus',
                    data:{
                        'id' : rowId
                    },
                    success: function(data){
                        if(data == false){
                            alert('该返利活动关联的产品尚未售罄，暂时不能被禁用!');
                            flag = false;
                        }
                    }
                });
            }
            if(status == 1){
                $.ajax({
                    type:'post',
                    async: false,
                    url: '${pageContext.request.contextPath}/bonus/validate/strategy',
                    data:{
                        'bonusId' : rowId
                    },
                    success: function(data){
                        if(data == false){
                            alert('该返利活动关联的红包已过期，暂时不能启用!');
                            flag = false;
                        }
                    }
                });
            }
            if(flag){
                $.ajax({
                    type:'post',
                    async: true,
                    url: '${pageContext.request.contextPath}/bonus/enable',
                    data:{
                        'id' : rowId,
                        'enable' : status
                    },
                    success: function(data){
                        if(data == 'false'){
                            alert('操作失败!');
                        } else {
                            window.location.href='${pageContext.request.contextPath}/bonus/list/${page}';
                        }
                    }
                });
            }
        } else {
            alert('请选择一条要(启用/禁用)的数据!');
        }
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>