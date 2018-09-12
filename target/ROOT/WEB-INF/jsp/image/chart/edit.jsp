<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
<body>
<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
<div class="container-fluid">
    <div class="row-fluid">
        <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
        <div class="span10" id="contentGroup">
            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
            <div class="row-fluid">
                <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/chart/save">
                    <input id="id" name="id" value="${chart.id}" type="hidden">
                    <input id="title" name="title" value="${chart.name}" type="hidden">
                    <input id="url" name="url" value="${chart.url}" type="hidden" >
                    <input id="category" name="category" value="${chart.category}" type="hidden" >
                    <div class="well" style="padding-bottom: 20px; margin: 0;">
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>启动图名称</label>
                            <div class="controls"><input type="text" id="title" name="name" value="APP启动图" class="validate[required,maxSize[40]] text-input span9"  readonly="readonly" ></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 540*810</label>
                            <div class="controls" id="chartOneUpload"><img id="chartOneImg" style="width:200px;height:350px;" src="" alt="540*810图片可能丢失" /></div>
                        </div>
                        <div class="control-group" id="chartOneReUpload">
                            <label class="control-label"></label>
                            <div class="controls"><a href="javascript:reUpload('chartOneUpload');"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 720*1080</label>
                            <div class="controls" id="chartTwoUpload"><img id="chartTwoImg" style="width:200px;height:350px;" src="" alt="720*1080图片可能丢失" /></div>
                        </div>
                        <div class="control-group" id="chartTwoReUpload">
                            <label class="control-label"></label>
                            <div class="controls"><a href="javascript:reUpload('chartTwoUpload');"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 1080*1620</label>
                            <div class="controls" id="chartThreeUpload"><img id="chartThreeImg" style="width:200px;height:350px;" src="" alt="1080*1620图片可能丢失" /></div>
                        </div>
                        <div class="control-group" id="chartThreeReUpload">
                            <label class="control-label"></label>
                            <div class="controls"><a href="javascript:reUpload('chartThreeUpload');"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 640*896</label>
                            <div class="controls" id="chartFourUpload"><img id="chartFourImg" style="width:200px;height:350px;" src="" alt="640*896图片可能丢失" /></div>
                        </div>
                        <div class="control-group" id="chartFourReUpload">
                            <label class="control-label"></label>
                            <div class="controls"><a href="javascript:reUpload('chartFourUpload');"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 750*1094</label>
                            <div class="controls" id="chartFiveUpload"><img id="chartFiveImg" style="width:200px;height:350px;" src="" alt="750*1094图片可能丢失" /></div>
                        </div>
                        <div class="control-group" id="chartFiveReUpload">
                            <label class="control-label"></label>
                            <div class="controls"><a href="javascript:reUpload('chartFiveUpload');"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
                        </div>


                        <div class="row-fluid">
                            <div class="span6">
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span>  链接地址</label>
                                    <div class="row-fluid">
                                        <div class="span2">
                                            <div class="control-group ">
                                                <span>&nbsp;&nbsp;</span>
                                                <input type="radio" name="linkCategory" value="0" checked="checked" class="validate[required] radio span1">
                                                <span>无</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="linkCategory" value="2"  class="validate[required] radio span1">
                                                <span >内部上传</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="linkCategory" value="1" class="validate[required] radio span1">
                                                <span >外部链接</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="text" id="link" class="validate[required, maxSize[65], custom[url]] text-input span4" />
                        </div>
                        <div class="control-group" id="innerContent">
                            <label class="control-label"><span class="required">*</span> 内容上传</label>
                            <div class="controls" id="innerRemark">
										<textarea cols="80" id="content" name="content" class="text-input span12">

										</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"></label>
                            <div class="controls">
                                <button type="submit" id="save" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
                                <button type="button" id="reback" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit();"><i></i>返回</button>
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
<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
</body>
<script type="text/javascript">
    var content = '';
    $(function() {
        $('#fm').validationEngine('attach', {
            promptPosition:'bottomLeft',
            showOneMessage: true,
            focusFirstField:true,
            scroll: true
        });
        content = UE.getEditor('content');
        $('.msg').css('color', 'red');
        $('input[name=linkCategory]').change(function(){
            var value = $('[name=linkCategory]').filter(':checked').attr('value');
            if (value == 0) {
                $('#link').hide();
                $('#link').val('');
                $('#innerContent').hide();
                $('#content').val('');
            } else if(value == 1){
                $('#link').show();
                $('#innerContent').hide();
                $('#content').val('');
                if ('${chart.content}' && '${chart.linkCategory}' == 1) {
                    $('#link').show();
                    $('#link').val('${chart.content}');

                } else {
                    $('#link').val('http://');
                }
            }else if(value == 2){
                $('#innerContent').show();
                UE.getEditor('content').addListener("ready", function () {
                    UE.getEditor('content').setContent('${chart.content}');
                });
                $('#link').hide();
                $('#link').val('');
            }
        });

        if ('${chart.linkCategory}' == 1) {
            $('input[name=linkCategory][value=1]').attr("checked",true);
            $('input[name=linkCategory][value=1]').trigger('change');
            $('#link').show();
            $('#innerContent').hide();
        }else if('${chart.linkCategory}' == 2){
            $('input[name=linkCategory][value=2]').attr("checked",true);
            $('input[name=linkCategory][value=2]').trigger('change');
            $('#link').hide();
            $('#innerContent').show();
        }else{
            $('input[name=linkCategory][value=0]').attr("checked",true);
            $('input[name=linkCategory][value=0]').trigger('change');
            $('#link').hide();
            $('#innerContent').hide();
        }
        var urls = '${chart.url}';
        $('#chartOneImg').attr('src', JSON.parse(urls)['540']);
        $('#chartTwoImg').attr('src', JSON.parse(urls)['720']);
        $('#chartThreeImg').attr('src', JSON.parse(urls)['1080']);
        $('#chartFourImg').attr('src', JSON.parse(urls)['640']);
        $('#chartFiveImg').attr('src', JSON.parse(urls)['750']);

        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">APP图片管理</a>&nbsp;/&nbsp;修改启动图</li>');
            $('#save').show();
        }else{
            $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">APP图片管理</a>&nbsp;/&nbsp;查看启动图</li>');
            $('#save').hide();
            readOnly();
        }
    });

    function quit(){
        window.location.href='${pageContext.request.contextPath}/chart/list';
    }

    var loadOne = 0;
    var loadTwo = 0;
    var loadThree = 0;
    var loadFour = 0;
    var loadFive = 0;
    function startValidate() {
        if (loadOne > 0 && !$('#chartOne').val()) {
            alert('尺寸:540*810的图片不能为空');
            return false;
        }
        if (loadTwo > 0 && !$('#chartTwo').val()) {
            alert('尺寸:720*1080的图片不能为空');
            return false;
        }
        if (loadThree > 0 && !$('#chartThree').val()) {
            alert('尺寸:1080*1620的图片不能为空');
            return false;
        }
        if (loadFour > 0 && !$('#chartFour').val()) {
            alert('尺寸:640*896的图片不能为空');
            return false;
        }
        if (loadFive > 0 && !$('#chartFive').val()) {
            alert('尺寸:750*1094的图片不能为空');
            return false;
        }

        var txt = content.getContent();
        if($.trim(txt) == ''){
            $('#content').addClass('validate[required]');
        }else if(txt.length > 10000){
            alert('内容字数超出限制');
            return false;
        }else{
            $('#content').removeClass('validate[required]');
        }

        var value = $('[name=linkCategory]').filter(':checked').attr('value');
        if (value == 1) {
            UE.getEditor('content').destroy();
            $('#content').val($('#link').val());
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

    var workImg=document.getElementsByTagName('img');
    for(var i=0; i<workImg.length; i++) {
        workImg[i].onclick=ImgShow;
    }

    function reUpload(value) {
        if (value == 'chartOneUpload') {
            loadOne++;
            $('#chartOneReUpload').hide();
            $('#'+value).html('');
            $('#'+value).html('<img id="preview_chartOne" /><input id="chartOne" type="file" name="chartOne" accept="image/*" onchange="javascript:setImagePreview(this.id);" /><span><font style="color:red">（建议尺寸：540*810，支持png或jpg格式）</font></span>');
        } else if (value == 'chartTwoUpload') {
            loadTwo++;
            $('#chartTwoReUpload').hide();
            $('#'+value).html('');
            $('#'+value).html('<img id="preview_chartTwo" /><input id="chartTwo" type="file" name="chartTwo" accept="image/*" onchange="javascript:setImagePreview(this.id);" /><span><font style="color:red">（建议尺寸：720*1080，支持png或jpg格式）</font></span>');
        } else if (value == 'chartThreeUpload') {
            loadThree++;
            $('#chartThreeReUpload').hide();
            $('#'+value).html('');
            $('#'+value).html('<img id="preview_chartThree" /><input id="chartThree" type="file" name="chartThree" accept="image/*" onchange="javascript:setImagePreview(this.id);" /><span><font style="color:red">（建议尺寸：1080*1620，支持png或jpg格式）</font></span>');
        } else if (value == 'chartFourUpload') {
            loadFour++;
            $('#chartFourReUpload').hide();
            $('#'+value).html('');
            $('#'+value).html('<img id="preview_chartFour" /><input id="chartFour" type="file" name="chartFour" accept="image/*" onchange="javascript:setImagePreview(this.id);" /><span><font style="color:red">（建议尺寸：640*896，支持png或jpg格式）</font></span>');
        } else if (value == 'chartFiveUpload') {
            loadFive++;
            $('#chartFiveReUpload').hide();
            $('#'+value).html('');
            $('#'+value).html('<img id="preview_chartFive" /><input id="chartFive" type="file" name="chartFive" accept="image/*" onchange="javascript:setImagePreview(this.id);" /><span><font style="color:red">（建议尺寸：750*1094，支持png或jpg格式）</font></span>');
        }
    }

    function readOnly() {
        var a = document.getElementsByTagName('input');
        for(var i=0; i<a.length; i++)   {
            if(a[i].type=='checkbox' || a[i].type=='radio' || a[i].type=='text'){
                a[i].readOnly = true;
                a[i].disabled = 'disbaled';
            }
        }

        var d = document.getElementsByTagName('button');
        for (var i=0; i<d.length; i++) {
            if (d[i].id == 'reback') {
                continue;
            }
            d[i].disabled='disabled';
        }

        UE.getEditor('content').addListener("ready", function () {
            UE.getEditor('content').setDisabled('fullscreen');
        });
    }
</script>
</html>