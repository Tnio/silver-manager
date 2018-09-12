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
            <div class="well">
                <form id="search" action="${pageContext.request.contextPath}/silver/goods/list" method="post" class="form-search"  style="margin: 0px">
                    <input type="hidden" id="size" name="size" value="${size}" />
                    <input type="hidden" id="page" name="page" value="${page}" />
                    <div id="searchDiv" style="position:relative; left:6px;">
                        <span >商品类型</span>
                        <select class="marginTop" id="achieveAmount" name="achieveAmount" style="width:163px">
                            <option value="-1" <c:if test="${achieveAmount == -1}">selected</c:if> > 全部</option>
                            <option value="1" <c:if test="${achieveAmount == 1}">selected</c:if> >尖货</option>
                            <option value="0" <c:if test="${achieveAmount == 0}">selected</c:if> >热门</option>
                        </select>
                        <a href="javascript:search();"><button type="button" class="btn">查询</button></a>
                    </div>
                </form>
            </div>
            <div class="row-fluid">
                <div class="block">
                    <div id="authorityButton" class="navbar navbar-inner block-header">
                        <a id="200" href="javascript:add()"><button class="btn btn-lg btn-success">新增</button></a>
                        <a id="201" href="javascript:detail()"><button class="btn btn-lg btn-primary">查看<i class=""></i></button></a>
                        <a id="202" href="javascript:edit()"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                        <a id="203" href="javascript:setStatus('1','status')"><button class="btn btn-lg btn-primary" >上架</button></a>
                        <a id="204" href="javascript:setStatus('0','status')"><button class="btn btn-lg btn-primary">下架</button></a>
<!--                         <a id="207" href="javascript:setStatus('1','hot')"><button class="btn btn-lg btn-primary" >热卖</button></a> -->
<!--                         <a id="208" href="javascript:setStatus('0','hot')"><button class="btn btn-lg btn-primary">取消热卖</button></a> -->
                        <a id="205" href="javascript:exchangeDetail()"><button class="btn btn-lg btn-primary">兑换明细</button></a>
                        <a id="206" href="javascript:codesDetail()"><button class="btn btn-lg btn-primary">券码号</button></a>
                    </div>

                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>商品名称</th>
                                    <th>消耗银子(两)</th>
                                    <th>剩余数量(件)</th>
                                    <th>销售状态</th>
                                    <!-- <th>操作</th> -->
                                    <!--  <th>商品图片</th>
                                     <th>当前状态</th>
                                     <th>排序</th> -->
                                </tr>
                                </thead>
                                <tbody class="goodsSortable">
                                <c:choose>
                                    <c:when test="${fn:length(goodses) > 0}">
                                        <c:forEach var="goods" items="${goodses}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="goodId${goods.id}N${goods.sortNumber}">
                                                <td class="hidden">${goods.id}</td>
                                                <td class="hidden">${goods.type}</td>
                                                <td class="hidden">${goods.hot}</td>
                                                <td class="hidden">${goods.sortNumber}</td>
                                                <td>${status.count}</td>
                                                <td><c:if test="${goods.hot == 1}"><span style="background-color: #E74C3C">热</span> </c:if> ${goods.name}</td>
                                                    <%--  <td><img class="thumbnail thumbnailSize" src="${goods.url}"/></td> --%>
                                                <td>${goods.consumeSilver}</td>
                                                <td>${goods.stock}</td>
                                                <td>
                                                    <c:if test="${goods.status == 0 || (goods.stock <= goods.joinNum)}">
                                                        下架
                                                    </c:if>
                                                    <c:if test="${goods.status == 1 && goods.stock > goods.joinNum }">
                                                        上架
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8">暂时还没有商品列表</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="8"><div id="goods-page"></div></td>
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
<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
</body>
<script type="text/javascript">
    var rowId = 0;
    var status = '';
    var type = '';
    var hot= '';
    var sortNumber = 0;
    $(document).ready(function(){
        $('#achieveAmount').find("option[value='${achieveAmount}']").attr('selected',true);
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">银子管理&nbsp;/&nbsp;银子商城管理</li>');
        $('[rel="tooltip"]').tooltip();
        $('#204').hide();
        $('#201').hide();
        $('#202').hide();
        $('#203').hide();
        $('#206').hide();
        $('#207').hide();
        $('#208').hide();
        $('.thumbnailSize').css('height', '40px');
        $('.thumbnailSize').css('width', '60px');
        var workImg=document.getElementsByTagName('img');
        for(var i=0; i<workImg.length; i++) {
            workImg[i].onclick=ImgShow;
        }
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
                    $('#search').attr('action','${pageContext.request.contextPath}/silver/goods/list/');
                    $('#page').val(page);
                    $('#search').submit();
                }
            };
            $('#goods-page').bootstrapPaginator(options);
        }

        changeSort('${pageContext.request.contextPath}/silver/goods/change/sort','goodsSortable','tr:contains("\u4e0a\u67b6")',/goodId/g,'N');
        $( ".goodsSortable" ).sortable("disable");
    });

    $('#201').hide();
    function getRow(tr, color) {
        $('#201').hide();
        $('#202').hide();
        $('#203').hide();
        $('#204').hide();
        $('#206').hide();
        $('#207').hide();
        $('#208').hide();
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
        } else {
            $('#201').show();
            $('#goodId'+rowId+'N'+sortNumber).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = $.trim(tr.getElementsByTagName('td')[0].innerHTML);
            type = $.trim(tr.getElementsByTagName('td')[1].innerHTML);
            hot = $.trim(tr.getElementsByTagName('td')[2].innerHTML);
            sortNumber = $.trim(tr.getElementsByTagName('td')[3].innerHTML);
            status = $.trim(tr.getElementsByTagName('td')[8].innerHTML);
            buttonShowOrHide(status);
        }

    }

    function exchangeDetail() {
        $('#search').attr('action','${pageContext.request.contextPath}/silver/goods/exchange/record');
        $('#search').attr('method','get');
        $('#search').submit();
    }

    function codesDetail(){
        window.location.href='${pageContext.request.contextPath}/silver/goods/codes/detail/'+rowId;
    }

    function buttonShowOrHide(status){
        if(type == '3'){
            $('#206').show();
        }else{
            $('#206').hide();
        }

        if($.trim(status) == '上架'){
            $('#204').show();
            $('#202').hide();
            $('#203').hide();
            if($.trim(hot) == 0){
                $('#207').show();
            }else{
                $('#208').show();
            }
        }else{
            $('#202').show();
            $('#204').hide();
            $('#203').show();
        }

    }

    function add(){
        window.location.href='${pageContext.request.contextPath}/silver/goods/add';
    }

    function edit() {
        if (rowId > 0) {
            $('#search').attr('action','${pageContext.request.contextPath}/silver/goods/edit/'+rowId);
            $('#search').attr('method','get');
            $('#search').submit();
        } else {
            alert('请先选择您想编辑的行!');
        }
    }

    function search() {
        $('#search').attr('action','${pageContext.request.contextPath}/silver/goods/list');
        $('#page').val(1);
        $('#search').submit();
    }

    function detail() {
        if (rowId > 0) {
            $('#search').attr('action','${pageContext.request.contextPath}/silver/goods/detail/'+rowId);
            $('#search').attr('method','get');
            $('#search').submit();
        } else {
            alert('请先选择您想查看的数据!');
        }
    }

    function setStatus(statue,category){
        if(rowId > 0){
            $.post('${pageContext.request.contextPath}/silver/goods/'+rowId+'/'+statue,{category:category}, function(result){
                search();
            });
        }else{
            alert('请先选择要 上架/下架 的产品！');
        }

    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>