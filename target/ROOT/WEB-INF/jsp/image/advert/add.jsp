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
                        <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/banner/save">
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <input id="id" name="id" value="0" type="hidden">
                                <input name="page" value="${page }" type="hidden">
                                <input name="size" value="${size }" type="hidden">
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称</label>
                                            <div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="6~40个字符" class="validate[required, minSize[6], maxSize[40], ajax[ajaxAppName]] text-input span9" id="name" name="name" /></div>
                                        </div>
                                    </div>
                                   
                                </div>
                             
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 图片上传</label>
                                    <div class="controls" id="imageChoice" >
                                        <input id="urls" type="file" name="urls" accept="image/jpeg, image/png" onchange="selectFile();" style="width: 190px;"/>
                                        <span  ><font class="msg"  >（app大图建议尺寸：750*408；网站大图建议尺寸：1920*400（内容区域1000），png或者jpg格式）</font></span>
                                    </div>
                                </div>
                            
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 显示平台</label>
                                            <div class="controls">
                                                <div class="row-fluid">
                                                    <div class="span4">
                                                        <div class="control-group ">
                                                            <input type="radio" name="displayPlatform" value="1" checked="checked" class="validate[required] radio span4">
                                                            <span>app</span>
                                                        </div>
                                                    </div>
                                                    <div class="span4">
                                                        <div class="control-group ">
                                                            <input type="radio" name="displayPlatform" value="2" class="validate[required] radio span4">
                                                            <span>web</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6" id="linkCategoryGroup">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 内&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;容</label>
                                            <div class="controls">
                                                <div class="row-fluid">
                                                    <div class="span4">
                                                        <div class="control-group ">
                                                            <input type="radio" name="linkCategory" value="0" checked="checked" class="validate[required] radio span4">
                                                            <span >无</span>
                                                        </div>
                                                    </div>
                                                    <div class="span4">
                                                        <div class="control-group ">
                                                            <input type="radio" name="linkCategory" value="2" class="validate[required] radio span4">
                                                            <span >内部上传</span>
                                                        </div>
                                                    </div>
                                                    <div class="span4">
                                                        <div class="control-group ">
                                                            <input type="radio" name="linkCategory" value="1" class="validate[required] radio span4">
                                                            <span >外部链接</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6" id="outerLinked">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 链接地址</label>
                                            <div class="controls"><input type="text" id="outerLinkedRemark" class="validate[required, maxSize[65], custom[url]] text-input span9" /></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="innerContent">
                                    <label class="control-label"><span class="required">*</span> 内容上传</label>
                                    <div class="controls">
                                        <textarea cols="80" id="editor" name="content" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" name="remark" rows="10"></textarea>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">分享文案</label>
                                    <div class="controls">
                                        <input type="text" class="validate[maxSize[40]] text-input span8" id="shareDesc" name="shareDesc" />
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
<script type="text/javascript">
    var editor = '';
    $(function() {
        $('#fm').validationEngine('attach', {
            promptPosition: 'centerRight',
            scroll: false,
            showOneMessage : true
        });
        $('#name').focus();
        $('.msg').css('color', 'red');

        $('#linkCategoryGroup').find('input:radio').click(function(){
            if($(this).val() == 0){
                $('#outerLinked').hide();
                $('#innerContent').hide();
            }
            if($(this).val() == 1){
                $('#outerLinked').show();
                $('#innerContent').hide();
                $('#outerLinkedRemark').val('http://');
            }
            if($(this).val() == 2){
                $('#outerLinked').hide();
                $('#innerContent').show();
            }
        });
        $('#linkCategoryGroup').find('input:radio').eq(0).trigger('click');
        editor = UE.getEditor('editor');
    });

    $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">广告图管理&nbsp;</a>/&nbsp;新增广告图</li>');

    function startValidate() {
        var flag = true;
        $.ajaxSettings.async = false;
        $.getJSON('${pageContext.request.contextPath}/banner/duplicate/name', {
            id: 0,
            fieldId: 0,
            fieldValue: $('#name').val()
        }, function(data){
            if(data && data.length>0 && data[1]){
                var value = $('[name=linkCategory]').filter(':checked').attr('value');
                if (value == 1) {
                    UE.getEditor('editor').destroy();
                    $('#editor').val($('#outerLinkedRemark').val());
                }
                if (!$('#urls').val()) {
                    if(flag){
                        alert('请选择要上传的图片');
                        flag = false;
                    }
                }
                var value = $('[name=linkCategory]').filter(':checked').attr('value');
                if (value == 0) {
                    if(flag){
                        var txt = editor.getContent();
                        if($.trim(txt) == ''){
                            $('#editor').addClass('validate[required]');
                        }else if(txt.length > 10000){
                            alert('字数超出限制');
                            flag = false;
                        }else{
                            $('#editor').removeClass('validate[required]');
                        }
                    }
                }
            }else{
                alert('【'+$('#name').val()+'】此名称已被使用请重新选择!');
                flag = false;
            }
        });
        $.ajaxSettings.async = true;
        return flag;
    }

    /*  $('input[name=linkCategory]').change(function(){
         var value = $('[name=linkCategory]').filter(':checked').attr('value');
         if (value == 0) {
             $('#outerLinked').hide();
             $('#innerContent').hide();
         } else if (value == 1) {
             $('#innerContent').hide();
             $('#outerLinked').show();

         } else if(value == 2){
             $('#outerLinked').hide();
             $('#innerContent').show();
         }else{

         }
     });  */

    function quit() {
        window.location.href='${pageContext.request.contextPath}/banner/list/1';
    }
    /*
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
                 $('#preview_'+id).css({'display':'block','width':'200px', 'height':'350px'});
                 $('#preview_'+id).attr('src', window.URL.createObjectURL(urlObj.files[0]));
             }
         } else {
             $('#'+id).val('');
            alert('请选择建议的图片格式！');
            return false;
         }
     }
    */
    function selectFile() {
        var file = document.getElementById('urls').files[0];
        if (file) {
            var suffix = file.name.split('.').pop().toLowerCase();
            if (suffix == 'png' || suffix == 'jpg') {
                if (Math.round(file.size * 100 / 1024) / 100 > 2048) {
                    alert('亲，图片不能超过2兆');
                    $('#urls').val('');
                    return false;
                }
                return true;
            } else {
                alert('请选择png、jpg的图片！');
                $('#urls').val('');
                return false;
            }
        }
    }
</script>
</body>
</html>