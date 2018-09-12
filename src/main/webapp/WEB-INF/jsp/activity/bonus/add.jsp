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
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form id="fm" action="${pageContext.request.contextPath}/bonus/save" onsubmit="return startValidate();" method="post" class="form-horizontal" >
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <div class="control-group">
                                    <input id="id" name="id" value="0" type="hidden">
                                    <input id="begin" name="begin" value="2015-01-01" type="hidden" />
                                    <input id="end" name="end" value="2025-01-01" type="hidden" />
                                    <input name="page" value="${page }" type="hidden">
                                    <input name="size" value="${size }" type="hidden">
                                    <input name="giveAmount" value="0" type="hidden">
                                    
                                </div>
                              <div class="control-group">
                                    <label class="control-label"><span class="required">*</span>活动名称</label>
                                    <div class="controls"><input type="text" id="name" name="name" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')"
                                                                 onblur="this.value=this.value.replace(/(\s*$)/g,'')"
                                                                 class="validate[required,minSize[6],maxSize[20],ajax[ajaxValidateName]] span11" placeholder="3~10个汉字" /></div>
                                </div>
                                   <div class="control_group" id="giveTypeBox">
                                    <label class="control-label">返利策略</label>
                                    <div class="row-fluid" >
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="giveType" checked="checked" value="0" class="validate[required] radio span4">
                                                <span >无</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="giveType" value="1" class="validate[required] radio span4">
                                                <span >返银子</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="giveType" value="2" class="validate[required] radio span4">
                                                <span >返红包</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="giveType" value="3" class="validate[required] radio span4">
                                                <span >返加息券</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="giveType" value="4" class="validate[required] radio span4">
                                                <span >返第三方券</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="rule" style="display:none">
                                    <label class="control-label" id="strategyLabel">策略规则</label>
                                    <div class="row-fluid">
                                        <table id="list">
                                        </table>
                                        <div class="control-group">
                                            <button type="button" class="btn btn-icon btn-default" id="add" style="margin-left: 210px" >添加</button>
                                        </div>
                                    </div>
                                </div>
                               <!--  <div class="control-group" id="firstOrder">
                                    <label class="control-label">首单立返</label>
                                    <div class="row-fluid" >
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="firstSingle" checked="checked" value="0" class="validate[required] span4">
                                                <span >无</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="firstSingle" value="1" class="validate[required] radio span4">
                                                <span >返银子</span>
                                            </div>
                                        </div>
                                        <div class="span4" id="interval" style="display:none;">
                                            <div class="control-group ">
                                                <span >银子数量：</span>
                                                <input type="text"  name="firstMinCoins" value="200" class="validate[required,min[20],custom[integer],max[10000]] text-input span4"/>
                                                <span >-</span>
                                                <input type="text"  name="firstMaxCoins" value="400" class="validate[required,min[20],custom[integer],max[10000]] text-input span4"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>   -->
                                <div class="control-group" id="lastOrder">
                                    <label class="control-label">尾单立返</label>
                                    <div class="row-fluid" >
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="lastSingle" checked="checked" value="0" class="validate[required] radio span4">
                                                <span >无</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="lastSingle" value="1" class="validate[required] radio span4">
                                                <span >返银子</span>
                                            </div>
                                        </div>
                                        <div class="span4" id="silverPercent" style="display:none;">
                                            <div class="control-group ">
                                                <span >银子数量=投资金额*</span>
                                                <input type="text" name="lastOrder" value="0" class="validate[required,min[1],custom[integer],max[100]] text-input span2">
                                                <span >%</span>
                                            </div>
                                        </div>
                                         <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio"  id="packcash"  name="lastSingle" value="2" class="validate[required] radio span4" onclick="selectcashtype()">
                                                <span >返现金</span>
                                            </div>
                                        </div>
                                        <br>
                                        <br>
                                        <br>
                                         <div id="cashs"  style="display:none; position: absolute;left: 200px">
                                             <input type="radio" id="cashType1" name="cashType"  checked="checked"  value="1">尾单赠送<input type="text" id="ss" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="4" name="cashAmount" onblur="checkValue(this.value)">元现金 &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="cashType2"  name="cashType" value="2" >尾单赠送投资金额*<input type="text" id="sss" onkeyup='clearNoNum(this)'  name="cashAmount">%元的现金 
                                         </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                </div>
                                <hr class="separator" />
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
                                    <button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit();"><i></i>返回</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- /block -->
            </div>
            <!-- content end -->
            <div class="modal hide fade" id="bonus" role="dialog" style="width: 800px">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="myModalLabel">选择红包</h4>
                        </div>
                        <div class="modal-body">
                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
                                <thead>
                                <tr>
                                    <th style="width:30px;">序号</th>
                                    <th style="width:200px;">使用条件</th>
                                    <th>红包金额</th>
                                    <th>是否可转赠</th>
                                    <th>到期时间</th>
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

            <div class="modal hide fade" id="coupon" role="dialog" style="width: 800px">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="myModalLabel">选择加息券</h4>
                        </div>
                        <div class="modal-body">
                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
                                <thead>
                                <tr>
                                    <th style="width:30px;">序号</th>
                                    <th style="width:200px;">使用条件</th>
                                    <th>加息收益</th>
                                    <th>加息天数</th>
                                    <th>是否可转赠</th>
                                    <th>到期时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="couponBody">
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="5">
                                        <div id="coupon-page"></div>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal hide fade" id="couponCard" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="myModalLabel">选择第三方券</h4>
                        </div>
                        <div class="modal-body">
                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>第三方券名称</th>
                                    <th>金额</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="couponCardBody">
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="5">
                                        <div id="couponCard-page"></div>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script type="text/javascript">
    var bonusInitNum=1;
    var giveType='银子';
    var units='两';
    var row = 0;
    $('input[name=giveType][value=0]').prop('checked', true);
    $('#lastOrder').show();
    $('#firstOrder').show();
    $('#giveTypeBox').show();
    $('#rule').hide();
    $('#strategyLabel').html('返利规则');

    $(function(){
        $('#name').css({width:'300px'});
        initEvent();
        $('input[name=firstSingle]').trigger('onchange');
        $('input[name=lastSingle]').trigger('onchange');
        $('input[name=giveType]').trigger('onchange');
        $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">返利活动管理</a>&nbsp;/&nbsp;新增返利活动</li>');
        $('#fm').validationEngine('attach', {
            promptPosition: 'centerRight',
            showOneMessage:true,
            binded:true,
            scroll: false,
            showOneMessage : true
        });
    });
    function selectcashtype(){
    	$("#cashs").show();
    	$('#silverPercent').hide();
    	$('input[name=lastOrder]').val(0);
    	 
    }
    function checkValue(value){
    	if(value == "0" | value == "00" | value == "000" | value == "0000" | value == "01" | value == "001" | value == "0001"){
    		$("#ss").val(1)
    	}
    }
    $('input[name=cashType]').change(function(){
		  var value = $('[name=cashType]').filter(':checked').attr('value');
		  if(value==1){
    		  $("#sss").val('');
    		  
    	  }else if(value==2){
    		  $("#ss").val('');
    	  }
	  });
    function clearNoNum(obj) {  
        obj.value = obj.value.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符  
            obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字而不是  
            obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的  
            obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");  
            obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数  

    } 
    $('input[name=firstSingle]').change(function(){
        var value = $('[name=firstSingle]').filter(':checked').attr('value');
        if (value == 0) {
            $('#interval').hide();
        } else if (value == 1) {
            $('#interval').show();
        }
    });
    $('input[name=lastSingle]').change(function(){
        var value = $('[name=lastSingle]').filter(':checked').attr('value');
        if (value == 0) {
           // $('#lastOrder').val(0);
           $('input[name=lastOrder]').val(0);
            $('#silverPercent').hide();
            $("#cashs").hide();
            $("#ss").val(0);
            $("#sss").val(0);
            $('#cashType1').val(0);
        } else if (value == 1) {
            $('#silverPercent').show();
            $("#cashs").hide();
            $("#ss").val(0);
            $("#sss").val(0);
            $('#cashType2').val(0);
        }
    });
    $('input[name=giveType]').change(function(){
        var value = $('[name=giveType]').filter(':checked').attr('value');
        if (value == 0) {
            $('#rule').hide();
            removeElement();
        } else {
            addElement();
            $('#rule').show();
        }
    });

    function startValidate() {
        //if($('#fm').validationEngine('validate')) {
        	
         var value = $('[name=lastSingle]').filter(':checked').attr('value');	
        	if(value==0 || value==1){
        		//$('#cashType1').attr("checked",true);
        		$("#cashs").empty();
        		
        	}else {
        		 var value = $('[name=cashType]').filter(':checked').attr('value');
       		  if(value==1){
       			$("#sss").attr("name","meaningless");
       			var value = $("#ss").val();
       			if(value == ""){
       				return false;
       			}
       		  
           	  }else if(value==2){
           		$("#ss").attr("name","meaningless");
           		var value = $("#sss").val();
       			if(value == ""){
       				return false;
       			}
           	    $("#sss").val(value*100);
           	  }else{
           		 return false;
           	  }
        	}
        var flag = true;
        $.ajaxSettings.async = false;
        var giveType = $('[name=giveType]').filter(':checked').attr('value');
        var firstSingle = $('[name=firstSingle]').filter(':checked').attr('value');
        var lastSingle = $('[name=lastSingle]').filter(':checked').attr('value');
        if (giveType == 0 && firstSingle == 0 && lastSingle == 0) {
            alert('返利策略、首单立返、尾单立返，至少选择一个');
            return false;
        }
        $.getJSON('${pageContext.request.contextPath}/bonus/validate/name', {
            id: 0,
            fieldId: 0,
            fieldValue: $('#name').val()
        }, function(data){
            if(data && data.length>0 && data[1]){
                var quotaArray = [0];
                var quotaIndex = 0;
                $('input[name^=bonusStrategy][name$=quota]').each(function() {
                    var value = $(this).val();
                    var len = quotaArray.length;
                    for (var i = 0; i < len; i++) {
                        if (quotaArray[i] == value) {
                            if(value!=null && value!=''){
                                quotaIndex++;
                            }
                            break;
                        } else {
                            quotaArray.push(value);
                        }
                    }
                });

                if (quotaIndex > 0) {
                    if(flag){
                        alert('亲，不同的返利策略，购买的金额不能相同');
                        flag = false;
                    }
                }
                var giveArray = [0];
                var giveIndex = 0;
                $('input[name^=bonusStrategy][name$=giveAmount]').each(function() {
                    var value = $(this).val();
                    var len = giveArray.length;
                    for (var i = 0; i < len; i++) {
                        if (giveArray[i] == value) {
                            if(value!= null && value!= ''){
                                giveIndex++;
                            }
                            break;
                        } else {
                            giveArray.push(value);
                        }
                    }
                });
                if (giveIndex > 0) {
                    if(flag){
                        alert('亲，不同的返利策略，赠送策略不能相同');
                        flag = false;
                    }
                }
            }else{
                $('#name').focus();
                alert('【'+$('#name').val()+'】此名称已被使用请重新选择!');
                flag = false;
            }
        });
        $.ajaxSettings.async = true;
        return flag;
    }

    function initEvent() {
        var v = 0;
        $('#giveTypeBox').find("input:radio").click(function(){
            var value = $(this).val();
            if(value==1) {
                $('.give_type').html('银子');
                $('.units').html('两');
                giveType='银子';
                units='两';
            } else if (value==2) {
                $('.give_type').html('红包');
                $('.units').html('元');
                giveType='红包';
                units='元';
            } else if (value==3) {
                $('.give_type').html('加息券');
                $('.units').html('%');
                giveType='加息券';
                units='%';
            } else if (value==4) {
                $('.give_type').html('第三方券');
                $('.units').html('元');
                giveType='第三方券';
                units='元';
            }
            v = value;
        });

        $('#add').click(function(){
            if(bonusInitNum == 6) {
                alert('亲，返利策略最高只能添加6个层次！');
                return false;
            }
            var html='<tr id="tr_'+bonusInitNum+'">'
            html+='<td><label class="control-label" style="margin-left: -40px">消费返<span class="give_type">'+giveType+'</span></label></td>'
                +' <td><label class="control-label" style="margin-left: -35px"><span>满</span></label>'
                +'		<div class="controls">'
                +'			<input type="text"  style="margin-left: -40px" name="bonusStrategy['+bonusInitNum+'].quota" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()" class="validate[required,min[1],custom[integer],max[1000000]] text-input span10"/>'
                +'			<span>元</span>'
                +'		</div>'
                +' </td>'
                +' <td>';

            html+='<label class="control-label" style="margin-left: -30px"><span>送</span></label>'
                +'<div class="controls">'
            if(giveType=='加息券') {
                html+='<input type="text" style="margin-left: -40px" id="bonusStrategy'+ bonusInitNum +'" name="bonusStrategy['+ bonusInitNum +'].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class=" rebate validate[required,min[0.01],custom[number],custom[numberSp]] text-input span10" readonly onclick="showCouponDialog(this.id);"/>';
                html+='<input type="hidden" id="bonusStrategy'+ bonusInitNum +'Coupon" name="bonusStrategy['+ bonusInitNum +'].coupon.id" value="" />';
            } else if (giveType=='第三方券') {
                html+='<input type="text" style="margin-left: -40px" id="bonusStrategy'+ bonusInitNum +'" name="bonusStrategy['+ bonusInitNum +'].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class=" rebate validate[required,min[1],custom[integer],max[100000]] text-input span10" readonly onclick="showCouponCardDialog(this.id);"/>';
                html+='<input type="hidden" id="bonusStrategy'+ bonusInitNum +'CouponCardName" name="bonusStrategy['+ bonusInitNum +'].couponCardName" value="" />';
            } else if(giveType =='红包'){
                html+='<input type="text" style="margin-left: -40px" id="bonusStrategy'+ bonusInitNum +'" name="bonusStrategy['+ bonusInitNum +'].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class=" rebate validate[required,min[1],custom[integer],max[100000]] text-input span10" readonly onclick="showBonusDialog(this.id);"/>';
                html+='<input type="hidden" id="bonusStrategy'+ bonusInitNum +'Coupon" name="bonusStrategy['+ bonusInitNum +'].coupon.id" value="" />';
            } else {
                html+='<input type="text" style="margin-left: -40px" id="bonusStrategy'+ bonusInitNum +'" name="bonusStrategy['+ bonusInitNum +'].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class=" validate[required,min[1],custom[integer],max[100000]] text-input span10"/>';
            }

            html+='<span class="units">'+units+'</span>'
                +'</div>'
                +'</td>'
                +'<td>'
                +'<input type="button" class="btn btn-lg" value="删除" onclick="delhtml('+bonusInitNum+')">'
                +'</td>'
                +'</tr>';
            $('#list').append(html);
            $('.rebate').click(function(){
                $(this).attr('readonly', true);
            });
            bonusInitNum++;

        });
    }

    function removeElement(){
        $('#list').html('');
    }

    function addElement(){
        $('#list').html(initStrategyList());
    }

    function initStrategyList() {
        var html='';
        for(var i=0;i<1;i++) {
            html+='<tr>';
            html+='<td><label class="control-label" style="margin-left: -40px">消费返<span class="give_type">'+giveType+'</span></label></td>'
                +' <td><label class="control-label" style="margin-left: -35px"><span>满</span></label>'
                +'		<div class="controls">'
                +'			<input style="margin-left: -40px" type="text" name="bonusStrategy['+ i +'].quota" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required,min[1],custom[integer],max[1000000]] text-input span10"/>'
                +'			<span>元</span>'
                +'		</div>'
                +' </td>'
                +' <td>';
            html+='<label class="control-label" style="margin-left: -30px"><span>送</span></label>'
                +'<div class="controls">';
            if(giveType=='加息券') {
                html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ i +'" name="bonusStrategy['+ i +'].giveAmount" value="" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required, min[0.01],custom[numberSp]] text-input span10" readonly onclick="showCouponDialog(this.id)" />';
                html+='<input type="hidden"  id="bonusStrategy'+ i +'Coupon" name="bonusStrategy['+ i +'].coupon.id" value="" />';
            } else if (giveType=='第三方券') {
                html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ i +'" name="bonusStrategy['+ i +'].giveAmount" value="" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required,min[1],custom[integer],max[100000]] text-input span10 " readonly onclick="showCouponCardDialog(this.id)" />';
                html+='<input type="hidden"  id="bonusStrategy'+ i +'CouponCardName" name="bonusStrategy['+ i +'].couponCardName" value="" />';
            } else {
                if(giveType =='红包'){
                    html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ i +'" name="bonusStrategy['+ i +'].giveAmount" value="" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required,min[1],custom[integer],max[100000]] text-input span10 " readonly onclick="showBonusDialog(this.id)" />';
                    html+='<input type="hidden"  id="bonusStrategy'+ i +'Coupon" name="bonusStrategy['+ i +'].coupon.id" value="" />';
                }else{
                    html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ i +'" name="bonusStrategy['+ i +'].giveAmount" value="" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required,min[1],custom[integer],max[100000]] text-input span10"/>';
                }
            }
            html+='<span class="units">'+units+'</span>'
                +'</div>'
                +'</td>'
                +' <td>'
                +' </td>'
                +' </tr>';
        }
        return html;
    }

    function delhtml(num) {
        $('#tr_'+num).remove();
        bonusInitNum--;
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

    function quit() {
        window.location.href='${pageContext.request.contextPath}/bonus/list/1';
    }

    function showBonusDialog(r){
        getBonus(1);
        row = r;
        $('#bonus').modal('show');
    }

    function showCouponDialog(r){
        getCouponList(1);
        row = r;
        $('#coupon').modal('show');
    }

    function showCouponCardDialog(r){
        getCouponCard(1);
        row = r;
        $('#couponCard').modal('show');
    }

    function getBonus(page){
        $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/'+page, {'category':0}, function(result){
            if (result.total > 0) {
                $('#bonusBody').html("");
                for (var i = 0; i < result.bonus.length; i++) {
                    var b = result.bonus[i];
                    $('#bonusBody').append('<tr>');
                    $('#bonusBody').append('<td class="hidden">'+b.id+'</td>');
                    $('#bonusBody').append('<td>'+(i+1)+'</td>');
                    $('#bonusBody').append('<td style="width:45%">'+b.condition+'</td>');
                    $('#bonusBody').append('<td>'+b.amount+'元</td>');
                    if(b.donation == 0){
                        $('#bonusBody').append('<td>不可转赠</td>');
                    }
                    if(b.donation == 1){
                        $('#bonusBody').append('<td>可转赠</td>');
                    }
                    if(b.lifeCycle == 0){
                        $('#bonusBody').append('<td>1万年有效</td>');
                    }
                    if(b.lifeCycle == 1){
                        $('#bonusBody').append('<td>'+b.expiresPoint+'过期</td>');
                    }
                    if(b.lifeCycle == 2){
                        $('#bonusBody').append('<td>领取后'+b.expiresPoint+'天过期</td>');
                    }
                    $('#bonusBody').append('<td><a href=javascript:choiceBonus('+b.id+','+b.amount+');>选择</a></td>');
                    $('#bonusBody').append('</tr>');
                }

                var totalPages = Math.ceil(result.total/15);
                var options = {
                    currentPage: page,
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
                        getBonus(page,row);
                    }
                };
                $('#bonus-page').bootstrapPaginator(options);
            }else{
                $('#bonusBody').html('<tr><td colspan="5">请先添加活动红包</td></tr>');
            }
        });
    }

    function getCouponList(page){
        $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/'+page, {"category": 4}, function(result){
            if (result.total > 0) {
                $('#couponBody').html("");
                for (var i = 0; i < result.bonus.length; i++) {
                    var b = result.bonus[i];
                    $('#couponBody').append('<tr>');
                    $('#couponBody').append('<td class="hidden">'+b.id+'</td>');
                    $('#couponBody').append('<td>'+(i+1)+'</td>');
                    $('#couponBody').append('<td style="width:40%">'+b.condition+'</td>');
                    $('#couponBody').append('<td>'+b.amount+'%</td>');
                    $('#couponBody').append('<td>'+b.increaseDays+'</td>');
                    if(b.donation == 0){
                        $('#couponBody').append('<td>不可转赠</td>');
                    }else if(b.donation == 1){
                        $('#couponBody').append('<td>可转赠</td>');
                    }else{
                        $('#couponBody').append('<td></td>');
                    }
                    if(b.lifeCycle == 0){
                        $('#couponBody').append('<td>1万年有效</td>');
                    }else if(b.lifeCycle == 1){
                        $('#couponBody').append('<td>'+b.expiresPoint+'过期</td>');
                    }else if(b.lifeCycle == 2){
                        $('#couponBody').append('<td>领取后'+b.expiresPoint+'天过期</td>');
                    }else{
                        $('#couponBody').append('<td></td>');
                    }
                    $('#couponBody').append('<td><a href=javascript:choiceCoupon('+b.id+','+b.amount+');>选择</a></td>');
                    $('#couponBody').append('</tr>');
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
                        getCoupon(page,row);
                    }
                };
                $('#coupon-page').bootstrapPaginator(options);
            }else{
                $('#couponBody').html('<tr><td colspan="5">请先添加加息券</td></tr>');
            }
        });
    }

    function getCouponCard(page){
        $.post('${pageContext.request.contextPath}/coupon/card/group/list/'+page, {'category':0}, function(result){
            if (result.total > 0) {
                $('#couponCardBody').html("");
                for (var i = 0; i < result.couponCards.length; i++) {
                    var cc = result.couponCards[i];
                    $('#couponCardBody').append('<tr>');
                    $('#couponCardBody').append('<td class="hidden">'+cc.id+'</td>');
                    $('#couponCardBody').append('<td>'+(i+1)+'</td>');
                    $('#couponCardBody').append('<td>'+cc.name+'</td>');
                    $('#couponCardBody').append('<td>'+cc.amount+'元</td>');
                    $('#couponCardBody').append('<td><a href=javascript:choiceCouponCard("'+cc.name+'",'+cc.amount+');>选择</a></td>');
                    $('#couponCardBody').append('</tr>');
                }

                var totalPages = Math.ceil(result.total/15);
                var options = {
                    currentPage: page,
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
                        getCouponCard(page,row);
                    }
                };
                $('#couponCard-page').bootstrapPaginator(options);
            }else{
                $('#couponCardBody').html('<tr><td colspan="5">请先添加第三方券</td></tr>');
            }
        });
    }

    function choiceBonus(couponId, amount){
        $('#'+row).val(amount);
        $('#'+row+'Coupon').val(couponId);
        $('#'+row).focus();
        $('#'+row).blur();
        $('#bonus').modal('hide');
    }

    function choiceCoupon(couponId, amount){
        $('#'+row).val(amount);
        $('#'+row+'Coupon').val(couponId);
        $('#'+row).focus();
        $('#'+row).blur();
        $('#coupon').modal('hide');
    }

    function choiceCouponCard(name, amount){
        $('#'+row).val(amount);
        $('#'+row).focus();
        $('#'+row).blur();
        $('#'+row+'Coupon').val(0);
        $('#'+row+'CouponCardName').val(name);
        $('#couponCard').modal('hide');
    }
</script>
</html>