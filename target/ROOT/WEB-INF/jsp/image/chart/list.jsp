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
                    <div id="authorityButton" class="navbar navbar-inner block-header">
                        <!-- <a id="400" href="javascript:add()" ><button class="btn btn-lg btn-success">新增</button></a> -->
                        <a href="javascript:detail()" id="401"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                        <a href="javascript:edit()" id="402"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                        <a href="javascript:enable(1);" id="430"><button type="button" class="btn btn-primary">启用</button></a>
                        <a href="javascript:enable(0);" id="431"><button type="button" class="btn btn-primary">禁用</button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table id="product" cellpadding="0" cellspacing="0" border="0" class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>名称</th>
                                    <th>缩略图</th>
                                    <th>显示平台</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(charts) > 0 || fn:length(productAds) > 0}">
                                        <c:forEach var="chart" items="${charts}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="chartId">
                                                <td class="hiddenid" style="display: none">${chart.id}</td>
                                                <td class="hidden">${chart.status}</td>
                                                <td class="hidden">${chart.category}</td>
                                                <td class="vertical">1</td>
                                                <td class="vertical">${chart.name}</td>
                                                <td class="vertical"><img class="thumbnail thumbnailSize" src=${fn:substringAfter(fn:split(chart.url, ',')[0],':')}/></td>
                                                <td class="vertical">APP</td>
                                                <td class="vertical">
                                                    <c:if test="${chart.status == 0}">禁用</c:if>
                                                    <c:if test="${chart.status == 1}">启用</c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:forEach var="productAd" items="${productAds}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="productAdId">
                                                <td class="hiddenid" style="display: none">${productAd.id}</td>
                                                <td class="hidden">${productAd.status}</td>
                                                <td class="hidden">${productAd.category}</td>
                                                <td class="vertical">2</td>
                                                <td class="vertical">${productAd.name}</td>
                                                <td class="vertical" height="65px">无</td>
                                                <td class="vertical">APP</td>
                                                <td class="vertical">
                                                    <c:if test="${productAd.status == 1}">启用</c:if>
                                                    <c:if test="${productAd.status == 0}">禁用</c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:forEach var="banner" items="${silverMarket}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="silverMarketId">
                                                <td class="hiddenid" style="display: none">${banner.id}</td>
                                                <td class="hidden">${banner.status}</td>
                                                <td class="hidden">${banner.category}</td>
                                                <td class="vertical">3</td>
                                                <td class="vertical">${banner.name}</td>
                                                <td class="vertical" height="65px"><c:if test="${not empty banner.url}"><img class="thumbnail thumbnailSize" src="${banner.url}" /></c:if>
                                                    <c:if test="${empty banner.url}">无</c:if>
                                                </td>
                                                <td class="vertical">APP/WAP</td>
                                                <td class="vertical">
                                                    <c:if test="${banner.status == 1}">启用</c:if>
                                                    <c:if test="${banner.status == 0}">禁用</c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:forEach var="banner" items="${activityEntrance}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="activityId">
                                                <td class="hiddenid" style="display: none">${banner.id}</td>
                                                <td class="hidden">${banner.status}</td>
                                                <td class="hidden">${banner.category}</td>
                                                <td class="vertical">4</td>
                                                <td class="vertical">${banner.name}</td>
                                                <td class="vertical" height="65px"><c:if test="${not empty banner.url}"><img class="thumbnail thumbnailSize" src="${banner.url}" /></c:if>
                                                    <c:if test="${empty banner.url}">无</c:if>
                                                </td>
                                                <td class="vertical">APP/WAP</td>
                                                <td class="vertical">
                                                    <c:if test="${banner.status == 1}">启用</c:if>
                                                    <c:if test="${banner.status == 0}">禁用</c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:forEach var="banner" items="${vipPicture}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="vipPictureId">
                                                <td class="hiddenid" style="display: none">${banner.id}</td>
                                                <td class="hidden">${banner.status}</td>
                                                <td class="hidden">${banner.category}</td>
                                                <td class="vertical">5</td>
                                                <td class="vertical">${banner.name}</td>
                                                <td class="vertical" height="65px"><c:if test="${not empty banner.url}"><img class="thumbnail thumbnailSize" src="${banner.url}" /></c:if>
                                                    <c:if test="${empty banner.url}">无</c:if>
                                                </td>
                                                <td class="vertical">APP/WAP</td>
                                                <td class="vertical">
                                                    <c:if test="${banner.status == 1}">启用</c:if>
                                                    <c:if test="${banner.status == 0}">禁用</c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5">暂时还没有数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
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
    var rowId = 0;
    var status = '';
    var category = 0;
    $(document).ready(function(){
        $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;APP图片管理</li>');
        $('[rel="tooltip"]').tooltip();
        $('.hiddenid').hide();

        $('#401').hide();
        $('#402').hide();
        $('#430').hide();
        $('#431').hide();
        if ('${fn:length(charts)}' > 0&'${fn:length(productAds)}' > 0) {
            $('#400').hide();
        }

        $('.thumbnailSize').css('height', '60px');
        $('.vertical').css('vertical-align', 'middle');
    });

    function getRow(tr, color) {
        $('#430').hide();
        $('#431').hide();
        $('#401').show();
        $('#402').show();
        category = tr.getElementsByTagName('td')[2].innerHTML;
        rowId = tr.getElementsByTagName('td')[0].innerHTML;
        status = tr.getElementsByTagName('td')[1].innerHTML;
        if (category == 1) {
            $(tr).css('background-color', color);
            $('#productAdId').css('background-color', 'white');
            $('#silverMarketId').css('background-color', 'white');
            $('#activityId').css('background-color', 'white');
            $('#vipPictureId').css('background-color', 'white');
        } else if (category == 5) {
            $(tr).css('background-color', color);
            $('#silverMarketId').css('background-color', 'white');
            $('#chartId').css('background-color', 'white');
            $('#activityId').css('background-color', 'white');
            $('#vipPictureId').css('background-color', 'white');
        } else if (category == 6) {
            $(tr).css('background-color', color);
            $('#productAdId').css('background-color', 'white');
            $('#chartId').css('background-color', 'white');
            $('#activityId').css('background-color', 'white');
            $('#vipPictureId').css('background-color', 'white');
        }else if (category == 7) {
            $(tr).css('background-color', color);
            $('#productAdId').css('background-color', 'white');
            $('#chartId').css('background-color', 'white');
            $('#silverMarketId').css('background-color', 'white');
            $('#vipPictureId').css('background-color', 'white');
        }else if(category == 8){
        	 $(tr).css('background-color', color);
             $('#productAdId').css('background-color', 'white');
             $('#chartId').css('background-color', 'white');
             $('#silverMarketId').css('background-color', 'white');
             $('#activityId').css('background-color', 'white');
        }
        if(status == 1){
            $('#402').hide();
            $('#430').hide();
            $('#431').show();
        } else {
            $('#402').show();
            $('#430').show();
            $('#431').hide();
        }
    }

    function edit() {
        if (rowId > 0) {
            if(category == 1){
                window.location.href='${pageContext.request.contextPath}/chart/edit/'+rowId;
            } else if (category == 5) {
                window.location.href='${pageContext.request.contextPath}/productad/edit/'+rowId;
            } else if (category == 6) {
                window.location.href='${pageContext.request.contextPath}/app/image/edit/'+rowId;
            } else if (category == 7) {
                window.location.href='${pageContext.request.contextPath}/activity/image/edit/'+rowId;
            } else if(category == 8){
            	 window.location.href='${pageContext.request.contextPath}/activity/vip/image/edit/'+rowId;
            }
        } else {
            alert('请先选择您想编辑的行!');
        }
    }
    /* function add() {
        if ('${fn:length(charts)}' > 0) {
				window.location.href='${pageContext.request.contextPath}/productad/add';
			}else{
				window.location.href='${pageContext.request.contextPath}/chart/add';
			}

		} */
    function detail() {
        if (rowId > 0) {
            if(category==1){
                window.location.href='${pageContext.request.contextPath}/chart/detail/'+rowId;
            }else if (category == 5) {
                window.location.href='${pageContext.request.contextPath}/productad/detail/'+rowId;
            } else if (category == 6) {
                window.location.href='${pageContext.request.contextPath}/app/image/detail/'+rowId;
            } else if (category == 7) {
                window.location.href='${pageContext.request.contextPath}/activity/image/detail/'+rowId;
            } else if(category == 8){
            	 window.location.href='${pageContext.request.contextPath}/activity/vip/image/detail/'+rowId;
            }
        } else {
            alert('请先选择您想查看的数据!');
        }
    }

    function enable(value) {
        if(category==1){
            $.get('${pageContext.request.contextPath}/chart/enable/'+rowId+'/'+value, function(result){
                if (result) {
                    window.location.href = '${pageContext.request.contextPath}/chart/list';
                }
            }, 'json');
        }else{
            $.get('${pageContext.request.contextPath}/productad/enable/'+rowId+'/'+value, function(result){
                if (result) {
                    window.location.href = '${pageContext.request.contextPath}/chart/list';
                }
            }, 'json');
        }
    }

</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>