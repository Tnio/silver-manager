<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form class="form-horizontal" enctype="multipart/form-data" id="from10" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/silver/race/save">
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <input id="id" name="id" value="${goods.id}" type="hidden">
                                <input name="page" value="${page }" type="hidden">
                                <input name="size" value="${size }" type="hidden">
                                <input name="type" value="4" type="hidden">
                                <input id="virtualGoods" value="${goods.virtualGoods}" type="hidden">
                                <div class="row-fluid">
                                    <div class="control-group">
                                        <label class="control-label"><span class="required">*</span> 商品名称</label>
                                        <div class="controls"><input type="text" id="name" name="name" value="${goods.name }" placeholder="3~20个汉字" class="validate[required, minSize[6], maxSize[40]] text-input span11" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>每次消耗银子</label>
                                            <div class="controls"><input type="text" id="consumeSilver" name="consumeSilver" value="${goods.consumeSilver }" class="validate[required, custom[integer] min[1] max[99999]] text-input span9" onblur="colcStock()" /> 两</div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>参考价</label>
                                            <div class="controls"><input type="text" id="price" name="price" value="<fmt:formatNumber type="currency" value="${goods.price }" currencySymbol="" pattern="#"/>" class="validate[required, custom[integer] min[50] max[99999]] text-input span9" onblur="colcStock()" /> 元</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>抽奖次数</label>
                                            <div class="controls"><input type="text" id="stock" name="stock" value="${goods.stock }" class="validate[required, custom[integer] min[1] max[1000000]] text-input span9"  onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" readonly="readonly"/> 次</div>
                                        </div>
                                    </div>
                                    <%-- <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>排序</label>
                                            <div class="controls"><input type="text" name="sortNumber" value="${goods.sortNumber}" class="validate[required, custom[integer] min[1] max[999]] text-input span9"/></div>
                                        </div>
                                    </div> --%>
                                </div>
                                <div class="row-fluid" >
                                    <label class="control-label"><span class="required">*</span>商品图片</label>
                                    <div class="controls" id="imageChoice">
                                        <div id="imgPreview"><img  name="image" style="height:220px; width: 300px;" src="${goods.url}"/></div>
                                        <div align="left"><button type="button" class="btn btn-lg" onclick="uploadAgain()">重新上传</button></div>
                                        <input id="url" type="hidden" name="url" value="${goods.url}"/>
                                        <input id="urls" type="file" name="urls" accept="image/png, image/jpg" onchange="setImagePreview(this.id)" />
                                        <span><font class="msg">（图片建议尺寸：460*200，png或者jpg格式）</font></span>
                                    </div>
                                </div>
                                <br>
                                <div class="row-fluid" >
                                    <div class="control-group" id="contentWrap">
                                        <label class="control-label"><span class="required">*</span>商品介绍</label>
                                        <div class="controls" style="width: 77%">
                                            <textarea cols="100" id="remark" name="remark" >${goods.remark}</textarea>
                                        </div>
                                    </div>
                                </div>
                                <!-- <hr class="separator" /> -->
                                <div class="form-actions">
                                    <button id="save" type="submit" class="btn btn-icon btn-primary glyphicons circle_ok" ><i></i>保存</button>
                                    <a type="reset" id="back" class="btn btn-icon btn-default glyphicons circle_remove" href="javascript:quit()"><i></i>取消</a>
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
<script type="text/javascript">
    var remark = '';
    $(function() {
        $('#from10').validationEngine('attach', {
            promptPosition: 'bottomLeft',
            scroll: false
        });
        $('#urls').hide();
        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active">银子管理 &nbsp;/&nbsp;<a href="javascript:quit();">0元夺宝</a>&nbsp;/&nbsp;编辑商品</li>');
        }else{
            $('.breadcrumb').html('<li class="active">银子管理  &nbsp;/&nbsp;<a href="javascript:quit();">0元夺宝</a>&nbsp;/&nbsp;查看商品</li>');
            readOnly();
            $('#save').hide();
        }

        remark = UE.getEditor('remark');

    });
    $('.breadcrumb').html('<li class="active">银子管理&nbsp;/&nbsp;<a href="javascript:quit();">0元夺宝</a>&nbsp;/&nbsp;新增商品</li>');

    function startValidate() {
        var flag = true;
        if (!$('#urls').val() && !$('#url').val()) {
            alert('请选择上传略缩图片');
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
        window.location.href='${pageContext.request.contextPath}/silver/race/list';
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

        var d = document.getElementsByTagName("button");
        for (var i=0; i<d.length; i++) {
            d[i].disabled='disabled';
        }

        UE.getEditor('remark').addListener("ready", function () {
            UE.getEditor('remark').setDisabled('fullscreen');
        });

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

    function colcStock(){
        if($('#consumeSilver').val() != '' && $('#price').val() != '' ){
            if(parseInt($('#consumeSilver').val()) >= 0 && parseInt($('#price').val()) >= 0){
                var cell = (parseInt($('#price').val()) + 10) * 1.10 * 100 / parseInt($('#consumeSilver').val());
                var count = Math.ceil(cell.toFixed(2));
                if(count < 50){
                    alert('抽奖次数不能小于 50 次!');
                    $('#stock').val('');
                }else{
                    $('#stock').val(count);
                }
            }
        }
    }
</script>
</body>
</html>