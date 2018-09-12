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
                <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/web/image/save">
                    <%-- <input id="category" name="category" value="${para}" type="hidden"> --%>
                    <input id="url" name="url" type="hidden" >
                    <div class="well" style="padding-bottom: 20px; margin: 0;">
                        <div class="control-group">
                            <label class="control-label" ><span class="required">*</span>图片名称</label>
                            <select name="category">
                                <c:if test="${para == ALBUM}">
                                    <option value="2">登录页</option>
                                    <option value="3">导航栏</option>
                                </c:if>
                                <c:if test="${para == LOGIN}">
                                    <option value="2">登录页</option>
                                </c:if>
                                <c:if test="${para == NAVIGATION}">
                                    <option value="3">导航栏</option>
                                </c:if>
                            </select>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>图片</label>
                            <div class="controls" id="UploadImg"><img id="preview_chartOne" /><input id="chartOne" type="file" name="filename" accept="image/*" onchange="javascript:setImagePreview(this.id);" /><span><font style="color:red">（建议尺寸：导航栏：140*60，登录页：600*400，支持png或jpg格式）</font></span></div>
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
        $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">网站图片管理</a>&nbsp;/&nbsp;添加网站图片</li>');
        $('.msg').css('color', 'red');
        $('#link').hide();
        $('input[name=linkCategory]').change(function(){
            var value = $('[name=linkCategory]').filter(':checked').attr('value');
            if (value == 0) {
                $('#link').hide();
                $('#link').val('');
            } else if (value == 1) {
                $('#link').show();
                if ('${chart.link}') {
                    $('#link').show();
                } else {
                    $('#link').val('http://');
                }
            }
        });

        if ('${chart.link}') {
            $('input[name=linkCategory][value=1]').attr("checked",true);
            $('#link').show();
        }

    });

    function quit(){
        window.location.href='${pageContext.request.contextPath}/web/image/list';
    }

    function startValidate() {
        if (!$('#chartOne').val()) {
            alert('图片不能为空');
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

    var workImg=document.getElementsByTagName('img');
    for(var i=0; i<workImg.length; i++) {
        workImg[i].onclick=ImgShow;
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