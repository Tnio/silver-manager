<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form class="form-horizontal" id="fm">
                            <input name="name" value="${name}" type="hidden"/>
                            <input name="cellphone" value="${cellphone}" type="hidden"/>
                            <input name="idcard" value="${idcard}" type="hidden"/>
                            <input name="timeType" value="${timeType}" type="hidden"/>
                            <input name="channelId" value="${channelId}" type="hidden"/>
                            <input name="beginTime" value="${beginTime}" type="hidden"/>
                            <input name="endTime" value="${endTime}" type="hidden"/>
                            <input name="startAmount" value="${startAmount}" type="hidden"/>
                            <input name="endAmount" value="${endAmount}" type="hidden"/>
                            <input name="sort" value="${sort}" type="hidden"/>
                            <div class="accordion-group" id="base">
                                <div class="accordion-heading">
                                    <a id="product-base-a" href="#product-base" data-parent="#product" data-toggle="collapse" class="accordion-toggle collapsed " style="text-decoration: none">
                                        基本信息
                                    </a>
                                </div>
                                <div class="well" style="padding-bottom: 20px; margin: 0;">
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">注册号码</label>
                                                <div class="controls"><input type="text" id="registerCellphone" name="registerCellphone" value="${user.registerCellphone }"/></div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">当前号码</label>
                                                <div class="controls"><input type="text" id="cellphone" name="cellphone" value="${user.cellphone }"/></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">姓名</label>
                                                <div class="controls"><input type="text" id="name" name="name" value="${user.name }"/></div>
                                            </div>
                                        </div>
                                        <%--  <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">会员等级</label>
                                                <div class="controls"><input type="text" id="vipLevel" name="vipLevel" value="${user.vipLevel }"/>
                                                    
                                                </div>
                                            </div>
                                        </div> --%>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">身份证号</label>
                                                <div class="controls"><input type="text" id="idcard" name="idcard" value="${user.idcard }"/></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">交易次数</label>
                                                <div class="controls">
                                                    <input type="text" id="totalTradeAmount" name="totalTradeAmount" value="${customer.totalTradeAmount}"/>次
                                                    <c:if test="${customer.totalTradeAmount > 0}"><a href="${pageContext.request.contextPath}/client/customer/${user.id}/trade/1">明细</a></c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">电子账户</label>
                                                <div class="controls">
                                                    <input type="text" id="accountId" name="accountId" value="${user.accountId}"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">邀请累计红包（已使用）</label>
                                                <div class="controls"><input type="text" id="usedCumulativeRebate" name="usedCumulativeRebate" value="<fmt:formatNumber type="number" pattern="0.00" value="${usedCumulativeRebate }"/>"/>元</div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">银子</label>
                                                <div class="controls"><input type="text" name="silver" value="${user.silverNumber}"/>两</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">提现账户</label>
                                                <div class="controls"><input type="text" id="cardNo" name="cardNo" value="${bank.cardNo}"/>&nbsp;<input type="button" id="bt_refresh" value="刷新"></span></div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">所属银行</label>
                                                <div class="controls"><input type="text" id="bankName" name="bankName" value="${bank.bankName}"/></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">交易总金额</label>
                                                <div class="controls"><input type="text" id="totalTradeMoney" name="totalTradeMoney" value="${customer.totalTradeMoney }"/>元</div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">待收总金额</label>
                                                <div class="controls"><input type="text" id="collectPrincipal" name="collectPrincipal" value="${collectPrincipal}"/>元</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">收益总金额</label>
                                                <div class="controls"><input type="text" id="totalTradeIncome" name="totalTradeIncome" value="<fmt:formatNumber type="number" pattern="0.00" value="${customer.totalTradeIncome}"/>"/>元</div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">渠道名称</label>
                                                <div class="controls"><input type="text" id="channelName" name="channelName" value="${user.channel.name }"/></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">账户余额</label>
                                                <div class="controls"><input type="text" id="balance" name="balance" value="<fmt:formatNumber type="number" pattern="0.00" value="${balance }"/>" /><a href="${pageContext.request.contextPath}/client/customer/${user.id}/balance/1">明细</a></div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">冻结金额</label>
                                                <div class="controls"><input type="text" id="freezingAmount" name="freezingAmount" value="${freezingAmount}"/><a href="${pageContext.request.contextPath}/client/customer/${user.id}/frozen/1">明细</a></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">邀请人</label>
                                                <div class="controls"><input type="text" id="inviterPhone" name="inviterPhone" value="${user.inviterPhone }"/></div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">已邀请人数</label>
                                                <div class="controls"><input type="text" id="inviteNumber" name="inviteNumber" value="${inviteNumber}"/><span id="inviterDetail">人</span> </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">邀请累计红包（总计）</label>
                                                <div class="controls"><input type="text" name="rebate" value="<fmt:formatNumber type="number" pattern="0.00" value="${reward}"/>"/>元</div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">首次交易时间</label>
                                                <div class="controls">
                                                    <c:if test="${user.firstTradeTime != 'Thu Jan 01 00:00:00 GMT+08:00 1970' and user.firstTradeTime != 'Thu Jan 01 00:00:00 CST 1970'}">
                                                        <input type="text" id="firstTradeTime" name="firstTradeTime" value="<fmt:formatDate value="${user.firstTradeTime }" type="both" pattern="yyyy-MM-dd HH:mm:ss" />"/>
                                                    </c:if>
                                                    <c:if test="${user.firstTradeTime == 'Thu Jan 01 00:00:00 GMT+08:00 1970' or user.firstTradeTime == 'Thu Jan 01 00:00:00 CST 1970'}">
                                                        <input type="text" id="firstTradeTime" name="firstTradeTime" />
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">邀请奖励</label>
                                                <div class="controls"><input type="text" id="sumInviteAmount" name="sumInviteAmount" value="<fmt:formatNumber type="number" pattern="0.00" value=""/>"/><span id = "sumInviteAmountDetail">元</span></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">最后登录时间</label>
                                                <%-- <div class="controls"><input type="text" id="latestLoginTime" name="latestLoginTime" value="<fmt:formatDate value="${user.latestLoginTime }" type="both" pattern="yyyy-MM-dd HH:mm:ss" />"/></div> --%>
                                                <div class="controls">
                                                    <c:if test="${user.latestLoginTime != 'Thu Jan 01 00:00:00 GMT+08:00 1970' and user.latestLoginTime != 'Thu Jan 01 00:00:00 CST 1970'}">
                                                        <input type="text" id="latestLoginTime" name="latestLoginTime" value="<fmt:formatDate value="${user.latestLoginTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />"/>
                                                    </c:if>
                                                    <c:if test="${user.latestLoginTime == 'Thu Jan 01 00:00:00 GMT+08:00 1970' or user.latestLoginTime == 'Thu Jan 01 00:00:00 CST 1970'}">
                                                        <input type="text" id="latestLoginTime" name="latestLoginTime" />
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">最后交易时间</label>
                                                <div class="controls">
                                                    <c:if test="${customer.latestTradeTime != 'Thu Jan 01 00:00:00 GMT+08:00 1970' and customer.latestTradeTime != 'Thu Jan 01 00:00:00 CST 1970'}">
                                                        <input type="text" id="latestTradeTime" name="latestTradeTime" value="<fmt:formatDate value="${customer.latestTradeTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />"/>
                                                    </c:if>
                                                    <c:if test="${customer.latestTradeTime == 'Thu Jan 01 00:00:00 GMT+08:00 1970' or customer.latestTradeTime == 'Thu Jan 01 00:00:00 CST 1970'}">
                                                        <input type="text" id="latestTradeTime" name="latestTradeTime" />
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">注册时间</label>
                                                <div class="controls"><input type="text" id="registerTime" name="registerTime" value="<fmt:formatDate value="${user.registerTime }" type="both" pattern="yyyy-MM-dd HH:mm:ss" />"/></div>
                                            </div>
                                        </div>
                                        <%-- <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">注册设备</label>
                                                <div class="controls"><input type="text" id="registerDevice" name="registerDevice" value="${user.registerDevice}"/></div>
                                            </div>
                                        </div> --%>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">未使用优惠券数量</label>
                                                <div class="controls"><input type="text" value="${unUsedCoupons}"/><a href="${pageContext.request.contextPath}/client/customer/coupons/${user.id}/1">明细</a></div>
                                            </div>
                                        </div>
                                        <div class="row-fluid">
                                         <div class="span6" >
                                            <div class="control-group" >
                                                <label class="control-label" >会员等级</label>
                                                <div class="controls" >
                                                  <input id="hidden"  type="hidden" value="${customer.vipLevel}">
                                                  <input type="text" id="vipLevel" name="vipLevel" value=""/>
                                                    <a href="${pageContext.request.contextPath}/client/customer/${id}/vipdetails/1">明细</a>
                                                 </div>
                                            </div>
                                          </div>
                                        </div>
                                       </div>
                                    <%-- <div class="row-fluid">
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">最后登录设备</label>
                                                <div class="controls"><input type="text" id="latestLoginDevice" name="latestLoginDevice" value="${user.latestLoginDevice }"/></div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label">未使用优惠券数量</label>
                                                <div class="controls"><input type="text" value="${unUsedCoupons}"/><a href="${pageContext.request.contextPath}/client/customer/coupons/${user.id}/1">明细</a></div>
                                            </div>
                                        </div>
                                    </div> --%>
                                </div>
                            </div>
                            <div class="accordion-group" id="base">
                                <div class="accordion-heading">
                                    <a id="product-base-a" href="#product-base" data-parent="#product" data-toggle="collapse" class="accordion-toggle collapsed " style="text-decoration: none">
                                        QQ信息
                                    </a>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label">是否绑定</label>
                                            <div class="controls">
                                                <div class="span2">
                                                    <input type="radio" name="qqBinded" <c:if test="${not empty qq}">checked="checked"</c:if> value="0">
                                                    <span>是</span>
                                                </div>
                                                <div class="span2">
                                                    <input type="radio" name="qqBinded" <c:if test="${empty qq}">checked="checked"</c:if> value="1">
                                                    <span>否</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label">QQ昵称</label>
                                            <div class="controls"><input type="text" value="${qq.nickName}"/></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid" id="bigImage">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label">QQ头像</label>
                                            <div class="controls" style="height:150px; width: 150px;"><img src="${qq.headImg }" /></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-group" id="base">
                                <div class="accordion-heading">
                                    <a id="product-base-a" href="#product-base" data-parent="#product" data-toggle="collapse" class="accordion-toggle collapsed " style="text-decoration: none">
                                        微信信息
                                    </a>
                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label">是否绑定</label>
                                            <div class="controls">
                                                <div class="span2">
                                                    <input type="radio" name="wechatBinded" <c:if test="${not empty wechat}">checked="checked"</c:if> value="0">
                                                    <span>是</span>
                                                </div>
                                                <div class="span2">
                                                    <input type="radio" name="wechatBinded" <c:if test="${empty wechat}">checked="checked"</c:if> value="1">
                                                    <span>否</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label">微信昵称</label>
                                            <div class="controls"><input type="text" value="${wechat.nickName}"/></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid" id="bigImage1">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label">微信头像</label>
                                            <div class="controls" style="height:150px; width: 150px;"><img src="${wechat.headImg }" /></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <a href="javascript:quit();"><button type="button" class="btn">返回</button></a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
<script type="text/javascript">
    $(function(){
        var workImg = document.getElementsByTagName('img');
        var inviteNumber = $('#inviteNumber').val();
        for(var i=0; i<workImg.length; i++) {
            workImg[i].onclick=ImgShow;
        }
        $('.breadcrumb').html('<li class="active">客户管理&nbsp;/&nbsp;<a href="javascript:quit();">用户管理&nbsp</a>/&nbsp;用户详情</li>');
        readOnly();

        $('#bt_refresh').click(function(){
            cardRefresh();
        });
        if(inviteNumber>0){
        	 $('#inviterDetail').html("<a href='javascript:showinviterDetails();'>明细</a>")
        }
        showSumInviteAmount();
        
    });


    function quit() {
        $('#fm').attr('action','${pageContext.request.contextPath}/client/customer/list/1');
        $('#fm').submit();
    }
    function readOnly()
    {
        var  a =  document.getElementsByTagName("input");
        for(var   i=0;   i<a.length;   i++)   {
            if(a[i].type=="checkbox" || a[i].type=="radio" || a[i].type=="text"){
                a[i].readOnly = true;
                a[i].disabled = "disbaled";
            }
        }

        var  b  =  document.getElementsByTagName("select");
        for(var i=0; i<b.length; i++)   {
            b[i].disabled="disabled";
        }

        var c = document.getElementsByTagName("textarea");
        for   (var   i=0;   i<c.length;   i++)
        {
            c[i].disabled="disabled";
        }
    }

    function cardRefresh(){
        var cardNo= $('#cardNo').val();
        var accountId=$('#accountId').val();
        var userId= ${user.id};
        if(accountId ==''){
            return;
        }
        /*  userId = 655388
         cardNo='6259651808512045';
         accountId='6212462070000146612';   */
        $.post('${pageContext.request.contextPath}/client/card/bind/query',{cardNo:cardNo,accountId:accountId,userId:userId},function(data){
            $('#cardNo').val(data);
        });
    }
    
    $(function () {
       var vipLev= $('#hidden').val();
       if (vipLev>=1 && vipLev<= 8 ){
    	   $("#vipLevel").val('VIP'+vipLev);
       }else{
    	   $("#vipLevel").val('非会员');
       }
	})
	
	function showSumInviteAmount() {
    	var userId = ${user.id};
    	 $.post('${pageContext.request.contextPath}/activity/sum/inviteamount',{userId:userId},function(result){
             $('#sumInviteAmount').val(result.data);
    		 if (result.data > 0){
    			 $('#sumInviteAmountDetail').html("<a href='javascript:showDetails();'>明细</a>")
    		 }
         });
    }
    
    function showDetails(){
    	var userId = ${user.id};
    	$.post('${pageContext.request.contextPath}/client/customer/cellphone',{userId:userId},function(result){
		   	if (result != null ){
    			window.location.href = '${pageContext.request.contextPath}/activity/inviter/list/1'+'?cellphone='+result;
		   	}
    	})
    }
    function showinviterDetails(){
    	var userId = ${user.id};
    	$.post('${pageContext.request.contextPath}/client/customer/cellphone',{userId:userId},function(result){
		   	if (result != null){
    	    	window.location.href = '${pageContext.request.contextPath}/client/inviter/detail/'+result+'/1';
		   	}
    	});
    }
		
</script>
</body>
</html>