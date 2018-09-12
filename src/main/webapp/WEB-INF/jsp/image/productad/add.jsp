<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
<body>
<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
<div class="container-fluid">
    <div class="row-fluid">
        <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
        <div class="span10">
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form id="form10" action="${pageContext.request.contextPath}/productad/save" method="post" enctype="multipart/form-data" class="form-horizontal" >
                            <input id="category" name="category" value="5" type="hidden">
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span>名称</label>
                                    <div class="controls" style="border: 1px solid #A8A8A8;margin-top: 5px;height:25px;width:469px;line-height: 25px;padding-left:2px;">
                                        产品列表广告位
                                        <input type="hidden" name="name" value="APP产品列表页跑马灯" readonly="readonly">
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>简介</label>
                                            <div class="controls">
                                                <textarea id="remark" name="remark" style="width:464px;height:60px"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="newsType">
                                    <label class="control-label"><span class="required">*</span>内容</label>
                                    <div class="controls">
                                        <div class="row-fluid">
                                            <div class="span2">
                                                <input type="radio" name="linkCategory" value="2" class="validate[required] radio span4" checked="checked">
                                                <span>内部上传</span>
                                            </div>
                                            <div class="span2">
                                                <input type="radio" name="linkCategory" value="1" class="validate[required] radio span4">
                                                <span>外部链接</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="linkWrap">
                                    <label class="control-label"><span class="required">*</span>链接地址</label>
                                    <div class="controls">
                                        <input type="text" id="link" name="link" value="" class="validate[required] text-input span12" />
                                    </div>
                                </div>
                                <div class="control-group" id="contentWrap">
                                    <label class="control-label"><span class="required">*</span>内容上传</label>
                                    <div class="controls">
                                        <textarea cols="80" id="content" name="content" class="text-input span12"></textarea>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <a id="save" class="btn btn-icon btn-default glyphicons circle_remove" href="javascript:validate();" >保存</a>

                                    <a id="reset" class="btn btn-icon btn-default glyphicons circle_remove" href="javascript:quit();">返回</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- /block -->
            </div>
            <!-- content end -->
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<script type="text/javascript">
    var content = '';
    $(function(){
        $('.breadcrumb').html('<li class="active">图片管理&nbsp;/&nbsp;<a href="javascript:quit();">广告位管理</a>&nbsp;/&nbsp;添加</li>');
        $('#linkWrap').hide();

        $('#form10').validationEngine('attach', {
            promptPosition:'bottomLeft',
            showOneMessage: true,
            focusFirstField: true,
            scroll: true
        });

        $('#newsType').find('input:radio').click(function(){
            var v=$(this).val();
            if(v==2){
                $('#linkWrap').hide();
                $('#contentWrap').show();
            }
            if(v==1){
                $('#linkWrap').show();
                $('#contentWrap').hide();
            }
        });
        content = UE.getEditor('content');
    });

    function validate() {
        if($('#remark').val().length<=0){
            return false;
        }
        var type = $('input:radio[name=linkCategory]:checked').val();
        if(type==2){
            var txt = content.getContent();
            if($.trim(txt) == ''){
                $('#content').addClass('validate[required]');
            }else if(txt.length > 10000){
                alert('内容字数超出限制');
                return false;
            }else{
                $('#content').removeClass('validate[required]');
            }
        }
        /* var value = $('[name=linkCategory]').filter(':checked').attr('value'); */
        if (type == 1) {
            UE.getEditor('content').destroy();
            $('#content').val($('#link').val());
        }
        $('#form10').submit();
    }


    function quit() {
        window.location.href='${pageContext.request.contextPath}/chart/list';
    }
</script>
</body>
</html>