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
            <div class="row-fluid">
                <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/chart/save">
                    <input id="id" name="id" value="0" type="hidden">
                    <input id="category" name="category" value="1" type="hidden">
                    <input id="remark" name="remark" type="hidden" >
                    <div class="well" style="padding-bottom: 20px; margin: 0;">
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>启动图名称</label>
                            <div class="controls"><input type="text" id="title" name="name" value="APP启动图" class="validate[required,maxSize[40]] text-input span9"onfocus="this.blur()" readonly="readonly"></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 540*810</label>
                            <div class="controls">
                                <img id="preview_chartOne" />
                                <input id="chartOne" type="file" name="chartOne" accept="image/*" onchange="javascript:setImagePreview(this.id);" />
                                <span><font class="msg">（建议尺寸：540*810，支持png或jpg格式）</font></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 720*1080</label>
                            <div class="controls">
                                <img id="preview_chartTwo" />
                                <input id="chartTwo" type="file" name="chartTwo" accept="image/*" onchange="javascript:setImagePreview(this.id);" />
                                <span><font class="msg">（建议尺寸：720*1080，支持png或jpg格式）</font></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 1080*1620</label>
                            <div class="controls">
                                <img id="preview_chartThree" />
                                <input id="chartThree" type="file" name="chartThree" accept="image/*" onchange="javascript:setImagePreview(this.id);" />
                                <span><font class="msg">（建议尺寸：1080*1620，支持png或jpg格式）</font></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 640*760</label>
                            <div class="controls">
                                <img id="preview_chartFour" />
                                <input id="chartFour" type="file" name="chartFour" accept="image/*" onchange="javascript:setImagePreview(this.id);" />
                                <span><font class="msg">（建议尺寸：640*760，支持png或jpg格式）</font></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 750*1094</label>
                            <div class="controls">
                                <img id="preview_chartFive" />
                                <input id="chartFive" type="file" name="chartFive" accept="image/*" onchange="javascript:setImagePreview(this.id);" />
                                <span><font class="msg">（建议尺寸：750*1094，支持png或jpg格式）</font></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="span4">
                                <label class="control-label"><span class="required">*</span> 链接地址</label>
                                <div class="row-fluid">
                                    <div class="span3">
                                        <div class="control-group ">
                                            <span>&nbsp;&nbsp;</span>
                                            <input type="radio" name="linkCategory" value="0" checked="checked" class="validate[required] radio span4">
                                            <span>无</span>
                                        </div>
                                    </div>
                                    <div class="span3">
                                        <div class="control-group ">
                                            <input type="radio" name="linkCategory" value="1" class="validate[required] radio span3">
                                            <span >跳转至</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="text" id="link" name="content" class="validate[required, maxSize[65], custom[url]] text-input span4" />
                        </div>
                        <div class="control-group">
                            <label class="control-label"></label>
                            <div class="controls">
                                <button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
                                <button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit();"><i></i>返回</button>
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
    $(function() {
        $('#fm').validationEngine('attach', {
            promptPosition:'bottomRight',
            showOneMessage: true,
            focusFirstField:true,
            scroll: true
        });
        $('.msg').css('color', 'red');
        $('#link').hide();
        $('input[name=linkCategory]').change(function(){
            var value = $('[name=linkCategory]').filter(':checked').attr('value');
            if (value == 0) {
                $('#link').hide();
                $('#link').val('');
            } else if (value == 1) {
                $('#link').show();
                $('#link').val('http://');
            }
        });
    });
    $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">启动图管理</a>&nbsp;/&nbsp;新增启动图</li>');

    function quit(){
        window.location.href='${pageContext.request.contextPath}/chart/list';
    }

    function startValidate() {
        if (!$('#chartOne').val()) {
            alert('尺寸:540*810的图片不能为空');
            return false;
        }
        if (!$('#chartTwo').val()) {
            alert('尺寸:720*1080的图片不能为空');
            return false;
        }
        if (!$('#chartThree').val()) {
            alert('尺寸:1080*1620的图片不能为空');
            return false;
        }
        if (!$('#chartFour').val()) {
            alert('尺寸:640*760的图片不能为空');
            return false;
        }
        if (!$('#chartFive').val()) {
            alert('尺寸:750*1094的图片不能为空');
            return false;
        }
        return true;
    }

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
                    $('#preview_'+id).css({'display':'block','width':'200px', 'height':'350px'});
                    $('#preview_'+id).attr('src', window.URL.createObjectURL(urlObj.files[0]));
                }
            } else {
                $('#'+id).val('');
                alert('请选择建议的图片格式！');
                return false;
            }
        }
        return true;
    }
</script>
</html>