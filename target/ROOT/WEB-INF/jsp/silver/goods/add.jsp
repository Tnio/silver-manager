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
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form class="form-horizontal" enctype="multipart/form-data" id="from10" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/silver/goods/save">
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <input id="id" name="id" value="0" type="hidden">
                                <input name="page" value="${page}" type="hidden">
                                <input name="size" value="${size}" type="hidden">
                                <input id="virtualGoods" value="${goods.virtualGoods}" type="hidden">
                                <input id="times" name="times" value="0" type="hidden">
                                <input id="achieveAmount" name="achieveAmount" value="0" type="hidden">
                                <input id="financePeriod" name="financePeriod" value="0" type="hidden">
                                <input id="discount" name="discount" value="10" type="hidden">
                                <!-- <input type="hidden" name="type" value="2"> -->
                                <div class="row-fluid">
                                    <div class="control-group">
                                        <label class="control-label"><span class="required">*</span> 商品名称</label>
                                        <div class="controls"><input type="text" id="name" name="name" placeholder="3~9个汉字" class="validate[required, minSize[6], maxSize[18]] text-input span11" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
                                    </div>
                                </div>
                                <div class="row-fluid" id="typeGroup">
                                    <div class="span12">
                                        <label class="control-label"><span class="required">*</span>是否实物商品</label>
                                        <div class="controls">
                                            <div class="span2">
                                                <input type="radio" name="type" value="2"  class="radio span1" checked="checked" style="margin-top: -1px">
                                                <span> 实物商品 </span>
                                            </div>
                                            <div class="span2">
                                                <input type="radio" name="type" value="1"  class="radio span1" style="margin-top: -1px" >
                                                <span> 虚拟商品 </span>
                                            </div>
                                            <div class="span7">
                                                <input type="radio" name="type" value="3"  class="radio span1" style="margin-top: -1px" >
                                                <input type="file" id="fileUrl" name="codeFile" accept=".csv" onchange="javascript:showFileName(this)" style="display: none;" >
                                                <span id="codeFile" >第三方券码  | <a href="javascript:importCode();" > 选择CSV文件 </a></span>
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
                                                <input type="radio" name="vipDiscount" value="0"  class="radio span1" checked="checked" style="margin-top: -1px">
                                                <span>否</span>
                                            </div>
                                            <div class="span2">
                                                <input type="radio" name="vipDiscount" value="1"  class="radio span1" style="margin-top: -1px" >
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
                                                <input type="radio" name="category" value="0"  class="validate[required] span1" style="margin-top: -1px" onclick="showDialog(this.value)">
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
                                        <div class="controls"><input type="text" name="prompt"  id="prompt" class="text-input span7" readonly="readonly" onfocus="this.blur();" /></div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>兑换所需银子</label>
                                            <div class="controls"><input type="text" name="consumeSilver" class="validate[required, custom[integer] min[1] max[1000000]] text-input span9"  onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" /> 两</div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>商品库存</label>
                                            <div class="controls"><input type="text" id="stock" name="stock" class="validate[required, custom[integer] min[1] max[10000]] text-input span9"/> 件</div>
                                        </div>
                                        <!-- <div class="control-group">
                                            <label class="control-label">排序</label>
                                            <div class="controls"><input type="text" name ="sortNumber" class="validate[custom[integer],min[1],max[999]] text-input span9" value="999"  onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/></div>
                                        </div> -->
                                    </div>
                                </div>

                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label">兑换次数</label>
                                            <div class="controls"><input type="text" id="timesInput" class="validate[custom[integer] min[1] max[99]] text-input span9"  onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" /> 次</div>
                                        </div>
                                    </div>
<!--                                     <div class="span6"> -->
<!--                                         <div class="control-group"> -->
<!--                                             <label class="control-label">折扣</label> -->
<!--                                             <div class="controls"><input type="text" id ="discountInput" class="validate[custom[numberPercentageOne],min[1],max[10]] text-input span9" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 折</div> -->
<!--                                         </div> -->
<!--                                     </div> -->
                                </div>
                                <div class="row-fluid" class="span12"><label class="control-label">兑换条件</label></div>
                                <div class="control-group">
                                    <div></div>
                                    <div class="row-fluid span10 control-group s6" style="margin-left: 75px">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">开始日期</label>
                                                <div class="controls"><input type="text" id="beginDate" name="beginDate" class="datepicker text-input span9" /></div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">结束日期</label>
                                                <div class="controls"><input type="text" id="endDate" name="endDate" class="datepicker text-input span9" /></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid span10 control-group s6" style="margin-left: 75px">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">累计投资</label>
                                                <div class="controls">
                                                    <input type="text" id="achieveAmountInput" name="achieveAmountInput" class="validate[custom[integer] min[1] max[999999]] text-input span9" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/>元
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">理财期限</label>
                                                <div class="controls">
                                                    <input type="text" id="financePeriodInput" name="financePeriodInput" class="validate[custom[integer] min[0] max[999]] text-input span9" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
<!--                                 <div class="row-fluid"> -->
<!--                                     <div class="control-group"> -->
<!--                                         <div class="controls"><input type="checkbox" name="isShow" id="isShow" value="1">库存为0时，在前端继续显示</div> -->
<!--                                     </div> -->
<!--                                 </div> -->
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group" style="display: none">
                                            <label class="control-label"><span class="required">*</span>是否热卖</label>
                                            <div class="row-fluid">
                                                <div class="span3">
                                                    <div class="control-group ">
                                                        <input type="radio" name="hot" value="0" checked="checked" class="validate[required] radio span4">
                                                        <span >否</span>
                                                    </div>
                                                </div>
                                                <div class="span3">
                                                    <div class="control-group ">
                                                        <input type="radio" name="hot" value="1" class="validate[required] radio span4">
                                                        <span >是</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid" >
                                    <label class="control-label"><span class="required">*</span>缩略图</label>
                                    <div class="controls" id="imageChoice">
                                        <div id="imgPreview"></div>
                                        <input id="urls" type="file" name="urls" accept="image/png, image/jpg" onchange="setImagePreview(this.id)" />
                                        <span><font class="msg">（图片建议尺寸：360*300，png或者jpg格式）</font></span>
                                    </div>
                                </div>
                                <br>
                                <div class="row-fluid">
                                    <label class="control-label"><span class="required">*</span>商品主图</label>
                                    <div class="controls">
                                        <div id="contractUploader"></div>
                                        <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                            <div style="height:270px; width: 217px;"></div>
                                            <button type="button" id="addContract" class="btn btn-lg" >添加</button>
                                        </a>
                                    </div>
                                    <span><font class="msg">（图片建议尺寸：750*280，png或者jpg格式）</font></span>
                                </div>
                                <br>
                                <div class="control-group" id="contentWrap">
                                    <label class="control-label"><span class="required">*</span>商品介绍</label>
                                    <div class="controls">
                                        <textarea cols="80" id="remark" name="remark"></textarea>
                                    </div>
                                </div>
                                <hr class="separator" />
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok" ><i></i>保存</button>
                                    <button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit()"><i></i>返回</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal hide fade" id="coupon"  style="width: 800px;" role="dialog" >
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
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<script type="text/javascript">
    var remark = '';
    $(function() {
        $('#from10').validationEngine('attach', {
            promptPosition:'bottomLeft',
            showOneMessage: true,
            focusFirstField:true,
            scroll: false
        });
        remark = UE.getEditor('remark');
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
    });
    $('.breadcrumb').html('<li class="active">银子管理 &nbsp;/&nbsp;<a href="javascript:quit();">银子商城管理</a>&nbsp;/&nbsp;新增商品</li>');

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

    function startValidate() {
        var beginDate=document.getElementById("beginDate").value;
        var endDate=document.getElementById("endDate").value;
        var achieveAmount=$('#achieveAmountInput').val();
        var financePeriod=$('#financePeriodInput').val();
        if(($.trim(beginDate) != '' || $.trim(endDate) != '' || $.trim(achieveAmount) != '' || $.trim(financePeriod) != '') && $.trim(achieveAmount) != 0 && $.trim(financePeriod) != 0 ){
            if(!($.trim(beginDate) != '' &&  $.trim(endDate) != '' && $.trim(achieveAmount) != '' && $.trim(financePeriod) != '')){
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
        }
        var flag = true;
        if (!$('#urls').val()) {
            alert('请选择上传略缩图片');
            flag = false;
            return flag;
        }
        var times = $('#timesInput').val();
        if (times && times > 0) {
            $('#times').val(times);
        }
        var achieveAmount = $('#achieveAmountInput').val();
        if (achieveAmount && achieveAmount >= 0) {
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
            var strimg=$('input[name="largerUrls0"]').val();
            if(strimg.length<1){
                alert('请选择要上传的主图片');
                flag = false;
                return flag;
            }
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
    var c = 0;
    $("#addContract").click(function(event) {
        $('#contractUploader').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="contract'+c+'"><div style="height:270px; width: 217px;" id="contract-'+c+'"></div><input  id="contract_'+c+'" name="largerUrls'+c+'" type="file" accept="image/*" style="width:160px" onchange="imagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delContract('+c+')"/></a>');
        $('#contract_'+c).trigger('click');
        c = c + 1;
    });
    function delContract(o){
        $('#contract'+o).remove();
    }
    function quit() {
        window.location.href='${pageContext.request.contextPath}/silver/goods/list';
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
                        var img = $('<img style="height:270px; width: 217px;" src="'+window.URL.createObjectURL(urlObj.files[0])+'">');
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

    function showDialog(category){
        $('#coupon').modal('show');
        getCoupon(1,category);
    }

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
                    $('#couponBody').html("");
                    for (var i = 0; i < result.bonus.length; i++) {
                        var b = result.bonus[i];
                        $('#couponBody').append('<tr>');
                        $('#couponBody').append('<td class="hidden">'+b.id+'</td>');
                        $('#couponBody').append('<td>'+(i+1)+'</td>');
                        $('#couponBody').append('<td>'+b.condition+'</td>');
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
                        $('#couponBody').append('<td>'+b.amount+'%'+b.increaseDays+'天</td>');
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
</script>
</body>
</html>