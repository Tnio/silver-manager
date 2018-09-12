<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form id="fm" onsubmit="return startValidate()" action="${pageContext.request.contextPath}/bonus/save" method="post" class="form-horizontal" >
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <div class="control-group">
                                    <input id="id" name="id" value="${bonus.id}" type="hidden">
                                    <input name="page" value="${page}" type="hidden">
                                    <input name="size" value="${size}" type="hidden">
                                    <input name="giveAmount" value="0" type="hidden">
                                    <input id="strategys" value="${fn:length(bonus.bonusStrategy)}" type="hidden"/>
                                      
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span>活动名称</label>
                                    <div class="controls"><input type="text" id="name" name="name" value="${bonus.name}" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')"
                                                                 onblur="this.value=this.value.replace(/(\s*$)/g,'')" class="validate[required,minSize[6],maxSize[20]] span11" placeholder="3~10个汉字" />
                                    </div>
                                </div>
                                <div class="control_group" id="giveTypeBox">
                                    <label class="control-label"><span class="required">*</span>返利策略</label>
                                    <div class="row-fluid">
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="giveType"  value="0" <c:if test="${bonus.giveType == 0}">checked="checked"</c:if> class="validate[required] radio span4">
                                                <span >无</span>
                                            </div>
                                        </div>
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
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="giveType" value="3" <c:if test="${bonus.giveType == 3}">checked="checked"</c:if> class="validate[required] radio span4">
                                                <span >返加息券</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="giveType" value="4" <c:if test="${bonus.giveType == 4}">checked="checked"</c:if> class="validate[required] radio span4">
                                                <span >返第三方券</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="rule" style="display:none">
                                    <label class="control-label">策略规则</label>
                                    <div class="row-fluid">
                                        <table id="list">
                                            <c:forEach items="${bonus.bonusStrategy}" var="bonusStrategy" varStatus="status">
                                                <tr id="tr_${status.count-1}">
                                                    <td><label class="control-label" style="margin-left: -40px">消费返<span class="give_type"><c:if test="${bonus.giveType == 1}">银子</c:if><c:if test="${bonus.giveType == 2}">红包</c:if><c:if test="${bonus.giveType == 3}">加息券</c:if><c:if test="${bonus.giveType == 4}">第三方券</c:if></span></label></td>
                                                    <td><label class="control-label" style="margin-left: -35px"><span>满</span></label>
                                                        <div class="controls">
                                                            <input type="text"  style="margin-left: -40px" type="text" name="bonusStrategy[${status.count-1}].quota" value="${bonusStrategy.quota}" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" class="validate[required,custom[integer],min[1],max[1000000]] text-input span10"/>
                                                            <span>元</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <label class="control-label" style="margin-left: -30px"><span>送</span></label>
                                                        <div class="controls">
                                                            <c:if test="${bonus.giveType == 1}">
                                                                <input type="text"  style="margin-left: -40px" name="bonusStrategy[${status.count-1}].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" value="<fmt:formatNumber type="number" pattern="###0" value="${bonusStrategy.giveAmount} " maxFractionDigits="0"/>" class="validate[required] text-input span10"/>
                                                            </c:if>
                                                            <c:if test="${bonus.giveType == 3}">
                                                                <input type="text"  style="margin-left: -40px" id="bonusStrategy${status.count-1}" name="bonusStrategy[${status.count-1}].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" value="${bonusStrategy.giveAmount}" class="validate[required] text-input span10" readonly  <c:if test="${operation == 'edit'}">onclick="showCouponDialog(this.id);"</c:if> <c:if test="${operation == 'detail'}">onclick="showCouponDetailDialog(${bonusStrategy.coupon.id});"</c:if>  />
                                                                <input type="hidden" id="bonusStrategy${status.count-1}Coupon" name="bonusStrategy[${status.count-1}].coupon.id" value="${bonusStrategy.coupon.id}" />
                                                            </c:if>
                                                            <c:if test="${bonus.giveType == 2}">
                                                                <input type="text"  style="margin-left: -40px" id="bonusStrategy${status.count-1}" name="bonusStrategy[${status.count-1}].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" value="${bonusStrategy.giveAmount}" class="validate[required] text-input span10" readonly="readonly" <c:if test="${operation == 'edit'}">onclick="showBonusDialog(this.id);"</c:if> <c:if test="${operation == 'detail'}">onclick="showBonusDetailDialog(${bonusStrategy.coupon.id});"</c:if> />
                                                                <input type="hidden" id="bonusStrategy${status.count-1}Coupon" name="bonusStrategy[${status.count-1}].coupon.id" value="${bonusStrategy.coupon.id}" />
                                                            </c:if>
                                                            <c:if test="${bonus.giveType == 4}">
                                                                <input type="text"  style="margin-left: -40px" id="bonusStrategy${status.count-1}" name="bonusStrategy[${status.count-1}].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" value="${bonusStrategy.giveAmount}" class="validate[required] text-input span10" readonly="readonly" onclick="showCouponCardDialog(this.id);"/>
                                                                <input type="hidden" id="bonusStrategy${status.count-1}CouponCardName" name="bonusStrategy[${status.count-1}].couponCardName" value="${bonusStrategy.couponCardName}" />
                                                            </c:if>
                                                            <span class="units"> <c:if test="${bonus.giveType == 1}">两</c:if><c:if test="${bonus.giveType == 2 or bonus.giveType == 4}">元</c:if><c:if test="${bonus.giveType == 3}">%</c:if></span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:if test="${status.count > 1}">
                                                            <button id="del" type="button" class="btn btn-icon btn-default" value="删除" onclick="delhtml(${status.count-1})">删除</button>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                        <div class="control-group">
                                            <button type="button" class="btn btn-icon btn-default" id="add" style="margin-left: 210px" >添加</button>
                                        </div>
                                    </div>
                                </div>
                               <%--  <div class="control-group" id="firstOrder">
                                    <label class="control-label">首单立返</label>
                                    <div class="row-fluid" >
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="firstSingle" <c:if test="${firstSingle != 1}">checked="checked"</c:if> value="0" class="validate[required] span4">
                                                <span >无</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" name="firstSingle" <c:if test="${firstSingle == 1}">checked="checked"</c:if> value="1" class="validate[required] radio span4">
                                                <span >返银子</span>
                                            </div>
                                        </div>
                                        <div class="span4" id="interval" <c:if test="${firstSingle != 1}">style="display:none;"</c:if>>
                                            <div class="control-group ">
                                                <span >银子数量：</span>
                                                <input type="text" name="firstMinCoins" value="${firstMinCoins}" class="validate[required,min[20],custom[integer],max[10000]] text-input span4">
                                                <span >-</span>
                                                <input type="text" name="firstMaxCoins" value="${firstMaxCoins}"  class="validate[required,min[20],custom[integer],max[10000]] text-input span4">
                                            </div>
                                        </div>
                                    </div>
                                </div> --%>
                                <div class="control-group" id="lastOrder">
                                    <label class="control-label">尾单立返</label>
                                    <div class="row-fluid" >
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" id="aa" name="lastSingle" <%-- <c:if test="${bonus.lastOrder == 0}">checked="checked"</c:if> --%> value="0" class="validate[required] radio span4">
                                                <span >无</span>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group ">
                                                <input type="radio" id ="bb" name="lastSingle" <%-- <c:if test="${bonus.lastOrder > 0}">checked="checked"</c:if> --%> value="1" class="validate[required] radio span4">
                                                <span >返银子</span>
                                            </div>
                                        </div>
                                        <div class="span4" id="silverPercent" <c:if test="${bonus.lastOrder > 0}">style="display:none;"</c:if>>
                                            <div class="control-group ">
                                                <span >银子数量=投资金额*</span>
                                                <input type="text" name="lastOrder" value="${bonus.lastOrder}" class="validate[required,min[1],custom[integer],max[100]] text-input span2" >
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
                                             <input type="radio"   id="cashType1" name="cashType" value="1" class="validate[required] radio ">尾单赠送<input type="text" id="ss" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="4" name="cashAmount" onblur="checkValue(this.value)">元现金 &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="cashType2" name="cashType" value="2" class="validate[required] radio">尾单赠送投资金额*<input type="text" id="sss" onkeyup='clearNoNum(this)'   name="cashAmount">%元的现金                                        
                                         </div>
                                    </div>
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
            <div class="modal hide fade" id="bonus" role="dialog" style="width: 800px">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a class="btn btn-icon btn-default close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </a>
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
                            <a class="btn btn-icon btn-default close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </a>
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

            <div class="modal hide fade" id="couponCard" role="dialog" >
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a class="btn btn-icon btn-default close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </a>
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

            <div class="modal hide fade" id="couponDetail" role="dialog" >
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a class="btn btn-icon btn-default close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </a>
                            <h4 class="modal-title" id="myModalLabel"></h4>
                        </div>
                        <div class="modal-body">
                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
                                <tbody id="couponDetailBody">
                                </tbody>
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
    var bonusInitNum=$('#list').find('tr').length;
    var giveType='银子';
    var units='两';
    var row = 0;

    $(function(){
        $('#lastOrder').show();
        $('#firstOrder').show();
        $('#giveTypeBox').show();
        $('#rule').hide();
        $('#strategyLabel').html('返利规则');
        
        initEvent();
        initGiveType();
        $('#fm').validationEngine('attach', {
            promptPosition: 'centerRight',
            scroll: false,
            showOneMessage : true
        });
        $('[name=giveType]').filter(':checked').attr('value') > 0 ? $('#rule').show() : $('#rule').hide();
        $('input[name=firstSingle]').trigger('onchange');
        if ('${bonus.lastOrder}' > 0) {
            $('#silverPercent').show();
        } else {
            $('#silverPercent').hide();
        }
        if('${bonus.cashType}' == 1){
        	$("#cashs").show();
        	$("#packcash").attr("checked",true);
        	$('#cashType1').attr("checked",true);
        	$("#ss").val('${bonus.cashAmount}');
        }else if('${bonus.cashType}' == 2){
        	$("#cashs").show();
        	$("#packcash").attr("checked",true);
        	$('#cashType2').attr("checked",true);
        	$("#sss").val('${bonus.cashAmount}'/100);
        }else if('${bonus.lastOrder}' == 0){
        	$("#aa").attr("checked",true);
        }else if('${bonus.lastOrder}' > 0){
        	$("#bb").attr("checked",true);
        }
        $('input[name=giveType]').trigger('onchange');
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

    function selectcashtype(){
    	$("#cashs").show();
    	$('#silverPercent').hide();
    	$('input[name=lastOrder]').val(0);
      var value = $('[name=cashType]').filter(':checked').attr('value');
   	  if(value==1){
   		  $("#sss").val('');
   	  }else if(value==2){
   		  $("#ss").val('');
   	  }
    	
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
           // $('#silverPercent').hide();
        	 $('input[name=lastOrder]').val(0);
             $('#silverPercent').hide();
             $("#cashs").hide();
             $("#ss").val(0);
             $("#sss").val(0);
             $('#cashType1').val(0);
            
        } else if (value == 1) {
          //  $('#silverPercent').show();
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
        		$("#cashs").empty();
        	}else {
        		 var value = $('[name=cashType]').filter(':checked').attr('value');
       		  if(value==1){
       			$("#sss").attr("name","meaningless");
       		     $('#cashType1').val(1);
       		  var value = $("#ss").val();
     			if(value == ""){
     				return false;
     			}
           	  }else if(value==2){
           		$("#ss").attr("name","meaningless");
           	    $('#cashType1').val(2);
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
            id: $('#id').val(),
            fieldId: $('#id').val(),
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
                        if (parseFloat(giveArray[i]).toFixed(2) == parseFloat(value).toFixed(2)) {
                            if(value != null && value!= ''){
                                giveIndex++;
                            }
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

    function initGiveType() {
        var t= '${bonus.giveType}';
        if(t==1) {
            $('input[name^=bonusStrategy][name$=giveAmount]').removeClass();
            $('input[name^=bonusStrategy][name$=giveAmount]').addClass('validate[required,custom[integer],min[1],max[100000]] text-input span10');
            giveType='银子';
            units='两';
        } else if (t==2 ){
            $('input[name^=bonusStrategy][name$=giveAmount]').removeClass();
            $('input[name^=bonusStrategy][name$=giveAmount]').addClass('validate[required,custom[numberSp],min[1],max[100000]] text-input span10');
            giveType='红包';
            units='元';
        } else if (t==3 ){
            $('input[name^=bonusStrategy][name$=giveAmount]').removeClass();
            $('input[name^=bonusStrategy][name$=giveAmount]').addClass('validate[required,min[0.01]] text-input span10');
            giveType='加息券';
            units='%';
        }else if (t==4 ){
            $('input[name^=bonusStrategy][name$=giveAmount]').removeClass();
            $('input[name^=bonusStrategy][name$=giveAmount]').addClass('validate[required,custom[numberSp],min[1],max[100000]] text-input span10');
            giveType='第三方券';
            units='元';
        }

        $('#lastOrder').show();
        $('#firstOrder').show();
        $('#giveTypeBox').show();
        $('#strategyLabel').html('返利规则');
        units
    }

    function initEvent() {
        $("#giveTypeBox").find("input:radio").click(function(){
            var value = $(this).val();
            if(value==1) {
                $('input[name^=bonusStrategy][name$=giveAmount]').removeClass();
                $('input[name^=bonusStrategy][name$=giveAmount]').addClass('validate[required,custom[integer],min[1],max[100000]] text-input span10');
                $('.give_type').html('银子');
                $('.units').html('两');
                giveType='银子';
                units='两';
            } else if (value==2) {
                $('input[name^=bonusStrategy][name$=giveAmount]').removeClass();
                $('input[name^=bonusStrategy][name$=giveAmount]').addClass('validate[required,custom[integer],min[1],max[100000]] text-input span10');
                $('.give_type').html('红包');
                $('.units').html('元');
                giveType='红包';
                units='元';
            } else if (value == 3) {
                $('input[name^=bonusStrategy][name$=giveAmount]').removeClass();
                $('input[name^=bonusStrategy][name$=giveAmount]').addClass('validate[required,min[0.01]] text-input span10');
                $('.give_type').html('加息券');
                $('.units').html('%');
                giveType='加息券';
                units='%';
            }else if (value == 4) {
                $('input[name^=bonusStrategy][name$=giveAmount]').removeClass();
                $('input[name^=bonusStrategy][name$=giveAmount]').addClass('validate[required,custom[integer],min[1],max[100000]] text-input span10');
                $('.give_type').html('第三方券');
                $('.units').html('元');
                giveType='第三方券';
                units='元';
            }
        });

        $('#add').click(function(){
            var html='<tr id="tr_'+bonusInitNum+'">'
            if(bonusInitNum == 6) {
                alert('亲，返利策略最高只能添加6个层次！');
                return false;
            }
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
                html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ bonusInitNum +'" name="bonusStrategy['+ bonusInitNum +'].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class=" rebate validate[required,min[0.01],custom[numberSp]] text-input span10"  readonly onclick="showCouponDialog(this.id);"/>';
                html+='<input type="hidden" id="bonusStrategy'+ bonusInitNum +'Coupon" name="bonusStrategy['+ bonusInitNum +'].coupon.id" value="" />';
            } else if (giveType=='第三方券') {
                html+='<input type="text" style="margin-left: -40px" id="bonusStrategy'+ bonusInitNum +'" name="bonusStrategy['+ bonusInitNum +'].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class=" rebate validate[required,min[1],custom[numberSp],max[100000]] text-input span10" readonly onclick="showCouponCardDialog(this.id);"/>';
                html+='<input type="hidden" id="bonusStrategy'+ bonusInitNum +'CouponCardName" name="bonusStrategy['+ bonusInitNum +'].couponCardName" value="" />';
            } else if(giveType =='红包'){
                html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ bonusInitNum +'" name="bonusStrategy['+ bonusInitNum +'].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class=" rebate validate[required,min[1],custom[numberSp],max[100000]] text-input span10" readonly onclick="showBonusDialog(this.id);"/>';
                html+='<input type="hidden" id="bonusStrategy'+ bonusInitNum +'Coupon" name="bonusStrategy['+ bonusInitNum +'].coupon.id" value="" />';
            } else {
                html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ bonusInitNum +'" name="bonusStrategy['+ bonusInitNum +'].giveAmount" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class=" validate[required,min[1],custom[numberSp],max[100000]] text-input span10"/>';
            }
            html+='<span class="units">'+units+'</span>'
                +'</div>'
                +'</td>'
                +'<td>'
                +'<input type="button" class="btn btn-lg" value="删除" onclick="delhtml('+bonusInitNum+')">'
                +'</td>'
                +'</tr>';
            $('#list').append(html);
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
                +'			<input style="margin-left: -40px" type="text"  name="bonusStrategy['+ i +'].quota" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required,min[1],custom[integer],max[1000000]] text-input span10"/>'
                +'			<span>元</span>'
                +'		</div>'
                +' </td>'
                +' <td>';
            html+='<label class="control-label" style="margin-left: -30px"><span>送</span></label>'
                +'<div class="controls">';
            if(giveType=='加息券') {
                if('${operation}' == 'detail'){
                    html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ i +'" name="bonusStrategy['+ i +'].giveAmount" value="" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required,min[1],custom[integer],max[100000]] text-input span10" readonly onclick="showCouponDetailDialog("bonusStrategy['+ i +'].coupon.id");"/>';
                }else{
                    html+='<input type="text" style="margin-left: -40px" id="bonusStrategy'+ i +'" name="bonusStrategy['+ i +'].giveAmount" value="" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required, min[0.01],custom[numberSp]] text-input span10" readonly onclick="showCouponDialog(this.id);"/>';
                }
                html+='<input type="hidden" id="bonusStrategy'+ i +'Coupon" name="bonusStrategy['+ i +'].coupon.id" value="" />';
            } else if (giveType=='第三方券') {
                html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ i +'" name="bonusStrategy['+ i +'].giveAmount" value="" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required,min[1],custom[integer],max[100000]] text-input span10" readonly onclick="showCouponCardDialog(this.id);"/>';
                html+='<input type="hidden" id="bonusStrategy'+ i +'CouponCardName" name="bonusStrategy['+ i +'].couponCardName" value="" />';
            } else if(giveType =='红包'){

                if('${operation}' == 'detail'){
                    html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ i +'" name="bonusStrategy['+ i +'].giveAmount" value="" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required,min[1],custom[integer],max[100000]] text-input span10" readonly onclick="showBonusDetailDialog("bonusStrategy['+ i +'].coupon.id");"/>';
                }else{
                    html+='<input type="text"  style="margin-left: -40px" id="bonusStrategy'+ i +'" name="bonusStrategy['+ i +'].giveAmount" value="" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required,min[1],custom[integer],max[100000]] text-input span10" readonly onclick="showBonusDialog(this.id);"/>';
                }

                html+='<input type="hidden" id="bonusStrategy'+ i +'Coupon" name="bonusStrategy['+ i +'].coupon.id" value="" />';
            }else{
                html+='<input type="text"  style="margin-left: -40px" name="bonusStrategy['+ i +'].giveAmount" value="" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, \'\').trim()"  class="validate[required,min[1],custom[integer],max[100000]] text-input span10"/>';
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

    function readOnly() {
        var a = document.getElementsByTagName("input");
        for(var i=0; i<a.length; i++)   {
            if(a[i].type=="checkbox" || a[i].type=="radio" || a[i].type=="text"){
                a[i].readOnly = true;
                a[i].disabled = "disabled";
            }
        }

        var b = document.getElementsByTagName("select");
        for(var i=0; i<b.length; i++) {
            b[i].disabled="disabled";
        }

        var c = document.getElementsByTagName("textarea");
        for (var i=0; i<c.length; i++){
            c[i].disabled="disabled";
        }

        var d = document.getElementsByTagName("button");
        for(var i=0; i<d.length; i++){
            d[i].disabled="disabled";
        }
        
        //document.getElementById('del').disabled="disabled";
    }

    function quit() {
        window.location.href='${pageContext.request.contextPath}/bonus/list/1';
    }

    function showBonusDialog(r){
        getBonus(1);
        row = r;
        $('#bonus').modal('show');
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

    function showCouponDialog(r){
        getCouponList(1);
        row = r;
        $('#coupon').modal('show');
    }

    function getCouponList(page){
        $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/'+ page,{"category": 4}, function(result){
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
                        getCoupon(page,row);
                    }
                };
                $('#coupon-page').bootstrapPaginator(options);
            }else{
                $('#couponBody').html('<tr><td colspan="5">请先添加加息券</td></tr>');
            }
        });
    }

    function showCouponCardDialog(r){
        if ('${operation}' == 'edit') {
            getCouponCard(1);
            row = r;
            $('#couponCard').modal('show');
        }
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
        $('#'+row+'Coupon').val(0);
        $('#'+row+'CouponCardName').val(name);
        $('#'+row).focus();
        $('#'+row).blur();
        $('#couponCard').modal('hide');
    }

    function showCouponDetailDialog(couponId){
        showDialog(couponId);
    }

    function showBonusDetailDialog(couponId){
        showDialog(couponId);
    }

    function showDialog(couponId){
        $('#couponDetail').modal('show');
        getCoupon(couponId);
    }

    function getCoupon(couponId){
        $('#head').html("");
        $.get('${pageContext.request.contextPath}/coupon/coupon/detail',{couponId:couponId} , function(result){
            if (result != null) {
                $('#myModalLabel').empty().html('优惠券信息');
                if(result.category < 4){
                    $('#couponDetailBody').html("");
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td width="80">使用条件</td>');
                    $('#couponDetailBody').append('<td>'+result.condition+'</td>');
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>红包类型</td>');
                    if(result.category == 0){
                        $('#couponDetailBody').append('<td>'+'固定红包'+'</td>');
                    }
                    if(result.category == 1){
                        $('#couponDetailBody').append('<td>'+'概率红包'+'</td>');
                    }
                    if(result.category == 4){
                        $('#couponDetailBody').append('<td>'+'加息券'+'</td>');
                    }
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>红包金额</td>');
                    $('#couponDetailBody').append('<td>'+result.amount+'元</td>');
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>可否转赠</td>');
                    if (result.donation == 0) {
                        $('#couponDetailBody').append('<td>不可转赠</td>');
                    } else {
                        $('#couponDetailBody').append('<td>可转赠</td>');
                    }
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>有效期限</td>');
                    if(result.lifeCycle == 0){
                        $('#couponDetailBody').append('<td>'+'一万年有效'+'</td>');
                    }
                    if(result.lifeCycle == 1){
                        $('#couponDetailBody').append('<td>'+result.expiresPoint+'到期</td>');
                    }
                    if(result.lifeCycle == 2){
                        $('#couponDetailBody').append('<td>'+'自领取后'+result.expiresPoint+'天</td>');
                    }
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>投资金额</td>');
                    if(result.moneyLimit == 0){
                        $('#couponDetailBody').append('<td>'+'不限制 </td>');
                    }
                    if(result.moneyLimit == 1){
                        $('#couponDetailBody').append('<td>单笔满'+result.tradeAmount+'元可用 </td>');
                    }
                    if(result.moneyLimit == 2){
                        $('#couponDetailBody').append('<td>累计满'+result.tradeAmount+'元可用 </td>');
                    }
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>理财期限</td>');
                    if(result.financePeriod == 0){
                        $('#couponDetailBody').append('<td>'+'不限制 </td>');
                    }else{
                        $('#couponDetailBody').append('<td>'+result.financePeriod+'天及以上 </td>');
                    }
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>备注</td>');
                    $('#couponDetailBody').append('<td>'+result.remark+'</td>');
                    $('#couponDetailBody').append('</tr>');
                }else{
                    $('#couponDetailBody').html("");
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td width="80">使用条件</td>');
                    $('#couponDetailBody').append('<td>'+result.condition+'</td>');
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>加息券收益</td>');
                    $('#couponDetailBody').append('<td>'+result.amount+'%</td>');
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>加息天数</td>');
                    $('#couponDetailBody').append('<td>'+result.increaseDays+'天</td>');
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>可否转赠</td>');
                    if (result.donation == 0) {
                        $('#couponDetailBody').append('<td>不可转赠</td>');
                    } else {
                        $('#couponDetailBody').append('<td>可转赠</td>');
                    }
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>有效期限</td>');
                    if(result.lifeCycle == 0){
                        $('#couponDetailBody').append('<td>'+'一万年有效'+'</td>');
                    }
                    if(result.lifeCycle == 1){
                        $('#couponDetailBody').append('<td>'+result.expiresPoint+'到期</td>');
                    }
                    if(result.lifeCycle == 2){
                        $('#couponDetailBody').append('<td>'+'自领取后'+result.expiresPoint+'天</td>');
                    }
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>投资金额</td>');
                    if(result.moneyLimit == 0){
                        $('#couponDetailBody').append('<td>'+'不限制 </td>');
                    }
                    if(result.moneyLimit == 1){
                        $('#couponDetailBody').append('<td>单笔满'+result.tradeAmount+'元可用 </td>');
                    }
                    if(result.moneyLimit == 2){
                        $('#couponDetailBody').append('<td>累计满'+result.tradeAmount+'元可用 </td>');
                    }
                    $('#couponDetailBody').append('</tr>');
                    $('#couponDetailBody').append('<tr>');
                    $('#couponDetailBody').append('<td>备注</td>');
                    $('#couponDetailBody').append('<td>'+result.remark+'</td>');
                    $('#couponDetailBody').append('</tr>');
                }
            }else{
                $('#couponDetailBody').html('<tr><td colspan="2">请先添加优惠券</td></tr>');
            }
        });
    }
</script>
</html>