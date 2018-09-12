<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <!-- content begin -->
            <div class="row-fluid">
                <form class="form-horizontal" style="margin-bottom: 0;" id="fmi" method="post"  action="${pageContext.request.contextPath}/silver/invitation/save"  autocomplete="off">
                    <input type="hidden" id="id" name="id" value="${silver.id}">
                    <input type="hidden" id="productCategory" name="productCategory" >
                    <div class="well" style="padding-bottom: 20px; margin: 0;">
                        <!-- <label class="control-label">赠送策略</label> -->
                        <div class="control-group">
                            <label class="control-label"><span class="required"></span>当前状态：</label>
                            <div class="controls">
                                <c:choose>
                                    <c:when test="${silver.enable > 0}">
                                        <label class="control-label" style="text-align: left;"><span style="width:350px;">启用</span></label>
                                    </c:when>
                                    <c:otherwise>
                                        <label class="control-label" style="text-align: left;"><span style="width:350px;">禁用</span></label>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>赠送条件：</label>
                            <div class="controls">
                                <div class="span2">
                                    <div class="control-group ">
                                        <input type="radio" name="giveCategory" checked="checked" value="0" <c:if test="${silver.giveCategory == 0}">checked="checked"</c:if> class="validate[required] radio">
                                        <span >好友注册即送</span>
                                    </div>
                                </div>
                                <div class="span2">
                                    <div class="control-group ">
                                        <input type="radio" name="giveCategory" value="1" <c:if test="${silver.giveCategory == 1}">checked="checked"</c:if> class="validate[required] radio">
                                        <span >好友交易即送</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>银子数量：</label>
                            <div class="controls"><input type="text" id="quantity" name="quantity" value="${silver.quantity}" class="validate[required,custom[integer],min[1],max[9999]] text-input span2" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" />两</div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"></label>
                            <div id="authorityButton">
                                <a href="javascript:;" onclick="save();" id="510"><button type="button" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button></a>
                                <a href="javascript:quit()" style="padding-left:10px;" ><button type="reset" class="btn btn-icon btn-default glyphicons circle_remove"><i></i>取消</button></a>
                                <c:choose>
                                    <c:when test="${silver.enable > 0}">
                                        <a href="javascript:;" onclick="audit(${silver.id}, 0);" style="padding-left:10px;" id="512"><button type="button" class="btn btn-primary"><i></i>禁用</button></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:;" onclick="audit(${silver.id}, 1);" style="padding-left:10px;" id="511"><button type="button" class="btn btn-primary"><i></i>启用</button></a>
                                    </c:otherwise>
                                </c:choose>
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
    if ('${saveSuccess}') {
        alert('保存成功！');
    }
    $(function() {
        $('#fmi').validationEngine();
        $('.breadcrumb').html('<li class="active">银子管理&nbsp;/&nbsp;邀请好友赠送银子</li>');
        $('#giveCategory').find('option[value=${silver.giveCategory}]').attr('selected',true);
        //$('input[name=giveCategory]').trigger('onchange');
    });

    function save(){
        $('#fmi').submit();
    };

    function audit(id, enable){
        var msg = "";
        if(enable == 1){
            msg = "启用";
        }else{
            msg = "禁用";
        }
        if (confirm('确定要'+msg+'吗?')) {
            $.ajax({
                type:'post',
                async: true,
                url: '${pageContext.request.contextPath}/silver/invitation/audit',
                data:{
                    'id' : id,
                    'enable' : enable
                },
                success: function(data){
                    if(data == 'false'){
                        alert(msg+'失败，请重试!');
                    } else {
                        quit();
                    };
                }
            });
        };
    }

    function quit(){
        window.location.href='${pageContext.request.contextPath}/silver/invitation';
    };
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>