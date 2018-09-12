<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/silver/goods/save">
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <input id="id" name="id" value="${goods.id}" type="hidden">
                                <input name="page" value="${page }" type="hidden">
                                <input name="size" value="${size }" type="hidden">
                                <input name="goodsAchieveAmount" value="${achieveAmount}"  type="hidden">
                                <input name="largerUrl" value="${goods.largerUrl}" type="hidden">
                                <input id="times" name="times" value="0" type="hidden">
                                <input id="discount" name="discount" value="10" type="hidden">
                                <input id="removeImg" name="removeImg" value="" type="hidden">
                                <input id="virtualGoods" value="${goods.virtualGoods}" type="hidden">
                                <input id="achieveAmount" name="achieveAmount" value="${achieveAmount}"  type="hidden">
                                <input id="financePeriod" name="financePeriod" value="0" type="hidden">
                                <!-- <input type="hidden" name="type" value="2"> -->
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 商品名称</label>
                                    <div class="controls"><input type="text" id="name" name="name" value="${goods.name}" placeholder="3~9个汉字" class="validate[required, minSize[6], maxSize[18]] text-input span11" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
                                </div>
                                <div class="row-fluid" id="typeGroup">
                                    <div class="span12">
                                        <label class="control-label"><span class="required">*</span>是否实物商品</label>
                                        <div class="controls">
                                            <div class="span2">
                                                <input type="radio" name="type" value="2"  class="radio span1" style="margin-top: -1px">
                                                <span> 实物商品 </span>
                                            </div>
                                            <div class="span2">
                                                <input type="radio" name="type" value="1"  class="radio span1" style="margin-top: -1px" >
                                                <span> 虚拟商品 </span>
                                            </div>
                                            <div class="span7">
                                                <input type="radio" name="type" value="3"  class="radio span1" style="margin-top: -1px" >
                                                <input type="file" id="fileUrl" name="codeFile" accept=".csv" onchange="javascript:showFileName(this)" style="display: none;" >
                                                <span id="codeFile" >第三方券码  | <a href="javascript:importCode();" > 选择CSV文件</a></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                 <div class="row-fluid" >
                                    <div class="span12">
                                        <label class="control-label"><span class="required">*</span>是否支持vip折扣</label>
                                        <div class="controls">
                                            <div class="span2">
                                                <input type="radio" name="vipDiscount" value="0"  class="radio span1" <c:if test="${goods.vipDiscount == 0 }"> checked="checked"</c:if> style="margin-top: -1px">
                                                <span>否</span>
                                            </div>
                                            <div class="span2">
                                                <input type="radio" name="vipDiscount" value="1"  class="radio span1"  <c:if test="${goods.vipDiscount == 1 }"> checked="checked"</c:if>   style="margin-top: -1px" >
                                                <span>是</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid" id="categoryGroup" style="display: none">
                                    <div class="span12">
                                        <label class="control-label"><span class="required">*</span> 商品类型</label>
                                        <div class="controls">
                                            <div class="span2">
                                                <input type="radio" name="category" value="0" class="validate[required] span1" style="margin-top: -1px" onclick="showDialog(this.value)">
                                                <span> 红包 </span>
                                            </div>
                                            <div class="span2">
                                                <input type="radio" name="category" value="1"  class="validate[required] span1" style="margin-top: -1px" onclick="showDialog(this.value)">
                                                <span> 加息券 </span>
                                            </div>
                                            <div class="span3">
                                                <input type="radio" name="category" value="2" class="validate[required] span1" style="margin-top: -1px;">
                                                <span> 流量币  <input type="text"  id="llb" class="text-input span6"/>牛 </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row-fluid" id="promptGroup">
                                    <div class="control-group">
                                        <label class="control-label"><span class="required">*</span>关联提示</label>
                                        <div class="controls"><input type="text" id="prompt" class="span7" readonly="readonly" onfocus="this.blur();" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>兑换所需银子</label>
                                            <div class="controls"><input type="text" name="consumeSilver" value="${goods.consumeSilver}" class="validate[required, custom[integer] min[0] max[1000000]] text-input span9"  onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 两</div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">兑换次数</label>
                                            <div class="controls"><input type="text" id="timesInput" class="validate[custom[integer] min[1] max[99]] text-input span9" <c:if test="${goods.times != 0 }">value="${goods.times}" </c:if> onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" /> 次</div>
                                        </div>
<!--                                         <div class="control-group"> -->
<!--                                             <label class="control-label">折扣</label> -->
<%--                                             <div class="controls"><input type="text" id ="discountInput" class="validate[custom[numberPercentageOne],min[1],max[10]] text-input span9" <c:if test="${goods.discount != 0.0 }">value="${goods.discount}" </c:if> onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 折</div> --%>
<!--                                         </div> -->
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>库存数量</label>
                                            <div class="controls"><input type="text" id="stock" name="stock" value="${goods.stock}" class="validate[required, custom[integer] min[1] max[10000]] text-input span9"   onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" /> 件</div>
                                        </div>
                                    </div>
                                </div>


                                <div class="row-fluid" class="span12"><label class="control-label">兑换条件</label></div>
                                <div class="control-group">
                                    <div></div>
                                    <div class="row-fluid span10 control-group s6" style="margin-left: 75px">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">开始日期</label>
                                                <div class="controls"><input type="text" id="beginDate" name="beginDate" <c:if test="${goods.beginDate != '1970-01-01'}">value="${goods.beginDate}"</c:if>  class="datepicker text-input span9" /></div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">结束日期</label>
                                                <div class="controls"><input type="text" id="endDate" name="endDate" <c:if test="${goods.endDate != '1970-01-01'}">value="${goods.endDate}"</c:if> class="datepicker text-input span9" /></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid span10 control-group s6" style="margin-left: 75px">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">累计投资</label>
                                                <div class="controls">
                                                    <input type="text" id="achieveAmountInput" name="achieveAmountInput" <c:if test="${goods.achieveAmount > 0}">value="${goods.achieveAmount}"</c:if>  class="validate[custom[integer] min[0] max[999999]] text-input span9" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/>元
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">理财期限</label>
                                                <div class="controls">
                                                    <input type="text" id="financePeriodInput" name="financePeriodInput" <c:if test="${goods.financePeriod > 0}">value="${goods.financePeriod}"</c:if>  class="validate[custom[integer] min[0] max[999]] text-input span9" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
<!--                                 <div class="row-fluid"> -->
<!--                                     <div class="control-group"> -->
<%--                                         <div class="controls"><input type="checkbox" name="isShow" id="isShow" <c:if test="${goods.isShow==1 }" >checked</c:if> value="1">库存为0时，在前端继续显示</div> --%>
<!--                                     </div> -->
<!--                                 </div> -->
                                <div class="row-fluid" >
                                    <label class="control-label"><span class="required">*</span>缩略图</label>
                                    <div class="controls" id="imageChoice">
                                        <div id="imgPreview"><img  name="image" style="height:220px; width: 300px;" src="${goods.url}"/></div>
                                        <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain()">重新上传</button></div>
                                        <input id="url" type="hidden" name="url" value="${goods.url}"/>
                                        <input id="urls" type="file" name="urls" accept="image/png, image/jpg" onchange="setImagePreview(this.id)" />
                                        <span><font class="msg">（图片建议尺寸：360*300，png或者jpg格式）</font></span>
                                    </div>
                                </div>
                                <br>
                                <div class="row-fluid">
                                    <label class="control-label"><span class="required">*</span>商品主图</label>
                                    <div class="controls">
                                        <div id="contractUploader"></div>
                                        <a class="thumbnail" style="float: left; height:270px; width: 217px;">
                                            <div style="height:240px; width: 217px;"></div>
                                            <button type="button" id="addContract" class="btn btn-lg" >添加</button>
                                        </a>
                                    </div>
                                    <span><font class="msg">（图片建议尺寸：750*280，png或者jpg格式）</font></span>
                                </div>
                                <br>
                                <div class="control-group" id="contentWrap">
                                    <label class="control-label"><span class="required">*</span>商品介绍</label>
                                    <div class="controls">
                                        <textarea cols="80" id="remark" name="remark">${goods.remark}</textarea>
                                    </div>
                                </div>
                                <hr class="separator" />
                                <div class="form-actions">
                                    <button type="submit" id="save" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
                                    <a type="reset" id="back" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit()"><i></i>取消</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal hide fade" id="coupon" style="width: 800px;" role="dialog" >
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
                            <thead>
                            <tr id="head">
                            </tr>
                            </thead>
                            <tbody id="couponBody">
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="5">
                                    <div id="coupon-page"></div>
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
<div class="modal hide fade" id="couponDialog" role="dialog" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myCouponLabel"></h4>
            </div>
            <div class="modal-body">
                <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
                    <!-- <thead>
                        <tr id="head">
                        </tr>
                   </thead> -->
                    <tbody id="couponInfo">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
<script type="text/javascript">
    var remark = '';
    $(function() {
        if('${goods.hot}' == 0){
            $('#hotf').click();
        }else{
            $('#hots').click();
        }
        $('#fm').validationEngine('attach', {
            promptPosition:'bottomLeft',
            showOneMessage: true,
            focusFirstField:true,
            scroll: false
        });
        $('#name').focus();
        $('#urls').hide();
        remark = UE.getEditor('remark');

        var strUrls = '${goods.largerUrl}'.split(";");
        var img ="";
        $('input[name=type][value=${goods.type}]').attr('checked',true);

        var workImg=document.getElementsByTagName('img');
        for(var i=0; i<workImg.length; i++) {
            workImg[i].onclick=ImgShow;
        }
        $('#beginDate').datetimepicker({
            format:'Y-m-d',
            lang:'ch',
            scrollInput:false,
            timepicker:false,
            onShow:function() {
                if ($('td').hasClass('xdsoft_other_month')) {
                    $('td').removeClass('xdsoft_other_month');
                }
            },
            onSelectDate:function() {
                var beginDate = $('#beginDate').val();
                var beginDate1 = new Date(Date.parse(beginDate.replace(/-/g,"/")));
                $('#endDate').datetimepicker({
                    format:'Y-m-d',
                    minDate:beginDate1.getFullYear()+'/'+(beginDate1.getMonth()+1)+'/'+beginDate1.getDate(),
                    lang:'ch',
                    scrollInput:false,
                    timepicker:false,
                    onShow:function() {
                        if ($('td').hasClass('xdsoft_other_month')) {
                            $('td').removeClass('xdsoft_other_month');
                        }
                    }
                });
            }
        });

        $('#endDate').datetimepicker({
            format:'Y-m-d',
            //minDate:new Date().toLocaleDateString(),
            lang:'ch',
            scrollInput:false,
            timepicker:false,
            onShow:function() {
                if ($('td').hasClass('xdsoft_other_month')) {
                    $('td').removeClass('xdsoft_other_month');
                }
            },
            onSelectDate:function() {
                var endDate = $('#endDate').val();
                var endDate1 = new Date(Date.parse(endDate.replace(/-/g,"/")));
                $('#beginDate').datetimepicker({
                    format:'Y-m-d',
                    maxDate:endDate1.getFullYear()+'/'+(endDate1.getMonth()+1)+'/'+endDate1.getDate(),
                    lang:'ch',
                    scrollInput:false,
                    timepicker:false,
                    onShow:function() {
                        if ($('td').hasClass('xdsoft_other_month')) {
                            $('td').removeClass('xdsoft_other_month');
                        }
                    }
                });
            }
        });

        $('#categoryGroup').hide();
        $('#promptGroup').hide();

        $('#typeGroup').find('input:radio').click(function(){
            if($.trim($(this).val()) == 1){
                $('#categoryGroup').show();
                $('#promptGroup').show();
                $('#stock').attr('readonly', false);
            }else{
                if($.trim($(this).val()) == 3){
                    $('#stock').attr('readonly', true);
                }else{
                    $('#stock').attr('readonly', false);
                }
                $('#categoryGroup').hide();
                $('#promptGroup').hide();
                //$('#prompt').val('');
            }
        });
        $('#categoryGroup').find('input:radio').click(function(){
            if($(this).attr("value") == 2){
                document.getElementById('llb').setAttribute("name","virtualGoods");
                document.getElementById('virtualGoods').removeAttribute("name");
                $('#llb').addClass('validate[required]');
                $('#prompt').removeClass('validate[required]');

                if($.trim('${goods.category}') == 2){
                    $('#llb').val('${goods.virtualGoods}');
                }
            }else{
                if($(this).attr("value") != '${goods.category}'){
                    $('#prompt').val('');
                }
                $('#llb').removeClass('validate[required]');
                $('#prompt').addClass('validate[required]');
                $('#llb').val('');
                document.getElementById('llb').removeAttribute("name");
                document.getElementById('virtualGoods').setAttribute("name","virtualGoods");
            }
        });
        if('${goods.type}' == '3'){
            $('#categoryGroup').hide();
            $('#promptGroup').hide();
            $('#typeGroup').find('input:radio').eq(2).trigger('click');
        }else if('${goods.type}' == '2'){
            $('#categoryGroup').hide();
            $('#promptGroup').hide();
            $('#typeGroup').find('input:radio').eq(0).trigger('click');
        }else{
            $('#categoryGroup').show();
            $('#promptGroup').show();
            $('#typeGroup').find('input:radio').eq(1).trigger('click');
            if('${goods.category}' == '0'){
                document.getElementById('virtualGoods').setAttribute("name","virtualGoods");
                document.getElementById('llb').removeAttribute("name");
                $('#llb').removeClass('validate[required]');
                $('#prompt').addClass('validate[required]');
                $('#categoryGroup').find('input:radio').eq(0).attr('checked',true);
            }
            if('${goods.category}' == '1'){
                document.getElementById('virtualGoods').setAttribute("name","virtualGoods");
                document.getElementById('llb').removeAttribute("name");
                $('#llb').removeClass('validate[required]');
                $('#prompt').addClass('validate[required]');
                $('#categoryGroup').find('input:radio').eq(1).attr('checked',true);
            }
            if('${goods.category}' == '2'){
                //$('#categoryGroup').find('input:radio').eq(2).trigger('click');
                $('#categoryGroup').find('input:radio').eq(2).trigger('click');
            }
            if('${goods.category}' != '2'){
                $.post('${pageContext.request.contextPath}/coupon/coupon/select',{couponId:$.trim('${goods.virtualGoods}')},function(result){
                    if(result.category <=  3){
                        $('#prompt').val(result.amount+'元'+result.condition);
                    }
                    if(result.category >  3){
                        $('#prompt').val('加息:'+result.amount+ result.financePeriod+'天'+result.condition);
                    }
                });
            }
        }

        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active">银子赠送&nbsp;/&nbsp;<a href="javascript:window.history.back();">银子商城管理</a>&nbsp;/&nbsp;编辑商品</li>');
            $('#save').show();
            for(var c = 0; c < strUrls.length; c++){
                if($.trim(strUrls[c])){
                    $('#contractUploader').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="contract'+c+'"><div style="height:240px; width: 217px;" id="contract-'+c+'"><img style="height:240px; width: 217px;" src="'+strUrls[c]+'"></div><input  id="contract_'+c+'" name="largerUrls'+c+'" type="file" accept="image/*" style="width:163px" onchange="imagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="javascript:delContract('+"'"+c+"M"+strUrls[c]+"'"+')"/></a>');
                }
            }
        }else{
            $('.breadcrumb').html('<li class="active">银子赠送管理 &nbsp;/&nbsp;<a href="javascript:window.history.back();">银子商城管理</a>&nbsp;/&nbsp;查看商品</li>');
            $('#save').hide();
            for(var c = 0; c < strUrls.length;c++){
                if($.trim(strUrls[c])){
                    $('#contractUploader').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="contract'+c+'"><div style="height:270px; width: 217px;" id="contract-'+c+'"><img style="height:270px; width: 217px;" src="'+strUrls[c]+'"></div></a>');

                }
            }
            readOnly();
            $('.msg').remove();
            $('#back').html('返回');
        }
    });

    function startValidate() {
        var endDate1 = $('#endDate').val();
        var endDate  = endDate1.replace(/-/g,"/");
        var beginDate1 = $('#beginDate').val();
        var beginDate = beginDate1.replace(/-/g,"/");
        var achieveAmount = $('#achieveAmountInput').val();
        var financePeriod = $('#financePeriodInput').val();
        if(($.trim(beginDate) != '' || $.trim(endDate) != '' || $.trim(achieveAmount) != '' || $.trim(financePeriod) != '') ){
            if(!($.trim(beginDate) != '' &&  $.trim(endDate) != '' && $.trim(achieveAmount) != '' && $.trim(financePeriod) != '')){
                //alert("开始时间、结束时间、投资满额请填写完整！");
                //return false;
                $('#achieveAmount').val(0);
                $('#achieveAmountInput').val(0);
                $('#financePeriodInput').val(0);
                $('#beginDate').val('1970-01-01');
                $('#endDate').val('1970-01-01');
                financePeriod = 0;
                achieveAmount = 0;
            } else {
                if(endDate.replace(/-/g,"/") < beginDate.replace(/-/g,"/")){
                    alert('亲，请选择结束时间不能小于开始时间！');
                    return false;
                }
            }
        } else {
            $('#achieveAmount').val(0);
            $('#achieveAmountInput').val(0);
            $('#financePeriodInput').val(0);
            $('#beginDate').val('1970-01-01');
            $('#endDate').val('1970-01-01');
            financePeriod = 0;
            achieveAmount = 0;
        }
        var flag = true;
        if (!$('#url').val()) {
            alert('请选择上传略缩图片');
            flag = false;
            return flag;
        }

        var times = $('#timesInput').val();
        if (times && times > 0) {
            $('#times').val(times);
        }
        if (achieveAmount) {
            $('#achieveAmount').val(achieveAmount);
        }
        if (financePeriod && financePeriod >= 0) {
            $('#financePeriod').val(financePeriod);
        }
        var discount = $('#discountInput').val();
        if (discount && discount > 0) {
            $('#discount').val(discount);
        }
        var str=$('#contractUploader').html();
        if(str.length>5){

        }else{
            alert('请选择要上传的主图片');
            flag = false;
            return flag;
        }

        var txt = remark.getContent();
        if($.trim(txt) == ''){
            $('#remark').addClass('validate[required]');
        }else if(txt.length > 10000){
            alert('字数超出限制');
            flag = false;
        }else{
            $('#remark').removeClass('validate[required]');
        }
        return flag;
    }

    var c = '${goods.largerUrl}'.split(";").length;
    $("#addContract").click(function(event) {
        $('#contractUploader').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="contract'+c+'"><div style="height:240px; width: 217px;" id="contract-'+c+'"></div><input  id="contract_'+c+'" name="largerUrls'+c+'" type="file" accept="image/*" style="width:163px" onchange="imagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="javascript:delContract('+"'"+c+"M"+'null'+"'"+')"/></a>');
        $('#contract_'+c).trigger('click');
        c = c + 1;
    });
    function delContract(param){
        $('#contract'+param.split('M')[0]).remove();
        if($.trim(param.split('M')[1]) != null){
            if($.trim($("#removeImg").val()) != ''){
                $("#removeImg").val($("#removeImg").val() +';' + param.split('M')[1]);
            }else{
                $("#removeImg").val(param.split('M')[1]);
            }
        }

    }

    function uploadAgain(){
        $('#urls').trigger('click');
    }

    function setImagePreview(fileInput) {
        var urlObj = $('#'+fileInput)[0];
        if(urlObj){
            var suffix = urlObj.files[0].name.split('.').pop().toLowerCase();
            if (suffix == 'png' || suffix == 'jpg') {
                if(urlObj.files[0].size <= (2102957)){
                    if(urlObj.files && urlObj.files[0]){
                        var img = $('<img style="height:220px; width: 290px;" src="'+window.URL.createObjectURL(urlObj.files[0])+'">');
                        $('#imgPreview').empty().append( img );
                    }
                }else{
                    $('#'+fileInput).val('');
                    alert('单个图片大小不能超过2M！');
                }

            } else {
                $('#'+fileInput).val('');
                alert('请选择建议的图片格式！');
                return false;
            }
        }
        return true;
    }
    function imagePreview(fileInput) {
        var urlObj = $('#'+fileInput)[0];
        if(urlObj){
            var suffix = urlObj.files[0].name.split('.').pop().toLowerCase();
            if (suffix == 'png' || suffix == 'jpg') {
                if(urlObj.files[0].size <= (2102957)){
                    if(urlObj.files && urlObj.files[0]){
                        var img = $('<img style="height:240px; width: 217px;" src="'+window.URL.createObjectURL(urlObj.files[0])+'">');
                        $('#'+(fileInput.split('_')[0]+'-'+fileInput.split('_')[1])).empty().append( img );
                    }
                }else{
                    $('#'+fileInput).val('');
                    alert('单个图片大小不能超过2M！');
                }

            } else {
                $('#'+fileInput).val('');
                alert('请选择建议的图片格式！');
                return false;
            }
        }
        return true;
    }

    function readOnly() {
        var a = document.getElementsByTagName('input');
        for(var i=0; i<a.length; i++) {
            if(a[i].type=='checkbox' || a[i].type=='radio' || a[i].type=='text'){
                a[i].readOnly = true;
                a[i].disabled = 'disabled';
            }
        }

        var b = document.getElementsByTagName("select");
        for(var i=0; i<b.length; i++) {
            b[i].disabled='disabled';
        }

        var c = document.getElementsByTagName("textarea");
        for (var i=0; i<c.length; i++) {
            c[i].disabled='disabled';
        }

        /* var d = document.getElementsByTagName("button");
        for (var i=0; i<d.length; i++) {
            d[i].disabled='disabled';
        } */
        document.getElementById('prompt').disabled=false;
        UE.getEditor('remark').addListener("ready", function () {
            UE.getEditor('remark').setDisabled('fullscreen');
        });
    }

    function quit() {
        $('#fm').attr('action','${pageContext.request.contextPath}/silver/goods/list');
        $('#fm').validationEngine('attach', {
            binded : false
        });
        $('#fm').attr('onsubmit','true');
        $('#fm').submit();
        //window.location.href='${pageContext.request.contextPath}/silver/goods/list';
    }

    function showDialog(category){
        $('#coupon').modal('show');
        getCoupon(1, category);
    }

    $('#prompt').bind('click',function(){
        if('${operation}' == 'detail'){
            showInfo()
        }
    });
    function getCoupon(page,category){
        $('#head').html("");
        if(category == 0){
            $('#head').append('<th style="width:30px;">序号</th>');
            $('#head').append('<th style="width:200px;">使用条件</th>');
            $('#head').append('<th>是否可转赠</th>');
            $('#head').append('<th>到期时间</th>');
            $('#head').append('<th>红包金额</th>');
            $('#head').append('<th>操作</th>');
            $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/'+ page, {'category':0}, function(result){
                if (result.total > 0) {
                    //$('#myModalLabel').empty().html('活动红包');
                    $('#couponBody').html("");
                    for (var i = 0; i < result.bonus.length; i++) {
                        var b = result.bonus[i];
                        $('#couponBody').append('<tr>');
                        $('#couponBody').append('<td class="hidden">'+b.id+'</td>');
                        $('#couponBody').append('<td>'+(i+1)+'</td>');
                        $('#couponBody').append('<td style="width:45%">'+b.condition+'</td>');
                        if (b.donation == 0) {
                            $('#couponBody').append('<td>不可转赠</td>');
                        } else {
                            $('#couponBody').append('<td>可转赠</td>');
                        }
                        if (b.lifeCycle == 0) {
                            $('#couponBody').append('<td>一万年有效</td>');
                        } else if (b.lifeCycle == 1) {
                            $('#couponBody').append('<td>'+b.expiresPoint+'到期</td>');
                        } else if (b.lifeCycle == 2) {
                            $('#couponBody').append('<td>自领取后'+b.expiresPoint+'天过期</td>');
                        }else {
                            $('#couponBody').append('<td></td>');
                        }
                        $('#couponBody').append('<td>'+b.amount+'元</td>');
                        var _t = b.condition;
                        _t = _t.replace(' ', '');
                        $('#couponBody').append('<td><a href=javascript:choiceCoupon('+b.id+',"'+ _t +'"'+','+b.amount+','+0+',0'+');>选择</a></td>');
                        $('#couponBody').append('</tr>');
                    }

                    var totalPages = Math.ceil(result.total/15);
                    var options = {
                        currentPage: page,
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
                            getCoupon(page,category);
                        }
                    };
                    $('#coupon-page').bootstrapPaginator(options);
                }else{
                    $('#couponBody').html('<tr><td colspan="5">请先添加活动红包</td></tr>');
                }
            });
        }else if(category == 1){
            $('#head').append('<th style="width:30px;">序号</th>');
            $('#head').append('<th style="width:200px;">使用条件</th>');
            $('#head').append('<th>是否可转赠</th>');
            $('#head').append('<th>到期时间</th>');
            $('#head').append('<th>加息额度</th>');
            $('#head').append('<th>操作</th>');
            $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/' + page, {'type':2}, function(result){
                if (result.total > 0) {
                    //$('#myModalLabel').empty().html('活动加息券');
                    $('#couponBody').html('');
                    for (var i = 0; i < result.bonus.length; i++) {
                        var b = result.bonus[i];
                        $('#couponBody').append('<tr>');
                        $('#couponBody').append('<td class="hidden">'+b.id+'</td>');
                        $('#couponBody').append('<td>'+(i+1)+'</td>');
                        $('#couponBody').append('<td style="width:45%">'+b.condition+'</td>');
                        if (b.donation == 0) {
                            $('#couponBody').append('<td>不可转赠</td>');
                        } else {
                            $('#couponBody').append('<td>可转赠</td>');
                        }
                        if (b.lifeCycle == 0) {
                            $('#couponBody').append('<td>一万年有效</td>');
                        } else if (b.lifeCycle == 1) {
                            $('#couponBody').append('<td>'+b.expiresPoint+'到期</td>');
                        } else if (b.lifeCycle == 2) {
                            $('#couponBody').append('<td>自领取后'+b.expiresPoint+'天过期</td>');
                        }else {
                            $('#couponBody').append('<td></td>');
                        }
                        $('#couponBody').append('<td>'+b.amount +'%'+b.increaseDays+'天</td>');
                        var _t = b.condition;
                        _t = _t.replace(' ', '');
                        $('#couponBody').append('<td><a href=javascript:choiceCoupon('+b.id+',"'+ _t +'"'+','+b.amount+','+b.increaseDays+',1'+');>选择</a></td>');
                        $('#couponBody').append('</tr>');
                    }

                    var totalPages = Math.ceil(result.total/15);
                    var options = {
                        currentPage: page,
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
                            getCoupon(page,category);
                        }
                    };
                    $('#coupon-page').bootstrapPaginator(options);
                }else{
                    $('#couponBody').html('<tr><td colspan="5">请先添加活动加息券</td></tr>');
                }
            });
        }else{
            //do nothing
        }
    }

    function choiceCoupon(couponId,tempConcent,amount, time, type){
        $('#virtualGoods').val(couponId);
        if(type == 0){
            $('#prompt').val(amount + '元 '+tempConcent);
        }
        if(type == 1){
            $('#prompt').val('加息:' +amount + '% '+time+'天 '+tempConcent);
        }
        $('#coupon').modal('hide');
    }

    function importCode(){
        $('#fileUrl').trigger('click');
    }
    function formSubmit(){
        /* $('#times').setAttribute("value",$('#timesInput').val());
        $('#discount').setAttribute("value",$('#discountInput').val());
        $('#achieveAmount').setAttribute("value",$('#achieveAmountInput').val()); */
        $('fm').submit();
    }
    function showFileName(imgFile){
        d3.csv(window.URL.createObjectURL(imgFile.files[0]), function(d) {
            if(d.code.length > 0 && d.code.length <= 20){
                return {
                    length: + d.length // convert "Length" column to number
                };
            }

        }, function(error, rows) {
            if(typeof(rows)  == 'undefined'){
                alert('所选文件格式不正确，请修改文件格式');
                $('#fileUrl').val('');
            }else{
                if(rows.length > 1000){
                    alert('所选文件可导入券码数量超过 1000 条,将只导入前 1000 条');
                    $('#stock').val(1000);
                }else{
                    $('#stock').val(rows.length);
                }
                $('#codeFile').empty().append('第三方券码  | <a href="javascript:importCode();" > 选择CSV文件</a>' + ' | ' + imgFile.value);
            }
            $('#stock').blur();
        });
    }

    function showInfo(){
        $('#couponDialog').modal('show');
        var couponId = $('#virtualGoods').val();
        getCouponInfo(couponId);
    }

    function getCouponInfo(couponId){
        $('#head').html("");
        $.get('${pageContext.request.contextPath}/coupon/coupon/detail',{couponId:couponId} , function(result){
            if (result != null) {
                $('#myCouponLabel').empty().html('优惠券信息');
                if(result.category < 4){
                    $('#couponInfo').html("");
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td width="80">使用条件</td>');
                    $('#couponInfo').append('<td>'+result.condition+'</td>');
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>红包类型</td>');
                    if(result.category == 0){
                        $('#couponInfo').append('<td>'+'固定红包'+'</td>');
                    }
                    if(result.category == 1){
                        $('#couponInfo').append('<td>'+'概率红包'+'</td>');
                    }
                    if(result.category == 4){
                        $('#couponInfo').append('<td>'+'加息券'+'</td>');
                    }
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>红包金额</td>');
                    $('#couponInfo').append('<td>'+result.amount+'元</td>');
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>可否转赠</td>');
                    if (result.donation == 0) {
                        $('#couponInfo').append('<td>不可转赠</td>');
                    } else {
                        $('#couponInfo').append('<td>可转赠</td>');
                    }
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>有效期限</td>');
                    if(result.lifeCycle == 0){
                        $('#couponInfo').append('<td>'+'一万年有效'+'</td>');
                    }
                    if(result.lifeCycle == 1){
                        $('#couponInfo').append('<td>'+result.expiresPoint+'到期</td>');
                    }
                    if(result.lifeCycle == 2){
                        $('#couponInfo').append('<td>'+'自领取后'+result.expiresPoint+'天</td>');
                    }
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>投资金额</td>');
                    if(result.moneyLimit == 0){
                        $('#couponInfo').append('<td>'+'不限制 </td>');
                    }
                    if(result.moneyLimit == 1){
                        $('#couponInfo').append('<td>单笔满'+result.tradeAmount+'元可用 </td>');
                    }
                    if(result.moneyLimit == 2){
                        $('#couponInfo').append('<td>累计满'+result.tradeAmount+'元可用 </td>');
                    }
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>理财期限</td>');
                    if(result.financePeriod == 0){
                        $('#couponInfo').append('<td>'+'不限制 </td>');
                    }else{
                        $('#couponInfo').append('<td>'+result.financePeriod+'天及以上 </td>');
                    }
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>备注</td>');
                    $('#couponInfo').append('<td>'+result.remark+'</td>');
                    $('#couponInfo').append('</tr>');
                }else{
                    $('#couponInfo').html("");
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td width="80">使用条件</td>');
                    $('#couponInfo').append('<td>'+result.condition+'</td>');
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>加息券收益</td>');
                    $('#couponInfo').append('<td>'+result.amount+'%</td>');
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>加息天数</td>');
                    $('#couponInfo').append('<td>'+result.increaseDays+'天</td>');
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>可否转赠</td>');
                    if (result.donation == 0) {
                        $('#couponInfo').append('<td>不可转赠</td>');
                    } else {
                        $('#couponInfo').append('<td>可转赠</td>');
                    }
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>有效期限</td>');
                    if(result.lifeCycle == 0){
                        $('#couponInfo').append('<td>'+'一万年有效'+'</td>');
                    }
                    if(result.lifeCycle == 1){
                        $('#couponInfo').append('<td>'+result.expiresPoint+'到期</td>');
                    }
                    if(result.lifeCycle == 2){
                        $('#couponInfo').append('<td>'+'自领取后'+result.expiresPoint+'天</td>');
                    }
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>投资金额</td>');
                    if(result.moneyLimit == 0){
                        $('#couponInfo').append('<td>'+'不限制 </td>');
                    }
                    if(result.moneyLimit == 1){
                        $('#couponInfo').append('<td>单笔满'+result.tradeAmount+'元可用 </td>');
                    }
                    if(result.moneyLimit == 2){
                        $('#couponInfo').append('<td>累计满'+result.tradeAmount+'元可用 </td>');
                    }
                    $('#couponInfo').append('</tr>');
                    $('#couponInfo').append('<tr>');
                    $('#couponInfo').append('<td>备注</td>');
                    $('#couponInfo').append('<td>'+result.remark+'</td>');
                    $('#couponInfo').append('</tr>');
                }
            }else{
                $('#couponInfo').html('<tr><td colspan="2">请先添加优惠券</td></tr>');
            }
        });
    }
</script>
</body>
</html>