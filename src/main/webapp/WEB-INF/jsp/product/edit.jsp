<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
	<style>
	<!--
	.combo-select {
	  position: relative;
	  max-width: 99%;
	  min-width: 99%;
	  /* margin-bottom: 15px; */
	  font: 100% Helvetica, Arial, Sans-serif;
	  border: 1px #ccc solid;
	  border-radius: 3px;
	  display:inline-block;
	  vertical-align: top;
	   }
	-->
	</style>
	<body>
		<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
            <div class="row-fluid">
                <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
                <div class="span9" id="content">
                	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <!-- content begin -->
                    <!-- <div class="span12"> -->
                    <form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post" enctype="multipart/form-data"  action="${pageContext.request.contextPath}/product/save"  autocomplete="off">
						<input id="id" name="id" value="${product.id}" type="hidden">
						<input name="actualAmount" value="${product.actualAmount}" type="hidden">
						<input id="productCategoryProperty" name="category.property" type="hidden" value="${product.category.property}">
						<input id="page" name="page" value="${page}" type="hidden">
                   		<input name="size" value="${size}" type="hidden">
                   		<input name="productName" value="${productName}" type="hidden">
                   		<input id="removeAttachmentIds" name="removeAttachmentIds" value="" type="hidden">
						<input id="productStatue" name="productStatue" value="${productStatue}" type="hidden">
						<input name="productCategoryId" value="${productCategoryId }" type="hidden">
						<input name="merchantId" value="${merchantId}" type="hidden">
						<input name="periodStart" value="${periodStart}" type="hidden">
						<input name="periodEnd" value="${periodEnd}" type="hidden">
						<input id="initStatus" name="initStatus" value="${product.status}" type="hidden" >
						<input name="productDetail.protocolIds" value="2,4" type="hidden">
						<input id="status" name="status" value="0" type="hidden" >
						<input id="registerMsg" name="registerMsg" type="hidden" >
						<input id="attachmentIdList" name="attachmentIdList"  type="hidden">
						<input id="projectIddata"  type="hidden">
						<input id="merchantIddata"  type="hidden">
						<input id="financePerioddata"  type="hidden">
						<input id="tempdata"  type="hidden">
						<input id="tempProjectData"  type="hidden" >
						<input id="productNameTempdata"  type="hidden"  >
							<h6 class="header smaller lighter blue" id="showTitle"></h6>
							<div id="product" class="accordion">
				                <div class="accordion-group">
				                  <div class="accordion-heading">
				                    <a id="product-base-a" href="#product-base" data-parent="#product" data-toggle="collapse" class="accordion-toggle collapsed " style="text-decoration: none">
				                     	 产品基本信息
				                     	 <!-- <span class="icon-chevron-up product-base-down"></span>
				                     	 <span class="icon-chevron-down product-base-up" style="display:none;"></span> -->
				                    </a>
				                  </div>
				                  <div class="accordion-body collapse in" id="product-base">
				                    <div class="accordion-inner">
				                    	    <div class="well" style="padding-bottom: 20px; margin: 0;">
				                    		<div class="control-group">
												<label class="control-label"><span class="required">*</span> 产品名称</label>
												<div class="controls"><input type="text" id="name" name="name" value="${product.name}" class="validate[required,maxSize[20],ajax[checkProductName]] text-input span12"  placeholder="不超过10个汉字" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="checkValue(this.value)"/></div>
											</div>
											<div class="row-fluid">
												<div class="span6">
													<div class="control-group">
														<label class="control-label"><span class="required">*</span> 产品类型</label>
														<div class="controls">
														    <select id="category"  name="category.id" class="validate[required] span12" onchange="showView(this)" >
				                                            <option></option>
				                                            <c:forEach items="${categorys}" var="category">
			                                            		<c:choose>
				                                            		<c:when test="${product.category.id == category.id}">
				                                            		<option  value="${category.id}" data="${category.property}" selected="selected">${category.name}</option>
				                                            		</c:when>
				                                            		<c:otherwise>
				                                            		<option  value="${category.id}" data="${category.property}" >${category.name}</option>
				                                            		</c:otherwise>
			                                            		</c:choose>
				                                           	</c:forEach>
															</select>
													    </div>
													</div>
													<div class="control-group">
														<label class="control-label"><span class="required">*</span> 服务费</label>
														<div class="controls"><input type="text" id="loanYearIncome" name="loanYearIncome" value="${product.loanYearIncome}" class="validate[required,custom[numberSp],min[0.01],max[36]] text-input span11"   onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" placeholder="输入的数字不大于36"/> %</div>
													</div>
													<div class="control-group" id="totalAmountGroup">
														<label class="control-label"><span class="required">*</span> 募集金额</label>
														<div class="controls"><input type="text" id="totalAmount" name="totalAmount"   value="<fmt:formatNumber type="currency" value="${product.totalAmount}" currencySymbol="" pattern="#"/>" class="validate[required,custom[number],min[1],max[99999999]] text-input span11" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 元</div>
													</div>
													<div class="control-group" style="display: none">
														<label class="control-label"><span class="required">*</span> 上架时间</label>
														<div class="controls"><input type="text" id="shippedTime" name="shippedTime" value="<fmt:formatDate value="${product.shippedTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />" class="validate[required] text-input span12"  onblur="colcDateTime()" onkeypress="return false"/></div>
													</div>
													<div class="control-group" id="lowestMoneyGroup">
														<label class="control-label"><span class="required">*</span> 起投金额</label>
														<div class="controls">
															<select id="lowestMoney" class="validate[required] span11">
				                                            	<option value="100" <c:if test="${product.lowestMoney == 100}">selected="selected"</c:if> >100 </option>
																<option value="200" <c:if test="${product.lowestMoney == 200}">selected="selected"</c:if> >200</option>
																<option value="500" <c:if test="${product.lowestMoney == 500}">selected="selected"</c:if> >500</option>
																<option value="1000" <c:if test="${product.lowestMoney ==1000}">selected="selected"</c:if> >1000</option>
															</select> 元
														</div>
													</div>
													<div class="control-group" id="sLowestMoneyGroup">
														<label class="control-label"><span class="required">*</span> 投资金额</label>
														<div class="controls">
															<input type="text" id="sLowestMoney"  class="validate[required,custom[integer],min[1],max[10000]] text-input span11" value="${product.lowestMoney}"/>  元
														</div>
													</div>
													<%-- <div class="control-group" id="interestDateGroup">
														<label class="control-label"><span class="required">*</span> 起息时间</label>
														<div class="controls"><input type="text" id="interestDate" name ="interestDate" value="${product.interestDate}" class="validate[required] text-input span12" onblur="colcDateTime()" onkeypress="return false"/></div>
													</div> --%>
													<div class="control-group" id="interestDateGroup">
														<label class="control-label"><span class="required">*</span> 起息时间</label>
														<div class="controls">
															<input type="text" id="interestDate"  name ="interestDate" value="${product.interestDate}" class="validate[] text-input span8" onblur="colcDateTime()" onkeypress="return false"/>
															<input type="checkbox" id="autoInterestDate" name="interestType" class="validate[]" style="margin-top: 0px;" value="1"> T + 1 起息
														</div>
													</div>
													<div class="control-group" id="dueTimeGroup">
														<label class="control-label"><span class="required">*</span> 到期时间</label>
														<div class="controls"><input type="text" id="dueTime" name="dueTime"  class="text-input span12" placeholder="根据起息时间和理财期限自动计算" readonly="readonly"/></div>
													</div>
													
													<div class="control-group">
														<label class="control-label"><span class="required">*</span> 手续费用</label>
														<div class="controls"><input type="text" id="poundage"  class="validate[text-input span12" name="productDetail.poundage" value="${product.productDetail.poundage}" readonly="readonly"/></div>
												  	</div>
												  	<div class="control-group" id="refundGroup">
														<label class="control-label"><span class="required">*</span> 回款方式</label>
														<div class="controls">
															<select id="refund" name="productDetail.refund" class="validate[required] span12">
				                                            	<option value="一次性还本付息">一次性还本付息</option>	
															</select>
														</div>
												    </div>
												   <%-- <div  class="control-group">
												          <label class="control-label"><span class="required">*</span>是否支持vip加息</label>
												     <div class="controls" style="position: absolute;top:495px" >
												                     否<span>&nbsp;&nbsp;</span><input type="radio" name="vipInterest"   <c:if test="${product.vipInterest == 0 }"> checked="checked"</c:if>   value="0"/><span>&nbsp;&nbsp;&nbsp;&nbsp;</span> 是<span>&nbsp;&nbsp;</span><input type="radio" name="vipInterest" <c:if test="${product.vipInterest == 1 }"> checked="checked"</c:if>   value="1"/>
												     </div>
												   </div> --%>
												</div>
												<div class="span6">
													<div class="control-group">
														<label class="control-label"><span class="required">*</span>选择项目</label>
														<div class="controls">
															<select id="projectId" name="productDetail.project.id" class="validate[required] span12" onchange="showProjectInfo(this.value)">
														        <option></option>
														        <c:forEach items="${projects}" var="project">
						                                            <option value="${project.id}"  <c:if test="${product.productDetail.project.id == project.id }">selected="selected"</c:if> >${project.name}</option>
					                                            </c:forEach>
														    </select>
														</div>
													</div>
													<div class="control-group merchantGroup">
														<label class="control-label"><span class="required">*</span>选择借款人</label>
														<div class="controls">
															<select id="merchantId" name="merchant.id" class="validate[required]" onchange="showMerchantInfo(this.value)">
															<option></option>
				                                            <c:forEach items="${merchants}" var="merchant">
				                                            	<c:choose>
				                                            		<c:when test="${product.merchant.id == merchant.id}">
				                                            			<option value="${merchant.id}" selected="selected">${merchant.name}</option>
				                                            		</c:when>
				                                            		<c:otherwise>
				                                            			<option value="${merchant.id}">${merchant.name}</option>
				                                            		</c:otherwise>
			                                            		</c:choose>
				                                            </c:forEach>	
															</select>
														</div>
												     </div>
													<div class="control-group">
														<label class="control-label"><span class="required">*</span> 年化收益</label>
														<div class="controls"><input type="text" id="yearIncome" name="yearIncome" value="${product.yearIncome}" class="validate[required,custom[numberSp],min[0.01],max[36]] text-input span11"   onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" placeholder="输入的数字不大于 36"/> %</div>
													</div>
													<div class="control-group" id="increaseInterestGroup">
														<label class="control-label"> 产品加息</label>
														<div class="controls"><input type="text" id="increaseInterest" name="increaseInterest" value="${product.increaseInterest}" onblur="checkIncreaseInterest()" class="validate[required,custom[numberSp],min[0],max[20]] text-input span11" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" placeholder="输入的数字不大于 20"/> %</div>
													</div>
													<div class="control-group">
														<label class="control-label"><span class="required">*</span> 风险程度</label>
														<div class="controls">
														    <select id="risk" name="productDetail.risk" class="span12">
				                                             <option value="低" <c:if test="${product.productDetail.risk == '低'}">selected="selected"</c:if> >低</option>
				                                             <option value="很低" <c:if test="${product.productDetail.risk == '很低'}">selected="selected"</c:if> >很低</option>
				                                             <option value="超低" <c:if test="${product.productDetail.risk == '超低'}">selected="selected"</c:if> >超低</option>
															</select>
														</div>
													</div>
													<div class="control-group" id="raisePeriodGroup">
														<label class="control-label"><span class="required">*</span> 募集周期</label>
														<div class="controls"><input type="text" id="raisePeriod"  name="raisePeriod" value="${product.raisePeriod}" class="validate[required,custom[integer],min[1],max[30]] text-input span11" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 天</div>
													</div>
													<div class="control-group" id="sRaisePeriodGroup">
														<label class="control-label"><span class="required">*</span> 募集周期</label>
														<div class="controls"><input type="text"  class="validate[text-input span11" value="无限制" disabled="disabled"/> 天</div>
													</div>
													<div class="control-group" id="highestMoneyGroup">
														<label class="control-label" id="higheLabel"> 投资上限</label>
														<div class="controls">
															<input type="text" id="highestMoney" name="highestMoney" value="" class="text-input span11"/> 元
														</div>
												    </div>
													<div class="control-group">
														<label class="control-label"><span class="required">*</span> 理财期限</label>
														<div class="controls">
															<input type="text" id="financePeriod" name="financePeriod"   value="${product.financePeriod}" class="validate[required,custom[onlyNumberSp],min[1],max[999]] text-input span11"   onblur="colcDateTime()"  onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 天
														</div>
													</div>
													<div class="control-group" id="bonusGroup">
														<label class="control-label"><span class="required"></span> 活动优惠</label>
														<div class="controls">
															<select id="bonus" name="bonus.id" class="span12" onchange="detailBonus(this.value)">
																<option value="0" selected="selected">无</option>
					                                            <c:forEach items="${bonus}" var="b">
					                                            	<c:choose>
					                                            		<c:when test="${product.bonus.id == b.key}">
					                                            		 	<option value="${b.key}" selected="selected">${b.value}</option>
					                                            		</c:when>
					                                            		<c:otherwise>
					                                            			<option value="${b.key}">${b.value}</option>
					                                            		</c:otherwise>
				                                            		</c:choose>
					                                            </c:forEach>
															</select>
															<span id="bonusSelect">
															</span>
														</div>
													</div>
												</div>
											</div>
										    <div class="control-group">
											  <label class="control-label"><span class="required"></span>标签</label>
											  <div class="controls"><input type="text" id="label" name="label" value="${product.label}" class="validate[maxSize[16] text-input span12"  placeholder="不超过8个汉字" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
										    </div>
											<div class="control-group" id="remarkGroup" >
												<label class="control-label"> 其他说明</label>
												<div class="controls">
													<textarea  name="productDetail.remark" class="validate[maxSize[256]] span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')">${product.productDetail.remark}</textarea>
										    	</div>
										    </div>
				                    	</div>
				                    </div>
				                  </div>
				                </div>
				                <div class="accordion-group" id="introduce">
					                <div class="accordion-heading">
					                    <a  id="product-introduce-a"  href="#product-introduce" data-parent="#product" data-toggle="collapse" class="accordion-toggle collapsed" style="text-decoration: none">
					                    	 产品详情
					                    </a>
					                </div>
				                  	<div class="accordion-body collapse" id="product-introduce">
				                    	<div class="accordion-inner">
				                    		<div class="well" style="padding-bottom: 20px; margin: 0;">
					                      		<div class="control-group" id="innerContent">
													<label class="control-label"><span class="required">*</span>项目介绍</label>
													<div class="controls">
														<textarea cols="80" id="productDesc" name="productDetail.productDesc"></textarea>
													</div>
												</div>
												<div class="control-group coreEnterpriseGroup">
											       <label class="control-label"><span class="required"></span>核心企业</label>
											       <div class="controls">
											       	<textarea id="coreEnterprise"  class="validate[maxSize[500]] span12" readonly="readonly"></textarea>
											       </div>
										        </div>
										        <div class="control-group">
											       <label class="control-label"><span class="required">*</span>资金用途</label>
											       <div class="controls">
											       	<textarea id="fundPurpose"  rows="2" class="validate[required, maxSize[256]] span12" readonly="readonly"></textarea>
										           </div>
										        </div>
												<div class="control-group">
											       <label class="control-label"><span class="required">*</span>风险提示</label>
											       <div class="controls">
											       	<textarea id="riskWarning" rows="2" class="span12" readonly="readonly"></textarea>
										           </div>
										        </div>
											</div>
				                    	</div>
				                  	</div>
				                </div>
				                <div class="accordion-group" id="merchantInfo">
					                <div class="accordion-heading">
					                    <a  id="product-introduce-a" href="#merchantInfo-introduce" data-toggle="collapse" data-parent="#product" class="accordion-toggle collapsed" style="text-decoration: none">
					                    	风控审核
					                    </a>
					                </div>
				                  	<div class="accordion-body collapse" id="merchantInfo-introduce">
				                    	<div class="accordion-inner">
				                    		<div class="well" style="padding-bottom: 20px; margin: 0;">
				                    			<div class="row-fluid" id="dataAuditingGroup">
													<div class="control-group">
												       <label class="control-label" style="margin-top: -5px;">资料审核</label>
												       <div class="controls" id="dataAuditingGroup">
												        	<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="1"> 营业执照
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="2"> 法人代表身份证
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="3"> 银行开户许可证
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="4"> 流水证明
											        		</span>
											        		<br>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="5"> 信用审核
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="6"> 涉诉信息
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="7"> 质押物估值
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="8"> 仓储监管
											        		</span>
											        		<br>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="9"> 担保合同
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="10"> 回购协议
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="11"> 身份证件
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="12"> 银行流水
											        		</span>
											        		<br>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="13"> 收入证明
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="14"> 征信报告
											        		</span>
											        		<span class="span3" style="margin-left:0;">
											        			<input type="checkbox" name="dataAuditing" style="margin-top: 0px;" value="15"> 贷款用途
											        		</span>
											           </div>
											        </div>
												</div>
				                    			<div class="row-fluid lenderGroup">
								      				<div class="span6">
														<div class="control-group">
															<label class="control-label"><span class="required">*</span>选择债权</label>
															<div class="controls">
																<input type="text" class="text-input span6" readonly onclick="showLenderDialog(0)"/>
															</div>
														</div>
									      			</div>
									      		</div>
									      		<div class="row-fluid lenderGroup">
									      			<div class="span12">
														<div class="control-group">
															<label class="control-label"><span class="required"></span></label>
															<div class="controls">
																<table class="table table-striped">
												                	<thead>
												                    	<tr>
											                                <th style="width:20%;">借款人</th>
											                                <th style="width:20%;">身份证</th>
										                                	<th style="width:20%;">借款金额(元)</th>
										                                	<th id="financial_th" style="width:20%;">借款期限(天)</th>
											                                <c:if test="${operation == 'edit'}">
											                                	<th>操作</th>
											                                </c:if>
												                        </tr>
												                   </thead>
												                   <tbody id="quantityGroup">
																		<c:choose>
							                                        		<c:when test="${fn:length(lenders) > 0}">
							                                        		  <input id="totals"  type="hidden" value="${fn:length(lenders)}" >
							                                        			<c:forEach var ="lender" items="${lenders}" varStatus="status">
							                                        				<tr id="divl${status.count}">
							                                        					<td><input id="lenderIds${status.count}" name="lenderIds" value="${lender.id}" type="hidden" ><span>${lender.name}</span></td>
							                                        					<td><span>${fn:substring(lender.idcard,0,2)}****${fn:substring(lender.idcard,16,18)}</span></td>
							                                        					<td><span>${lender.loanAmount}</span></td>
							                                        					<td><span>${lender.loanPeriod}</span></td>
							                                        					<c:if test="${operation == 'edit'}">
								                                        					<td><input type="button" class="btn btn-lg" value ="删除" onclick= "remove('divl${status.count}','${lender.loanAmount}')" ></td>
							                                        					</c:if>
							                                        				</tr>
							                                        			</c:forEach>
							                                        		</c:when>
							                                        		<c:otherwise>
							                                        			<tr>
							                                        				<td colspan="6">暂时没有借款人数据</td>
							                                        			</tr>
							                                        		</c:otherwise>
							                                        	</c:choose>
												                   </tbody>
										             			</table>
												                <label id="totleAmountDiv"></label>
															</div>
														</div>
									      			</div>
									      		</div>
										        <div class="row-fluid licensesGroup">
										        	<div class="control-group">
					                    				<div class="span6">
					                    					<label class="control-label" id="ls"></label>
															<div class="controls">
																<div id="licenses"></div>
													      	</div>
					                    				</div>
														<div class="span6">
															<label class="control-label" id="lp"></label>
															<div class="controls">
																<div id="legalPersonIdcard"></div>
														    </div>
														</div>
												    </div>
										        </div>
										        <div class="row-fluid storageGroup">
				                					<div class="span6">
				                						<div class="control-group">
				                							<label class="control-label" id="rd"></label>
															<div class="controls">
																<div id="realDiagram"></div>
														    </div>
				                						</div>
				                    				</div>
				                				</div>
				                				<div class="row-fluid storageGroup">
				                					<div class="span12">
				                						<div class="control-group">
					                    					<label class="control-label">物品仓储</label>
					                    					<div class="controls">
					                    						<div id="storageUpload"></div>
				                    							<c:set var="countSto" value="0"></c:set>
				                    							<c:forEach items="${attachments}" var="attachment" varStatus="status">
															        <c:if test="${attachment.category == 6}">
																		<a id="${attachment.id}" class="thumbnail" style="float: left; height:300px; width: 217px;">
															        		<div id="storage-${status.index}" style="height:270px; width: 217px;"><img  name="STORAGE" style="height:270px; width: 217px;" src="${attachment.url}"/></div>
															        		<div align="right"><button type="button" class="btn btn-lg" onclick="javascript:deleteAttachments(${attachment.id}, 'se')">删除</button></div>
																      	</a>
																      	<c:set var="countSto" value="${countSto + 1}"></c:set>
															      	</c:if>
														        </c:forEach>
													        	<a class="thumbnail" style="float: left; height:300px; width: 217px;">
																	<div style="height:270px; width: 217px;"></div>
																	<button type="button" onclick="javascript:addStorage('', '')" class="btn btn-lg">添加</button>
																</a>
					                    						
					                    					</div>
													    </div>
				                					</div>
				                				</div>    			
											    <div class="row-fluid pledgeGroup">
											    	<div class="control-group">
												    	<div class="span12">
					                    					<label class="control-label"><span class="required"></span>物品清单</label>
															<div class="controls">
																<div id="pledgeUpload"></div>
																<c:set var="countPe" value="0"></c:set>
																<c:forEach items="${attachments}" var="attachment">
															        <c:if test="${attachment.category == 3}">
																		<a id="${attachment.id}" class="thumbnail" style="float: left; height:300px; width: 217px;">
															        		<div id="inven" style="height:270px; width: 217px;"><img  name="PLEDGE" style="height:270px; width: 217px;" src="${attachment.url}"/></div>
															        		<div align="right"><button type="button" class="btn btn-lg" onclick="javascript:deleteAttachments(${attachment.id}, 'pe')">删除</button></div>
																      	</a>
																      	<c:set var="countPe" value="${countPe + 1}"></c:set>
															      	</c:if>
														        </c:forEach>
													        	<a class="thumbnail" style="float: left; height:300px; width: 217px;">
																	<div style="height:270px; width: 217px;"></div>
																	<button type="button" onclick="javascript:addPledge('', '')" class="btn btn-lg">添加</button>
																</a>
														    </div>
					                    				</div>
												    </div>
											    </div>
											    <div class="control-group otherDataGroup">
													<label class="control-label" id="idcardOd"></label>
													<div class="controls">
														<div id="idcardUrl"></div>
												    </div>
											    </div>
											    <div class="control-group otherDataGroup">
													<label class="control-label" id="od"></label>
													<div class="controls">
														<div id="otherData"></div>
												    </div>
											    </div>
											</div>
				                    	</div>
				                  	</div>
				                </div>
				                <div class="accordion-group" id="safety">
					                <div class="accordion-heading">
					                    <a  id="product-introduce-a" href="#safety-info" data-toggle="collapse" data-parent="#product" class="accordion-toggle collapsed" style="text-decoration: none">
					                    	安全保障
					                    </a>
					                </div>
				                  	<div class="accordion-body collapse" id="safety-info">
				                    	<div class="accordion-inner">
				                    		<div class="well" style="padding-bottom: 20px; margin: 0;">
										        <div class="control-group" id="innerContent">
													<label class="control-label"><span class="required">*</span>安全保障</label>
													<div class="controls">
														<textarea cols="80" rows="3" id="assetsSafety" name="productDetail.project.assetsSafety" >${productDetail.project.assetsSafety}</textarea>
													</div>
												</div>
												 <div class="control-group commitmentLetterGroup">
													<label class="control-label" id="cr"></label>
													<div class="controls">
														<div id="commitmentLetter"></div>
												    </div>
											    </div>
												<div class="control-group guaranteeGroup">
													<label class="control-label" id="ge"></label>
													<div class="controls">
													   <div id="guarantee"></div>
													</div> 
												</div>
												<div class="control-group buyBackAttachmentGroup">
													<label class="control-label" id="bt"></label>
													<div class="controls">
													   <div id="buyBackAttachment"></div>
													</div>
												</div>
												<div class="control-group otherDataGroup">
													<label class="control-label" id="projectOd"></label>
													<div class="controls">
														<div id="projectOtherData"></div>
												    </div>
											    </div>
											</div>
				                    	</div>
				                  	</div>
				                </div>
				              </div>
							  <div class="row-fluid">
							  	<div class="span6" align="right">
							  		<button type="submit" id="save" class="btn btn-success btn-lg" >保存</button>
							  		<a class="btn btn-default btn-lg" onclick="quit()">返回</a>
							  		
							  	</div>
							  	<!-- <div class="span3" align="right">s
							  		
							  	</div> -->
							  	<div class="span6" align="left">
							  		<span id="authorityButton">
							  			<a class="btn btn-lg btn-primary" id="136" onclick="audit()">审核</a>
							  		</span>
							  	</div>
							  </div>
						</form>
                    <!-- content end -->
                <!-- </div> -->
            </div>
            <div class="modal hide fade" id="auditDiv" role="dialog" style="margin-top: 200px;width: 500px" >
				<form id="fmg" class="modal-content form-horizontal password-modal" >
					  <div class="modal-header">
				        <h4>产品审核</h4>
				      </div>
				      <div class="input-group span12" id="auditResultGroup">
				      		<div class="control-group">
								<label class="control-label"><span class="required">*</span>审核结果</label>
								<div class="controls">
									<span class="span3">
										<input type="radio" name="type" value="enable"> 通过
									</span>
									<span class="span3">
										<input type="radio" name="type" value="disabled"> 不通过
									</span>
								</div>
							</div>
					  </div>
					<div class="input-group span12" id="auditTypeGroup">
						<div class="control-group">
							<label class="control-label"><span class="required">*</span>上架类型</label>
							<div class="controls">
										<span class="span3">
											<input type="radio" name="type2" value="enable"> 自动上架
										</span>
								<span class="span3">
											<input type="radio" name="type2" value="disabled"> 定时上架
										</span>
							</div>
						</div>
					</div>
				      <div class="input-group span12 shippedTimeGroup">
				      		<div class="control-group">
								<label class="control-label"><span class="required">*</span>上架日期</label>
								<div class="controls">
									<%-- <input type="text" id="shippedTimeDay" name="shippedTime" value="<fmt:formatDate value="${product.shippedTime}" type="both" pattern="yyyy-MM-dd" />" class="validate[required] text-input span6"  onblur="colcDateTime()" onkeypress="return false"/> --%>
									<select id="shippedTimeDay" class="validate[required] span6" >
									<c:forEach items="${dates}" var="dateX">
                                    	<option  value="${dateX}" data="${dateX}" >${dateX}</option>
                                    </c:forEach>
                                    </select>
								</div>
							</div>
					  </div>
					  <div class="input-group span12 shippedTimeGroup">
				      		<div class="control-group">
								<label class="control-label"><span class="required">*</span>上架时间</label>
								<div class="controls">
									<select id="shippedTimeHour" class="validate[required] span3" >
                                    	<option value="00" >00</option>
                                    	<option value="01" >01</option>
                                    	<option value="02" >02</option>
                                    	<option value="03" >03</option>
                                    	<option value="04" >04</option>
                                    	<option value="05" >05</option>
                                    	<option value="06" >06</option>
                                    	<option value="07" >07</option>
                                    	<option value="08" >08</option>
                                    	<option value="09" >09</option>
                                    	<option value="10" >10</option>
                                    	<option value="11" >11</option>
                                    	<option value="12" >12</option>
                                    	<option value="13" >13</option>
                                    	<option value="14" >14</option>
                                    	<option value="15" >15</option>
                                    	<option value="16" >16</option>
                                    	<option value="17" >17</option>
                                    	<option value="18" >18</option>
                                    	<option value="19" >19</option>
                                    	<option value="20" >20</option>
                                    	<option value="21" >21</option>
                                    	<option value="22" >22</option>
                                    	<option value="23" >23</option>
                                    </select>点
                                    <select id="shippedTimeMinute" class="validate[required] span3" >
                                    	<option value="00" >00</option>
                                    	<option value="10" >10</option>
                                    	<option value="20" >20</option>
                                    	<option value="30" >30</option>
                                    	<option value="40" >40</option>
                                    	<option value="50" >50</option>
                                    </select>分
								</div>
							</div>
					  </div>
				      <div class="input-group span12" style="margin-bottom: 10px">
				      	<span class="span12" style="text-align: center;display:block;" >
				      		<a class="btn btn-primary" onclick="setStatus()">确认</a>
				      		<a class="btn btn-default" onclick="quitAuditDiv()">取消</a>
				      	</span>
				      </div>
				</form>		   
			</div>
			<div class="modal hide fade" id="lender" role="dialog" style="top:3%;width: 800px;height:600px;" >
			  	<div class="modal-dialog modal-lg">
			    	<div class="modal-content">
			      		<div class="modal-header">
			        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        			<span aria-hidden="true">&times;</span>
			        		</button>
			        		<h4 class="modal-title" id="myModalLabel">选择借款人</h4>
			      		</div>
			      		<div class="modal-body" style="max-height:480px;">
	                        <table class="table table-striped">
			                	<thead>
			                    	<tr>
		                                <th style="width:100px;">序号</th>
		                                <th style="width:200px;">姓名</th>
		                                <th style="width:200px;">身份证</th>
		                                <th style="width:250px;">借款金额(元)</th>
		                                <th id="financial" style="width:250px;">借款期限(天)</th>
		                                <th style="width:200px;">操作</th>
			                        </tr>
			                   </thead>
			                   <tbody id="lenderBody">
	                     	   </tbody>
	                     	   <tfoot>
	                      	        <tr>
	                      				<td colspan="6">
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
        <div class="popOver" style="width: 100%; height: 100%; position: fixed; z-index: 100000; left:0; top:0; background: #000;opacity: .3; display: none; text-align:center; vertical-align: middle">
        	<img alt="" src="${pageContext.request.contextPath}/images/loading.gif" style=" position: absolute; margin: auto;top: -9999px;right: -9999px;bottom: -9999px;left: -9999px;  ">
        </div>      
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
		<script type="text/javascript">	
		  var len = $("#totals").val();
		  var totals = Number(len);
		  var len = $("#totals").val();
		  var totals = Number(len);
		    var temp = 0;
		    var lenders = eval('(' + '${lenders}' + ')') ;
		    var d = new Date();
		    var totalSubmit = 0;
			var productDesc = '';
			var assetsSafety = '';
			var auditStatus = '';
			var projectType = 0;
			var countLender = lenders.length;
			function deleteAttachments(id, type){
				document.getElementById(id).style.display = 'none';
				document.getElementById(id).parentNode.removeChild(document.getElementById(id));
				if (type == 'pe') {
					peNum--;
				} else if (type == 'se') {
					num--;
				}	
				$('#removeAttachmentIds').val($('#removeAttachmentIds').val()+id+',');
		   }
		    $('#shippedTime').datetimepicker({
				format:'Y-m-d H:i:00',
				minDate:true,
				minTime:true,
				lang:'ch',
				step : 10,
				timepicker:true,
				scrollInput:false,
				onShow:function() {
					if ($('td').hasClass('xdsoft_other_month')) {
						$('td').removeClass('xdsoft_other_month');
					} 
				},
				onSelectDate:function() {
					var beginTime = $('#shippedTime').val();
					var beginDate = new Date(Date.parse(beginTime.replace(/-/g,"/")));
					if($.trim('${systemTime}'.split(" ")[0]) == $.trim(beginTime.split(" ")[0])){
						$('#shippedTime').datetimepicker({
							format:'Y-m-d H:i:00',
							step : 10,
							minDate:beginDate.getFullYear()+'/'+(beginDate.getMonth()+1)+'/'+beginDate.getDate(),
							minTime:beginDate.getHours()+":00",
							lang:'ch',
							timepicker:true,
							onShow:function() {
								if ($('td').hasClass('xdsoft_other_month')) {
									$('td').removeClass('xdsoft_other_month');
								} 
							}
						});
						if(($.trim('${systemTime}').split(" ")[1].split(":")[0] == beginTime.split(" ")[1].split(":")[0])){
							var dateTime =  new Date(Date.parse((beginDate.getFullYear()+'-'+(beginDate.getMonth()+1)+'-'+beginDate.getDate()+" "+fix((parseInt(beginDate.getHours())+1),2)+":00:00").replace(/-/g,"/")));
							$('#shippedTime').val(dateTime.getFullYear()+'-'+(dateTime.getMonth()+1)+'-'+dateTime.getDate()+" "+fix(dateTime.getHours(),2)+":00:00");
						}
					}else{
						$('#datetimepicker4').datetimepicker('reset');
						$('#shippedTime').datetimepicker({
							format:'Y-m-d H:i:00',
							step : 10,
							minDate:'${systemTime}',
							minTime:'00:00',
							lang:'ch',
							timepicker:true,
							onShow:function() {
								if ($('td').hasClass('xdsoft_other_month')) {
									$('td').removeClass('xdsoft_other_month');
								} 
							}
						});
					}
					
				}
			});
			
			$('#interestDate').datetimepicker({
				format:'Y-m-d',
				lang:'ch',
				scrollInput:false,
				timepicker:false
			});
			function checkValue(value){
				
				value=value.replace(/(\s*$)/g,'')
				if(value != ''){
					$("#tempdata").val(-1)
				}else{
					
					$("#tempdata").val(0)
				}
			}
			$('#auditResultGroup').find('input:radio').click(function(){
				if($(this).val() == 'enable'){
                    $('#auditTypeGroup').show();
					$('.shippedTimeGroup').show();
				}
				if($(this).val() == 'disabled'){
                    $('#auditTypeGroup').hide();
					$('.shippedTimeGroup').hide();
				}
			});
			$('#auditResultGroup').find('input:radio').eq(0).trigger('click');

            $('#auditTypeGroup').find('input:radio').click(function(){
                if($(this).val() == 'enable'){
                    $('.shippedTimeGroup').hide();
                }
                if($(this).val() == 'disabled'){
                    $('.shippedTimeGroup').show();
                }
            });
            $('#auditTypeGroup').find('input:radio').eq(0).trigger('click');
			
			var se = 0;
			var num = 0;
			$(function() {
				$('#name').focus();
				if('${registerMsg}' != null && '${registerMsg}' != ''){
					alert('${registerMsg}');
				}
				validationEngine();
				var workImg=document.getElementsByTagName('img'); 
				for(var i=0; i<workImg.length; i++) {
					workImg[i].onclick=ImgShow;
				}
				
				productDesc = UE.getEditor('productDesc');
				assetsSafety = UE.getEditor('assetsSafety');
		        
				$('#bonus').find('option[value="${product.bonus.id}"]').attr('selected','selected');
				showView('');
				$.each('${product.productDetail.protocolIds}'.split(','),function(i,value){
					$('#protocol').find('input:checkbox').each(function(j,element){
						if($(this).attr('value') == value){
							$(this).trigger('click');
						}
					});
				});
				
				/* $.each('${product.productDetail.project.dataAuditing}'.split(','),function(i,value){
					$('#dataAuditingGroup').find('input:checkbox').each(function(j,element){
						if($(this).attr('value') == value){
							$(this).trigger('click');
						}
					});
				});
				$('input[name="dataAuditing"]').attr("disabled","disabled");
				 */
				$('#merchantId').comboSelect();
				showMerchantInfo('${product.merchant.id}');
				showProjectInfo('${product.productDetail.project.id}')
				$('#autoInterestDate').on('click',function(){
					$('#interestDate').blur();
					if($(this).is(':checked') == true){
						$('#interestDate').removeClass('validate[required]');
						$('#dueTime').removeClass('validate[required]');
						$("#interestDate").attr("disabled",true);
						$('#interestDate').val('');
						$('#dueTime').val('');
					}
					if($(this).is(':checked') == false){
						$('#interestDate').addClass('validate[required]');
						$("#interestDate").attr("disabled",false);
					}
				});
				if('${product.interestType}' == 1){
					$('#autoInterestDate').trigger('click');
				}else{
					$('#interestDate').addClass('validate[required]');
					$("#interestDate").attr("disabled",false);
				}
				colcDateTime();
				if('${operation}' == 'edit'){
					$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit()">定期产品管理</a>&nbsp;/&nbsp;定期产品编辑</li>');
					$('#name').focus();
					$('#save').show();
					$('#136').hide();
				}else{
					$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit()">定期产品管理</a>&nbsp;/&nbsp;定期产品查看</li>');
					$('#save').hide();
					if('${product.status}' == 0){
						$('#136').show();
					}else{
						$('#136').hide();
					}
					if($('#bonus').val() > 0){
						detailBonus($('#bonus').val());
					}
					readOnly();
				}
				/* var atr =  eval('${attachments}');
				$.each(atr,function(index,element){
					if(element.category == 6){
						se ++;
						num ++;
					} else if (lement.category == 3) {
						pe++;
						peNum++;
					}
				}); */
				var lenderId = '${lender.id}';
				if (lenderId && lenderId > 0) {
					$.get('${pageContext.request.contextPath}/product/lender/'+ lenderId, function(result){
						if (result) {
							$('#idcardOd').empty().append('身份证照片');
							$('#idcardUrl').empty().append('<a class="thumbnail" style="float: left; height:270px; width: 217px;"><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+result.idcardUrl+'"/></span></a>');
							$('#otherData').empty();
							$(result.attachments).each(function(index,element){
								$('#od').empty().append('其他资料')
								$('#otherData').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" ><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+element.url+'"/></span></a>');
							});
				       }
		           });
				}
			});
			
			function validationEngine(){
				$('#fm').validationEngine('attach', {
			        promptPosition:'bottomLeft',
			        showOneMessage: true,
			        focusFirstField:true,
			        onFieldFailure:function(field){
			        	var focusId = field.attr("id");
			        	var style = $('#'+focusId).parents(".accordion-body").attr('style');
			        	var bclass = $('#'+focusId).parents(".accordion-body").attr('class');
			        	if(style != 'height:auto' && bclass != 'accordion-body collapse in'){
			        		$('#'+focusId).parents(".accordion-body").addClass('in');
			        		$('#'+focusId).parents(".accordion-body").attr({style:"height:auto"});
			        	}
			        
			        },
			        onValidationComplete:function(form, valid){
			        	if(valid && startValidateAndUpload()){
			        		$('.popOver').show();
			        		$('#save').attr('disabled','true');
			        		$('#fm').validationEngine('attach', {binded : false});
			        		/* var val = $("#tempProjectData").val();
							if(val == 1){
								 var proname =  $("#name").val();
								 if(proname !=''){
									var arr =  proname.split(",");
									if(temp < 10 ){
										var pronamefinal = arr[0]+"0"+temp+arr[1];
										$("#name").val(pronamefinal);
									}else{
										var pronamefinal = arr[0]+temp+arr[1];
										$("#name").val(pronamefinal);
									}
								  }
								 temp = 0;
							    } */
							    
			        		productFormSubmit();
			        		
			        	}
			        },
			        scroll: false
			    });
			}
			
			function productFormSubmit(){
				if(auditStatus == 'enable'){
					var type = $('input[name="type2"]:checked').val();
				  if(type == 'disabled'){
		   			 $.post('${pageContext.request.contextPath}/product/register',{productId:'${product.id}'},function(result){
		   				if(result != null && (result.retCode == '00000000' || result.retCode == 'JX900122')){
		   					$('#fm').validationEngine('attach', {binded : false});
		   					$('#fm').submit(); 
		   				}else{
		   					$('#fm').attr('action','${pageContext.request.contextPath}/product/detail/${product.id}/1');
		   					$('#fm').validationEngine('attach', {
		   						binded : false
		   				    });
		   					$('#registerMsg').val('\u4ea7\u54c1\u767b\u8bb0\u5931\u8d25\u002c\u8bf7\u8054\u7cfb\u7ba1\u7406\u5458\u0021');
		   					$('#fm').attr('onsubmit',true);
		   	                $('#fm').submit();
		   					/* $('.popOver').hide();
		   					$('#auditDiv').modal('hide');
		   					validationEngine();
		   					alert('产品登记失败,请联系管理员!');
		   					return ; */
		   				 }
		   			  });
				   }else{
					   $('#fm').submit();
				   }	 
		   		}else{
		   		 	$('#fm').submit();
		   		} 
			}
			
			function quitAuditDiv(){
				$('#auditDiv').modal('hide');
			}
			num = document.getElementsByName('STORAGE').length;
			function addStorage(id, url) {
				if(num >= 4){
					alert("最多只能上传4张图片!");
					return false;
				}
				setAttachmentIds(id);
				$('#storageUpload').empty().append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="storage'+se+'"><div style="height:270px; width: 217px;" id="storage-'+se+'"></div><input id="storage_'+se+'" name="storage'+se+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/></a>');  
			    $('#storage_'+se).trigger('click');
			    se = se+1;
			    num ++;
			};
			
			function delContract(o, id, url){
				deleteAttachment(o, id, url);
			    $('#storage'+o).remove();
			    num --;
			}
			
			var pe = 0;
			var peNum = document.getElementsByName('PLEDGE').length;;
			function addPledge(id, url) {
				if(peNum >= 4){
					alert("最多只能上传4张图片!");
					return false;
				}
				setAttachmentIds(id);
				$('#pledgeUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="pledge'+pe+'"><div style="height:270px; width: 217px;" id="pledge-'+pe+'"></div><input id="pledge_'+pe+'" name="pledge'+pe+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/></</a>');  
			    $('#pledge_'+pe).trigger('click');
			    pe = pe + 1;
			};
			
			function startValidateAndUpload() {
				$.ajaxSettings.async = false;
				var flag = true;
				$.getJSON('${pageContext.request.contextPath}/product/check/name', {
					   id:$('#id').val(), 
					   fieldId:$('#id').val(), 
					   fieldValue: $('#name').val() 
				   }, function(data){
					   if(data && data.length>0 && data[1]){
						   if(flag){
							   if(($('#productCategoryProperty').val() != null && '${product.status}' == 1) && ($('#productCategoryProperty').val() == 'EXPERIENCE' || $('#productCategoryProperty').val() == 'NOVICE')){
								   if('${product.totalAmount}' != '' && $('#totalAmount').val() != ''){
						    			 if(parseFloat('${product.totalAmount}') >= parseFloat($('#totalAmount').val())){
						    				alert("修改后的募集金额不能小于或等于修改前的募集金额");
						    				 flag = false;
						    			 }
						    		}
							   }
						   }
					   	   /* if(flag){
						   		if($('#shippedTime').val() != ''){
									if('${systemTime}' > $('#shippedTime').val()){
										alert("上架时间不能小于当前时间,请修改上架时间!");
										flag = false;
									}
								} 
					   	   } */
					   	   if(flag){
							 if($('#productCategoryProperty').val() != null){
								 if($('#productCategoryProperty').val() == 'EXPERIENCE'){
									 if($.trim($('#totalAmount').val()) != '' && $.trim($('#sLowestMoney').val())!= ''){
										if(parseFloat($.trim($('#totalAmount').val())) % parseFloat($.trim($('#sLowestMoney').val())) != 0){
											alert("募集金额必须是投资金额的整数倍!");
											 flag = false;
										} 
									 }
								 }else{
									 if($.trim($('#totalAmount').val()) != '' && $.trim($('#lowestMoney').val())!= ''){
										if(parseFloat($.trim($('#totalAmount').val())) % parseFloat($.trim($('#lowestMoney').val())) != 0){
											alert("募集金额必须是起投金额的整数倍!");
											 flag = false;
										} 
									 }
								 }
							 }
						 }
						 if(flag){
							 if($('#productCategoryProperty').val() != null && $('#productCategoryProperty').val() != 'COMMON'){
								 if($('#productCategoryProperty').val() == 'EXPERIENCE'){
									 if($('#highestMoney').val() != null && $.trim($('#highestMoney').val()) != '' && $('#sLowestMoney').val() != ''){
										if(parseInt($('#highestMoney').val()) < parseInt($('#sLowestMoney').val())){
											alert("享受金额不能低于投资金额!");
											flag = false;
										}
									 }
								 }else{
									 if($('#highestMoney').val() != null && $.trim($('#highestMoney').val()) != '' && $('#lowestMoney').val() != null){
										if(parseInt($('#highestMoney').val()) < parseInt($('#lowestMoney').val())){
											alert("投资上限不能小于起投金额!");
											flag = false;
										}
									 }
								 }
							 }
						 }
						 if(flag){
							   if($.trim($('#productCategoryProperty').val()) != ''){
								   if(flag){
									    var len = productDesc.getContentLength(false,[]);
									    if(len <= 0){
									    	alert('项目介绍不能为空');
									    	//$('#productDesc').addClass('validate[required]');
									    	flag = false;
									    }else if(len > 10000){
									    	alert('项目介绍字数或内置样式过多，字符数超出限制');
									    	flag = false;
									    }else{
									    	//$('#productDesc').removeClass('validate[required]');
									    }
								   }
							   }
						   }
						   if(flag){
							 if(projectType > 0 && countLender <= 0){
								 alert('请选择债权');
							     flag = false;
							 }
						   }
						   if(flag){
							   $.getJSON('${pageContext.request.contextPath}/product/check/status', {
								   id:$('#id').val(),
								   initStatus:$('#initStatus').val(),
							   }, function(result){
								   if(!result){
									   alert('保存失败，产品被审核!');
									   flag = false;
								   }
							   })
						   }
					   }else{
						   $('#name').focus();
						   alert('【'+$('#name').val()+'】此名称已被使用请重新选择!');
						   flag = false;
					   }
			     });
				 return flag;
			}  
			
			function audit(){
				var  a =  document.getElementsByTagName("input");   
		        for(var   i=0;   i<a.length;   i++)   {   
		           if(a[i].type=="checkbox" || a[i].type=="radio" || a[i].type=="text"){
		        	   a[i].disabled = false;
		           }     
		        }
		        
		        var  b  =  document.getElementsByTagName("select");   
		        for(var i=0; i<b.length; i++)   {   
		              b[i].disabled = false;   
		        }
		        
		        var d = document.getElementsByTagName("button");
		        for   (var   i=0;   i<d.length;   i++)   
		        {   
		              d[i].disabled = false;   
		        }
		        var choosedDate = '${choosedDate}';
		        if (choosedDate) {
			        $('#shippedTimeDay').find('option[value=${choosedDate}]').attr('selected',true);
		        }
		        var choosedHour = '${choosedHour}';
		        if (choosedHour) {
			        $('#shippedTimeHour').find('option[value=${choosedHour}]').attr('selected',true);
		        }
		        var choosedMinute = '${choosedMinute}';
		        if (choosedMinute) {
			        var minute = parseInt('${choosedMinute}');
			        minute = Math.floor(minute/10)*10;
			        $('#shippedTimeMinute').find('option[value='+minute+']').attr('selected',true);
		        }
		        
				$('#auditDiv').modal('show');
			}
			
			function setStatus(){
				var Sstatus = $('#auditResultGroup input[name="type"]:checked').val();
				auditStatus = Sstatus;
				if(auditStatus != 'disabled'){
					var auditShippedTime = $('#shippedTimeDay').val() + " " + $('#shippedTimeHour').val()+':'+$('#shippedTimeMinute').val()+':00';
					var systemTime = new Date(Date.parse('${systemTime}'.replace(/-/g,"/")));
					var auditTime = new Date(Date.parse(auditShippedTime.replace(/-/g,"/")));
					if(parseInt(systemTime.getTime() - auditTime.getTime()) > 0){
						alert("上架时间不能小于当前时间,请修改上架时间审核!");
						return;
					}
					$('#shippedTime').val(auditShippedTime);
				}
				$.getJSON('${pageContext.request.contextPath}/product/check/status', {
			   		id:'${product.id}',
			   		initStatus:'${product.status}'
			  	}, function(result){
			   		if(!result){
				   		alert('审核失败，产品已被审核!');
			   		}else{
			   			if ('enable' == Sstatus) {
				   			$('#productStatue').val('INTHESALE');
			   			} else {
				   			$('#productStatue').val('WAITAUDIT');
			   			}
			   			var type = $('input[name="type2"]:checked').val();
				   		$('#fm').attr('action','${pageContext.request.contextPath}/product/audit/'+type+'/${product.id}/'+Sstatus+'/1');
				   		if(Sstatus == 'disabled'){
			   				$('#fm').validationEngine('detach');
			   			}
				   		$('#fm').submit(); 
			   		}
			  	}) 
			}
			
			function colcDateTime(){
				var proName = $("#tempdata").val();
				
			if(proName === '0'){
				
				var value = $("#financePeriod").val();
				$("#financePerioddata").val(value);
				var value1 = $("#merchantIddata").val();
				var value2 = $("#projectIddata").val();
				var value3 = $("#financePerioddata").val();
				if(value1 == '' | value1 == 'Undefined'){
					value1 = -1
				}
					if((value1 > 0 && value2 > 0) | (value2 > 0) ){
						$.ajax({
							  type: 'POST',
							  url: '${pageContext.request.contextPath}/product/auto/produce/product/name',
							  data: {merchantIdData:value1,projectIdData:value2,financePeriodData:value3},
							  dataType: 'json',
							  success: function(result){
								  var productName = result.name;
								  $("#tempProjectData").val(result.type);
								  $("#productNameTempdata").val(result.productTempName);
								  var val = $("#tempProjectData").val();
									if(val == 1 ){
										 var proname =  $("#productNameTempdata").val();
										 if(proname !=''){
											var arr =  proname.split(",");
											if(totals < 10 ){
												var pronamefinal = arr[0]+"0"+totals+arr[1];
												$("#name").val(pronamefinal);
											}else{
												var pronamefinal = arr[0]+totals+arr[1];
												$("#name").val(pronamefinal);
											}
										  }
									}else{
										 $("#name").val(productName);
									}
							    }
						});
					}
			}
				
				var c_is_checked = $("input[id='autoInterestDate']").is(':checked');
				if($('#financePeriod').val() != '' && $('#interestDate').val() != '' && !c_is_checked){
					  var returnDate = "";
					  if(parseInt($('#financePeriod').val()) >= 0){
						  returnDate = addDate($('#interestDate').val(), $('#financePeriod').val());
						  $('#dueTime').val(returnDate);
						  return;
					  }  
				}
				
				if('${product.interestDate}' != ''){
				  var returnDate = "";
				  if(parseInt('${product.financePeriod}') >= 0){
					  returnDate = addDate('${product.interestDate}', '${product.financePeriod}');
					  $('#dueTime').val(returnDate);
				  }
				}
				
			}   
		
			function addDate(date,num){
				time = date.split(' ')[1];
		   		date = new Date(date.split(' ')[0]).valueOf();
		   		date = date + num * 24 * 60 * 60 * 1000
		   		date = new Date(date);
		   		var month = date.getMonth() + 1;
				if(month.toString().length == 1){
					month='0'+month;
		   		}
				var day = date.getDate();
		   		if(day.toString().length == 1){
			   		day = '0' + day;
		   		}
		   		return date.getFullYear() + "-" + month + "-" + day;
			}
		  
			
			function setImagePreview(fileInput) {
				var urlObj = $('#'+fileInput)[0];
				if(urlObj){
					var suffix = urlObj.files[0].name.split('.').pop().toLowerCase();
					if (suffix == 'png' || suffix == 'jpg') {
						if(urlObj.files[0].size <= (2102957)){
							if(urlObj.files && urlObj.files[0]){
								 var img = $('<img style="height:270px; width: 217px;" src="'+window.URL.createObjectURL(urlObj.files[0])+'">');
					             $('#'+(fileInput.split('_')[0]+'-'+fileInput.split('_')[1])).empty().append( img );
							}
						}else{
							$('#'+fileInput).val('');
			        		   alert('单个图片大小不能超过2M！');
						}
	        		} else {
	        		   $('#'+fileInput).val('');
	        		   alert('请选择建议的图片格式！');
		               return false;
	        		}
				}
				return true;
			}
			
			function showView(ev){
				var label ="${product.category.property}";
				if($(ev).val() != undefined && $(ev).val() !=''){
					label = $(ev).find("option:selected").attr("data");
					var productCategory = $("#category option:selected").text();
					if(productCategory == "新手专享"){
						$("#lowestMoney option:first").prop("selected", 'selected'); 
					}else {
						$("#lowestMoney option:last").prop("selected", 'selected');
					}
				}
				//clearForm('pfm',label);
				$('#introduce').show();
				$('#productCategoryProperty').val(label);
				//$('#sTotalAmountGroup').hide();
				$('#sLowestMoneyGroup').hide();
				$('#highestMoney').removeClass('validate[required,custom[integer],min[1],max[1000000]]');
				$('#highestMoney').removeClass('validate[required,custom[integer],min[1],max[500000]]');
				$('#lowestMoney').removeAttr('name');
				$('#sLowestMoney').removeAttr('name');
				//$('#sDueTimeGroup').hide();
				$('#bonus').attr('disabled', false);
				if(label == 'EXPERIENCE' || label == 'NOVICE'){
					$('#bonus').val(0);
					$('#interestDateGroup').show();
					//$('#sInterestDateGroup').show();
					$('#raisePeriodGroup').hide();
					$('#sRaisePeriodGroup').show();
					$('#highestMoney').attr('disabled', false);
					if(label == 'NOVICE'){
						$('#lowestMoneyGroup').show();
						$('#lowestMoney').attr('name','lowestMoney');
						$('#highestMoney').addClass('validate[required,custom[integer],min[1],max[1000000]]');
						$('#higheLabel').html('<span class="required">*</span> 投资上限');
						$("#remark").val('');	         
					}else{
						$('#lowestMoneyGroup').hide();
						$('#sLowestMoneyGroup').show();
						$('#sLowestMoney').attr('name','lowestMoney');
						$('#highestMoney').addClass('validate[required,custom[integer],min[1],max[500000]]');
						$('#higheLabel').html('<span class="required">*</span> 享受金额');
						$("#remark").val('');	
					}
					//$('#dueTimeGroup').hide();
					$('#bonusGroup').hide();
					$('#refundGroup').show();
					$('#increaseInterestGroup').show();
					//$('#increaseInterest').val('0');
				}else{
					$('#totalAmountGroup').show();
					//$('#sTotalAmountGroup').hide();
					$('#interestDateGroup').show();
					//$('#sInterestDateGroup').hide();
					$('#raisePeriodGroup').show();
					$('#sRaisePeriodGroup').hide();
					$('#lowestMoneyGroup').show();
					$('#lowestMoney').attr('name','lowestMoney');
					$('#higheLabel').empty().append("投资上限");
					if(label == 'ACTIVITY'){
// 						$('#bonus').val(0);
// 						$('#highestMoney').attr('disabled', 'disabled');
// 						$('#higheLabel').html(' 投资上限');
						$('#highestMoney').attr('disabled', 'disabled');
						$('#highestMoney').val('');
					}else{
						$('#highestMoney').attr('disabled', 'disabled');
						$('#highestMoney').val('');
					}
					//$('#dueTimeGroup').show();
					$('#bonusGroup').show();
					$('#refundGroup').show();
					$('#increaseInterestGroup').show();
					$("#remark").val('');
				}
				if(label == 'ACTIVITY'){
					$('#bonus').attr('disabled',true);
				}
				if(label == 'EXPERIENCE' || label == 'NOVICE' ){
					$('#highestMoney').val('${product.highestMoney}');
				}
			}
			
			function showMerchantInfo(merchantId){
				var proName = $("#tempdata").val();
			if(proName === '0'){
				$("#merchantIddata").val(merchantId);
				var value1 = $("#merchantIddata").val();
				var value2 = $("#projectIddata").val();
				var value3 = $("#financePerioddata").val();
					if((value2 > 0 && value3 > 0)){
						$.ajax({
							  type: 'POST',
							  url: '${pageContext.request.contextPath}/product/auto/produce/product/name',
							  data: {merchantIdData:value1,projectIdData:value2,financePeriodData:value3},
							  dataType: 'json',
							  success: function(result){
								  var productName = result.name;
								  $("#tempProjectData").val(result.type);
								  $("#productNameTempdata").val(result.productTempName);
								  var val = $("#tempProjectData").val();
									if(val == 1 ){
										 var proname =  $("#productNameTempdata").val();
										 if(proname !=''){
											var arr =  proname.split(",");
											if(totals < 10 ){
												var pronamefinal = arr[0]+"0"+totals+arr[1];
												$("#name").val(pronamefinal);
											}else{
												var pronamefinal = arr[0]+totals+arr[1];
												$("#name").val(pronamefinal);
											}
										  }
									}else{
										 $("#name").val(productName);
									}
							    }
						});
					}
			}
				$.ajaxSettings.async = false;
				var ls = 0;
				var lp = 0;
				var cr = 0;
				var rd = 0
				if($.trim(merchantId) == ''){
					$('#ls').empty();
					$('#licenses').empty();
					$('#lp').empty();
					$('#legalPersonIdcard').empty();
					$('#rd').empty();
					$('#realDiagram').empty();
					$('#cr').empty();
					$('#commitmentLetter').empty()
					return;
				}
				$.post('${pageContext.request.contextPath}/product/get/merchant/info/'+merchantId,{},function(result){
					if(result != null){
						if(result.license){
							$('#ls').empty().append('营业执照');
							$('#licenses').empty().append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="licenses'+ls+'"><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+result.license+'"/></span></a>');  
							ls++;
						}
						if(result.legalPersonIdcard){
							$('#lp').empty().append('法人身份证');
							$('#legalPersonIdcard').empty().append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="legalPersonIdcard'+lp+'"><span ><img  name="legalPersonIdcard" style="height:270px; width: 217px;" src="'+result.legalPersonIdcard+'"/></span></a>');  
							lp++;
						}
						if(result.realDiagram){
							$('#rd').empty().append('商户实拍图');
							$('#realDiagram').empty().append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="legalPersonIdcard'+lp+'"><span ><img  name="legalPersonIdcard" style="height:270px; width: 217px;" src="'+result.realDiagram+'"/></span></a>');  
							rd++;
						}
						
						$('#cr').empty().append('商户承诺书');
						$('#commitmentLetter').empty();
						$(result.attachments).each(function(index,element){
							$('#commitmentLetter').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="guarantee'+ge+'"><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+element.url+'"/></span></a>');
							cr++;
						});
					}
				});
				
				var workImg=document.getElementsByTagName('img'); 
				for(var i=0; i<workImg.length; i++) {
					workImg[i].onclick=ImgShow;
				}
				$.ajaxSettings.async = true;
			}
			
			function deleteAttachment(divId, id, url){
				setAttachmentIds(id);
				var ind= 'storage'+divId;
				document.getElementById(ind).style.display = 'none';
				document.getElementById(ind).parentNode.removeChild(document.getElementById(ind));
			}
			
			function setAttachmentIds(id){
				if($.trim($('#attachmentIdList').val()) != ''){
					$('#attachmentIdList').val($('#attachmentIdList').val()+',' +id);
				}else{
					$('#attachmentIdList').val(id);
				}
			}
			
			function checkedBoxs(){
				$('#protocol').find('input:checkbox').click(function(){
					if($(this).is(':checked') == false){
						$('#protocol').find('input:checkbox[category='+$(this).attr('category')+']').attr("disabled",false);
					}
					$('#protocol').find('input:checkbox').each(function(i){
						if($(this).is(':checked') == true){
							$('#protocol').find('input:checkbox[category='+$(this).attr('category')+']').attr("disabled",true);
						}
						if($(this).is(':checked')){
							$(this).attr("disabled",false);
						}
					});
				});
			}
			
			function readOnly(){   
		        var  a =  document.getElementsByTagName("input");   
		        for(var   i=0;   i<a.length;   i++)   {   
		           if(a[i].type=="checkbox" || a[i].type=="radio" || a[i].type=="text"){
		        	   a[i].disabled = "disabled";
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
		        
		        var d = document.getElementsByTagName("button");
		        for   (var   i=0;   i<d.length;   i++)   
		        {   
		              d[i].disabled="disabled";   
		        }
		        
		        UE.getEditor('productDesc').addListener("ready", function () {
		        	UE.getEditor('productDesc').setDisabled('fullscreen');
				}); 
		        UE.getEditor('assetsSafety').addListener("ready", function () {
		        	UE.getEditor('assetsSafety').setDisabled('fullscreen');
				}); 
			}
			
			function clearForm(id,label) {
				if(label != '${product.category.property}'){
					var  a =  document.getElementsByTagName("input");   
			        for(var i=0; i<a.length; i++)   {   
			           if(a[i].type=="radio" || a[i].type=="text"){
			        	   if(a[i].id != "name" && a[i].id != "increaseInterest" && a[i].id != "sortNumber" && a[i].id != 'poundage'){
			        		   a[i].value = "";
			        	   }
			           }     
			        }
			        var  b  =  document.getElementsByTagName("select");   
			        for(var i=0; i<b.length; i++)   { 
			        	if(b[i].id != 'category'){
							$('#ls').empty();
							$('#licenses').empty();
							$('#lp').empty();
							$('#legalPersonIdcard').empty();  
							$('#rd').empty();
							$('#realDiagram').empty();  
							$('#lc').empty();
							$('#leasingContract').empty();	
							$('#ge').empty();
							$('#guaranteeImage').empty();
							$('#fundFlowUpload').empty();
							$('#commit').empty();
							$('#pled').empty();
							$('#stora').empty();
							$('#inven').empty();
							$('#attachmentIdList').val('');
							showMerchantInfo('');
							showProjectInfo('');
							var ar =  eval('${attachments}');
							$.each(ar,function(index,element){
								if(element.category == 1 || element.category == 3 || element.category == 4 || element.category == 6){
									setAttachmentIds(element.id);
								}
							});
							$('#protocol').find('input:checkbox').prop('checked', false);
							$('#dataAuditingGroup').find('input:checkbox').prop('checked', false);
							
							/* $('#protocol').find('input:checkbox').each(function(i){
								if($(this).is(':checked')){
									$(this).trigger('click');
								}
							})
							$('#dataAuditingGroup').find('input:checkbox').each(function(i){
								if($(this).is(':checked')){
									$(this).trigger('click');
								}
							});  */
			        	}
			        }
			        
			        var c = document.getElementsByTagName("textarea");
			        for   (var   i=0;   i<c.length;   i++)   
			        {   
			        	if(c[i].id == 'riskWarning'){
			        		$('#riskWarning').val('').val('理财有风险，投资需谨慎。');  
			        	}else{
			        		c[i].value = "";
			        	}
			        }
			        
			        var d = document.getElementsByTagName("button");
			        for   (var   i=0;   i<d.length;   i++)   
			        {   
			        	 d[i].value = "";
			        }
			        
			        UE.getEditor('productDesc').setContent('');
				} 	
			}
			
			function fix(num, length) {
			  return ('' + num).length < length ? ((new Array(length + 1)).join('0') + num).slice(-length) : '' + num;
			}
			
			function detailBonus(id){
				if('${operation}' == 'detail'){
					$('#bonusSelect').empty().append('<a  href="${pageContext.request.contextPath}/bonus/'+id+'/detail/1/15" target="_blank">详情</a>')
				}
			}
			
			function quit() {
				var statue=$('#productStatue').val();
				location.href='${pageContext.request.contextPath}/product/${page}?productStatue='+statue;
		    }
			
			var index = parseInt("${fn:length(lenders)}") + 1;
			var flag = parseInt("${fn:length(lenders)}");
			var totleAmount = ${totleLoanAmount};
			$('#totleAmountDiv').html('借款总金额:'+totleAmount);
			function showLenderDialog(){
				if(projectType <= 0){
					alert('请先选择项目类型为信用贷或抵押贷的项目!');
					return;
				}
				var financePeriod = $('#financePeriod').val();
				if(financePeriod > 0){
					if(flag <= 30){
						getLender(1, category);
						$('#lender').modal('show');
					}else{
						alert('您一次不能添加更多的借款人了!');
					}
				}else{
					alert('请您先填写理财期限!');
				}
			}
			
			function getLender(page){
				var financePeriod = $('#financePeriod').val();
				if(projectType <= 0){
					return;
				}
				$.post('${pageContext.request.contextPath}/client/lender/period/list/'+ page,{"loanPeriod": financePeriod, "projectType" : projectType}, function(result){
					if (result.total > 0) {
						$('#lenderBody').html("");
				       	for (var i = 0; i < result.lenders.length; i++) {
				    		var b = result.lenders[i];
				    	   	$('#lenderBody').append('<tr>');
				    	   	$('#lenderBody').append('<td class="hidden">'+b.id+'</td>');
				    	   	$('#lenderBody').append('<td>'+(i+1)+'</td>');
				    	   	$('#lenderBody').append('<td style="width:20%">'+b.name+'</td>');
				    	   	$('#lenderBody').append('<td style="width:20%">'+ b.idcard.substr(0, 2) + '****' + b.idcard.substr(16)+'</td>');
				    	   	$('#lenderBody').append('<td style="width:20%">'+b.loanAmount+'</td>');
				    	   	if( projectType != 1){
				    		$('#lenderBody').append('<td style="width:20%">'+b.loanPeriod+'</td>');
				    	   	}
				    		$('#lenderBody').append('<td><a href=javascript:choiceLender('+b.id+',"'+$.trim(b.name)+'",'+b.loanAmount+','+b.loanPeriod+',"'+b.idcard+'");>选择</a></td>');
				    	   	$('#lenderBody').append('</tr>');
					   	}
				       	var totalPages = Math.ceil(result.total/30);
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
				            	getLender(page);
				            }  
					    };
						$('#bonus-page').bootstrapPaginator(options);
			       }else{
			    	   $('#lenderBody').html('<tr><td colspan="6">请先添加借款人信息</td></tr>');	
			       }
	           });
			}
			//var temp = 0;
			function choiceLender(lenderId, name, loanAmount, loanPeriod, idcard){
				//temp = temp +1;
				totals = totals + 1;
				 var val = $("#tempProjectData").val();
					if(val == 1){
						 var proname =  $("#productNameTempdata").val();
						 if(proname !=''){
							var arr =  proname.split(",");
							if(totals < 10 ){
								var pronamefinal = arr[0]+"0"+totals+arr[1];
								$("#name").val(pronamefinal);
							}else{
								var pronamefinal = arr[0]+totals+arr[1];
								$("#name").val(pronamefinal);
							}
						  }
					    }
			//	var val = $("#tempProjectData").val();
				if(val == 2){
				$.post('${pageContext.request.contextPath}/client/query/lender/count',{"lenderId": lenderId}, function(result){
					var  value = $("#name").val();
					var idcardData ="";
					if(idcard !="" && idcard.length >=6){
						idcardData = idcard.substring((idcard.length)-6);
			    	}
					if(result.loanCount < 10){
						var finalValue = value + idcardData + "0"+ result.loanCount;
						$("#name").val(finalValue);
					}else{
						var finalValue = value + idcardData + result.loanCount;
						$("#name").val(finalValue);
					}
				});
			}
				if(projectType == 2 && flag > 0){
					alert('此产品不能添加更多的借款人了!');
					return;
				}
				$('#idcardOd').empty();
				$('#idcardUrl').empty();
				$('#otherData').empty();
				$('#od').empty();
				if (projectType == 2) {
					$.get('${pageContext.request.contextPath}/product/lender/'+ lenderId, function(result){
						if (result) {
							$('#idcardOd').empty().append('身份证照片');
							$('#idcardUrl').empty().append('<a class="thumbnail" style="float: left; height:270px; width: 217px;"><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+result.idcardUrl+'"/></span></a>');
							$('#otherData').empty();
							$(result.attachments).each(function(index,element){
								$('#od').empty().append('其他资料')
								$('#otherData').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" ><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+element.url+'"/></span></a>');
							});
				       }
		           });
				}
				if(flag > 0){
					var sign = true;
					$('input[name="lenderIds"]').each(function(){
						if($(this).val() == lenderId){
							//temp = temp - 1;
							totals = totals - 1;
							 var val = $("#tempProjectData").val();
								if(val == 1){
									 var proname =  $("#productNameTempdata").val();
									 if(proname !=''){
										var arr =  proname.split(",");
										if(totals < 10 ){
											var pronamefinal = arr[0]+"0"+totals+arr[1];
											$("#name").val(pronamefinal);
										}else{
											var pronamefinal = arr[0]+totals+arr[1];
											$("#name").val(pronamefinal);
										}
									  }
								    }
							alert("不可以重复添加");
							sign = false;
							return false;
						}
					});
					if(!sign){
						return ;
					}
				}
				if(flag > 30){
					alert('此产品不能添加更多的借款人了!');
					return ;
				}
				totleAmount += loanAmount;
				$('#totalAmount').val(totleAmount);
				if($('#quantity').val() != ''){
					$('#quantity').val(parseInt($('#quantity').val()) + 1);
				}else{
					$('#quantity').val(1);
				}
				//$('#bonus').modal('hide');
				if(projectType == 1 ){
				$('#quantityGroup').append('<tr id="divl'+index+'"><td><input id="lenderIds'+index+'" name="lenderIds"  value="'+lenderId+'" type="hidden" ><span>'+ name +'</span></td><td><span>'+ idcard.substr(0, 2) + "****" + idcard.substr(16) +'</span></td><td><span>'+ loanAmount +'</span></td><td><input type="button" class="btn btn-lg" value ="删除" onclick=remove("divl'+index+'",'+loanAmount+') ></td></tr>');
				}else{
				$('#quantityGroup').append('<tr id="divl'+index+'"><td><input id="lenderIds'+index+'" name="lenderIds"  value="'+lenderId+'" type="hidden" ><span>'+ name +'</span></td><td><span>'+ idcard.substr(0, 2) + "****" + idcard.substr(16) +'</span></td><td><span>'+ loanAmount +'</span></td><td><span>'+ loanPeriod +'</span></td><td><input type="button" class="btn btn-lg" value ="删除" onclick=remove("divl'+index+'",'+loanAmount+') ></td></tr>');
				}
				$('#quantityGroup').append('');
				index++;
				flag++;
				countLender++;
				$('#totleAmountDiv').html('借款总金额:'+totleAmount);
				$('#quantity').blur();
			}
			/*  function checkProName(){
				 var val = $("#tempProjectData").val();
					if(val == 1){
						 var proname =  $("#name").val();
						 if(proname !=''){
							var arr =  proname.split(",");
							var pronamefinal = arr[0]+temp+arr[1];
							$("#name").val(pronamefinal)
						   }
						 temp = 0;
					    }
					$("#fm").submit();
			    } */
			function remove(id, loanAmount){
				//temp = temp - 1;
				totals = totals - 1;
				 var val = $("#tempProjectData").val();
					if(val == 1){
						 var proname =  $("#productNameTempdata").val();
						 if(proname !=''){
							var arr =  proname.split(",");
							if(totals < 10 ){
								var pronamefinal = arr[0]+"0"+totals+arr[1];
								$("#name").val(pronamefinal);
							}else{
								var pronamefinal = arr[0]+totals+arr[1];
								$("#name").val(pronamefinal);
							}
						  }
					    }
				flag --;
				totleAmount -= loanAmount;
				$('#totalAmount').val(totleAmount);
				$('#totleAmountDiv').html('借款总金额:'+totleAmount);
				$('#quantity').val(parseInt($('#quantity').val()) - parseInt(1));
				$('#quantity').blur();
				$('#'+id).remove();
				$('#idcardOd').empty();
				$('#idcardUrl').empty();
				$('#otherData').empty();
				$('#od').empty();
			}
			
			var f = 0;
			function showProjectInfo(projectId){
				var proName = $("#tempdata").val();
			if(proName === '0'){
				$("#projectIddata").val(projectId);
				var value1 = $("#merchantIddata").val();
				var value2 = $("#projectIddata").val();
				var value3 = $("#financePerioddata").val();
				if(value1 == '' | value1 == 'Undefined'){
					value1 = -1
				}
					if((value1 > 0 && value3 > 0) | (value3 > 0)){
						$.ajax({
							  type: 'POST',
							  url: '${pageContext.request.contextPath}/product/auto/produce/product/name',
							  data: {merchantIdData:value1,projectIdData:value2,financePeriodData:value3},
							  dataType: 'json',
							  success: function(result){
								  var productName = result.name;
								  $("#tempProjectData").val(result.type);
								  $("#productNameTempdata").val(result.productTempName);
								  var val = $("#tempProjectData").val();
									if(val == 1 ){
										 var proname =  $("#productNameTempdata").val();
										 if(proname !=''){
											var arr =  proname.split(",");
											if(totals < 10 ){
												var pronamefinal = arr[0]+"0"+totals+arr[1];
												$("#name").val(pronamefinal);
											}else{
												var pronamefinal = arr[0]+totals+arr[1];
												$("#name").val(pronamefinal);
											}
										  }
									}else{
										 $("#name").val(productName);
									}
							    }
						});
					}
			}
				var ge = 0;
				var bt = 0;
				var od = 0;
				$('#idcardOd').empty();
				$('#idcardUrl').empty();
				$('#otherData').empty();
				$('#od').empty();
				if($.trim(projectId) == ''){
					$('#bt').empty();
					$('#buyBackAttachment').empty();
					$('#ge').empty();
					$('#guarantee').empty();
					return;
				}
				$.ajax({
		             type: 'POST',
		             async: false,
		             url: '${pageContext.request.contextPath}/product/get/project/info/'+projectId,
		             data: {},
		             dataType: "json",
		             success: function(result){
		            	 if(result != null && result.project != null){
		            		 projectType = result.project.type;
		            		 if(projectType == 1 ){
		     					$('#financial_th').hide();
		     					$('#financial').hide();
		     					obj  =  document.getElementById("quantityGroup");
		     			        for(i=0;i<obj.rows.length;i++){
		     			           obj.rows[i].cells[3].style.display  =  "none";
		     			        }
		     				 }if(projectType == 2) {
		     					$('#financial_th').show();
		     					$('#financial').show();
		     					obj  =  document.getElementById("quantityGroup");
		     			        for(i=0;i<obj.rows.length;i++){
		     			           obj.rows[i].cells[3].style.display  =  "block";
		     			        }
		     				 }
		            		 $('input[name="dataAuditing"]').each(function(){
								    $(this).removeAttr('disabled');
								    $(this).prop('checked',false);
							 });
	            			 $.each(result.project.dataAuditing.split(','),function(i,value){
	         					$('input[name="dataAuditing"]').each(function(j,element){
	         						if($(this).attr('value') == value){
	         							$(this).prop('checked',true);
	         						}
	         					});
	         				 });
	            			 $('input[name="dataAuditing"]').each(function(){
								 $(this).attr('disabled','disabled');
							 });
	            			 
		            		 if(result.project.type > 0){
		            			 $('.merchantGroup').hide();
		            			 $('.coreEnterpriseGroup').hide();
		            			 $('.lenderGroup').show();
		            			 $('.licensesGroup').hide();
		            			 $('.storageGroup').hide();
		            			 $('.pledgeGroup').hide();
		            			 $('.commitmentLetterGroup').hide();
		            			 $('.guaranteeGroup').hide();
		            			 $('.buyBackAttachmentGroup').hide();
		            			 $('#dataAuditingGroup').show();
		            		 }else{
		            			 $('.merchantGroup').show();
		            			 $('.coreEnterpriseGroup').show();
		            			 $('.licensesGroup').show();
		            			 $('.lenderGroup').hide();
		            			 $('.storageGroup').show();
		            			 $('.pledgeGroup').show();
		            			 $('.commitmentLetterGroup').show();
		            			 $('.guaranteeGroup').show();
		            			 $('.buyBackAttachmentGroup').show();
		            			 $('#dataAuditingGroup').show();
		            		 }
		            		 if(f == 0){
									UE.getEditor('productDesc').addListener("ready", function () {
										UE.getEditor('productDesc').setContent(result.project.introduce);
										UE.getEditor('productDesc').setDisabled('fullscreen');
										f = 1;
									}); 
								}
								if(f == 1){
									UE.getEditor('productDesc').setContent(result.project.introduce);
									UE.getEditor('productDesc').setDisabled('fullscreen');
								}
								$('#coreEnterprise').val(result.project.coreEnterprise);
								$('#fundPurpose').val(result.project.fundPurpose);
								$('#riskWarning').val(result.project.riskWarning);
								$('#assetsSafety').val(result.project.securityDesc);
		            	 }
		            	 if(result != null && result.project != null && result.project.attachments != null){
		            		    $('#projectOd').empty().append('其他资料');
								$('#projectOtherData').empty();
								$(result.project.attachments).each(function(index,element){
									$('#projectOtherData').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="guarantee'+ge+'"><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+element.url+'"/></span></a>');
									od++;
								});
								if(result.project.guaranteeAttachments != null){
									$('#ge').empty().append('担保合同');
									$('#guarantee').empty();
									$(result.project.guaranteeAttachments).each(function(index,element){
										$('#guarantee').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="guarantee'+ge+'"><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+element.url+'"/></span></a>');
										ge++;
									});
								}
							}
		             }
		         });
				
				var workImg=document.getElementsByTagName('img'); 
				for(var i=0; i<workImg.length; i++) {
					workImg[i].onclick=ImgShow;
				}
				
			}
			
			function changeLender(){
				if(projectType == 2){
					index = 1;
					flag = 0;
					totleAmount = 0;
					countLender = 0;
					$('#quantityGroup').empty();
					$('#totleAmountDiv').empty();
				}
			}
			function checkIncreaseInterest(){
				var increaseInterest=$('#increaseInterest').val();
				if(increaseInterest==''){
					$('#increaseInterest').val(0);
				}
			}
			
		   $(function () {
				if('${buttonType}' == "edit"){
				    var timeout=setTimeout(function () {
				    	$("#136").css("visibility","hidden");
				    }, 100);
				}
			}); 
		</script>
	</body>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>