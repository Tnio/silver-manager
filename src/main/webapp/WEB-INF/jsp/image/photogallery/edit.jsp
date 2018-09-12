<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" action="${pageContext.request.contextPath}/web/image/save">
                    <input id="id" name="id" value="${photo.id}" type="hidden">
                    <input id="url" name="url" value="${photo.url}" type="hidden" >
                    <input id="title" name="name" value="${photo.name}" type="hidden" >
                    <input id="status" name="status" value="${photo.status}" type="hidden" >
                    <input id="category" name="category" value="${photo.category}" type="hidden" >
                    <div class="well" style="padding-bottom: 20px; margin: 0;">
                        <div class="control-group">
                            <label class="control-label" ><span class="required">*</span>图片名称</label>
                            <div class="controls" style="margin-top: 5px">${photo.name}</div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>图片</label>
                            <div class="controls" id="UploadImg"><c:if test="${photo.category == 3}"><img style="width:140px;height:60px;" src="${photo.url}" /></c:if>
                                <c:if test="${photo.category == 2 || photo.category == 8}"><img style="width:300px;height:200px;" src="${photo.url}" /></c:if>
                            </div>
                        </div>
                        <div class="control-group" >
                            <label class="control-label"></label>
                            <div class="controls" id="imageUpload"><a href="javascript:reUpload();"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
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
                            <input type="text" id="link" name="content" value="${photo.content}"  class="validate[required, maxSize[65], custom[url]] text-input span4" />
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
            var value = $(this).attr('value');
            if (value == 0) {
                $('#link').hide();
                $('#link').val('');
            } else if (value == 1) {
                $('#link').show();
                if ('${photo.content}' != null) {
                    $('#link').show('${photo.content}');
                } else {
                    $('#link').val('http://');
                }
            }
        });
        $('input[name=linkCategory][value=${photo.linkCategory}]').attr("checked",true);
        $('input[name=linkCategory][value=${photo.linkCategory}]').trigger("change");
        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">网站图片管理</a>&nbsp;/&nbsp;编辑网站图片</li>');
            $('#save').show();
        }else{
            $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">网站图片管理</a>&nbsp;/&nbsp;查看网站图片</li>');
            $('#save').hide();
            readOnly();
        }
    });

    function quit(){
        window.location.href='${pageContext.request.contextPath}/web/image/list';
    }

    function setImagePreview(id) {
        var urlObj = $('#'+id)[0];
        if(urlObj){
            var suffix = urlObj.files[0].name.split('.').pop().toLowerCase();
            if ('${photo.category}' == 3) {
                if (suffix == 'png' || suffix == 'jpg' || suffix == 'gif') {
                    if(urlObj.files && urlObj.files[0]){
                        if (Math.round(urlObj.files[0].size * 100 / 1024) / 100 > 2048) {
                            $('#'+id).val('');
                            alert('亲，请选择不超过2兆的图片！');
                            return false;
                        }
                        if ('${photo.category}' == 2 || '${photo.category}' == 8) {
                            $('#preview_'+id).css({'display':'block','width':'300px', 'height':'200px'});
                        } else if ('${photo.category}' == 3) {
                            $('#preview_'+id).css({'display':'block','width':'140px', 'height':'60px'});
                        } else {
                            $('#preview_'+id).css({'display':'block','width':'300px', 'height':'200px'});
                        }
                        $('#preview_'+id).attr('src', window.URL.createObjectURL(urlObj.files[0]));
                    }
                } else {
                    $('#'+id).val('');
                    alert('请选择建议的图片格式！');
                    return false;
                }
            } else if ('${photo.category}' == 2 || '${photo.category}' == 8) {
                if (suffix == 'png' || suffix == 'jpg') {
                    if(urlObj.files && urlObj.files[0]){
                        if (Math.round(urlObj.files[0].size * 100 / 1024) / 100 > 2048) {
                            $('#'+id).val('');
                            alert('亲，请选择不超过2兆的图片！');
                            return false;
                        }
                        if ('${photo.category}' == 2 || '${photo.category}' == 8) {
                            $('#preview_'+id).css({'display':'block','width':'300px', 'height':'200px'});
                        } else if ('${photo.category}' == 3) {
                            $('#preview_'+id).css({'display':'block','width':'140px', 'height':'60px'});
                        } else {
                            $('#preview_'+id).css({'display':'block','width':'300px', 'height':'200px'});
                        }
                        $('#preview_'+id).attr('src', window.URL.createObjectURL(urlObj.files[0]));
                    }
                } else {
                    $('#'+id).val('');
                    alert('请选择建议的图片格式！');
                    return false;
                }
            }
        }
        return true;
    }

    var workImg=document.getElementsByTagName('img');
    for(var i=0; i<workImg.length; i++) {
        workImg[i].onclick=ImgShow;
    }

    function reUpload() {
        $('#UploadImg').html('');
        if ('${photo.category}' == 2 || '${photo.category}' == 8) {
            $('#UploadImg').html('<img id="preview_chartOne" /><input id="chartOne" type="file" name="filename" accept="image/*" onchange="javascript:setImagePreview(this.id);" /><span><font style="color:red">（建议尺寸：840*480，支持png或jpg格式）</font></span>');
        } else if ('${photo.category}' == 3) {
            $('#UploadImg').html('<img id="preview_chartOne" /><input id="chartOne" type="file" name="filename" accept="image/*" onchange="javascript:setImagePreview(this.id);" /><span><font style="color:red">（建议尺寸：140*60，支持png、jpg或gif格式）</font></span>');
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
    }
</script>
</html>