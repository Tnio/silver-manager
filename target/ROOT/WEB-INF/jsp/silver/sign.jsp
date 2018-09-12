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
                <form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post"  enctype="multipart/form-data" onsubmit="return startValidateParam();" action="${pageContext.request.contextPath}/silver/sign/save" autocomplete="off">
                    <input type="hidden" id="id" name="id" value="${signIn.id}">
                    <div class="well" style="padding-bottom: 0; margin: 0;">
                        <div class="control-group" style="margin-left: -60px">
                            <label class="control-label"><span class="required">*</span> 第一天</label>
                            <div class="controls">
                                <input type="text" name="silver"  value="${signIn.silver}" class="validate[required,custom[integer],min[1],max[999]] text-input span2"  onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" value="50"/>  银子
                                <span class="required" style="margin-left: 30px"><font color="red" style="margin-right: 4px">*</font></span>每日递增
                                <input type="text" id="increment" name="increment" value="${signIn.increment}" class="validate[required,custom[integer],min[0],max[99]] text-input span2" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" value="10"/>  银子
                                <span class="required" style="margin-left: 30px"><font color="red" style="margin-right: 4px">*</font></span>递增上限
                                <input type="text" id="ceiling" name="ceiling" value="${signIn.ceiling}" class="validate[required,custom[integer],min[0],max[999]] text-input span2" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" value="5"/>  天
                            </div>
                        </div>
                        <div class="control-group" style="margin-left: -50px">
                            <label class="control-label"><span class="required">*</span> 奖品设置</label>
                            <div class="controls">
                                <div class="well span12" style="padding-bottom: 20px; margin: 0;">
                                    <c:if test="${fn:length(signIn.signInPrizes) <= 0}">
                                        <div class="well span12" style="margin-left: 0px">
                                            <div id="giveTypeGroup0" class="controls" style="margin-bottom: 10px">
                                                <input type="hidden" name="signInPrizesId" value="0">
                                                <input type="hidden" id="couponId0" name="couponId">
                                                <span>签到满</span>
                                                <input type="text" name="days"  value="${prizes.days}" class="  validate[required,custom[integer],min[1],max[31]] text-input span2" />  天
                                                <span ><input type="radio" name="giveType0" value="1"  style="margin-left: -10px;margin-top: -1px; width:80px;" onclick="radioClick(this.value,0)">送银子</span>
                                                <input type="text" id="giveSilver0"  name="giveSilver" class="validate[custom[integer],min[1],max[99999]] text-input span2"/>  两
                                                <span ><input type="radio" name="giveType0" value="2" class="validate[required]" style="margin-left: -10px;margin-top: -1px;" onclick="radioClick(this.value,0)">送红包</span>
                                                <input type="text" id="giveBonus0"  name="giveBonus" class="validate[custom[integer]] text-input span2" readonly="readonly" onclick="radioClick(2,0)"/>  元
                                                <span ><input type="radio" name="giveType0" value="3" class="validate[required]" style="margin-left: -10px;margin-top: -1px;" onclick="radioClick(this.value,0)">送加息券</span>
                                                <input type="text" id="giveCoupon0"  name="giveCoupon" class="validate[custom[numberSp]] text-input span2" readonly="readonly" onclick="radioClick(3,0)"/>  %
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>问题</span>
                                                <input type="text" name="question"  value="${prizes.question}" class="validate[required,maxSize[60]] text-input span6"  placeholder="不超过30个汉字"/>
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>选项</span><span style="margin-left: 10px">A</span>
                                                <input type="text" id="answerA0" name="answerA"  class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">B</span>
                                                <input type="text" id="answerB0" name="answerB"  class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">C</span>
                                                <input type="text" id="answerC0" name="answerC"  class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">D</span>
                                                <input type="text" id="answerD0" name="answerD"  class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>答案</span>
                                                <span ><input type="radio" value="1" name="rightAnswer0" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">A</span>
                                                <span ><input type="radio" value="2" name="rightAnswer0" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">B</span>
                                                <span ><input type="radio" value="3" name="rightAnswer0" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">C</span>
                                                <span ><input type="radio" value="4" name="rightAnswer0" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">D</span>
                                            </div>
                                        </div>
                                        <div class="well span12" style="margin-left: 0px">
                                            <div id="giveTypeGroup1" class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <input type="hidden" name="signInPrizesId" value="0">
                                                <input type="hidden" id="couponId1" name="couponId">
                                                <span>签到满</span>
                                                <input type="text" name="days"  value="${prizes.days}" class="validate[required,custom[integer],min[1],max[31]] text-input span2" />  天
                                                <span ><input type="radio" name="giveType1" value="1" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,1)" >送银子</span>
                                                <input type="text" id="giveSilver1"  name="giveSilver" class="validate[custom[integer],min[1],max[99999]] text-input span2"/>  两
                                                <span ><input type="radio" name="giveType1" value="2" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,1)" >送红包</span>
                                                <input type="text" id="giveBonus1"  name="giveBonus" class="validate[custom[integer]] text-input span2" readonly="readonly" onclick="radioClick(2,1)" />  元
                                                <span ><input type="radio" name="giveType1" value="3" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,1)">送加息券</span>
                                                <input type="text" id="giveCoupon1"  name="giveCoupon" class="validate[custom[numberSp]] text-input span2" readonly="readonly" onclick="radioClick(3,1)"/>  %
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>问题</span>
                                                <input type="text" name="question"  value="${prizes.question}" class="validate[required,maxSize[60]] text-input span11"  placeholder="不超过30个汉字"/>
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>选项</span><span style="margin-left: 10px">A</span>
                                                <input type="text" id="answerA1" name="answerA" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">B</span>
                                                <input type="text" id="answerB1" name="answerB" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">C</span>
                                                <input type="text" id="answerC1" name="answerC" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">D</span>
                                                <input type="text" id="answerD1" name="answerD" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>答案</span>
                                                <span ><input type="radio" value="1" name="rightAnswer1" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">A</span>
                                                <span ><input type="radio" value="2" name="rightAnswer1" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">B</span>
                                                <span ><input type="radio" value="3" name="rightAnswer1" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">C</span>
                                                <span ><input type="radio" value="4" name="rightAnswer1" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">D</span>
                                            </div>
                                        </div>
                                        <div class="well span12" style="margin-left: 0px">
                                            <div id="giveTypeGroup2" class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <input type="hidden" name="signInPrizesId" value="0">
                                                <input type="hidden" id="couponId2" name="couponId">
                                                <span>签到满</span>
                                                <input type="text" name="days"  value="${prizes.days}" class="validate[required,custom[integer],min[1],max[31]] text-input span2" />  天
                                                <span ><input type="radio" name="giveType2" value="1" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,2)" >送银子</span>
                                                <input type="text" id="giveSilver2"  name="giveSilver" class="validate[custom[integer],min[1],max[99999]] text-input span2"/>  两
                                                <span ><input type="radio" name="giveType2" value="2" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,2)" >送红包</span>
                                                <input type="text" id="giveBonus2"  name="giveBonus" class="validate[custom[integer]] text-input span2" readonly="readonly" onclick="radioClick(2,2)"/>  元
                                                <span ><input type="radio" name="giveType2" value="3" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,2)">送加息券</span>
                                                <input type="text" id="giveCoupon2"  name="giveCoupon" class="validate[custom[numberSp]] text-input span2" readonly="readonly" onclick="radioClick(3,2)"/>  %
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>问题</span>
                                                <input type="text" name="question" class="validate[required,maxSize[60]] text-input span11"  placeholder="不超过30个汉字"/>
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>选项</span><span style="margin-left: 10px">A</span>
                                                <input type="text" id="answerA2" name="answerA" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">B</span>
                                                <input type="text" id="answerB2" name="answerB" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">C</span>
                                                <input type="text" id="answerC2" name="answerC" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">D</span>
                                                <input type="text" id="answerD2" name="answerD" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>答案</span>
                                                <span ><input type="radio" value="1" name="rightAnswer2" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">A</span>
                                                <span ><input type="radio" value="2" name="rightAnswer2" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">B</span>
                                                <span ><input type="radio" value="3" name="rightAnswer2" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">C</span>
                                                <span ><input type="radio" value="4" name="rightAnswer2" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">D</span>
                                            </div>
                                        </div>
                                        <div class="well span12" style="margin-left: 0px">
                                            <div id="giveTypeGroup3" class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <input type="hidden" name="signInPrizesId" value="0">
                                                <input type="hidden" id="couponId3" name="couponId">
                                                <span>签到满</span>
                                                <input type="text" name="days"  value="${prizes.days}" class="validate[required,custom[integer],min[1],max[31]] text-input span2" />  天
                                                <span ><input type="radio" name="giveType3" value="1" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,3)" >送银子</span>
                                                <input type="text" id="giveSilver3"  name="giveSilver" class="validate[custom[integer],min[1],max[99999]] text-input span2"/>  两
                                                <span ><input type="radio" name="giveType3" value="2" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,3)" >送红包</span>
                                                <input type="text" id="giveBonus3"  name="giveBonus" class="validate[custom[integer]] text-input span2" readonly="readonly" onclick="radioClick(2,3)" />  元
                                                <span ><input type="radio" name="giveType3" value="3" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,3)">送加息券</span>
                                                <input type="text" id="giveCoupon3"  name="giveCoupon" class="validate[custom[numberSp]] text-input span2" readonly="readonly" onclick="radioClick(3,3)" />  %
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>问题</span>
                                                <input type="text" name="question"  value="${prizes.question}" class="validate[required,maxSize[60]] text-input span11"  placeholder="不超过30个汉字"/>
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>选项</span><span style="margin-left: 10px">A</span>
                                                <input type="text" id="answerA3" name="answerA"  class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">B</span>
                                                <input type="text" id="answerB3" name="answerB" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">C</span>
                                                <input type="text" id="answerC3" name="answerC" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                <span style="margin-left: 10px">D</span>
                                                <input type="text" id="answerD3" name="answerD" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                            </div>
                                            <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                <span>答案</span>
                                                <span ><input type="radio" value="1" name="rightAnswer3" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">A</span>
                                                <span ><input type="radio" value="2" name="rightAnswer3" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">B</span>
                                                <span ><input type="radio" value="3" name="rightAnswer3" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">C</span>
                                                <span ><input type="radio" value="4" name="rightAnswer3" class="validate[required]" style="margin-left: 10px;margin-top: -1px;">D</span>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${fn:length(signIn.signInPrizes) > 0}">
                                        <c:forEach items="${signIn.signInPrizes}" var="prizes" varStatus="status">
                                            <div class="well span12" style="margin-left: 0px">
                                                <div id="giveTypeGroup${status.count -1}" class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                    <input type="hidden" name="signInPrizesId" value="${prizes.id}">
                                                    <input type="hidden" id="couponId${status.count -1}" name="couponId" value="${prizes.coupon.id}" >
                                                    <span>签到满</span>
                                                    <input type="text" name="days"  value="${prizes.days}" class="validate[required,custom[integer],min[1],max[31]] text-input span2" />  天
                                                    <span ><input type="radio" name="giveType${status.count -1}" value="1" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,${status.count -1})" <c:if test="${prizes.giveType == 1}">checked</c:if> >送银子</span>
                                                    <input type="text" id="giveSilver${status.count -1}"  name="giveSilver" <c:if test="${prizes.giveType == 1}">value="<fmt:formatNumber type="currency" value="${prizes.giveNum}" currencySymbol="" pattern="#"/>"</c:if> class="validate[custom[integer],min[1],max[99999]] text-input span2"/>  两
                                                    <span ><input type="radio" name="giveType${status.count -1}" value="2" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,${status.count -1})" <c:if test="${prizes.giveType == 2}">checked</c:if>>送红包</span>
                                                    <input type="text" id="giveBonus${status.count -1}"  name="giveBonus" <c:if test="${prizes.giveType == 2}">value="<fmt:formatNumber type="currency" value="${prizes.giveNum}" currencySymbol="" pattern="#"/>"</c:if> class="validate[custom[integer]] text-input span2" onclick="radioClick(2,${status.count -1})"  readonly="readonly" />  元
                                                    <span ><input type="radio" name="giveType${status.count -1}" value="3" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" onclick="radioClick(this.value,${status.count -1})" <c:if test="${prizes.giveType == 3}">checked</c:if> >送加息券</span>
                                                    <input type="text" id="giveCoupon${status.count -1}"  name="giveCoupon" <c:if test="${prizes.giveType == 3}">value="${prizes.giveNum}"</c:if> class="validate[custom[numberSp]] text-input span2" onclick="radioClick(3,${status.count -1})"  readonly="readonly" />  %
                                                </div>
                                                <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                    <span>问题</span>
                                                    <input type="text" name="question"  value="${prizes.question}" class="validate[required,maxSize[60]] text-input span11"  placeholder="不超过30个汉字"/>
                                                </div>
                                                <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                    <span>选项</span><span style="margin-left: 10px">A</span>
                                                    <input type="text" id="answerA${status.count -1}" name="answerA"  value="${prizes.answerA}" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                    <span style="margin-left: 10px">B</span>
                                                    <input type="text" id="answerB${status.count -1}" name="answerB" value="${prizes.answerB}" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                    <span style="margin-left: 10px">C</span>
                                                    <input type="text" id="answerC${status.count -1}" name="answerC" value="${prizes.answerC}" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                    <span style="margin-left: 10px">D</span>
                                                    <input type="text" id="answerD${status.count -1}" name="answerD" value="${prizes.answerD}" class="validate[required,maxSize[40]] text-input span2"  placeholder="不超过20个汉字"/>
                                                </div>
                                                <div class="controls" style="margin-left: -10px;margin-bottom: 10px">
                                                    <span>答案</span>
                                                    <span ><input type="radio" value="1" name="rightAnswer${status.count -1}" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" <c:if test="${prizes.rightAnswer == 1}">checked</c:if> >A</span>
                                                    <span ><input type="radio" value="2" name="rightAnswer${status.count -1}" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" <c:if test="${prizes.rightAnswer == 2}">checked</c:if> >B</span>
                                                    <span ><input type="radio" value="3" name="rightAnswer${status.count -1}" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" <c:if test="${prizes.rightAnswer == 3}">checked</c:if> >C</span>
                                                    <span ><input type="radio" value="4" name="rightAnswer${status.count -1}" class="validate[required]" style="margin-left: 10px;margin-top: -1px;" <c:if test="${prizes.rightAnswer == 4}">checked</c:if> >D</span>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><span class="required">*</span>规则说明</label>
                            <div class="controls">
                                <textarea id="ruleDesc" name="ruleDesc" rows="5"  onkeypress="startValidateParam()">${signIn.ruleDesc}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"></label>
                            <div class="controls">
                                <button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
                                <button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit();"><i></i>取消</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- content end -->
        </div>
    </div>
</div>
<div class="modal hide fade" id="coupon" role="dialog" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel"></h4>
            </div>
            <div class="modal-body">
                <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
                    <thead>
                    <tr id="head">
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
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script type="text/javascript">
    if ('${saveSuccess}') {
        alert('保存成功！');
    }
    var flag = 2;
    var ruleDesc;
    $(function() {
        $('#fm').validationEngine('attach', {
            promptPosition:'bottomLeft',
            showOneMessage: true,
            focusFirstField:true,
            scroll: true
        });
        ruleDesc = UE.getEditor('ruleDesc');
        var beforeDate = new Date();
        beforeDate.setTime(beforeDate.getTime()-1000*60*60*24*6);
        $('.breadcrumb').html('<li class="active">银子管理&nbsp;/&nbsp;APP签到机制</li>');
        $('#beginTime').datetimepicker({
            format:'Y-m-d H:00:00',
            /* minDate:beforeDate.getFullYear()+'/'+(beforeDate.getMonth()+1)+'/'+beforeDate.getDate(), */
            minDate:new Date().toLocaleDateString(),
            lang:'ch',
            timepicker:true,
            onShow:function() {
                if ($('td').hasClass('xdsoft_other_month')) {
                    $('td').removeClass('xdsoft_other_month');
                }
            },
            onSelectDate:function() {
                var beginTime = $('#beginTime').val();
                var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
                $('#endTime').datetimepicker({
                    format:'Y-m-d H:00:00',
                    minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
                    lang:'ch',
                    timepicker:true,
                    onShow:function() {

                        if ($('td').hasClass('xdsoft_other_month')) {
                            $('td').removeClass('xdsoft_other_month');
                        }
                    }
                });
                var endTime = new Date(Date.parse($('#endTime').val().replace(/-/g,"/")));
                if(beginDate > endTime){
                    $('#endTime').val('');
                }
            }
        });

        $('#endTime').datetimepicker({
            format:'Y-m-d H:00:00',
            minDate:new Date().toLocaleDateString(),
            lang:'ch',
            timepicker:true,
            onShow:function() {
                if ($('td').hasClass('xdsoft_other_month')) {
                    $('td').removeClass('xdsoft_other_month');
                }
            },
            onSelectDate:function() {
                var endTime = $('#endTime').val();
                var endDate = new Date(Date.parse(endTime.replace(/-/g,"/")));
                $('#beginTime').datetimepicker({
                    format:'Y-m-d H:00:00',
                    maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
                    lang:'ch',
                    timepicker:true,
                    onShow:function() {
                        if ($('td').hasClass('xdsoft_other_month')) {
                            $('td').removeClass('xdsoft_other_month');
                        }
                    }
                });
            }
        });

    });

    function startValidateParam(){
        var txt = ruleDesc.getContent();
        if($.trim(txt) == ''){
            $('#ruleDesc').addClass('validate[required]');
        }else if(txt.length > 10000){
            alert('字数超出限制');
            return false;
        }else{
            $('#ruleDesc').removeClass('validate[required]');
        }
        $('#ruleDesc').blur();

    }

    function validateDate(date){
        var beginTime = new Date($('#beginTime').val().replace(/-/g,"/")).getTime();
        var endTime = new Date($('#endTime').val().replace(/-/g,"/")).getTime();
        if(beginTime > endTime){
            if(date == 'beginTime'){
                alert('开始时间要小于结束时间!');
                $('#beginTime').val('');
            }else{
                alert('结束时间要大于开始时间!');
                $('#endTime').val('');
            }
        }
    }

    function quit(){
        window.location.href='${pageContext.request.contextPath}/silver/sign';
    }

    function radioClick(val,flag){
        $('#giveTypeGroup'+flag).find('input:radio').eq(val-1).attr('checked','checked');
        if(val == 1){
            $('#giveSilver'+ flag).addClass('validate[required]');
            $('#giveBonus'+ flag).removeClass('validate[required]');
            $('#giveCoupon'+ flag).removeClass('validate[required]');
            $('#giveBonus'+ flag).val('');
            $('#giveCoupon'+ flag).val('');
        }
        if(val == 2){
            $('#giveSilver'+flag).removeClass('validate[required]');
            $('#giveBonus'+flag).addClass('validate[required]');
            $('#giveCoupon'+flag).removeClass('validate[required]');
            $('#giveSilver'+ flag).val('');
            $('#giveCoupon'+ flag).val('');
            showDialog(0,'#giveBonus'+flag, flag);
        }
        if(val == 3){
            $('#giveSilver'+flag).removeClass('validate[required]');
            $('#giveBonus'+flag).removeClass('validate[required]');
            $('#giveCoupon'+flag).addClass('validate[required]');
            $('#giveSilver'+ flag).val('');
            $('#giveBonus'+ flag).val('');
            showDialog(1,'#giveCoupon'+flag, flag);
        }
        $('#giveSilver'+flag).blur();
        $('#giveBonus'+ flag).blur();
        $('#giveCoupon'+ flag).blur();
    }

    function showDialog(category, flag, index){
        $('#coupon').modal('show');
        getCoupon(1,category, flag, index);
    }

    function getCoupon(page,category, flag, index){
        $('#head').html("");
        if(category == 0){
            $('#head').append('<th>序号</th>');
            $('#head').append('<th>使用条件</th>');
            $('#head').append('<th>红包金额</th>');
            $('#head').append('<th>操作</th>');
            $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/'+ page, {'category':0}, function(result){
                if (result.total > 0) {
                    //$('#myModalLabel').empty().html('活动红包');
                    $('#couponBody').html("");
                    for (var i = 0; i < result.bonus.length; i++) {
                        var b = result.bonus[i];
                        $('#couponBody').append('<tr>');
                        $('#couponBody').append('<td class="hidden">'+b.id+'</td>');
                        $('#couponBody').append('<td>'+(i+1)+'</td>');
                        $('#couponBody').append('<td style="width:45%">'+b.condition+'</td>');
                        $('#couponBody').append('<td>'+b.amount+'元</td>');
                        $('#couponBody').append('<td><a href=javascript:choiceCoupon('+b.id+','+ b.amount +',"'+flag+'",'+index+');>选择</a></td>');
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
                            getCoupon(page,category, flag, index);
                        }
                    };
                    $('#coupon-page').bootstrapPaginator(options);
                }else{
                    $('#couponBody').html('<tr><td colspan="5">请先添加活动红包</td></tr>');
                }
            });
        }else if(category == 1){
            $('#head').append('<th>序号</th>');
            $('#head').append('<th>使用条件</th>');
            $('#head').append('<th>加息收益</th>');
            $('#head').append('<th>加息天数</th>');
            $('#head').append('<th>操作</th>');
            $.post('${pageContext.request.contextPath}/coupon/coupon/goods/srource/list/' + page, {'type':2}, function(result){
                if (result.total > 0) {
                    //$('#myModalLabel').empty().html('活动加息券');
                    $('#couponBody').html("");
                    for (var i = 0; i < result.bonus.length; i++) {
                        var b = result.bonus[i];
                        $('#couponBody').append('<tr>');
                        $('#couponBody').append('<td class="hidden">'+b.id+'</td>');
                        $('#couponBody').append('<td>'+(i+1)+'</td>');
                        $('#couponBody').append('<td style="width:45%">'+b.condition+'</td>');
                        $('#couponBody').append('<td>'+b.amount+'%</td>');
                        $('#couponBody').append('<td>'+b.increaseDays+'天</td>');
                        $('#couponBody').append('<td><a href=javascript:choiceCoupon('+b.id+','+ b.amount +',"'+flag+'",'+index+');>选择</a></td>');
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
                            getCoupon(page,category, flag, index);
                        }
                    };
                    $('#coupon-page').bootstrapPaginator(options);
                }else{
                    $('#couponBody').html('<tr><td colspan="5">请先添加活动加息券</td></tr>');
                }
            });
        }else{
            //do nothing
        }
    }

    function choiceCoupon(couponId,amount, flag, index){

        $('#couponId'+index).val(couponId);
        //alert($('#couponId'+index).val());
        $(flag).val(amount);
        $('#coupon').modal('hide');
        $(flag).blur();
        $(flag).blur();
        $(flag).blur();
    }
</script>
</html>