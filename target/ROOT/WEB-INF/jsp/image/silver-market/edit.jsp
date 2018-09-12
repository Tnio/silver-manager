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
                <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/app/image/save">
                    <input id="id" name="id" value="${photo.id}" type="hidden">
                    <input id="name" name="name" value="${photo.name}" type="hidden">
                    <input id="url" name="url" value="${photo.url}" type="hidden" >
                    <input id="category" name="category" value="${photo.category}" type="hidden" >
                    <div class="well" style="padding-bottom: 20px; margin: 0;">
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>名称</label>
                            <div class="controls"><input type="text" id="title" name="name" value="银子商城首页焦点图" readonly="readonly" ></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span> 图片</label>
                            <div class="controls" id="imgReUpload"><img id="imgUrl" style="width:260px;height:100px;" src="" alt="图片可能丢失" /></div>
                        </div>
                        <div class="control-group" id="reloadButton">
                            <label class="control-label"></label>
                            <div class="controls"><a href="javascript:reUpload('imgReUpload');"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
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
                if ('${photo.content}' && '${photo.linkCategory}' == 1) {
                    $('#link').show();
                    $('#link').val('${photo.content}');

                } else {
                    $('#link').val('http://');
                }
            }else if(value == 2){
                $('#innerContent').show();
                UE.getEditor('content').addListener("ready", function () {
                    UE.getEditor('content').setContent('${photo.content}');
                });
                $('#link').hide();
                $('#link').val('');
            }
        });

        if ('${photo.linkCategory}' == 1) {
            $('input[name=linkCategory][value=1]').attr("checked",true);
            $('input[name=linkCategory][value=1]').trigger('change');
            $('#link').show();
            $('#innerContent').hide();
        }else if('${photo.linkCategory}' == 2){
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
        var url = '${photo.url}';
        $('#imgUrl').attr('src', url);

        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">APP图片管理</a>&nbsp;/&nbsp;银子商城图</li>');
            $('#save').show();
        }else{
            $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">APP图片管理</a>&nbsp;/&nbsp;银子商城图</li>');
            $('#save').hide();
            readOnly();
        }
    });

    function quit(){
        window.location.href='${pageContext.request.contextPath}/chart/list';
    }

    var load = 0;
    function startValidate() {
        if (!$('#imgUrl').val() && load > 0) {
            alert('图片不能为空!');
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
                    $('#preview_'+id).css({'display':'block','width':'260px', 'height':'100px'});
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
        $('#reloadButton').hide();
        load++;
        $('#'+value).html('');
        $('#'+value).html('<img id="preview_imgUrl" /><input id="imgUrl" type="file" name="imgUrl" accept="image/*" onchange="javascript:setImagePreview(this.id);" /><span><font style="color:red">（建议尺寸：750*280，支持png或jpg格式）</font></span>');
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