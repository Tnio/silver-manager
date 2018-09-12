<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                        <form class="form-horizontal" style="margin-bottom: 0;" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/banner/save">
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <input id="id" name="id" value="${image.id }" type="hidden">
                                <input name="page" value="${page }" type="hidden">
                                <input name="size" value="${size }" type="hidden">
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称</label>
                                            <div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="6~40个字符" class="validate[required, minSize[6], maxSize[40], ajax[ajaxAppName]] text-input span9" value="${image.name }" id="name" name="name" /></div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 排&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;序</label>
                                            <div class="controls"><input type="text" onkeydown="this.value = this.value.replace(/^0/g, '')" class="validate[required,minSize[1], maxSize[999],custom[integer]] text-input span9" value="${image.sortNumber }" name="sortNumber" /></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 图片上传</label>
                                    <div class="controls" id="bigImage">
                                        <img style="height:220px; width: 300px;" class="thumbnail" src="${image.url}"/>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"></label>
                                        <div class="controls" id="imageUpload"><a href="javascript:reUpload();"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 显示平台</label>
                                            <div class="row-fluid">
                                                <div class="span3">
                                                    <div class="control-group ">
                                                        <input type="radio" name="displayPlatform" value="1"  class="validate[required] radio span4">
                                                        <span>app</span>
                                                    </div>
                                                </div>
                                                <div class="span3">
                                                    <div class="control-group ">
                                                        <input type="radio" name="displayPlatform" value="2" class="validate[required] radio span4">
                                                        <span>web</span>
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
                                                        <div class="control-group " style="margin-left: -25px">
                                                            <input type="radio" name="linkCategory" value="0" checked="checked" class="validate[required] radio span5">
                                                            <span >无</span>
                                                        </div>
                                                    </div>
                                                    <div class="span4">
                                                        <div class="control-group " style="margin-left: -3px">
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
                                            <div class="controls">
                                                <input id="outerLinkedRemark" type="text" value="${image.content}" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" class="validate[required, maxSize[65], custom[url]] text-input span9" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="innerContent">
                                    <label class="control-label"><span class="required">*</span> 内容上传</label>
                                    <div class="controls" id="innerRemark">
                                        <textarea cols="80" id="editor" name="content" rows="10"><c:if test="${image.linkCategory == 2}">${image.content}</c:if></textarea>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">分享文案</label>
                                    <div class="controls">
                                        <input type="text" class="validate[maxSize[40]] text-input span8" id="shareDesc" name="shareDesc" value="${image.shareDesc}"/>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" id="save" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
                                    <a type="button" class="btn" href="javascript:quit();">返回</a>
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
<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
<script type="text/javascript">
    var  editor = '';
    $(function() {
        $('#fm').validationEngine('attach', {
            promptPosition: 'centerRight',
            scroll: false,
            showOneMessage : true
        });
        $('#name').focus();
        editor = UE.getEditor('editor');
        $('input[name=displayPlatform][value=${image.displayPlatform}]').attr("checked",true);
        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active"><li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">广告图管理&nbsp;</a>/&nbsp;编辑广告图</li>');
            $('#save').show();
        }else{
            $('.breadcrumb').html('<li class="active"><li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">广告图管理&nbsp;</a>/&nbsp;查看广告图</li>');
            $('#save').hide();
            readOnly();
        }

        $('#linkCategoryGroup').find('input:radio').bind('click',function(){
            if($.trim($(this).val()) == 0){
                $('#outerLinked').hide();
                $('#innerContent').hide();
            }
            if($.trim($(this).val()) == 1){
                $('#outerLinked').show();
                $('#innerContent').hide();
                if('${image.linkCategory}' == 1){


                }else{
                    $('#outerLinkedRemark').val('http://');
                }
            }
            if($.trim($(this).val()) == 2){
                $('#outerLinked').hide();
                $('#innerContent').show();
                if('${image.linkCategory}' == 2){

                }
            }
        })


        if('${image.linkCategory}' == 0){
            $('#linkCategoryGroup').find('input:radio').eq(0).attr('checked','checked');
            $('#linkCategoryGroup').find('input:radio').eq(0).trigger('click');

        }
        if('${image.linkCategory}' == 1){
            $('#linkCategoryGroup').find('input:radio').eq(2).attr('checked','checked');
            $('#linkCategoryGroup').find('input:radio').eq(2).trigger('click');
        }
        if('${image.linkCategory}' == 2){
            $('#linkCategoryGroup').find('input:radio').eq(1).attr('checked','checked');
            $('#linkCategoryGroup').find('input:radio').eq(1).trigger('click');
        }
    });


    index = 0;

    function startValidate() {
        var flag = true;
        $.ajaxSettings.async = false;
        $.getJSON('${pageContext.request.contextPath}/banner/duplicate/name', {
            id:$('#id').val(),
            fieldId:$('#id').val(),
            fieldValue: $('#name').val()
        }, function(data){
            if(data && data.length>0 && data[1]){
                var value = $('[name=linkCategory]').filter(':checked').attr('value');
                if (value == 1) {
                    UE.getEditor('editor').destroy();
                    $('#editor').val($('#outerLinkedRemark').val());
                }
                if (index > 0) {
                    if(flag){
                        if (!$('#urls').val()) {
                            alert('请选择要上传的图片');
                            flag = false;
                        }
                    }
                }
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
                $('#name').focus();
                alert('【'+$('#name').val()+'】此名称已被使用请重新选择!');
                flag = false;
            }
        });
        $.ajaxSettings.async = true;
        return flag;
    }

    function quit() {
        window.location.href='${pageContext.request.contextPath}/banner/list/1';
    }

    if(document.getElementById("bigImage")){
        var workTag=document.getElementById("bigImage");
        var workImg=workTag.getElementsByTagName('img');
        for(var i=0; i<workImg.length; i++) {
            workImg[i].onclick=ImgShow;
        }
    }

    function reUpload() {
        var msg = "您确认要删除除此图片吗?";
        if (confirm(msg)==true){
            var name = getFileName('${image.url}');
            name = name ? name : null;
            index++;
            $.post('${pageContext.request.contextPath}/client/merchant/loan/contract/delete', {'name' : name}, function(result){
                document.getElementById('bigImage').innerHTML = '';
                document.getElementById('imageUpload').style.display = 'none';
                document.getElementById('bigImage').innerHTML = '<input id="urls" type="file" name="urls" accept="image/jpeg, image/png" onchange="selectFile();" /><span><font style="color:red;">（APP大图建议尺寸：750*408；网站大图建议尺寸：1920*400（内容区域1000），png或者jpg格式）</font></span>';
            });
        }
    }

    function getFileName(url){
        var pos = url.lastIndexOf("/");
        if(pos == -1){
            pos = url.lastIndexOf("\\");
        }
        return url.substr(pos +1);;
    }

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

    function   readOnly()
    {
        var  a =  document.getElementsByTagName("input");
        for(var   i=0;   i<a.length;   i++)   {
            if(a[i].type=="checkbox" || a[i].type=="radio" || a[i].type=="text"){
                a[i].readOnly = true;
                a[i].disabled = "disbaled";
            }
        }

        var  b  =  document.getElementsByTagName("select");
        for(var i=0; i<b.length; i++)   {
            b[i].disabled="disabled";
        }

        var c = document.getElementsByTagName("textarea");
        for   (var   i=0;   i<c.length;   i++)
        {
            c[i].disabled="disabled";
        }

        var d = document.getElementsByTagName("button");
        for   (var   i=0;   i<d.length;   i++)
        {
            d[i].disabled="disabled";
        }

        UE.getEditor('editor').addListener("ready", function () {
            UE.getEditor('editor').setDisabled('fullscreen');
        });
    }
</script>
</body>
</html>