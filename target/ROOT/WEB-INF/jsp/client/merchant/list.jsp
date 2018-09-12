<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
    <!--
    .combo-select {
        position: relative;
        max-width: 99%;
        min-width: 16%;
        /* margin-bottom: 15px; */
        font: 100% Helvetica, Arial, Sans-serif;
        border: 1px #ccc solid;
        border-radius: 3px;
        display:inline-block;
        vertical-align: top;
    }
    -->
</style>
<html>
<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
<body>
<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
<div class="container-fluid">
    <div class="row-fluid">
        <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
        <div class="span10" id="content">
            <!-- content begin -->
            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
            <div class="well">
                <form id="search" action="${pageContext.request.contextPath}/client/merchant/list/1" method="post">
                    <input type="hidden" id="size" name="size" value="${size}" />
                    <div class="input-group">
                        <span>借款人名称</span>
                        <c:if test="${type == 0 }">
                            <select id="name" name="searchName" >
                                <option></option>
                                <c:forEach items="${merchants}" var="merchant">
                                    <c:choose>
                                        <c:when test="${merchant.name == searchName}">
                                            <option value="${merchant.name}" selected="selected">${merchant.name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${merchant.name}">${merchant.name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>&nbsp;&nbsp;&nbsp;
                        </c:if>
                        <c:if test="${type == 1 || type==2 }">
                            <select id="name" name="searchName" >
                                <option></option>
                                <c:forEach items="${merchants}" var="merchant">
                                    <c:choose>
                                        <c:when test="${merchant.name == searchName}">
                                            <option value="${merchant.name}" selected="selected">${merchant.name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${merchant.name}">${merchant.name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>&nbsp;&nbsp;&nbsp;
                        </c:if>
                        <span>借款类型</span>
                        <select  name="type" id="sel" style="position:relative; top:5px;">
                            <option value="0" <c:if test="${type == 0 }">selected</c:if>>供应链</option>
                            <option value="1" <c:if test="${type == 1 }">selected</c:if>>信用贷</option>
                            <option value="2" <c:if test="${type == 2 }">selected</c:if>>抵押贷</option>
                        </select>&nbsp;&nbsp;&nbsp;
                        <span>手机号</span>
                        <input class="horizontal marginTop" id="cellphone" name="cellphone" type="text" value="${cellphone}"/><br/><br/>
                        <span>待还本金</span>
                        <input type="text" id="startAmount" name="startAmount" value="${startAmount}" class="validate[custom[integer]] text-input  horizontal marginTop"/>
                        <span>至</span>
                        <input type="text" id="endAmount" name="endAmount"  value="${endAmount}" class="validate[custom[integer]] text-input  horizontal marginTop"/>&nbsp;&nbsp;&nbsp;
                        <input type="button" value="查询" onclick="check()" class="btn btn-default" />
                    </div>
                </form>
            </div>
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <div id="authorityButton" class="navbar navbar-inner block-header">
                        <a href="javascript:add();" id="180"><button type="button" class="btn btn-success">新增</button></a>
                        <a href="javascript:detail()" id="181"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                        <a href="javascript:edit();" id="182"><button type="button" class="btn btn-primary">编辑 </button></a>
                        <a href="javascript:auditing();" id="183"><button type="button" class="btn btn-primary" >审核 </button></a>
                        <!--  <a href="javascript:setStatus(0);" id="184" style="display: none"><button type="button" class="btn btn-primary">启用短信提醒</button></a>
                         <a href="javascript:setStatus(1);" id="185" style="display: none"><button type="button" class="btn btn-primary">禁用短信提醒</button></a> -->
                    </div>
                    <!-- block -->
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table id="companies" class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>借款人名称</th>
                                    <c:if test="${type == 0 }">
                                        <th>联系人</th>
                                    </c:if>
                                    <th>联系人手机号</th>
                                    <th>待还本金</th>
                                    <th>借款次数</th>
                                    <c:if test="${type == 0 }">
                                        <th>审核状态</th>
                                    </c:if>
                                    <c:if test="${type == 2 && addFunctionPermit ==true}">
                                        <th>新增债权</th>
                                    </c:if>
                                </tr>
                                </thead>
                                <tbody id="merchantBody">
                                <c:choose>
                                    <c:when test="${fn:length(companies) > 0}">
                                        <c:forEach var ="merchant" items="${companies}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF','${merchant.id}','${merchant.type}')" id="merchantId${merchant.id}">
                                                <td class="hidden">${merchant.id}</td>
                                                    <%-- <td class="hidden">${merchant.closeNotice}</td> --%>
                                                <td>${status.count}</td>
                                                <td>${merchant.name}</td>
                                                <c:if test="${merchant.type == 0 }">
                                                    <td>${merchant.linkman}</td>
                                                </c:if>
                                                <td>${merchant.cellphone}</td>
                                                <c:if test="${merchant.type == 0 }">
                                                    <td><fmt:formatNumber value="${merchant.pendingRepaymentAmount}" pattern="#,##0" /></td>
                                                </c:if>
                                                <c:if test="${merchant.type == 1 || merchant.type == 2 }">
                                                    <td><fmt:formatNumber value="${merchant.loanAmount}" pattern="#,##0" /></td>
                                                </c:if>
                                                <c:if test="${merchant.type == 0 }">
                                                    <td><a href="javascript:borrowDetail('${merchant.id}', '${merchant.loanNum}')">${merchant.loanNum}</a></td>
                                                </c:if>
                                                <c:if test="${merchant.type == 1 || merchant.type == 2 }">
                                                    <td>
                                                        <c:if test="${merchant.status == 0 }">
                                                            <a href="javascript:borrowDetail('${merchant.idcard}','0')">0</a>
                                                        </c:if>
                                                        <c:if test="${merchant.status != 0 }">
                                                            <a href="javascript:borrowDetail('${merchant.idcard}','${merchant.tradeCount}','${merchant.type}')">${merchant.tradeCount}</a>
                                                        </c:if>
                                                    </td>
                                                </c:if>
                                                <c:if test="${merchant.type == 0 }">
                                                    <td id="myId${merchant.id}"><c:if test="${merchant.status == 1 }">通过</c:if><c:if test="${merchant.status == 0 }">待审核</c:if><c:if test="${merchant.status == 2 }">不通过</c:if></td>
                                                </c:if>
                                                <c:if test="${merchant.type == 2 && addFunctionPermit == true}">
                                                    <td><button class="btn btn-success" onclick="lenderAdd('${merchant.id}')">新增</button></td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8">暂时没有商户数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <c:if test="${type == 0 }">
                                        <td colspan="10">总数:<fmt:formatNumber value="${total}" pattern="#,##0" />人
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;待还本金:<fmt:formatNumber value="${totalMoney}" pattern="#,##0" />元
                                        </td>
                                    </c:if>
                                    <c:if test="${type == 1 || type == 2}">
                                        <td colspan="10">总数:<fmt:formatNumber value="${total}" pattern="#,##0" />人
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;待还本金:<fmt:formatNumber value="${totalMoney}" pattern="#,##0" />元
                                        </td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <td colspan="8"><div id="merchant-page"></div></td>
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
<div class="modal hide fade" id="authorizationDiv" role="dialog" style="margin-top: 200px">
    <form id="fmg" class="modal-content form-horizontal password-modal" action="${pageContext.request.contextPath}/client/merchant/auditing" >
        <div class="modal-header">
            <h4 class="modal-title">审核意见</h4>
        </div>
        <div class="modal-body">
            请确认审核结果！
            <div class="modal-footer">
                <!-- <a href="javascript:setStatus(1)" class="btn btn-primary" >通过</a>
                <a href="javascript:setStatus(2)" class="btn btn-default" >不通过</a> -->
                <input type="hidden" id="borrowerStatus" name="status" />
                <input type="hidden" id="borId" name="rowId"/>
                <button class="btn btn-primary" onclick="changeStatus('1')">通过</button>
                <button class="btn btn-default" onclick="changeStatus('2')">不通过</button>
            </div>
        </div>
    </form>
</div>
<input type="hidden" id="borrowerId" />
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script type="text/javascript">
    var rowId = 0;
    if('${type}'==0){
        $('#181').hide();
        $('#182').hide();
        $('#183').hide();
    }else{
        $('#180').hide();
        $('#181').hide();
        $('#182').hide();
        $('#183').hide();
    }
    $('.marginTop').css('margin', '2px auto auto auto');
    $(document).ready(function(){
        var totalPages = '${pages}';
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;借款人管理</li>');
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
                    var value =	$("#sel option:selected").val();
                    if(value==0){
                        $('#search').attr('action','${pageContext.request.contextPath}/client/merchant/list/'+page);
                    }else {
                        $('#search').attr('action','${pageContext.request.contextPath}/client/borrowerCredit/list/'+page);
                    }
                    $('#search').submit();
                }
            };
            $('#merchant-page').bootstrapPaginator(options);
        }
        $('#name').find('option[value=${name}]').attr('selected',true);
        $('#name').comboSelect();
    });
    /* var status = tr.getElementsByTagName('td')[8].innerHTML;
    var closeNotice = tr.getElementsByTagName('td')[1].innerHTML;
    if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
        $('#181').hide();
        $('#182').hide();
        $(tr).css('background-color', 'white');
        rowId = 0;
    } else {
        if (status == '通过') {
            $('#182').hide();
        } else {
            $('#182').show();
        }
        $('#183').show();
        $('#181').show();
        $('#merchantId'+rowId).css('background-color', 'white');
        $(tr).css('background-color', color);
        rowId = tr.getElementsByTagName("td")[0].innerHTML;
    } */

    /* if(closeNotice == 0){
        $('#185').show();
        $('#184').hide();
    }
    if(closeNotice == 1){
        $('#184').show();
        $('#185').hide();
    } */

    var rowId = 0;
    function getRow(tr, color,borrowerId,type) {
        $("#borrowerId").val(borrowerId);
        if(type==0){
            var mytd = "myId"+borrowerId;
            var status = document.getElementById(mytd).innerText;
            if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
                $('#181').hide();
                $('#182').hide();
                $('#183').hide();
                $(tr).css('background-color', 'white');
                rowId = 0;
            } else{
                if(status == '通过'){
                    $('#182').hide();
                    $('#180').show();
                    $('#181').show();
                    $('#183').hide();
                }else {
                    $('#180').show();
                    $('#181').show();
                    $('#182').show();
                    $('#183').show();
                }
                if(status == '不通过'){
                    $('#182').show();
                    $('#180').show();
                    $('#181').show();
                    $('#183').hide();
                }
                $('#merchantId'+rowId).css('background-color', 'white');
                $(tr).css('background-color', color);
                rowId = tr.getElementsByTagName("td")[0].innerHTML;
            }
        } else{
            $('#180').hide();
            $('#181').hide();
            $('#182').hide();
            $('#183').hide();
        }
    }
    function check(){
        var value =	$("#sel option:selected").val();
        if(value==1){
            $('#search').attr('action','${pageContext.request.contextPath}/client/borrowerCredit/list/1?type='+value);
            $('#search').submit();
        }else if(value==2){
            $('#search').attr('action','${pageContext.request.contextPath}/client/borrowerCredit/list/1?type='+value);
            $('#search').submit();
        }else if(value==0){
            $('#search').attr('action','${pageContext.request.contextPath}/client/merchant/list/1');
            $('#search').submit();
        }
    }
    function add() {
        $('#search').attr('action','${pageContext.request.contextPath}/client/merchant/add/${page}');
        $('#search').submit();
    }
    $('.waring-borrow').css('background-color', '#46A3FF');
    $('.serious-borrow').css('background-color', '#FFFF37');
    $('.danger-borrow').css('background-color', '#FF5151');

    function edit() {
        //if (rowId > 0) {
        var rowId = $("#borrowerId").val();
        $('#search').attr('action','${pageContext.request.contextPath}/client/merchant/edit/' + rowId + '/${page}');
        $('#search').submit();
        //} else {
        //alert('请选择一条要修改的数据');
        //}
    }

    function borrowDetail(merchantId, count,type) {
        if (count == 0) {
            alert('当前商户无借款纪录');
        } else {
            if('${type}'==0){
                $('#search').attr('action','${pageContext.request.contextPath}/client/merchant/record/'+merchantId);
                $('#search').submit();
            }else{
                window.location.href='${pageContext.request.contextPath}/client/merchant/borrowCountDetail/1?idcard='+merchantId+"&type="+type;
            }
        }
    }

    function auditing(){
        $('#authorizationDiv').modal('show');
    }

    function changeStatus(status){
        var rowId = $("#borrowerId").val();
        $("#borId").val(rowId);
        $("#borrowerStatus").val(status);
        //$('#fmg').attr('action','${pageContext.request.contextPath}/client/merchant/auditing?rowId='+rowId+'&status='+status);
        $('#fmg').submit();
    }

    function detail() {
        //if (rowId > 0) {
        var rowId = $("#borrowerId").val();
        $('#search').attr('action','${pageContext.request.contextPath}/client/merchant/detail/' + rowId + '/${page}');
        $('#search').submit();
        //} else {
        //	alert('请选择一条要查看的数据');
        //}
    }

    /* function setStatus(status) {
        if (rowId > 0) {
            $.post('${pageContext.request.contextPath}/client/merchant/sms/status',{merchantId:rowId, status:status},function(result){
					$('#search').submit();
				})
			} else {
				alert('请选择一条要查看的数据');
			}
		} */
    function lenderAdd(lenderId){
        window.location.href='${pageContext.request.contextPath}/product/lender/add?lenderId='+lenderId;
    }
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>