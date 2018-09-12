<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                        <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/activity/save">
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <input id="id" name="id" value="0" type="hidden">
                                <input id="content" name="content" value="" type="hidden">
                                <input name="page" value="${page }" type="hidden">
                                <input name="size" value="${size }" type="hidden">
                                <div class="row-fluid">
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>活动标题</label>
                                            <div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="6~40个字符" class="validate[required, minSize[6], maxSize[40]] text-input span9" id="title" name="title" /></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 开始时间</label>
                                            <div class="controls"><input type="text" id="beginDate" name="beginDate" class="validate[required, custom[date],past[#endDate]] text-input span9" onkeypress="return false"/></div>
                                        </div>
                                    </div>
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 结束时间</label>
                                            <div class="controls">
                                                <input type="text" id="endDate" name="endDate" class="validate[required, custom[date],future[#beginDate]] text-input span7" onkeypress="return false"/>
                                                <input type="checkbox" id="longTerm" name="longTerm" onchange="changeDate()" class="span1" /><span> 长期有效</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span> 活动图片</label>
                                    <div class="controls" id="imageChoice">
                                        <input id="urls" type="file" name="urls" accept="image/jpeg, image/png" onchange="selectFile();" />
                                        <span><font class="msg">（建议尺寸：460*200px， png或者jpg格式）</font></span>
                                    </div>
                                </div>
                                <div class="control-group" >
                                    <label class="control-label"><span class="required">*</span> 活动介绍</label>
                                    <div class="controls">
                                        <textarea cols="80" style="width:98%" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" name="introduction" rows="3" placeholder="最多70个汉字" class="validate[required,minSize[2] maxSize[140]] text-input"></textarea>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 活动类型</label>
                                            <div class="controls">
                                                <div class="row-fluid">
                                                    <div class="span4">
                                                        <div class="control-group ">
                                                            <input type="radio" name="type" value="2" checked="checked" class="validate[required] radio span4">
                                                            <span >内部上传</span>
                                                        </div>
                                                    </div>
                                                    <div class="span4">
                                                        <div class="control-group ">
                                                            <input type="radio" name="type" value="1" class="validate[required] radio span4">
                                                            <span >外部链接</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="outerLinked">
                                    <div class="control-group">
                                        <label class="control-label"><span class="required">*</span> 链接地址</label>
                                        <div class="controls"><input type="text" id="outerLinkedRemark" class="validate[required, maxSize[65], custom[url]] text-input span9" /></div>
                                    </div>
                                </div>
                                <div class="control-group" id="innerContent">
                                    <label class="control-label"><span class="required">*</span> 活动内容</label>
                                    <div class="controls">
                                        <textarea cols="80" id="editor" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" rows="10" placeholder="最多4000个汉字"></textarea>
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
            promptPosition: 'bottomLeft',
            scroll: false,
            showOneMessage : true
        });
        $('#tite').focus();
        $('.msg').css('color', 'red');
        $('#innerContent').show();
        $('#outerLinked').hide();
        editor = UE.getEditor('editor');

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

    $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">活动专区管理&nbsp</a>/&nbsp;新增活动</li>');

    function startValidate() {
        var flag = true;
        $.ajaxSettings.async = false;
        $.getJSON('${pageContext.request.contextPath}/activity/exist/title', {
            id: 0,
            title: $('#title').val()
        }, function(data){
            if(!data){
                if (!$('#urls').val()) {
                    if(flag){
                        alert('请选择要上传的图片');
                        flag = false;
                    }

                }
                var value = $('[name=type]').filter(':checked').attr('value');
                if (value == 1) {
                    $('#content').val($('#outerLinkedRemark').val());
                } else {
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
        } else if (value == 1) {
            $('#innerContent').hide();
            $('#outerLinked').show();
            if(!$('#outerLinkedRemark').val()){
                $('#outerLinkedRemark').val('http://');
            }
        }
    });

    function changeDate(){
        if($("#longTerm").prop("checked") == true){
            $('#endDate').val("2020-12-30");
        }
    }

    function quit() {
        window.location.href='${pageContext.request.contextPath}/activity/list/1';
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
</script>
</body>
</html>