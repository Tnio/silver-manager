<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
<link href="${pageContext.request.contextPath}/plugin/select/select2.css" rel="stylesheet" />
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
                        <form class="form-horizontal" style="margin-bottom: 0;" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/client/merchant/save">
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <input id="id" name="id" value="0" type="hidden">
                                <input id="address" name="address" value="" type="hidden">
                                <input name="page" value="${page }" type="hidden">
                                <input name="size" value="${size }" type="hidden">
                                <input name="searchName" value="${searchName}" type="hidden">
                                <!-- <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 借款类型</label>
                                    <div class="controls">
                                        <select id="type" name="type" class="validate[required] span10" onchange="selectType()">
                                            <option value="0">商户借款</option>
                                            <option value="1">个人借款</option>
                                        </select>
                                    </div>
                                </div> -->
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span>企业名称</label>
                                    <div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="最多40个字符" class="validate[required, maxSize[40]] text-input span10" name="name" /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 法人姓名</label>
                                    <div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="最多20个字符" class="validate[required, maxSize[20]] text-input span10" name="legalPerson" /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 联系人</label>
                                    <div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="最多20个字符" class="validate[required, maxSize[20]] text-input span10" name="linkman" /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 联系人手机号</label>
                                    <div class="controls"><input type="text" class="validate[required, minSize[11] maxSize[11]] text-input span10" name="cellphone" /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 企业地址</label>
                                    <div class="controls">
                                        <select name="province" class="validate[required] text-input span3" id="province" ></select>
                                        <select name="city" class="validate[required] text-input span3" id="city" ></select>
                                        <select name="county" class="validate[required] text-input span4" id="county" ></select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 详细地址</label>
                                    <div class="controls"><input type="text" placeholder="最多100个字符" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" class="validate[required, maxSize[100]] text-input span10" id="detailAddress" /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 商户银行账户</label>
                                    <div class="controls"><input type="text" id="cardNO" name="cardNO" class="validate[required, custom[bankCode]] text-input span10" /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 所属银行</label>
                                    <div class="controls">
                                        <select id="bankNO" name="bankNO" class="validate[required] span10">
                                            <option value=""></option>
                                            <c:forEach items="${unionPayBanks}" var="bank">
                                                <option value="${bank.bankNO}">${bank.bankName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="control-group">
                                        <label class="control-label"><span class="required">*</span> 开户支行名称</label>
                                        <div class="controls">
                                            <select id="provinceCode" data-plugin-selectTwo name="provinceCode" class="provinceCode" >
                                                <option value="">选择省份</option>
                                                <c:forEach items="${provinces}" var="province">
                                                    <option value="${province.provinceCode}">${province.province}</option>
                                                </c:forEach>
                                            </select>
                                            <select id="cityCode" data-plugin-selectTwo name="cityCode" class="provinceCode">
                                            </select>
                                            <select id="payVoucher" name="payVoucher" data-plugin-selectTwo class="payVoucher">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" id="licenseLabel"><span class="required">*</span>营业执照号</label>
                                    <div class="controls">
                                        <input id="licenseNO" type="text" name="licenseNO" placeholder="最多30个字符" class="validate[required]  text-input span10" maxlength="30"  onblur="checklicenseNO()" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 存管电子账户</label>
                                    <div class="controls">
                                        <input id="accountId" type="text" name="accountId" placeholder="最多19个字符" class="validate[required ,custom[accountIdCode]]  text-input span10" maxlength="19"/>
                                    </div>
                                </div>
                                <!-- <div class="row-fluid">
                                      <div class="control-group span9">
                                        <label class="control-label"><span class="required">*</span> 短信提醒</label>
                                        <div class="controls">
                                            <div class="span4">
                                                <input type="radio" name="closeNotice" checked="checked" value="0"  class="validate[required] span1" style="margin-top: -1px">
                                                <span>发</span>
                                            </div>
                                            <div class="span4">
                                                <input type="radio" name="closeNotice" value="1" class="validate[required] span1" style="margin-top: -1px;">
                                                <span>不发</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>  -->
                                <div class="row-fluid">
                                    <div class="span4" id="licensesDiv">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 营业执照</label>
                                            <div class="controls">
                                                <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                    <div style="height:270px;width:217px;" id="preview_licenses" ></div>
                                                    <input  id="licenses" name="licenses" type="file" accept="image/*" style="width:163px" onchange="setContractPreview(this.id)"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4">
                                        <div class="control-group" id="legalPersonIdcardsDiv">
                                            <label class="control-label"><span class="required">*</span> 法人身份证</label>
                                            <div class="controls">
                                                <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                    <div style="height:270px;width:217px;" id="preview_legalPersonIdcards" ></div>
                                                    <input  id="legalPersonIdcards" name="legalPersonIdcards" type="file" accept="image/*" style="width:163px" onchange="setContractPreview(this.id)"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span4">
                                        <div class="row-fluid">
                                            <label class="control-label">商户实拍图</label>
                                            <div class="controls">
                                                <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                    <div style="height:270px;width:217px;" id="preview_realDiagrams" ></div>
                                                    <input  id="realDiagrams" name="realDiagrams" type="file" accept="image/*" style="width:163px" onchange="setContractPreview(this.id)"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- <div class="span4">
                                        <div class="row-fluid">
                                            <label class="control-label">租任合同</label>
                                            <div class="controls">
                                                <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                    <div style="height:270px;width:217px;" id="preview_leasingContract" ></div>
                                                    <input  id="leasingContract" name="leasingContracts" type="file" accept="image/*" style="width:163px" onchange="setContractPreview(this.id)"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div> -->
                                    <div class="span4">
                                        <div class="row-fluid">
                                            <label class="control-label"><span class="required"></span> 商户承诺书</label>
                                            <div class="controls">
                                                <!-- <div id="commitmentUpload"></div> -->
                                                <a class="thumbnail"  style="float: left; height:300px; width: 217px;">
                                                    <div style="height:270px; width: 217px;" id="preview_letterOfCommitment"></div>
                                                    <input  id="letterOfCommitment" name="letterOf" type="file" accept="image/*" style="width:163px" onchange="setContractPreview(this.id)"/>
                                                    <!-- <button type="button" id="addCommitment" class="btn btn-lg">添加</button> -->
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span4" id="licenceImgsDiv">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 开户许可证</label>
                                            <div class="controls">
                                                <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                    <div style="height:270px;width:217px;" id="preview_licenceImgs" ></div>
                                                    <input  id="licenceImgs" name="licenceImgs" type="file" accept="image/*" style="width:163px" onchange="setContractPreview(this.id)"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- <div class="row-fluid">
                                    <div class="row-fluid">
                                        <label class="control-label"><span class="required"></span> 商户承诺书</label>
                                        <div class="controls">
                                            <div id="commitmentUpload"></div>
                                            <a class="thumbnail" id="addDiv" style="float: left; height:300px; width: 217px;">
                                                <div style="height:270px; width: 217px;"></div>
                                                <button type="button" id="addCommitment" class="btn btn-lg">添加</button>
                                            </a>
                                        </div>
                                    </div>
                                </div> -->
                                <div class="row-fluid">
                                    <div class="row-fluid">
                                        <label class="control-label"><span class="required"></span>其它资料</label>
                                        <div class="controls">
                                            <div id="commitmentUpload"></div>
                                            <a class="thumbnail" id="addDiv" style="float: left; height:300px; width: 217px;">
                                                <div style="height:270px; width: 217px;"></div>
                                                <button type="button" id="addCommitment" class="btn btn-lg">添加</button>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
                                    <a href="javascript:quit();"><button type="button" class="btn">返回</button></a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<script src="${pageContext.request.contextPath}/js/area.js"></script>
<script src="${pageContext.request.contextPath}/plugin/select/modernizr.js"></script>
<script src="${pageContext.request.contextPath}/plugin/select/nanoscroller.js"></script>
<script src="${pageContext.request.contextPath}/plugin/select/select2.js"></script>
<script src="${pageContext.request.contextPath}/plugin/select/theme.js"></script>
<script src="${pageContext.request.contextPath}/plugin/select/theme.init.js"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js"></script>
<script type="text/javascript">
    var ge = 0;
    var geCount = 0;
    $("#addCommitment").click(function() {
        if(geCount < 10){
            $('#commitmentUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="commitment'+ge+'"><div style="height:270px; width: 217px;" id="commitment-'+ge+'"></div><input id="commitment_'+ge+'" name="commitment'+ge+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delGuarantee('+ge+')"/></</a>');
            $('#commitment_'+ge).trigger('click');
            ge = ge + 1;
            geCount = geCount + 1;
            if (geCount < 10) {
                $('#addDiv').show();
            } else {
                $('#addDiv').hide();
            }
        }else{
            alert('不超过10张!');
        }
    });

    function delGuarantee(o){
        $('#commitment'+o).remove();
        geCount = geCount - 1;
        $('#addDiv').show();
    }

    function setContractPreview(fileInput) {
        var urlObj = $('#'+fileInput)[0];
        if(urlObj){
            var suffix = urlObj.files[0].name.split('.').pop().toLowerCase();
            if (suffix == 'png' || suffix == 'jpg') {
                if(urlObj.files[0].size <= (2102957)){
                    if(urlObj.files && urlObj.files[0]){
                        var img = $('<img style="height:270px; width: 217px;" src="'+window.URL.createObjectURL(urlObj.files[0])+'">');
                        $('#preview_'+fileInput).empty().append(img);
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

    function setImagePreview(fileInput) {
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


    $(function() {
        $('#fm').validationEngine('attach', {
            promptPosition:'bottomRight',
            inlineValidation: true,
            validationEventTriggers:'click blur',
            showOneMessage: true,
            focusFirstField:true,
            scroll: true
        });

        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;<a href="javascript:quit();">借款人管理</a>&nbsp;/&nbsp;新增</li>');
        setup();
    });
    $('.provinceCode').css('width', '20%');
    $('.payVoucher').css('width', '42%');
    $('#provinceCode').change(function() {
        var code = $('#provinceCode').val();
        $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/city/' + code, function(result){
            if (result && result.length > 0) {
                var html = '<option value="">选择城市</option>';
                for (var i = 0; i < result.length; i++) {
                    html += '<option value="' + result[i].city + '">' + result[i].city + '</option>';
                }
                $('#cityCode').html(html);
                $('#cityCode').select2('val', '');
                //$('#cityCode').select2('val', result[0].cityCode);
            }
        });
    });

    $('#cityCode').change(function() {
        var city = $('#cityCode').val();
        var provinceCode = $('#provinceCode').val();
        var bankCode = $('#bankNO').val();
        if (bankCode) {
            $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode + '/' + bankCode, {'city' : city}, function(result){
                if (result && result.length > 0) {
                    var html = '<option value="">选择支行</option>';
                    for (var i = 0; i < result.length; i++) {
                        html += '<option value="' + result[i].payVoucher + '">' + result[i].brabankName + '</option>';
                    }
                    $('#payVoucher').html(html);
                    $('#payVoucher').select2('val', result[0].payVoucher);
                } else {
                    alert('该城市下暂无支行！');
                }
            });
        } else {
            $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode, {'city' : city}, function(result){
                if (result && result.length > 0) {
                    var html = '<option value="">选择支行</option>';
                    for (var i = 0; i < result.length; i++) {
                        html += '<option value="' + result[i].payVoucher + '">' + result[i].brabankName + '</option>';
                    }
                    $('#payVoucher').html(html);
                    //$('#payVoucher').select2('val', result[0].payVoucher);
                } else {
                    alert('该城市下暂无支行！');
                }
            });
        }
    });

    $('#bankNO').change(function() {
        var city = $('#cityCode').val();
        var bankCode = $('#bankNO').val();
        var provinceCode = $('#provinceCode').val();
        if (city) {
            $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode + '/' + bankCode, {'city' : city}, function(result){
                if (result && result.length > 0) {
                    var html = '<option value="">选择支行</option>';
                    for (var i = 0; i < result.length; i++) {
                        html += '<option value="' + result[i].payVoucher + '">' + result[i].brabankName + '</option>';
                    }
                    $('#payVoucher').html(html);
                    $('#payVoucher').select2('val', result[0].payVoucher);
                } else {
                    alert('该城市下暂无支行！');
                }
            });
        }
    });

    function selectType(){
        var type = $('#type').val();
        $('#licenseLabel').html('');
        if(type == 0){
            $('#licenseLabel').append('营业执照号');
            $('#licensesDiv').show();
            $('#legalPersonIdcardsDiv').show();
            $('#licenceImgsDiv').show();
        }else{
            $("#licenseLabel").append('身份证号')
            $('#licensesDiv').hide();
            $('#legalPersonIdcardsDiv').hide();
            $('#licenceImgsDiv').hide();
        }
    }
    var tempFlag = 0;//  function checklicenseNO() 用
    function startValidate() {
        var flag = true;
        // 	var type = $('#type').val();
        // 	if(type == 0){
        if (!$('#licenses').val()) {
            if(flag){
                alert('请选择营业执照');
                flag = false;
            }
        }
        if (!$('#legalPersonIdcards').val()) {
            if(flag){
                alert('请选择法人身份证');
                flag = false;
            }
        }
        if (!$('#licenceImgs').val()) {
            if(flag){
                alert('请选择开户许可证');
                flag = false;
            }
        }
        if (tempFlag == 1){
            alert('营业执照号已存在 ,请重新输入 ');
            flag = false;
        }
        // }

        var countGuarantee = 0;
        $('input[name^="commitment"]').each(function(){
            if($(this).val() != ''){
                countGuarantee = countGuarantee + 1;
            }
        });
        /* if(countGuarantee <= 0){
            alert('商户承诺书不能为空 ');
            flag = false;
        } */
        if($('#select2-chosen-1').html().trim().replace('&nbsp;', '') == '' ||
            $('#select2-chosen-1').html().trim().replace('&nbsp;', '') == '选择省份' ||
            $('#select2-chosen-2').html().trim().replace('&nbsp;', '') == '' ||
            $('#select2-chosen-2').html().trim() == '选择城市' ||
            $('#select2-chosen-3').html().trim().replace('&nbsp;', '') == ''){
            if(flag){
                alert('请填写完整的开户支行信息');
                flag = false;
            }
        }
        var address = $('#province').val() + '-' + $('#city').val() + '-' + $('#county').val() + '-' + $('#detailAddress').val();
        $('#address').val(address);
        return flag;
    }

    function quit() {
        window.location.href='${pageContext.request.contextPath}/client/merchant/list/1';
    }

    function checklicenseNO(){
        var  licenseNO = $("#licenseNO").val();
        if (licenseNO.replace(/\s+/g,"")!=""){
            $.ajax({
                type: 'GET',
                url: '${pageContext.request.contextPath}/client/merchant/checklicenseNO',
                data: {
                    licenseNO:licenseNO
                },
                dataType: 'json',
                success: function(data){
                    if(data.message==false){
                        layer.tips('*营业执照号已存在,请重新输入', '#licenseNO',{tips: [3, 'red']});
                        tempFlag = 1;
                    }else if(data.message==true){
                        tempFlag = 0;
                    }
                }
            });
        }
    }
</script>
</body>
</html>