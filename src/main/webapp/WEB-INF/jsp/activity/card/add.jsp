<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <div class="row-fluid">
                <form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post"  action="${pageContext.request.contextPath}/bonus/card/save">
                    <div class="well" style="padding-bottom: 20px; margin: 0;">
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>名称</label>
                            <div class="controls"><input type="text" id="cardName" name="cardName" class="validate[required,minSize[10],maxSize[40]] text-input span9"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" /></div>
                        </div>
                        <div class="control-group" id="totalAmountGroup">
                            <label class="control-label"><span class="required">*</span>支付金额</label>
                            <div class="controls"><input type="text" id="realMoney" name="realMoney" value="1" readonly="readonly" class="text-input span9"/> (元)</div>
                        </div>
                        <div class="control-group" id="totalAmountGroup">
                            <label class="control-label"><span class="required">*</span>抵用金额</label>
                            <div class="controls"><input type="text" id="payMoney" name="payMoney" value="100" class="validate[required,custom[number],min[1],max[9999]] text-input span9" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" /> (元)</div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>生成数量</label>
                            <div class="controls"><input type="text" id="quantity" name="quantity" class="validate[required,custom[integer],min[1],max[99]] text-input span9" onkeyup="this.value=this.value.replace(/^0[0|1|2|3|4|5|6|7|8|9]/g, this.value.substring(this.value.length-1, this.value.length)).trim()" value="1"/> (张)</div>
                        </div>
                        <div class="control-group" id="interestDateGroup">
                            <label class="control-label"><span class="required">*</span>过期日期</label>
                            <div class="controls"><input type="text" id="expireDate" name ="expireDate" class="validate[required] text-input span9" onkeypress="return false"/></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>领取凭证</label>
                            <div class="controls"><input type="text" id="voucher" name="voucher" class="validate[required, minSize[6], maxSize[6] custom[integer]] text-input span9" /></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"></label>
                            <div class="controls">
                                <button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok">生成</button>
                                <button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="javascript:back();">返回</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- content end -->
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script type="text/javascript">
    $(document).ready(function(){
        var date = new Date();
        date.setDate(date.getDate()+61);

        $('.breadcrumb').html('<li class="active">红包管理&nbsp;/&nbsp;<a href="#" onclick="javascript:back();">支付卡管理</a>&nbsp;/&nbsp;新增支付卡</li>');
        $('#fm').validationEngine('attach', {
            promptPosition:'bottomLeft',
            showOneMessage: true,
            focusFirstField:true,
            scroll: true
        });

        $('#expireDate').datetimepicker({
            format:'Y-m-d',
            lang:'ch',
            scrollInput:false,
            timepicker:false,
            allowBlank:false,
            minDate:date.toLocaleDateString(),
            value:date.toLocaleDateString().replace(/\//g,"-"),
            yearStart:new Date().getFullYear(),
            onSelectDate:function() {
                var nowDate = new Date();
                var expireDateString = $('#expireDate').val();
                var expireDate = new Date(Date.parse(expireDateString.replace(/-/g,"/")));
                if(nowDate.getTime() > expireDate.getTime()) {
                    alert("过期日期必需是将来时间！");
                    $('#expireDate').val(new Date());
                }
            }
        });

    });

    function back(){
        window.location.href='${pageContext.request.contextPath}/bonus/card/list/1';
    }
</script>
</html>