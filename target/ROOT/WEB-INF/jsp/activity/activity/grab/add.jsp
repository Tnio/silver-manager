<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
<body>
<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
<div class="row-fluid">
    <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
    <div class="span9" id="content">
        <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
        <!-- content begin -->
        <div class="row-fluid">
            <form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post"  onsubmit="return startValidate();" enctype="multipart/form-data" action="${pageContext.request.contextPath}/activity/grab/save" >
                <input id="id" name="id" value="0" type="hidden">
                <input name="page" value="${page }" type="hidden">
                <input name="size" value="${size }" type="hidden">
                <div class="span12" style="margin-left: -2px">
                    <div id="product" class="accordion">
                        <div class="accordion-group" id="base">
                            <div class="accordion-body collapse in" id="product-base">
                                <div class="accordion-inner">
                                    <div class="well" style="padding-bottom: 20px; margin: 0;">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>活动名称</label>
                                            <div class="controls"><input type="text" id="name" name="name" class="validate[required,maxSize[30],ajax[ajaxValidateActivityCouponName]] text-input span12"  placeholder="不超过15个汉字"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
                                        </div>
                                        <div class="row-fluid">
                                            <div class="span6">
                                                <div class="control-group">
                                                    <label class="control-label"><span class="required">*</span>开始时间</label>
                                                    <div class="controls">
                                                        <input type="text" id="beginTime" name="beginTime" class="validate[required] text-input span11" onkeypress="return false"/>
                                                    </div>
                                                </div>
                                                <div class="row-fluid">
                                                    <div class="control-group">
                                                        <label class="control-label"><span class="required">*</span>选择红包</label>
                                                        <div class="controls">
                                                            <!-- <input type="hidden" id="couponId" name="coupon.id"/> -->
                                                            <input type="text" id="couponName" class="text-input span11" onclick="showCouponDialog()" readonly/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="span6">
                                                <div class="control-group" id="lowestMoneyGroup">
                                                    <label class="control-label"><span class="required">*</span>结束时间</label>
                                                    <div class="controls">
                                                        <input type="text" id="endTime" name="endTime" class="validate[required] text-input span11" onkeypress="return false"/>
                                                    </div>
                                                </div>
                                                <div class="control-group" id="increaseInterestGroup">
                                                    <label class="control-label"><span class="required">*</span>红包数量</label>
                                                    <div class="controls">
                                                        <input type="text" id="quantity" name="quantity" class="validate[required,custom[integer],min[1],max[99999]] text-input span11"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="control-group">
                                                    <label class="control-label"><span class="required">*</span>优惠券预览</label>
                                                    <div class="controls" id="quantityGroup">

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">参与次数</label>
                                            <div class="controls" id="imageChoice">
                                                <input type="text" value="每人仅参与一次" readonly class="validate[required, minSize[6], maxSize[40]] text-input span12"/>
                                                <input type="hidden" id="raceFrequency" name="raceFrequency" value="1"/>
                                            </div>
                                        </div>
                                        <div class="control-group" >
                                            <label class="control-label"><span class="required">*</span> 活动规则</label>
                                            <div class="controls">
                                                <textarea name="remark" class="validate[required] text-input span12" rows="5" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="最多4000个汉字"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="span6" align="right">
                            <button type="submit" id="save" class="btn btn-success btn-lg">保存</button>
                        </div>
                        <div class="span6" align="left">
                            <button  type="reset" class="btn btn-default btn-lg" onclick="quit()">返回</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>
<div class="modal hide fade" id="bonus" role="dialog" style="top:2%;width: 800px;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">选择优惠券</h4>
            </div>
            <div class="modal-body" style="max-height:250px;">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>序号</th>
                        <th>使用条件</th>
                        <th>是否可转赠</th>
                        <th>到期时间</th>
                        <th>优惠额度</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="bonusBody">
                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="5">
                            <div id="bonus-page"></div>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<script src="${pageContext.request.contextPath}/res/js/show.original.image.js"></script>
<script type="text/javascript">
    var editor = '';
    var index = 0;
    var flag = 0;
    $(function() {
        $('#fm').validationEngine('attach', {
            promptPosition: 'bottomLeft',
            scroll: false,
            showOneMessage : true
        });
        $('#name').focus();
        $('#beginTime').datetimepicker({
            format:'Y-m-d H:00:00',
            minDate:true,
            lang:'ch',
            timepicker:true,
            scrollInput:false,
            onSelectDate : function() {
                var selectedDatetime = $('#beginTime').val();
                var start=new Date(selectedDatetime.replace("-", "/").replace("-", "/"));
                var endtime = $('#endTime').val();
                if(endtime != null && endtime != ''){
                    var end=new Date(endtime.replace("-", "/").replace("-", "/"));
                    if ((new Date() > start) || (end < start)) {
                        $('#beginTime').val('');
                    }
                }else{
                    if (new Date() > start) {
                        $('#beginTime').val('');
                    }
                }
            },
            onSelectTime : function() {
                var selectedDatetime = $('#beginTime').val();
                var start=new Date(selectedDatetime.replace("-", "/").replace("-", "/"));
                var endtime = $('#endTime').val();
                if(endtime != null && endtime != ''){
                    var end=new Date(endtime.replace("-", "/").replace("-", "/"));
                    if ((new Date() > start) || (end < start)) {
                        $('#beginTime').val('');
                    }
                }else{
                    if (new Date() > start) {
                        $('#beginTime').val('');
                    }
                }
            },
            onClose : function() {
                var selectedDatetime = $('#beginTime').val();
                var start=new Date(selectedDatetime.replace("-", "/").replace("-", "/"));
                var endtime = $('#endTime').val();
                var result = true;
                if(endtime != null && endtime != ''){
                    var end=new Date(endtime.replace("-", "/").replace("-", "/"));
                    if (new Date() > start || end < start) {
                        $('#beginTime').val('');
                    }
                    result = (start > new Date()) && (start <= end);
                }else{
                    if (new Date() > start) {
                        $('#beginTime').val('');
                    }
                    result = start > new Date();
                }
                return result;
            }
        });
        $('#endTime').datetimepicker({
            format:'Y-m-d H:00:00',
            minDate: $('#beginTime').val(),
            lang:'ch',
            timepicker:true,
            scrollInput:false,
            onSelectDate : function() {
                var selectedDatetime = $('#endTime').val();
                var start=new Date(selectedDatetime.replace("-", "/").replace("-", "/"));
                if ($('#beginTime').val() > start) {
                    $('#beginTime').val('');
                }
            },
            onSelectTime : function() {
                var selectedDatetime = $('#endTime').val();
                var end = new Date(selectedDatetime.replace("-", "/").replace("-", "/"));
                var beginTime = $('#beginTime').val();
                var begin = new Date(beginTime.replace("-", "/").replace("-", "/"));
                if(begin > end){
                    $('#endTime').val('');
                }
            },
            onClose : function() {
                var selectedDatetime = $('#endTime').val();
                var end = new Date(selectedDatetime.replace("-", "/").replace("-", "/"));
                var beginTime = $('#beginTime').val();
                var begin = new Date(beginTime.replace("-", "/").replace("-", "/"));
                return begin <= end;
            }
        });
    });

    $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">抢红包活动&nbsp</a>/&nbsp;新增抢红包活动</li>');

    function startValidate() {
        var couponId = $("input[name='couponIds']").val();
        if(couponId == undefined){
            alert("请选择优惠券");
            return false;
        }
    }

    function showCouponDialog(){
        getCoupon(1);
        $('#bonus').modal('show');
    }

    function getCoupon(page){
        $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/'+page, {"category":0,"type":1}, function(result){
            if (result.total > 0) {
                $('#bonusBody').html("");
                for (var i = 0; i < result.bonus.length; i++) {
                    var b = result.bonus[i];
                    $('#bonusBody').append('<tr>');
                    $('#bonusBody').append('<td class="hidden">'+b.id+'</td>');
                    $('#bonusBody').append('<td>'+(i+1)+'</td>');
                    $('#bonusBody').append('<td style="width:45%">'+b.condition+'</td>');
                    if (b.donation == 0) {
                        $('#bonusBody').append('<td>不可转赠</td>');
                    } else {
                        $('#bonusBody').append('<td>可转赠</td>');
                    }
                    if (b.lifeCycle == 0) {
                        $('#bonusBody').append('<td>一万年有效</td>');
                    } else if (b.lifeCycle == 1) {
                        $('#bonusBody').append('<td>'+b.expiresPoint+'到期</td>');
                    } else if (b.lifeCycle == 1) {
                        $('#bonusBody').append('<td>自领取后'+b.expiresPoint+'天过期</td>');
                    }else {
                        $('#bonusBody').append('<td></td>');
                    }
                    $('#bonusBody').append('<td>'+b.amount+'元</td>');
                    $('#bonusBody').append('<td><a href=javascript:choiceCoupon('+b.id+','+'"'+b.amount+'"'+',"'+b.condition+'");>选择</a></td>');
                    $('#bonusBody').append('</tr>');
                }

                var totalPages = Math.ceil(result.total/15);
                var options = {
                    currentPage: result.newsPage,
                    totalPages: totalPages,
                    size: 'normal',
                    alignment: 'center',
                    tooltipTitles: function (type, page, current) {
                        switch (type) {
                            case 'first':
                                return '首页';
                            case 'prev':
                                return '上一页';
                            case 'next':
                                return '下一页';
                            case 'last':
                                return '末页';
                            case 'page':
                                return (page === current) ? '当前页 ' + page : '跳到 ' + page;
                        }
                    },
                    onPageClicked: function(event, originalEvent, type, page){
                        getCoupon(page);
                    }
                };
                $('#bonus-page').bootstrapPaginator(options);
            }else{
                $('#bonusBody').html('<tr><td colspan="5">请先添加红包</td></tr>');
            }
        });
    }

    function choiceCoupon(couponId, amount, condition){
        if(flag > 19){
            alert('您一次不能添加更多的优惠券了!');
            return ;
        }
        var company = '元';
        $('#quantityGroup').append('<a href="javascript:remove(div'+index+')" id="div'+index+'" amount="'+amount+'"><input id="couponIds'+index+'" name="couponIds"  value="'+couponId+'" type="hidden" ><input id="couponAmount'+index+'" name="couponAmounts"  value="'+amount+'" type="hidden" ><input id="coupons'+index+'" name="coupons"  value="'+couponId+'*'+amount+company+'" type="hidden" ><span class="label label-important" style="height:22px;width:70px;margin-top: 1px;padding-top: 8px" title="'+condition+'">'+ amount + company +'</span></a>');

        $('#quantityGroup').append(' ');
        index++;
        flag ++;
    }

    function remove(id){
        flag --;
        $(id).remove();
    }

    function quit() {
        window.location.href='${pageContext.request.contextPath}/activity/grab/list/1';
    }
</script>
</body>
</html>
