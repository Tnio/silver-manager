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
        <div class="span10">
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form class="form-horizontal" style="margin-bottom: 0;" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/activity/save">
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <input id="id" name="id" value="${activity.id }" type="hidden">
                                <input name="page" value="${page }" type="hidden">
                                <input id="content" name="content" value="" type="hidden">
                                <input name="size" value="${size }" type="hidden">
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>活动标题</label>
                                            <div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="6~40个字符" class="validate[required, minSize[6], maxSize[40]] text-input span9" value="${activity.title }" id="title" name="title" /></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 开始时间</label>
                                            <div class="controls"><input type="text" id="beginDate" name="beginDate" value="${activity.beginDate}" class="validate[required, custom[date],past[#endDate]] text-input span9" onkeypress="return false"/></div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 结束时间</label>
                                            <div class="controls">
                                                <input type="text" id="endDate" name="endDate" value="${activity.endDate}" class="validate[required, custom[date],future[#beginDate]] text-input span9" onkeypress="return false"/>
                                                <input type="checkbox" id="longTerm" name="longTerm" onchange="changeDate()" class="span1" /><span> 长期有效</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <input type="hidden" id="img" value="${activity.imgUrl}"/>
                                    <label class="control-label"><span class="required">*</span>活动图片</label>
                                    <div class="controls" id="bigImage">
                                        <img style="height:220px; width: 300px;" class="thumbnail" src="${activity.imgUrl}"/>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"></label>
                                        <div class="controls" id="imageUpload"><a href="javascript:reUpload();"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
                                    </div>
                                </div>
                                <div class="control-group" >
                                    <label class="control-label"><span class="required">*</span> 活动介绍</label>
                                    <div class="controls">
                                        <textarea cols="80" style="width:98%"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" name="introduction" rows="3" placeholder="最多70个汉字" class="validate[required,minSize[2] maxSize[140]] text-input" >${activity.introduction }</textarea>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 活动类型</label>
                                            <div class="row-fluid">
                                                <div class="span3">
                                                    <div class="control-group ">
                                                        <input type="radio" name="type" value="2"  class="validate[required] radio span4">
                                                        <span >内部上传</span>
                                                    </div>
                                                </div>
                                                <div class="span3">
                                                    <div class="control-group ">
                                                        <input type="radio" name="type" value="1" class="validate[required] radio span4">
                                                        <span >外部链接</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="outerLinked">
                                    <div class="control-group">
                                        <label class="control-label"><span class="required">*</span> 链接地址</label>
                                        <div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" id="outerLinkedRemark" class="validate[required, maxSize[65], custom[url]] text-input span9" value="http://" /></div>
                                    </div>
                                </div>
                                <div class="control-group" id="innerContent">
                                    <label class="control-label"><span class="required">*</span>活动内容</label>
                                    <div class="controls" id="innerRemark">
                                        <textarea cols="80" id="editor" rows="10" class="validate[minSize[1],maxSiz[10000]]">${activity.content}</textarea>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">分享文案</label>
                                    <div class="controls">
                                        <input type="text" class="validate[maxSize[40]] text-input span8" id="shareDesc" name="shareDesc" value="${activity.shareDesc}" />
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
<script src="${pageContext.request.contextPath}/res/js/show.original.image.js"></script>
<script type="text/javascript">
    var editor = '';
    $(function() {
        $('#fm').validationEngine('attach', {
            promptPosition: 'bottomLeft',
            scroll: false,
            showOneMessage : true
        });
        $('#title').focus();
        editor = UE.getEditor('editor');
        $('input[name=type][value=${activity.type}]').attr("checked",true);
        if($('[name=type]').filter(':checked').attr('value')==1){
            $('#outerLinkedRemark').val($('#editor').val());
        }
        $('input[name=type]').trigger('onchange');
        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active"><li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">活动专区管理&nbsp;</a>/&nbsp;编辑活动</li>');
            $('#save').show();
        }else{
            $('.breadcrumb').html('<li class="active"><li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">活动专区管理&nbsp;</a>/&nbsp;查看活动</li>');
            $('#save').hide();
            readOnly();
        }


        $('#beginDate').datetimepicker({
            format:'Y-m-d',
            lang:'ch',
            timepicker:false
        });

        $('#endDate').datetimepicker({
            format:'Y-m-d',
            lang:'ch',
            timepicker:false,
            onSelectDate:function() {
                $("#longTerm").prop("checked", false);
            }
        });
    });

    $('#innerContent').hide();
    $('#outerLinked').hide();
    var value = '${activity.type}';
    if (value == 1) {
        $('#outerLinked').show();
    } else {
        $('#innerContent').show();
    }
    index = 0;

    function startValidate() {
        var flag = true;
        $.ajaxSettings.async = false;
        $.getJSON('${pageContext.request.contextPath}/activity/exist/title', {
            id: $('#id').val(),
            title: $('#title').val()
        }, function(data){
            if(!data){
                if (!$('#urls').val() && !$("#img").val() ) {
                    if(flag){
                        alert('请选择要上传的图片');
                        flag = false;
                    }
                }
                var value = $('[name=type]').filter(':checked').attr('value');
                if (value == 1) {
                    $('#content').val($('#outerLinkedRemark').val());
                } else {
                    if(flag){
                        var txt = editor.getContent();
                        if($.trim(txt) == ''){
                            $('#editor').addClass('validate[required]');
                        }else if(txt.length > 10000){
                            alert('活动内容字数超出限制');
                            return false;
                        }else{
                            $('#editor').removeClass('validate[required]');
                        }
                        $('#content').val(txt);
                    }
                }

            }else{
                alert('【'+$('#title').val()+'】此标题已被使用请重新选择!');
                flag = false;
            }
        });
        $.ajaxSettings.async = true;
        return flag;
    }

    $('input[name=type]').change(function(){
        var value = $('[name=type]').filter(':checked').attr('value');
        if (value == 2) {
            $('#outerLinked').hide();
            $('#innerContent').show();
            if(!$('#editor').val()){
                $('#editor').val('');
            }
        } else if (value == 1) {
            $('#innerContent').hide();
            $('#outerLinked').show();
            if(!$('#outerLinkedRemark').val()){
                $('#outerLinkedRemark').val('http://');
            }
        }
    });

    function quit() {
        window.location.href='${pageContext.request.contextPath}/activity/list/1';
    }

    function changeDate(){
        if($("#longTerm").prop("checked") == true){
            $('#endDate').val("2020-12-30");
        }
    }

    if(document.getElementById("bigImage")){
        var workTag=document.getElementById("bigImage");
        var workImg=workTag.getElementsByTagName('img');
        for(var i=0; i<workImg.length; i++) {
            workImg[i].onclick=ImgShow;
        }
    }

    function reUpload() {
        var msg = "您确认要删除此图片吗?";
        if (confirm(msg)==true){
            var name = getFileName('${activity.imgUrl}');
            name = name ? name : null;
            index++;
            $.post('${pageContext.request.contextPath}/client/merchant/loan/contract/delete', {'name' : name}, function(result){
                $("#img").val('');
                document.getElementById('bigImage').innerHTML = '';
                document.getElementById('imageUpload').style.display = 'none';
                document.getElementById('bigImage').innerHTML = '<input id="urls" type="file" name="urls" accept="image/jpeg, image/png" onchange="selectFile();" /><span><font style="color:red;">（建议尺寸：460*200，png或者jpg格式）</font></span>';
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

    function readOnly()
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