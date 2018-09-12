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
            <div class="row-fluid">
                <div class="block">
                    <div id="authorityButton" class="navbar navbar-inner block-header">
                        <a id="530" href="javascript:detail()"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                        <a id="531" href="javascript:edit()"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                        <a id="532" href="javascript:enable(1)"><button class="btn btn-lg btn-primary" >启用<i class=""></i></button></a>
                        <a id="533" href="javascript:enable(0)"><button class="btn btn-lg btn-primary" >禁用<i class=""></i></button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table id="earnSilver" cellpadding="0" cellspacing="0" border="0" class="table">
                                <thead>
                                <tr align="center">
                                    <th>序号</th>
                                    <th>任务名称</th>
                                    <th>任务类型</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${fn:length(earnSilvers) > 0}">
                                        <c:forEach var="earnSilver" items="${earnSilvers}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="earnSilverId${earnSilver.id}">
                                                <td class="hiddenid">${earnSilver.id}</td>
                                                <td>${earnSilver.name}</td>
                                                <td><c:if test="${earnSilver.type == 1}">一次性任务</c:if><c:if test="${earnSilver.type == 2}">每日任务</c:if></td>
                                                <td><c:if test="${earnSilver.enable > 0}">启用</c:if><c:if test="${earnSilver.enable < 1}">禁用</c:if></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4">暂时还没有赚银子任务列表</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="4"><div id="earnSilver-page"></div></td>
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
    $('.breadcrumb').html('<li class="active">银子管理&nbsp;/&nbsp;赚银子</li>');
    var rowId = 0;
    var initStatus = -1;
    $(document).ready(function(){
        $('#530').hide();
        $('#531').hide();
        $('#532').hide();
        $('#533').hide();
    });

    function getRow(tr, color) {
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
            $('#530').hide();
            $('#531').hide();
            $('#532').hide();
            $('#533').hide();
        }else{
            $('#530').show();

            $('#earnSilverId'+rowId).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = tr.getElementsByTagName('td')[0].innerHTML;
            if(tr.getElementsByTagName('td')[3].innerHTML == '禁用'){
                $('#531').show();
                $('#532').show();
                $('#533').hide();
            }else{
                $('#531').hide();
                $('#532').hide();
                $('#533').show();
            }
        }
    }

    function detail(){
        if(rowId > 0){
            window.location.href='${pageContext.request.contextPath}/silver/earn/detail/'+rowId;
        }else{
            alert('请先选择一条记录！');
        }
    }

    function edit(){
        if(rowId > 0){
            window.location.href='${pageContext.request.contextPath}/silver/earn/edit/'+rowId;
        }else{
            alert('请先选择一条记录！');
        }
    }

    function enable(value) {
        $.post('${pageContext.request.contextPath}/silver/earn/enable/'+rowId+'/'+value, function(result){
            if (result) {
                window.location.href='${pageContext.request.contextPath}/silver/earn/';
            }
        }, 'json');
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>