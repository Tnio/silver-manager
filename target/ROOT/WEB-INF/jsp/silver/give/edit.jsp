<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <!-- content begin -->
            <form class="form-horizontal" onsubmit="return startValidate();" id="fm" method="post"  action="${pageContext.request.contextPath}/silver/give/save"  autocomplete="off">
                <input id="id" name="id" value="${dispatchingBonusLog.id}" type="hidden">
                <input id="status" name="status" value="0" type="hidden">
                <input id="category" name="category" value="1" type="hidden">
                <input id="templateId" name="template.id" value="0" type="hidden">
                <div class="accordion" id="accordion2">
                    <div class="accordion-group">
                        <div class="accordion-heading">
                            <a class="accordion-toggle btn-info" data-toggle="collapse" data-parent="#accordion2" style="text-decoration: none; ">
                                银子赠送管理
                            </a>
                        </div>
                        <div id="collapseOne" class="accordion-body collapse in">
                            <div class="accordion-inner">
                                <div class="well" style="margin: 0;">
                                    <div class="row-fluid" id="conditionsGoup">
                                        <label class="control-label"><span class="required">*</span> 选择用户</label>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="choiceType" value="0" class="validate[required] radio span4">
                                                <span >按条件筛选</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="choiceType" value="1" class="validate[required] radio span4">
                                                <span >自定义筛选</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="conditionId">
                                        <div class="row-fluid">
                                            <label class="control-label"><span class="required">*</span>时间筛选</label>
                                            <div class="span4">
                                                <div class="control-group">
                                                    <label class="control-label span3"><span class="required">*</span> 开始时间</label>
                                                    <div class="controls"><input type="text" id="beginDate" name="beginDate" value="${dispatchingBonusLog.beginDate}" class="validate[required, custom[date],past[#endDate]] text-input span12" onkeypress="return false"/></div>
                                                </div>
                                            </div>
                                            <div class="span4">
                                                <div class="control-group">
                                                    <label class="control-label span3"><span class="required">*</span> 结束时间</label>
                                                    <div class="controls"><input type="text" id="endDate" name="endDate" value="${dispatchingBonusLog.endDate}" class="validate[required, custom[date],future[#beginDate]] text-input span12" onkeypress="return false"/></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row-fluid" id="tradeAmountGroup">
                                            <label class="control-label"><span class="required">*</span>投资金额</label>
                                            <div class="span4">
                                                <div class="control-group ">
                                                    <input type="radio" name="amount" value="0" class="validate[required] radio span3">
                                                    <span>累计金额 >= <input type="text" id="accumulativeAmount" name="accumulativeAmount" class="validate[custom[integer],max[9999999]] span3"  <c:if test="${dispatchingBonusLog.satisfyType == 2 }">value="${dispatchingBonusLog.satisfyInitialAmount}"</c:if>>元</span>
                                                </div>
                                            </div>
                                            <div class="span4">
                                                <div class="control-group ">
                                                    <input type="radio" name="amount" value="1" class="validate[required] radio span3" >
                                                    <span>单笔金额 >= <input type="text" id="singleAmount" name="singleAmount" class="validate[custom[integer],max[9999999]] span3" <c:if test="${dispatchingBonusLog.satisfyType == 1 }">value="${dispatchingBonusLog.satisfyInitialAmount}"</c:if> >元</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid" id="cellphoneIds">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 手机号</label>
                                            <div class="controls"><!-- <input type="text" id="condition" name="condition" class="validate[required,maxSize[20]] text-input span12"  placeholder="20个汉字以内"  onkeyup="preview('condition')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/> -->
                                                <textarea  id="cellphones" name="cellphones" rows="2" class="validate[required, custom[numberSemicolon], maxSize[599]] span10" placeholder="不同手机号之间以英文“;”间隔，最多50个">${dispatchingBonusLog.cellphones}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid" style="display: none">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label"><span class="required">*</span>银子来源</label>
                                                <div class="controls">
                                                    <input type="text" name="source" value="0" class="validate[required,maxSize[20]] text-input span10" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label"><span class="required">*</span>银子数量</label>
                                                <div class="controls">
                                                    <input type="text" id="quantity" name="quantity" value="${dispatchingBonusLog.quantity}" class="validate[required,min[1],max[9999],custom[integer]] text-input span10"/> 两
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label"><span class="required">*</span> 赠送日期</label>
                                                <div class="controls">
                                                    <input type="text" id="giveDate" name ="giveDate" value="${dispatchingBonusLog.giveDate}" class="validate[required] text-input span6" onkeypress="return false"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 赠送原因</label>
                                            <div class="controls">
                                                <textarea  id="reason" name="reason" rows="2" class="validate[required, maxSize[100]] span10" placeholder="50个汉字以内">${dispatchingBonusLog.reason}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span6" align="right">
                        <button type="submit" id="save" class="btn btn-success btn-lg">保存</button>
                    </div>
                    <div class="span6" align="left">
                        <a class="btn btn-default btn-lg" href="${pageContext.request.contextPath}/silver/give/list">返回</a>
                    </div>
                </div>
            </form>
            <!-- content end -->
            <div class="modal hide fade" id="bonus" role="dialog" >
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="myModalLabel">选择红包</h4>
                        </div>
                        <div class="modal-body">
                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>红包名称</th>
                                    <th>红包金额</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="bonusBody">
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="5">
                                        <div id="bonus-page"></div>
                                    </td>
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
    $(function() {
        $('#fm').validationEngine('attach', {
            promptPosition: 'centerRight',
            scroll: false,
            showOneMessage : true
        });
        $('#beginDate').datetimepicker({
            format:'Y-m-d',
            lang:'ch',
            timepicker:false
        });
        $('#endDate').datetimepicker({
            format:'Y-m-d',
            lang:'ch',
            timepicker:false
        });

        $('#giveDate').datetimepicker({
            format:'Y-m-d',
            lang:'ch',
            scrollInput:false,
            timepicker:false,
            minDate:new Date()
        });
        $('#conditionId').hide();
        $('#cellphoneIds').hide();
        $('#conditionsGoup').find('input:radio').click(function(){
            if($(this).val() == 0){
                $('#conditionId').show();
                $('#cellphoneIds').hide();
            }
            if($(this).val() == 1){
                $('#cellphoneIds').show();
                $('#conditionId').hide();
            }
        });

        $('#conditionsGoup').find('input:radio').eq('${dispatchingBonusLog.choiceType}').trigger('click');

        $('#tradeAmountGroup').find('input:radio').click(function(){
            if($(this).val() == 0){
                $('#accumulativeAmount').addClass('validate[required,min[1]]');
                $('#singleAmount').removeClass('validate[required,min[1]]');

            }
            if($(this).val() == 1){
                $('#accumulativeAmount').removeClass('validate[required,min[1]]');
                $('#singleAmount').addClass('validate[required,min[1]]');

            }
            $('#accumulativeAmount').blur();
            $('#singleAmount').blur();
        });
        $('#tradeAmountGroup').find('input:radio').eq(0).trigger('click');

        if(parseInt('${dispatchingBonusLog.satisfyType}') == 2){
            $('#tradeAmountGroup').find('input:radio').eq(0).trigger('click');
        }
        if(parseInt('${dispatchingBonusLog.satisfyType}') == 1){
            $('#tradeAmountGroup').find('input:radio').eq(1).trigger('click');
        }

        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active">银子管理&nbsp;/&nbsp;<a href="javascript:quit();">银子赠送</a>&nbsp;/&nbsp;编辑银子赠送</li>');
            $('#save').show();
        }else{
            $('.breadcrumb').html('<li class="active">银子管理&nbsp;/&nbsp;<a href="javascript:quit();">银子赠送</a>&nbsp;/&nbsp;查看银子赠送</li>');
            $('#save').hide();
            readOnly();
        }

    });

    function quit(){
        window.location.href='${pageContext.request.contextPath}/silver/give/list';
    }

    function startValidate() {
        var result = $('#fm').validationEngine('validate');
        var value = $('input[name=category]').filter(':checked').attr('value');
        if (result && value == 1) {
            var cellphones = $.trim($('#cellphones').val());
            if (cellphones && cellphones.length > 0) {
                var cellarry = cellphones.split(';');
                for (var i = 0; i < cellarry.length; i++) {
                    if (cellarry[i].length == 11) {
                        cellphones = cellphones.replace(cellarry[i], '');
                        if (cellphones.indexOf(cellarry[i]) > -1) {
                            alert('输入的手机号：'+cellarry[i]+'重复');
                            return false;
                        }
                    } else {
                        alert('输入的手机号：'+cellarry[i]+'无效');
                        return false;
                    }
                }
                $.ajaxSettings.async = false;
                $.post('${pageContext.request.contextPath}/coupon/user/exist', {'cellphones':$.trim($('#cellphones').val())}, function(result){
                    if (result && result.code == 200) {
                        var status = '${dispatchingBonusLog.status}';
                        $.ajaxSettings.async = false;
                        $.get('${pageContext.request.contextPath}/coupon/dispatching/log/${dispatchingBonusLog.id}', function(data){
                            if (data && data.status == status) {
                                flag = true;
                            } else {
                                alert('该信息的状态已发生改变，不能再进行修改');
                                flag = false;
                                return flag;
                            }
                        });
                    } else {
                        alert(result.msg + '未注册');
                        flag = false;
                    }
                });
                return flag;
            } else {
                alert('手机号不能为空');
            }
        }else{
            return true;
        }
        return false;
    }

    function readOnly(){
        var  a =  document.getElementsByTagName('input');
        for(var i=0; i<a.length;   i++)   {
            if(a[i].type=='checkbox' || a[i].type=='radio' || a[i].type=='text'){
                a[i].disabled = 'disabled';
            }
        }
        var b =  document.getElementsByTagName('select');
        for(var i=0; i<b.length; i++){
            b[i].disabled = 'disabled';
        }

        var c = document.getElementsByTagName('textarea');
        for   (var   i=0;   i<c.length;   i++){
            c[i].disabled = 'disabled';
        }
        var d = document.getElementsByTagName('button');
        for   (var   i=0;   i<d.length;   i++)   {
            d[i].disabled = 'disabled';
        }
    }
</script>
</html>