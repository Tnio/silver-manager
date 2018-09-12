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
                        <form class="form-horizontal" id="fm" method="post" enctype="multipart/form-data" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/client/merchant/save">
                            <div class="well">
                                <input id="id" name="id" value="${merchant.id}" type="hidden">
                                <input id="letterOfCommitment" name="letterOfCommitment" value="${merchant.letterOfCommitment}" type="hidden">
                                <input id="address" name="address" value="" type="hidden">
                                <input name="page" value="${page }" type="hidden">
                                <input name="size" value="${size }" type="hidden">
                                <input name="status" value="0" type="hidden">
                                <input id="removeAttachments" name="removeAttachments" value="" type="hidden">

                                <%-- <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 借款类型</label>
                                    <div class="controls">
                                        <select id="type" name="type" class="validate[required] span10" disabled="true">
                                            <option value="0" <c:if test="${merchant.type == 0}"> selected="selected" </c:if>>商户借款</option>
                                            <option value="1" <c:if test="${merchant.type == 1}"> selected="selected" </c:if>>个人借款</option>
                                        </select>
                                    </div>
                                </div> --%>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 企业名称</label>
                                    <div class="controls"><input type="text" name="name" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="最多40个字符" class="validate[required, maxSize[40]] text-input span10" value="${merchant.name}" /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 法人姓名</label>
                                    <div class="controls"><input type="text" placeholder="最多20个字符" class="validate[required, maxSize[20]] text-input span10" name="legalPerson" value="${merchant.legalPerson}" /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 联系人</label>
                                    <div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="最多20个字符" class="validate[required, maxSize[20]] text-input span10" name="linkman" value="${merchant.linkman}"  /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 联系人手机号</label>
                                    <div class="controls"><input type="text" id="cellphone" class="validate[required, minSize[11] maxSize[11]] text-input span10" name="cellphone" value="${merchant.cellphone}" /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 企业地址</label>
                                    <div class="controls">
                                        <select name="province" class="validate[required] text-input span3" id="province"></select>
                                        <select name="city" class="validate[required] text-input span3" id="city"></select>
                                        <select name="county" class="validate[required] text-input span4" id="county"></select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 详细地址</label>
                                    <div class="controls"><input type="text" placeholder="最多100个字符" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" class="validate[required, maxSize[100]] text-input span10" id="detailAddress" value="" /></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 商户银行账户</label>
                                    <div class="controls"><input type="text" id="cardNO" name="cardNO" value="${merchant.cardNO}" class="validate[required, custom[bankCode]] text-input span10" /></div>
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
                                            <select id="provinceCode" data-plugin-selectTwo name="provinceCode" class="provinceCode">
                                                <option value="">选择省份</option>
                                                <c:forEach items="${provinces}" var="province">
                                                    <option value="${province.provinceCode}">${province.province}</option>
                                                </c:forEach>
                                            </select>
                                            <select id="cityCode" data-plugin-selectTwo name="cityCode" class="provinceCode">
                                            </select>
                                            <select id="payVoucher" data-plugin-selectTwo name="payVoucher" class="payVoucher">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" id="licenseLabel"><font color="red">*</font>营业执照号</label>
                                    <div class="controls">
                                        <input id="licenseNO" type="text" name="licenseNO" value="${merchant.licenseNO}" placeholder="最多30个字符" class="validate[required]  text-input span10" maxlength="30" onblur="checklicenseNO()" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 存管电子账户</label>
                                    <div class="controls">
                                        <input id="accountId" type="text" name="accountId" value="${merchant.accountId}" placeholder="最多19个字符" class="validate[required ,custom[accountIdCode]] text-input span10" maxlength="19" />
                                    </div>
                                </div>
                                <%-- <div class="row-fluid">
                                      <div class="control-group span9">
                                        <label class="control-label"><span class="required">*</span> 短信提醒</label>
                                        <div class="controls">
                                            <div class="span4">
                                                <input type="radio" name="closeNotice"  <c:if test="${merchant.closeNotice != 1}">checked="checked"</c:if>  value="0"  class="validate[required] span1" style="margin-top: -1px">
                                                <span>发</span>
                                            </div>
                                            <div class="span4">
                                                <input type="radio" name="closeNotice" <c:if test="${merchant.closeNotice == 1}">checked="checked"</c:if> value="1" class="validate[required] span1" style="margin-top: -1px;">
                                                <span>不发</span>
                                            </div>
                                        </div>
                                    </div>
                                </div> --%>
                                <div class="row-fluid">
                                    <div class="span4" id="licensesDiv">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 营业执照</label>
                                            <div class="controls">
                                                <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                    <div style="height:270px;width:217px;" id="preview_licenses" ><img style="height:270px; width: 217px;" src="${merchant.license}"/></div>
                                                    <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain('licenses')">重新上传</button></div>
                                                    <input id="licenses" type="file" name="licenses" accept="image/*" onchange="javascript:setImagePreview(this.id);" />
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4" id="legalPersonIdcardsDiv">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 法人身份证</label>
                                            <div class="controls">
                                                <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                    <div style="height:270px;width:217px;" id="preview_legalPersonIdcards" ><img style="height:270px; width: 217px;" src="${merchant.legalPersonIdcard}"/></div>
                                                    <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain('legalPersonIdcards')">重新上传</button></div>
                                                    <input id="legalPersonIdcards" type="file" name="legalPersonIdcards" accept="image/*" onchange="javascript:setImagePreview(this.id);" />
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span4">
                                        <div class="row-fluid">
                                            <label class="control-label"><span class="required"></span>商户实拍图</label>
                                            <div class="controls">
                                                <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                    <c:if test="${not empty merchant.realDiagram }">
                                                        <div style="height:270px;width:217px;" id="preview_realDiagrams" ><img style="height:270px; width: 217px;" src="${merchant.realDiagram}"/></div>
                                                        <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain('realDiagrams')">重新上传</button></div>
                                                    </c:if>
                                                    <c:if test="${empty merchant.realDiagram }">
                                                        <div style="height:270px;width:217px;" id="preview_realDiagrams" ><img style="height:270px; width: 217px;" /></div>
                                                        <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain('realDiagrams')">添加</button></div>
                                                    </c:if>
                                                    <input id="realDiagrams" type="file" name="realDiagrams" accept="image/*" onchange="javascript:setImagePreview(this.id);" />
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- <div class="span4">
                                        <div class="row-fluid">
                                            <label class="control-label">租赁合同</label>
                                            <div class="controls">
                                                 <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                     <c:if test="${not empty merchant.leasingContract }">
                                                         <div style="height:270px;width:217px;" id="preview_leasingContracts" ><img style="height:270px; width: 217px;" src="${merchant.leasingContract}"/></div>
                                                        <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain('leasingContracts')">重新上传</button></div>
                                                     </c:if>
                                                     <c:if test="${empty merchant.leasingContract }">
                                                         <div style="height:270px;width:217px;" id="preview_leasingContracts" ><img style="height:270px; width: 217px;" /></div>
                                                        <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain('leasingContracts')">添加</button></div>
                                                     </c:if>
                                                    <input id="leasingContracts" type="file" name="leasingContracts" accept="image/*" onchange="javascript:setImagePreview(this.id);" />
                                                </a>
                                            </div>
                                        </div>
                                    </div> --%>
                                    <div class="span4">
                                        <div class="row-fluid">
                                            <label class="control-label">商户承诺书</label>
                                            <div class="controls">
                                                <c:forEach items="${merchant.attachments}" var="attachment">
                                                    <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                        <c:if test="${not empty attachment.url }">
                                                            <div style="height:270px;width:217px;" id="preview_letterOfCommitments" ><img style="height:270px; width: 217px;" src="${attachment.url}"/></div>
                                                            <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain('letterOfCommitments')">重新上传</button></div>
                                                        </c:if>
                                                        <c:if test="${empty attachment.url }">
                                                            <div style="height:270px;width:217px;" id="preview_letterOfCommitments" ><img style="height:270px; width: 217px;" /></div>
                                                            <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain('letterOfCommitments')">添加</button></div>
                                                        </c:if>
                                                        <div style="display: none;"><input id="letterOfCommitments" type="file" name="letterOfCommitments" accept="image/*" onchange="javascript:setImagePreview(this.id);"/></div>
                                                    </a>
                                                </c:forEach>
                                                <c:if test="${empty merchant.attachments}">
                                                    <a class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                        <div style="height:270px;width:217px;" id="preview_letterOfCommitments" ><img style="height:270px; width: 217px;" /></div>
                                                        <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain('letterOfCommitments')">添加</button></div>
                                                        <div style="display: none;"><input id="letterOfCommitments" type="file" name="letterOfCommitments" accept="image/*" onchange="javascript:setImagePreview(this.id);"/></div>
                                                    </a>
                                                </c:if>
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
                                                    <div style="height:270px;width:217px;" id="preview_licenceImgs" ><img style="height:270px; width: 217px;" src="${merchant.licenceImg}"/></div>
                                                    <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain('licenceImgs')">重新上传</button></div>
                                                    <input id="licenceImgs" type="file" name="licenceImgs" accept="image/*" onchange="javascript:setImagePreview(this.id);" />
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%-- <div class="row-fluid">
                                    <div class="row-fluid">
                                        <label class="control-label"><span class="required"></span>商户承诺书</label>
                                        <div class="controls">
                                            <div id="commitmentUpload">
                                                <c:forEach items="${merchant.attachments}" var="attachment">
                                                    <a id="${attachment.id}" class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                        <span ><img  name="commitmentImg" style="height:270px; width: 217px;" src="${attachment.url}"/></span>
                                                        <div align="right"><button type="button" class="btn btn-lg" onclick="javascript:deleteAttachment(${attachment.id})">删除</button></div>
                                                      </a>
                                                </c:forEach>
                                            </div>
                                            <a class="thumbnail" id="addDiv" style="float: left; height:300px; width: 217px;">
                                                <div style="height:270px; width: 217px;"></div>
                                                <button type="button" id="addCommitment" class="btn btn-lg">添加</button>
                                            </a>
                                        </div>
                                    </div>
                                </div> --%>
                                <div class="row-fluid">
                                    <div class="row-fluid">
                                        <label class="control-label"><span class="required"></span>其它资料</label>
                                        <div class="controls">
                                            <div id="commitmentUpload">
                                                <c:forEach items="${merchantOtherData}" var="attachment" varStatus="status">
                                                    <a id="${status.count}" class="thumbnail" style="float: left; height:300px; width: 217px;">
                                                        <span ><img  name="commitmentImg" style="height:270px; width: 217px;" src="${attachment}"/></span>
                                                        <input type="hidden" name="commitment" value='${attachment}' />
                                                        <div align="right"><button type="button" class="btn btn-lg" onclick="javascript:deleteAttachment(${status.count})">删除</button></div>
                                                    </a>
                                                </c:forEach>
                                            </div>
                                            <a class="thumbnail" id="addDiv" style="float: left; height:300px; width: 217px;">
                                                <div style="height:270px; width: 217px;"></div>
                                                <button type="button" id="addCommitment" class="btn btn-lg">添加</button>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" id="save" class="btn btn-lg btn-primary"><i></i>保存</button>
                                    <a type="button" class="btn" href="javascript:quit();">返回</a>
                                    <!-- <span id="authorityButton">
                                        <a href="javascript:audit()" id="183" class="btn btn-lg btn-primary" >审核</a>
                                    </span> -->
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal hide fade" id="authorizationDiv" role="dialog" style="margin-top: 200px">
    <form id="fmg" class="modal-content form-horizontal password-modal" >
        <div class="modal-header">
            <h4 class="modal-title">审核意见</h4>
        </div>
        <div class="modal-body">
            请确认审核结果！
            <div class="modal-footer">
                <a href="javascript:setStatus('1')" class="btn btn-primary" >通过</a>
                <a href="javascript:setStatus('2')" class="btn btn-default" >不通过</a>
            </div>
        </div>
    </form>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<script src="${pageContext.request.contextPath}/js/area.js"></script>
<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
<script src="${pageContext.request.contextPath}/plugin/select/modernizr.js"></script>
<script src="${pageContext.request.contextPath}/plugin/select/nanoscroller.js"></script>
<script src="${pageContext.request.contextPath}/plugin/select/select2.js"></script>
<script src="${pageContext.request.contextPath}/plugin/select/theme.js"></script>
<script src="${pageContext.request.contextPath}/plugin/select/theme.init.js"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js"></script>
<script type="text/javascript">
    function deleteAttachment(id, url){
        document.getElementById(id).style.display = 'none';
        document.getElementById(id).parentNode.removeChild(document.getElementById(id));
        geCount = geCount - 1;
        $('#letterOfCommitment').val($('#letterOfCommitment').val().replace(id, ''));
    }

    var ge = 0;
    var geCount = document.getElementsByName('commitmentImg').length;
    $('#addCommitment').click(function() {
        if(geCount < 10){
            $('#commitmentUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="commitment'+ge+'"><div style="height:270px; width: 217px;" id="commitment-'+ge+'"></div><input id="commitment_'+ge+'" name="commitment'+ge+'"type="file" accept="image/*" style="width:163px" onchange="setNewImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delGuarantee('+ge+')"/></</a>');
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

    var addr = '${merchant.address}'.split('-');
    if (addr.length > 3) {
        var msg = '';
        for (var i = 3; i < addr.length; i++) {
            if (i == addr.length - 1) {
                msg +=addr[i];
            } else {
                msg +=addr[i] + '-';
            }
        }
        $('#detailAddress').val(msg);
    }
    $('#licenses').hide();
    $('#legalPersonIdcards').hide();
    $('#licenceImgs').hide();
    $('#realDiagrams').hide();
    $('#leasingContracts').hide();
    function setImagePreview(id) {
        var urlObj = $('#'+id)[0];
        if(urlObj){
            var suffix = urlObj.files[0].name.split('.').pop().toLowerCase();
            if (suffix == 'png' || suffix == 'jpg') {
                if(urlObj.files && urlObj.files[0]){
                    if (Math.round(urlObj.files[0].size * 100 / 1024) / 100 > 2048) {
                        $('#'+id).val('');
                        alert('亲，请选择不超过2兆的图片！');
                        return false;
                    }
                    var img = $('<img style="height:270px; width: 217px;" src="'+window.URL.createObjectURL(urlObj.files[0])+'">');
                    $('#preview_'+id).empty().append(img);
                }
            } else {
                alert('请选择建议的图片格式！');
                return false;
            }
        }
        return true;
    }

    function uploadAgain(value){
        $('#'+value).trigger('click');
    }

    $(function() {
        $('#licenseNO').focus();
        $('#fm').validationEngine('attach', {
            promptPosition:'bottomRight',
            inlineValidation: true,
            validationEventTriggers:'blur',
            showOneMessage: true,
            focusFirstField:true,
            scroll: true
        });

        $('.provinceCode').css('width', '20%');
        $('.payVoucher').css('width', '42%');
        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;<a href="javascript:quit();">借款人管理</a>&nbsp;/&nbsp;编辑</li>');
            $('#save').show();
            $('#183').hide();
        }else{
            $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;<a href="javascript:quit();">借款人管理</a>&nbsp;/&nbsp;查看</li>');
            //$('#cellphone').attr('value',$('#cellphone').val().replace($('#cellphone').val().substr(3,4),'****'));
            $('#save').hide();
            if ('${merchant.status}' == 0) {
                $('#183').show();
            } else {
                $('#183').hide();
            }
            readOnly();
        }

        setup();
        var province='${fn:split(merchant.address, "-")[0]}';
        $('#province').find("option[value='"+province+"']").attr("selected",true);
        $("#province").trigger('onchange');
        var city='${fn:split(merchant.address, "-")[1]}';
        $('#city').find("option[value='"+city+"']").attr("selected",true);
        $("#city").trigger('onchange');
        var county='${fn:split(merchant.address, "-")[2]}';
        $('#county').find("option[value='"+county+"']").attr("selected",true);

        var type = '${merchant.type}';
        $('#licenseLabel').html('');
        if(type == 0){
            $('#licenseLabel').append('<font color="red">*</font>营业执照号');
            $('#licensesDiv').show();
            $('#legalPersonIdcardsDiv').show();
            $('#licenceImgsDiv').show();
        }else{
            $("#licenseLabel").append('身份证号')
            $('#licensesDiv').hide();
            $('#legalPersonIdcardsDiv').hide();
            $('#licenceImgsDiv').hide();
        }
    });
    $('#organizationCode').focus();
    $('#taxRegistrationCode').focus();
    var licenseIndex = 0;
    var certificateIndex = 0;
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
            }
        });
    });

    function audit(){
        $('#authorizationDiv').modal('show');
    }

    function setStatus(status){
        $('#fm').attr('action','${pageContext.request.contextPath}/client/merchant/audit/${merchant.id}/' + status);
        $('#fm').submit();
    }

    $('#cityCode').change(function() {
        var city = $('#cityCode').val();
        var provinceCode = $('#provinceCode').val();
        var bankCode = $('#bankNO').val();
        if (bankCode) {
            $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode + '/' + bankCode, {'city':city}, function(result){
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
            $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode, {'city':city}, function(result){
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
        var provinceCode = $('#provinceCode').val();
        var bankCode = $('#bankNO').val();
        if (city) {
            $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode + '/' + bankCode, {'city':city}, function(result){
                if (result && result.length > 0) {
                    var html = '<option value="">选择支行</option>';
                    for (var i = 0; i < result.length; i++) {
                        html += '<option value="' + result[i].payVoucher + '">' + result[i].brabankName + '</option>';
                    }
                    $('#payVoucher').html(html);
                    $('#payVoucher').select2('val', result[0].payVoucher);
                }
            });
        }
    });

    function setNewImagePreview(fileInput) {
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

    var bankNO = '${merchant.bankNO}';
    $('#bankNO').find('option[value='+bankNO+']').attr('selected',true);
    var provinceCode = '${merchant.provinceCode}';
    $('#provinceCode').find('option[value='+provinceCode+']').attr('selected',true);
    var city = '${merchant.cityCode}';
    if (provinceCode) {
        $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/city/' + provinceCode, function(result){
            if (result && result.length > 0) {
                var html = '';
                for (var i = 0; i < result.length; i++) {
                    html += '<option value="' + result[i].city + '">' + result[i].city + '</option>';
                }
                $('#cityCode').html(html);
                $('#cityCode').select2('val', city);
            }
        });
    }

    var payVoucher = '${merchant.payVoucher}';
    if (city) {
        var bankCode = '${merchant.bankNO}';
        var provinceCode = $('#provinceCode').val();
        $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode + '/' + bankCode, {'city':city}, function(result){
            if (result && result.length > 0) {
                var html = '';
                for (var i = 0; i < result.length; i++) {
                    html += '<option value="' + result[i].payVoucher + '">' + result[i].brabankName + '</option>';
                }
                $('#payVoucher').html(html);
                $('#payVoucher').select2('val', payVoucher);
            }
        });
    }
    var tempFlag = 0;//  function checklicenseNO() 用
    function startValidate() {
        var flag = true;
        var address = $('#province').val() + '-' + $('#city').val() + '-' + $('#county').val() + '-' + $('#detailAddress').val();
        $('#address').val(address);
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
        var countCommitment = 0;
        $('input[name^="commitment"]').each(function(){
            if($(this).val() != ''){
                countCommitment = countCommitment + 1;
            }
        });
        /* if((document.getElementsByName('commitmentImg').length + countCommitment) <= 0){
            alert('商户承诺书不能为空 ');
            flag = false;
        } */
        if (tempFlag == 1){
            alert('营业执照号已存在 ,请重新输入 ');
            flag = false;
        }
        return flag;
    }

    function getFileName(url){
        var pos = url.lastIndexOf("/");
        if(pos == -1){
            pos = url.lastIndexOf("\\");
        }
        return url.substr(pos +1);;
    }

    var workImg=document.getElementsByTagName('img');
    for(var i=0; i<workImg.length; i++) {
        workImg[i].onclick=ImgShow;
    }

    function readOnly() {
        var a = document.getElementsByTagName("input");
        for(var i=0; i<a.length; i++) {
            if(a[i].type=="checkbox" || a[i].type=="text" || a[i].type=="radio"){
                a[i].readOnly = true;
                a[i].disabled = "disbaled";
            }
        }

        var  b  =  document.getElementsByTagName("select");
        for(var i=0; i<b.length; i++) {
            b[i].disabled="disabled";
        }

        var c = document.getElementsByTagName("textarea");
        for (var i=0; i<c.length; i++) {
            c[i].disabled="disabled";
        }

        var d = document.getElementsByTagName("button");
        for (var i=0; i<d.length; i++) {
            d[i].disabled="disabled";
        }
    }

    function quit() {
        $('#fm').attr('action','${pageContext.request.contextPath}/client/merchant/list/1');
        $('#fm').validationEngine('attach', {
            binded : false
        });
        $('#fm').attr('onsubmit',true);
        $('#fm').submit();
    }
    function checklicenseNO(){
        var  licenseNO = $("#licenseNO").val();
        var merchantId = $("#id").val();
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
                        if(data.list.id == merchantId){

                        }else{
                            layer.tips('*营业执照号已存在,请重新输入', '#licenseNO',{tips: [3, 'red']});
                            tempFlag = 1;
                        }
                    }else if(data.message==true){
                        tempFlag = 0;
                    }
                }
            });
        }
    }
</script>
</body>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>