<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:import url="/header" />
<body>
<c:import url="/menu" />
<div class="container-fluid">
    <div class="row-fluid">
        <c:import url="/sidebar" />
        <div class="span10" id="content">
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <c:import url="/breadcrumb" />
                    <div class="block-content collapse in">
                        <form id="fm" onsubmit="return validate()" enctype="multipart/form-data" action="${pageContext.request.contextPath}/bonus/lottery/save" method="post" class="form-horizontal" >
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <div class="control-group">
                                    <input id="id" name="id" value="0" type="hidden">
                                    <input id="prizeStr" name="prizeStr" value="0" type="hidden">
                                    <input name="page" value="${page }" type="hidden">
                                    <input name="size" value="${size }" type="hidden">
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><span class="required">*</span>活动名称</label>
                                    <div class="controls"><input type="text" id="name" name="name" placeholder="3~20个汉字" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')"
                                                                 onblur="this.value=this.value.replace(/(\s*$)/g,'')"
                                                                 class="validate[required,minSize[6],maxSize[40],ajax[ajaxValidateLotteryName]] span11" /></div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>活动类型</label>
                                            <div class="controls">
                                                <select id="category" name="category" class="span9">
                                                    <!-- <option value="1" >刮刮卡</option> -->
                                                    <option value="2" selected>大转盘</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>使用场景</label>
                                            <div class="controls">
                                                <select id="scene" name="scene" class="span9">
                                                    <option value="1" selected>银子商城</option>
                                                    <option value="2" >日常活动</option>
                                                    <option value="3" >渠道活动</option>
                                                    <option value="4" >翻牌活动</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 开始时间</label>
                                            <div class="controls"><input type="text" id="begin" name="begin" class="validate[required,custom[date],past[#end]] text-input span9" onkeypress="return false"/></div>
                                        </div>
                                    </div>
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 结束时间</label>
                                            <div class="controls"><input type="text" id="end" name="end" class="validate[required,custom[date],future[#begin]] text-input span9" onkeypress="return false"/></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 参与频率</label>
                                            <div class="controls">
                                                <input type="text" id="frequency" name="frequency" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[required,custom[integer],min[1],max[9999]] text-input span4" /><span> 次数/天</span>
                                                <input type="checkbox" id="frequency1" name="frequency1" onclick="checkboxOnclick('frequency',this)" class="span1" /><span> 不限次数</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 消耗银子</label>
                                            <div class="controls">
                                                <input type="text" id="silverCost" name="silverCost" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[required,custom[integer],min[0],max[999]] text-input span4" /><span> 两/次</span>
                                                <input type="checkbox" id="silverCost1" name="silverCost1" onclick="checkboxOnclick('silverCost',this)" class="span1" /><span> 免费</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label">免费赠送</label>
                                            <div class="controls">
                                                <input type="text" id="shareGetSilver" name="shareGetSilver" value="0" class="validate[custom[integer],min[0],max[999]] text-input span4" /><span> 次抽奖机会</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span5">
                                        <div class="control-group">
                                            <label class="control-label"> 单日分享最高获得</label>
                                            <div class="controls">
                                                <input type="text" id="shareMaximumSilver" name="shareMaximumSilver" value="0" class="validate[custom[integer],min[0],max[999999]] text-input span4" /><span> 次抽奖机会</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid"><label class="control-label"><span class="required">*</span> 奖品设置</label></div>
                                <div class="control-group">
                                    <div></div>
                                    <div class="span11">
                                        <div class="control-group s6" >
                                            <input type="hidden" id="lotteryPrizeId0" name="lotteryPrizeId0" value="0"/>
                                            <label class="control-label"><span class="required">*</span> 奖品一:</label>
                                            <div class="controls">
                                                <input type="radio" name="category0" id="category01" value="1" class="validate[required] span1"><span>银子</span><input type="text" id="silverQuantity0" name="silverQuantity0" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[9999]] span2" />
                                                <input type="radio" style="margin-left: 5px;" name="category0" id="category02" value="2" class="span1"><span>红包</span><input type="hidden" id="couponId0" name="coupon.id">
                                                <input type="text" id="rebateAmount0" name="rebateAmount0" class="validate[required, maxSize[20]] text-input span2" readonly onclick="showBonusDialog(0)"/> 元
                                                <input type="radio" name="category0" id="category03" value="3" class="span1"><span>实物</span><input type="text" id="prizeName0" name="prizeName0" class="validate[maxSize[40]] span2" />
                                                <input type="radio" name="category0" id="category04" value="4" class="span1"><span>谢谢参与</span>
                                            </div>
                                            <div class="controls" style="margin-left:200px;">
                                                <span>奖品数量</span><input type="text" id="limitedNumber0" name="limitedNumber0" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[1],max[999999]] span2" />
                                                <span>活动期投资满</span><input type="text" id="requirement0" value="0" name="requirement0" class="validate[custom[integer],min[0]]" style="width:100px;" /><span>&nbsp;元才能中奖</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span11">
                                        <div class="control-group s6" style="margin-left: 45px">
                                            <input type="hidden" id="lotteryPrizeId1" name="lotteryPrizeId1" value="0"/>
                                            <label class="control-label"><span class="required">*</span> 奖品二:</label>
                                            <div class="controls">
                                                <input type="radio" name="category1" id="category11" value="1" class="validate[required] span1"><span>银子</span><input type="text" id="silverQuantity1" name="silverQuantity1" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[9999]] span2" />
                                                <input type="radio" name="category1" style="margin-left: 5px;" id="category12" value="2" class="span1"><span>红包</span><input type="hidden" id="couponId1" name="coupon.id">
                                                <input type="text" id="rebateAmount1" name="rebateAmount1" class="validate[required,maxSize[20]] text-input span2" readonly onclick="showBonusDialog(1)"/> 元
                                                <input type="radio" name="category1" id="category13" value="3" class="span1"><span>实物</span><input type="text" id="prizeName1" name="prizeName1" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[maxSize[40]] span2" />
                                                <input type="radio" name="category1" id="category14" value="4" class="span1"><span>谢谢参与</span>
                                            </div>
                                            <div class="controls" style="margin-left:200px;">
                                                <span>奖品数量</span><input type="text" id="limitedNumber1" name="limitedNumber1" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[1],max[999999]] span2" />
                                                <span>活动期投资满</span><input type="text" id="requirement1" value="0" name="requirement1" style="width:100px;" class="validate[custom[integer],min[0]]" /><span>&nbsp;元才能中奖</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span11">
                                        <div class="control-group s6">
                                            <input type="hidden" id="lotteryPrizeId2" name="lotteryPrizeId2" value="0"/>
                                            <label class="control-label"><span class="required">*</span> 奖品三:</label>
                                            <div class="controls">
                                                <input type="radio" name="category2" id="category21" value="1" class="validate[required] span1"><span>银子</span><input type="text" id="silverQuantity2" name="silverQuantity2" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[9999]] span2" />
                                                <input type="radio" name="category2" style="margin-left: 5px;" id="category22" value="2" class="span1"><span>红包</span><input type="hidden" id="couponId2" name="coupon.id">
                                                <input type="text" id="rebateAmount2" name="rebateAmount2" class="validate[required,maxSize[20]] text-input span2" readonly onclick="showBonusDialog(2)"/> 元
                                                <input type="radio" name="category2" id="category23" value="3" class="span1"><span>实物</span><input type="text" id="prizeName2" name="prizeName2" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[maxSize[40]] span2" />
                                                <input type="radio" name="category2" id="category24" value="4" class="span1"><span>谢谢参与</span>
                                            </div>
                                            <div class="controls" style="margin-left:200px;">
                                                <span>奖品数量</span><input type="text" id="limitedNumber2" name="limitedNumber2" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[1],max[999999]] span2" />
                                                <span>活动期投资满</span><input type="text" id="requirement2" value="0" name="requirement2" style="width:100px;" class="validate[custom[integer],min[0]]" /><span>&nbsp;元才能中奖</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span11">
                                        <div class="control-group s6">
                                            <input type="hidden" id="lotteryPrizeId3" name="lotteryPrizeId3" value="0"/>
                                            <label class="control-label"><span class="required">*</span> 奖品四:</label>
                                            <div class="controls">
                                                <input type="radio" name="category3" id="category31" value="1" class="validate[required] span1"><span>银子</span><input type="text" id="silverQuantity3" name="silverQuantity3" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[9999]] span2" />
                                                <input type="radio" name="category3" style="margin-left: 5px;" id="category32" value="2" class="span1"><span>红包</span><input type="hidden" id="couponId3" name="coupon.id">
                                                <input type="text" id="rebateAmount3" name="rebateAmount3" class="validate[required,maxSize[20]] text-input span2" readonly onclick="showBonusDialog(3)"/> 元
                                                <input type="radio" name="category3" id="category33" value="3" class="span1"><span>实物</span><input type="text" id="prizeName3" name="prizeName3" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[maxSize[40]] span2" />
                                                <input type="radio" name="category3" id="category34" value="4" class="span1"><span>谢谢参与</span>
                                            </div>
                                            <div class="controls" style="margin-left:200px;">
                                                <span>奖品数量</span><input type="text" id="limitedNumber3" name="limitedNumber3" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[1],max[999999]] span2" />
                                                <span>活动期投资满</span><input type="text" id="requirement3" value="0" style="width:100px;" name="requirement3" class="validate[custom[integer],min[0]]" /><span>&nbsp;元才能中奖</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span11">
                                        <div class="control-group s6">
                                            <input type="hidden" id="lotteryPrizeId4" name="lotteryPrizeId4" value="0"/>
                                            <label class="control-label"><span class="required">*</span> 奖品五:</label>
                                            <div class="controls">
                                                <input type="radio" name="category4" id="category41" value="1" class="validate[required] span1"><span>银子</span><input type="text" id="silverQuantity4" name="silverQuantity4" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[9999]] span2" />
                                                <input type="radio" name="category4" style="margin-left: 5px;" id="category42" value="2" class="span1"><span>红包</span><input type="hidden" id="couponId4" name="coupon.id">
                                                <input type="text" id="rebateAmount4" name="rebateAmount4" class="validate[required,maxSize[20]] text-input span2" readonly onclick="showBonusDialog(4)"/> 元
                                                <input type="radio" name="category4" id="category43" value="3" class="span1"><span>实物</span><input type="text" id="prizeName4" name="prizeName4" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[maxSize[40]] span2" />
                                                <input type="radio" name="category4" id="category44" value="4" class="span1"><span>谢谢参与</span>
                                            </div>
                                            <div class="controls" style="margin-left:200px;">
                                                <span>奖品数量</span><input type="text" id="limitedNumber4" name="limitedNumber4" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[1],max[999999]] span2" />
                                                <span>活动期投资满</span><input type="text" id="requirement4" value="0" name="requirement4" style="width:100px;" class="validate[custom[integer],min[0]]" /><span>&nbsp;元才能中奖</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span11">
                                        <div class="control-group s6">
                                            <input type="hidden" id="lotteryPrizeId5" name="lotteryPrizeId5" value="0"/>
                                            <label class="control-label"><span class="required">*</span> 奖品六:</label>
                                            <div class="controls">
                                                <input type="radio" name="category5" id="category51" value="1" class="validate[required] span1"><span>银子</span><input type="text" id="silverQuantity5" name="silverQuantity5" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[9999]] span2" />
                                                <input type="radio" name="category5" style="margin-left: 5px;" id="category52" value="2" class="span1"><span>红包</span><input type="hidden" id="couponId5" name="coupon.id">
                                                <input type="text" id="rebateAmount5" name="rebateAmount5" class="validate[required,maxSize[20]] text-input span2" readonly onclick="showBonusDialog(5)"/> 元
                                                <input type="radio" name="category5" id="category53" value="3" class="span1"><span>实物</span><input type="text" id="prizeName5" name="prizeName5" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[maxSize[40]] span2" />
                                                <input type="radio" name="category5" id="category54" value="4" class="span1"><span>谢谢参与</span>
                                            </div>
                                            <div class="controls" style="margin-left:200px;">
                                                <span>奖品数量</span><input type="text" id="limitedNumber5" name="limitedNumber5" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[1],max[999999]] span2" />
                                                <span>活动期投资满</span><input type="text" id="requirement5" style="width:100px;" value="0" name="requirement5" class="validate[custom[integer],min[0]]" /><span>&nbsp;元才能中奖</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span11" id="prizeServen">
                                        <div class="control-group s6">
                                            <input type="hidden" id="lotteryPrizeId6" name="lotteryPrizeId6" value="0"/>
                                            <label class="control-label"><span class="required">*</span> 奖品七:</label>
                                            <div class="controls">
                                                <input type="radio" name="category6" id="category61" value="1" class="validate[required] span1"><span>银子</span><input type="text" id="silverQuantity6" name="silverQuantity6" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[9999]] span2" />
                                                <input type="radio" name="category6" style="margin-left: 6px;" id="category62" value="2" class="span1"><span>红包</span><input type="hidden" id="couponId6" name="coupon.id">
                                                <input type="text" id="rebateAmount6" name="rebateAmount6" class="validate[required,maxSize[20]] text-input span2" readonly onclick="showBonusDialog(6)"/> 元
                                                <input type="radio" name="category6" id="category63" value="3" class="span1"><span>实物</span><input type="text" id="prizeName6" name="prizeName5" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[maxSize[40]] span2" />
                                                <input type="radio" name="category6" id="category64" value="4" class="span1"><span>谢谢参与</span>
                                            </div>
                                            <div class="controls" style="margin-left:200px;">
                                                <span>奖品数量</span><input type="text" id="limitedNumber6" name="limitedNumber5" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[1],max[999999]] span2" />
                                                <span>活动期投资满</span><input type="text" id="requirement6" style="width:100px;" value="0" name="requirement6" class="validate[custom[integer],min[0]]" /><span>&nbsp;元才能中奖</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span11" id="prizeEight">
                                        <div class="control-group s6">
                                            <input type="hidden" id="lotteryPrizeId7" name="lotteryPrizeId7" value="0"/>
                                            <label class="control-label"><span class="required">*</span> 奖品八:</label>
                                            <div class="controls">
                                                <input type="radio" name="category7" id="category71" value="1" class="validate[required] span1"><span>银子</span><input type="text" id="silverQuantity7" name="silverQuantity7" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[0],max[9999]] span2" />
                                                <input type="radio" name="category7" style="margin-left: 5px;" id="category72" value="2" class="span1"><span>红包</span><input type="hidden" id="couponId7" name="coupon.id">
                                                <input type="text" id="rebateAmount7" name="rebateAmount7" class="validate[required,maxSize[20]] text-input span2" readonly onclick="showBonusDialog(7)"/> 元
                                                <input type="radio" name="category7" id="category73" value="3" class="span1"><span>实物</span><input type="text" id="prizeName7" name="prizeName7" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[maxSize[40]] span2" />
                                                <input type="radio" name="category7" id="category74" value="4" class="span1"><span>谢谢参与</span>
                                            </div>
                                            <div class="controls" style="margin-left:200px;">
                                                <span>奖品数量</span><input type="text" id="limitedNumber7" name="limitedNumber7" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[custom[integer],min[1],max[999999]] span2" />
                                                <span>活动期投资满</span><input type="text" id="requirement7" style="width:100px;" value="0" name="requirement7" class="validate[custom[integer],min[0]]" /><span>&nbsp;元才能中奖</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span> 活动预估抽奖总次数</label>
                                            <div class="controls"><input type="text" id="totalNumber" name="totalNumber" onkeyup="this.value=this.value.replace(/^0/g, '')" class="validate[required,custom[integer],min[1],max[9999999]] text-input span4" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
                                    <button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit();"><i></i>返回</button>
                                </div>
                            </div>
                        </form>
                        <div class="modal hide fade" id="bonus" style="width: 800px;" role="dialog" >
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
                                                <th>是否可转赠</th>
                                                <th>到期时间</th>
                                                <th>红包金额</th>
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
                    </div>
                </div>
                <!-- /block -->
            </div>
            <!-- content end -->
        </div>
    </div>
</div>
<c:import url="/footer" />
</body>
<script type="text/javascript">
    $('#scene').change(function(){
        var value = $('#scene').val();
        if (value == 3 || value == 4) {
            $('#prizeEight').show();
            $('#prizeServen').show();
        } else {
            $('#prizeEight').hide();
            $('#prizeServen').hide();
        }
    });


    $(function(){
        $('#prizeEight').hide();
        $('#prizeServen').hide();
        $('.breadcrumb').html('<li class="active">活动管理&nbsp;/&nbsp;<a href="javascript:quit();">抽奖活动管理</a>&nbsp;/&nbsp;新增抽奖活动</li>');
        $('#fm').validationEngine('attach', {
            promptPosition: 'bottomRight',
            scroll: false
        });
        $('.s1').css({'margin-left':'-10px','width':'60px'});
        $('.s2').css({'margin-left':'-150px'});
        $('.s3').css({'margin-left':'-130px'});
        $('.s4').css({'margin-left':'-80px'});
        $('.s5').css({'margin-left':'-20px'});
        $('.s6').css({'margin-left':'45px'});
        $('input[name^="limitedNumber"]').attr('disabled', 'true');
        $('input[name^="silverQuantity"]').attr('disabled', 'true');
        $('input[name^="rebateAmount"]').attr('disabled', 'true');
        $('input[name^="prizeName"]').attr('disabled', 'true');
        $('input[name^="requirement"]').attr('disabled', 'true');
        $('.span10 .control-group .controls').find('input:radio').each(function(i){
            $(this).click(function(){
                if($(this).val()==4){
                    $(this).parent().find('input:text').eq(0).val('');
                    $(this).parent().find('input:text').eq(0).attr('disabled', 'false');
                    $(this).parent().find('input:text').eq(1).val('');
                    $(this).parent().find('input:text').eq(1).attr('disabled', 'false');
                    $(this).parent().find('input:text').eq(2).val('');
                    $(this).parent().find('input:text').eq(2).attr('disabled', 'false');
                    $(this).parent().parent().find('input:text').eq(3).val('');
                    $(this).parent().parent().find('input:text').eq(3).attr('disabled', 'false');
                    $(this).parent().parent().find('input:text').eq(4).val('');
                    $(this).parent().parent().find('input:text').eq(4).attr('disabled', 'false');
                }else{
                    if($(this).val()==1){
                        $(this).parent().find('input:text').eq(0).removeAttr('disabled');
                        $(this).parent().find('input:text').eq(0).attr('required', true);
                        $(this).parent().find('input:text').eq(1).val('');
                        $(this).parent().find('input:text').eq(1).attr('disabled', 'false');
                        $(this).parent().find('input:text').eq(2).val('');
                        $(this).parent().find('input:text').eq(2).attr('disabled', 'false');
                    }else if($(this).val()==2){
                        $(this).parent().find('input:text').eq(0).val('');
                        $(this).parent().find('input:text').eq(0).attr('disabled', 'false');
                        $(this).parent().find('input:text').eq(1).removeAttr('disabled');
                        $(this).parent().find('input:text').eq(1).attr('required', true);
                        $(this).parent().find('input:text').eq(2).val('');
                        $(this).parent().find('input:text').eq(2).attr('disabled', 'false');
                    }else if($(this).val()==3){
                        $(this).parent().find('input:text').eq(0).val('');
                        $(this).parent().find('input:text').eq(0).attr('disabled', 'false');
                        $(this).parent().find('input:text').eq(1).val('');
                        $(this).parent().find('input:text').eq(1).attr('disabled', 'false');
                        $(this).parent().find('input:text').eq(2).removeAttr('disabled');
                        $(this).parent().find('input:text').eq(2).attr('required', true);
                    }else{
                        alert("请正确使用抽奖新增功能!");
                    }
                    $(this).parent().parent().find('input:text').eq(3).removeAttr('disabled');
                    $(this).parent().parent().find('input:text').eq(3).attr('required', true);
                    $(this).parent().parent().find('input:text').eq(4).removeAttr('disabled');
                    //$(this).parent().parent().find('input:text').eq(4).attr('required', true);
                }
                var i = $(this).attr('name').replace('category','');
                for(var j=0; j<i; j++){
                    if($('input[name="category'+j+'"]:checked').val() == undefined){
                        $(this).parent().find('input:text').eq(0).attr('disabled', 'false');
                        $(this).parent().find('input:text').eq(1).attr('disabled', 'false');
                        $(this).parent().find('input:text').eq(2).attr('disabled', 'false');
                        $(this).parent().parent().find('input:text').eq(3).attr('disabled', 'false');
                        $(this).parent().parent().find('input:text').eq(4).attr('disabled', 'false');
                        alert('请您按照顺序从上向下录入奖品!');
                        return false;
                    }
                }
            });
        });
    });

    $('#begin').datetimepicker({
        format:'Y-m-d',
        lang:'ch',
        timepicker:false
    });

    $('#end').datetimepicker({
        format:'Y-m-d',
        lang:'ch',
        timepicker:false
    });

    function checkboxOnclick(category,checkbox){
        if(checkbox.checked == true){
            $('#'+category).val(0);
            $('#'+category).attr('disabled', 'false');
        }else{
            $('#'+category).removeAttr('disabled');
        }
    }

    function validate(){
        var shareGetSilver = $('#shareGetSilver').val();
        if(shareGetSilver != ''){
            shareGetSilver = parseInt(shareGetSilver);
        }else{
            shareGetSilver = 0;
        }
        var shareMaximumSilver = parseInt($('#shareMaximumSilver').val());
        if(shareMaximumSilver != ''){
            shareMaximumSilver = parseInt(shareMaximumSilver);
        }else{
            shareMaximumSilver = 0;
        }
        var prizeStr = '';
        var limitedNumberes = 0;
        var length = 6;
        var value = $('#scene').val();
        if (value == 3 || value == 4) {
            length = 8;
        }

        for(var i = 0;i < length; i++){
            var category = 0;
            var silverQuantity = 0;
            var couponId = 0;
            var prizeName = '';
            var lotteryPrizeId = 0;
            var limitedNumber = 0;
            var requirement = 0;
            category = $('input[name="category'+i+'"]:checked').val();
            if(category > 0){
                lotteryPrizeId = $('#lotteryPrizeId'+i).val();
                prizeName = $('#prizeName'+i).val();
                limitedNumber = $('#limitedNumber'+i).val();
                silverQuantity = $('#silverQuantity'+i).val();
                couponId = $('#couponId'+i).val();
                requirement = $('#requirement'+i).val();
                if(limitedNumber == '' || limitedNumber == null){
                    limitedNumber = 0;
                }
                if(silverQuantity == '' || silverQuantity == null){
                    silverQuantity = 0;
                }
                if(couponId == '' || couponId == null){
                    couponId = 0;
                }
                if(requirement == '' || requirement == null){
                    requirement = 0;
                }
                limitedNumberes += parseInt(limitedNumber);
                prizeStr += (lotteryPrizeId + ',' + category + ',' + silverQuantity + ',' + couponId + ',' + requirement+ ',' + prizeName + ',' + limitedNumber +';');
            }else{
                break;
            }
        }
        var totalNumber = $('#totalNumber').val();
        if(totalNumber < limitedNumberes){
            alert('预计抽奖总次数不能小于产品总数量,请认真填写!');
            return false;
        }
        if(prizeStr.length > 0){
            $('#prizeStr').val(prizeStr);
        }else{
            alert('请您填写奖项,并从上向下按顺序填写!');
            return false;
        }
        return true;
    }

    function showBonusDialog(sign){
        getBonus(1, sign);
        $('#bonus').modal('show');
    }

    function getBonus(page, sign){
        $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/'+page, {'category':0}, function(result){
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
                    } else if (b.lifeCycle == 2) {
                        $('#bonusBody').append('<td>自领取后'+b.expiresPoint+'天过期</td>');
                    }else {
                        $('#bonusBody').append('<td></td>');
                    }
                    $('#bonusBody').append('<td>'+b.amount+'元</td>');
                    $('#bonusBody').append('<td><a href=javascript:choiceBonus('+sign+','+b.id+','+b.amount+');>选择</a></td>');
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
                        getBonus(page, sign);
                    }
                };
                $('#bonus-page').bootstrapPaginator(options);
            }else{
                $('#bonusBody').html('<tr><td colspan="5">请先添加活动红包</td></tr>');
            }
        });
    }

    function choiceBonus(sign,couponId,amount){
        $('#couponId'+sign).val(couponId);
        $('#rebateAmount'+sign).val(amount);
        $('#rebateAmount'+sign).focus();
        $('#rebateAmount'+sign).blur();
        $('#bonus').modal('hide');
    }

    function quit() {
        window.location.href='${pageContext.request.contextPath}/bonus/lottery/list/${page}';
    }
</script>
</html>