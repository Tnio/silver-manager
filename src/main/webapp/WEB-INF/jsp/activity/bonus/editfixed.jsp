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
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form id="fm" onsubmit="return validate()" action="${pageContext.request.contextPath}/bonus/save" method="post" class="form-horizontal" >
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <div class="control-group">
                                    <input id="id" name="id" value="${bonus.id}" type="hidden">
                                    <input name="page" value="${page}" type="hidden">
                                    <input name="size" value="${size}" type="hidden">
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span>活动名称</label>
                                    <div class="controls"><input type="text" id="name" name="name" value="${bonus.name}" readonly="readonly"  class="validate[required,minSize[6],maxSize[40],ajax[ajaxValidateName]] span11" placeholder="3~20个汉字" /></div>
                                </div>
                                <%-- <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 开始时间</label>
                                            <div class="controls"><input type="text" readonly style="background:white;" id="begin" name="begin" value="${bonus.begin}" class="validate[required,custom[date],past[#end]] text-input span9" /></div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 结束时间</label>
                                            <div class="controls"><input type="text" readonly style="background:white;" id="end" name="end" value="${bonus.end}" class="validate[required,custom[date],future[#begin]] text-input span9" /></div>
                                        </div>
                                    </div>
                                </div> --%>

                                <div class="control_group" id="giveTypeBox">
                                    <label class="control-label"><span class="required">*</span> 赠送类型</label>
                                    <div class="row-fluid">
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="giveType"  value="1" <c:if test="${bonus.giveType == 1}">checked="checked"</c:if> class="validate[required] radio span4">
                                                <span >返银子</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="giveType" value="2" <c:if test="${bonus.giveType == 2}">checked="checked"</c:if> class="validate[required] radio span4">
                                                <span >返红包</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span>赠送数量</label>
                                    <div class="controls"><input type="text" id="give" name="give" value="${bonus.giveAmount}" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" class="required,custom[integer],min[1],max[100000]] text-input span10" /><span class="units">两</span></div>
                                </div>
                                <hr class="separator" />
                                <div class="form-actions">
                                    <button type="submit" id="save" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
                                    <a type="reset" class="btn btn-icon btn-default glyphicons circle_remove" href="javascript:quit();"><i></i>返回</a>
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
</body>
<script type="text/javascript">
    $(function(){
        $('#name').css({width:'300px'}).focus();
        $('#give').css({width:'90px'});
        initGiveType();
        $('#fm').validationEngine('attach', {
            promptPosition: 'centerRight',
            scroll: false,
            showOneMessage : true
        });
        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">返利活动管理</a>&nbsp;/&nbsp;编辑返利活动</li>');
            $('#name').css({width:'300px'}).focus();
            $('#save').show();
        }else{
            $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">返利活动管理</a>&nbsp;/&nbsp;查看返利活动</li>');
            $('#save').hide();
            readOnly();
        }
    });

    function initGiveType() {
        var t= '${bonus.giveType}';
        if(t==1) {
            $('.units').html('两');
        } else if (t==2 ){
            $('.units').html('元');
        }

        $('#giveTypeBox').find("input:radio").click(function(){
            var value = $(this).val();
            if(value==1) {
                $('.units').html('两');
            } else if (value==2) {
                $('.units').html('元');
            }
        });
    }

    $('#begin').datetimepicker({
        format:'Y-m-d',
        minDate:new Date().toLocaleDateString(),
        lang:'ch',
        scrollInput:false,
        timepicker:false
    });

    $('#end').datetimepicker({
        format:'Y-m-d',
        lang:'ch',
        scrollInput:false,
        timepicker:false
    });

    function validate(){
        $('#fm').validationEngine('attach', {
            promptPosition: 'centerRight',
            scroll: false,
            showOneMessage : true
        });
        return true;
    }

    function readOnly() {
        var a = document.getElementsByTagName('input');
        for(var i=0; i<a.length; i++)   {
            if(a[i].type=='checkbox' || a[i].type=='radio' || a[i].type=='text'){
                a[i].readOnly = true;
                a[i].disabled = 'disabled';
            }
        }

        var  b  =  document.getElementsByTagName('select');
        for(var i=0; i<b.length; i++)   {
            b[i].disabled='disabled';
        }

        var c = document.getElementsByTagName('textarea');
        for   (var   i=0;   i<c.length;   i++)
        {
            c[i].disabled="disabled";
        }

        var d = document.getElementsByTagName("button");
        for   (var   i=0;   i<d.length;   i++)
        {
            d[i].disabled="disabled";
        }
    }

    function quit() {
        window.location.href='${pageContext.request.contextPath}/bonus/list/1';
    }
</script>
</html>