<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
                    <form class="form-horizontal" style="margin-bottom: 0;" id="fm"  method="post"  enctype="multipart/form-data" action="${pageContext.request.contextPath}/product/save">
						<input id="id" name="id" value="0" type="hidden">
						<input name="actualAmount" value="0" type="hidden">
						<input id="productCategoryProperty" name="category.property" type="hidden" value="">
						<input name="page" value="${page}" type="hidden">
						<input name="size" value="${size}" type="hidden">
						<input name="productName" value="${productName}" type="hidden">
						<input id="productStatue" name="productStatue" value="${productStatue}" type="hidden">
						<input name="productFinancePeriod" value="${financePeriod}" type="hidden">
						<input name="productCategoryId" value="${categoryId}" type="hidden">
						<input name="displayPlatform" value="1,2,3,4" type="hidden">
						<input name="productDetail.protocolIds" value="2,4" type="hidden">
						<input id="projectIddata"  type="hidden">
						<input id="merchantIddata"  type="hidden">
						<input id="financePerioddata"  type="hidden">
						<input id="tempdata"  type="hidden">
						<input id="tempProjectData"  type="hidden" >
						<input id="productNameTempdata"  type="hidden"  >
						<input id="pname"  type="hidden"  >
						<div class="span12" style="margin-left: -2px">
						<div id="product" class="accordion">
			                <div class="accordion-group" id="base">
			                  <div class="accordion-heading">
			                    <a id="product-base-a" href="#product-base" data-parent="#product" data-toggle="collapse" class="accordion-toggle collapsed " style="text-decoration: none">
			                     	 产品基本信息
			                    </a>
			                  </div>
			                  <div class="accordion-body collapse in" id="product-base">
			                    <div class="accordion-inner">
			                    	<div class="well" style="padding-bottom: 20px; margin: 0;">
			                    		<div class="control-group">
											<label class="control-label"><span class="required">*</span> 产品名称</label>
											<div class="controls"><input type="text" id="name" name="name" class="validate[required,maxSize[20],ajax[checkProductName]] text-input span12"  placeholder="不超过10个汉字"  onkeyup="this.value=this.value.replace(/(^\s*)/g,'')"  onblur="checkValue(this.value)"/></div>
										</div>
										<div class="row-fluid">
											<div class="span6">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 产品类型</label>
													<div class="controls">
													    <select id="category"  name="category.id" class="validate[required] span12" onchange="showView(this)">
														    <option></option>
				                                            <c:forEach items="${categorys}" var="category">
					                                            <option value="${category.id}" data="${category.property}" >${category.name}</option>
				                                            </c:forEach>
														</select>
												    </div>
												</div>
												<!-- <div class="dowebok">
												    
												</div> -->
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 服务费</label>
													<div class="controls"><input type="text" id="loanYearIncome" name="loanYearIncome" value="1" class="validate[required,custom[numberSp],min[0.01],max[36]] text-input span11"   onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" placeholder="输入的数字不大于36"/> %</div>
												</div>
												<div class="control-group" id="totalAmountGroup">
													<label class="control-label"><span class="required">*</span> 募集金额</label>
													<div class="controls"><input type="text" id="totalAmount" name="totalAmount"  onfocus="deleteLendermoney()"  class="validate[required,custom[number],min[1],max[99999999]] text-input span11" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" onblur="showLender(0)"/> 元</div>
												</div>
												
												<div class="control-group" style="display: none">
													<label class="control-label"><span class="required">*</span> 上架时间</label>
													<div class="controls"><input type="text" id="shippedTime" name="shippedTime" class="validate[required]  text-input span12" onkeypress="return false"/></div>
												</div>
												<div class="control-group" id="lowestMoneyGroup">
													<label class="control-label"><span class="required">*</span> 起投金额</label>
													<div class="controls">
														<select id="lowestMoney" class="validate[required] span11">
															<option value="100">100</option>
															<option value="200">200</option>
															<option value="500">500</option>
															<option value="1000">1000</option>
														</select> 元
													</div>
												</div>
												<div class="control-group" id="interestDateGroup">
													<label class="control-label"><span class="required">*</span> 起息时间</label>
													<div class="controls">
														<input type="text" id="interestDate"  name ="interestDate" class="validate[] text-input span8" onblur="colcDateTime()" onkeypress="return false"/>
														<input type="checkbox" id="autoInterestDate" name="interestType" class="validate[]" style="margin-top: 0px;" value="1"> T + 1 起息
													</div>
												</div>
												<div class="control-group" id="dueTimeGroup">
													<label class="control-label"><span class="required">*</span> 到期时间</label>
													<div class="controls"><input type="text" id="dueTime" name="dueTime"  class="validate[] text-input span12" placeholder="根据起息时间和理财期限自动计算" disabled="disabled"/></div>
												</div>
												
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 手续费用</label>
													<div class="controls"><input type="text"  class="validate[text-input span12" name="productDetail.poundage" value="无" readonly="readonly"/></div>
												</div>
												<div class="control-group" id="refundGroup">
													<label class="control-label"><span class="required">*</span> 回款方式</label>
													<div class="controls">
														<select id="refund" name="productDetail.refund" class="validate[required] span12">
			                                            	<option value="一次性还本付息">一次性还本付息</option>	
														</select>
													</div>
												</div>
												<!-- <div  class="control-group">
												     <label class="control-label"><span class="required">*</span>是否支持vip加息</label>
												   <div class="controls" style="position: absolute;top:495px" >
												                否<span>&nbsp;&nbsp;</span><input type="radio" name="vipInterest" checked="checked" value="0"/><span>&nbsp;&nbsp;&nbsp;&nbsp;</span> 是<span>&nbsp;&nbsp;</span><input type="radio" name="vipInterest" value="1"/>
												   </div>
												</div> -->
											</div>
											<div class="span6">
											    <div class="control-group">
													<label class="control-label"><span class="required">*</span>选择项目</label>
													<div class="controls">
														<select id="projectId" name="productDetail.project.id" class="validate[required] span12" onchange="showProjectInfo(this.value)">
													        <option></option>
													        <c:forEach items="${projects}" var="project">
					                                            <option value="${project.id}">${project.name}</option>
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
					                                            <option value="${merchant.id}">${merchant.name}</option>
				                                            </c:forEach>
													    </select>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 产品年化收益</label>
													<div class="controls"><input type="text" id="yearIncome" name="yearIncome" class="validate[required,custom[numberSp],min[0.01],max[36]] text-input span11"   onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" placeholder="输入的数字不大于36"/> %</div>
												</div>
												<div class="control-group" id="increaseInterestGroup">
													<label class="control-label">产品加息</label>
													<div class="controls"><input type="text" id="increaseInterest" onblur="checkIncreaseInterest()" name="increaseInterest" class="validate[required,custom[numberSp],min[0],max[20]] text-input span11" onkeyup="this.value=this.value.replace(/^((0{2,})|(\.{0,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" value="0" placeholder="输入的数字不大于 20"/> %</div>
												</div>
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 风险程度</label>
													<div class="controls">
													    <select id="risk" name="productDetail.risk" class="span12" required>
				                                            <option value="低">低</option>
				                                            <option value="很低">很低</option>
				                                            <option value="超低">超低</option>
														</select>
													</div>
												</div>
												<div class="control-group" id="raisePeriodGroup">
													<label class="control-label"><span class="required">*</span> 募集周期</label>
													<div class="controls"><input type="text"  id="raisePeriod" name="raisePeriod" value= "15" onfocus="deleteLender()"  class="validate[required,custom[integer],min[1],max[30]] text-input span11" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()" /> 天</div>
												</div>
												<div class="control-group" id="sRaisePeriodGroup">
													<label class="control-label"><span class="required">*</span> 募集周期</label>
													<div class="controls"><input type="text"  class="validate[text-input span11" value="无限制" disabled="disabled"/> 天</div>
												</div>
											    <div class="control-group" id="highestMoneyGroup">
													<label class="control-label" id="higheLabel"> 投资上限</label>
													<div class="controls">
														<input type="text" id="highestMoney" name="highestMoney" class="text-input span11"/> 元
													</div>
												</div>
							      				<div class="control-group">
													<label class="control-label"><span class="required">*</span> 理财期限</label>
													<div class="controls">
														<input type="text" id="financePeriod" name="financePeriod" class="validate[required,custom[integer],min[1],max[999]] text-input span11"  onfocus="deleteLender()"  onblur="showLenderTime()" onkeypress="changeLender()" onkeyup="this.value=this.value.replace(/^((0{2,})|(0[1|2|3|4|5|6|7|8|9]))/g, '').trim()"/> 天
													</div>
												</div>
												
												<div class="control-group" id="bonusGroup">
													<label class="control-label"><span class="required"></span> 活动优惠</label>
													<div class="controls">
														<select id="bonus" name="bonus.id" class="span12">
														<option value="0" selected="selected">无</option>
			                                            <c:forEach items="${bonus}" var="b">
				                                            <option value="${b.key}">${b.value}</option>
			                                            </c:forEach>
														</select>
														<!-- <span id="bonusSelect">
														</span> -->
													</div>
												</div>
											</div>
										</div>
									    <div class="control-group">
										  <label class="control-label"><span class="required"></span>标签</label>
										  <div class="controls"><input type="text" id="label" name="label" class="validate[maxSize[16] text-input span12"  placeholder="不超过8个汉字" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
									    </div>
									    <div class="control-group">
											<label class="control-label"><span class="required"></span>其他说明</label>
											<div class="controls">
											<textarea  id="remark" name="productDetail.remark" rows="2" class="validate[maxSize[256]] span12" placeholder="最多不能超过256个字符">到期自动打款至存管电子账户，预计1-2个工作日到账。</textarea>
											</div>
										</div>
			                    	</div>
			                    </div>
			                  </div>
			                </div>
			                <div class="accordion-group" id="introduce">
				                <div class="accordion-heading">
				                    <a  id="product-introduce-a" href="#product-introduce" data-toggle="collapse" data-parent="#product" class="accordion-toggle collapsed" style="text-decoration: none">
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
										       	<textarea id="fundPurpose" rows="2" class="validate[required, maxSize[256]] span12" readonly="readonly"></textarea>
									           </div>
									        </div>
											<div class="control-group">
										       <label class="control-label"><span class="required">*</span>风险提示</label>
										       <div class="controls">			
										       	<textarea id="riskWarning" rows="2" class="validate[required, maxSize[256]] span12" readonly="readonly"></textarea>
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
											       <div class="controls">
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
										                                <th style="width:300px;">借款人</th>
										                                <th style="width:300px;">身份证</th>
										                                <th style="width:250px;">借款金额(元)</th>
										                                <th id="financial" style="width:250px;">借款期限(天)</th>
										                                <th style="width:200px;">操作</th>
											                        </tr>
											                   </thead>
											                   <tbody id="quantityGroup"></tbody>
									             			</table>
									             			<label id="totleAmountDiv"></label>
														</div>
													</div>
								      			</div>
			                    			</div>
			                    			<!-- <div class="row-fluid">
								      			<div class="span6">
													<div class="control-group">
														<label class="control-label"><span class="required">*</span>选择借款人</label>
														<div class="controls">
															<input type="text" class="text-input span6" readonly onclick="showLenderDialog(0)"/>
														</div>
													</div>
								      			</div>
								      		</div>
								      		<div class="row-fluid">
								      			<div class="span10">
													<div class="control-group">
														<label class="control-label"><span class="required">*</span>借款人预览</label>
														<table class="table table-striped">
										                	<thead>
										                    	<tr>
									                                <th style="width:200px;">姓名</th>
									                                <th>借款金额</th>
									                                <th>操作</th>
										                        </tr>
										                   </thead>
										                   <tbody id="quantityGroup"></tbody>
								             			</table>
										                <label id="totleAmountDiv"></label>
													</div>
								      			</div>
								      		</div> -->
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
										    	<div class="span12">
										    		<div class="control-group">
														<label class="control-label">物品仓储</label>
														<div class="controls" id="storageUpload"></div>
															<!-- <div ></div> -->
													    <a class="thumbnail" style="float: left; height:300px; width: 217px;">
															<div style="height:270px; width: 217px;"></div>
															<button type="button" id="addStorage" class="btn btn-lg">添加</button>
														</a>
													</div>
												</div>
												<div class="span12">
			                    					<div class="control-group">
				                    					<label class="control-label" id="rd"></label>
														<div class="controls">
															<div id=realDiagram></div>
												      	</div>
			                    					</div>
			                    				</div>
										    </div>
										    <div class="row-fluid pledgeGroup">
										    	<div class="span12">
										    		<div class="control-group">
														<label class="control-label"><span class="required"></span>物品清单</label>
														<div class="controls" id="pledgeUpload"></div>
														<!-- <div id=""></div> -->
													    <a class="thumbnail" style="float: left; height:300px; width: 217px;">
															<div style="height:270px; width: 217px;"></div>
															<button type="button" id="addPledge" class="btn btn-lg">添加</button>
														</a>
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
													<textarea cols="80" rows="3" id="assetsSafety" readonly="readonly"></textarea>
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
						  	</div>
						  	<div class="span6" align="left">
						  		<button  type="reset" class="btn btn-default btn-lg" onclick="quit()">返回</button>	
						  	</div>
						  </div>
						</div>
						</form>
                   
                    <!-- content end -->
                </div>
            </div>
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
	                                <th id="financial_th" style="width:250px;">借款期限(天)</th>
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
        <div class="popOver" style="width: 100%; height: 100%; position: fixed; z-index: 100000; left:0; top:0; background: #000;opacity: .3; display: none; text-align:center; vertical-align: middle">
        	<img alt="" src="${pageContext.request.contextPath}/images/loading.gif" style=" position: absolute; margin: auto;top: -9999px;right: -9999px;bottom: -9999px;left: -9999px;  ">
        </div>      
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
		<script type="text/javascript">
		    var temp = 0;
		    var d = new Date();
		    var totalSubmit = 0;
			var productDesc = '';
			var assetsSafety = '';
			var projectType = 0;
			var countLender = 0;
		    $('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit()">定期产品管理</a>&nbsp;/&nbsp;新增定期产品</li>');
			$('#shippedTime').datetimepicker({
				format:'Y-m-d H:i:00',
				minDate:true,
				minTime:true,
				step : 10,
				lang:'ch',
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
							minDate:d.getFullYear()+'/'+(d.getMonth()+1)+'/'+d.getDate(),
							minTime:d.getHours()+1+":00",
							lang:'ch',
							step : 10,
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
						$('#shippedTime').datetimepicker({
							format:'Y-m-d H:i:00',
							minDate:'${systemTime}',
							minTime:'00:00',
							lang:'ch',
							step : 10,
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
   
			$(function() {
				$('#name').focus();
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
			        		productFormSubmit();
			        	}
			        },
			        scroll: false
			    }); 
				colcDateTime();
				checkedBoxs();
				showView('');
				$('#guaranteeId').trigger('change');
				productDesc = UE.getEditor('productDesc');
				assetsSafety = UE.getEditor('assetsSafety');
				$('#merchantId').comboSelect();
				
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
				$('#autoInterestDate').trigger('click');
			});
			
			function checkValue(value){
				value=value.replace(/(\s*$)/g,'')
				if(value != ''){
					$("#tempdata").val(-1)
				}else{
					$("#tempdata").val(0)
				}
			}
			function productFormSubmit(){
				$('#fm').validationEngine('detach');
				/*  var val = $("#tempProjectData").val();
					if(val == 1){
						 var proname =  $("#productNameTempdata").val();
						 alert(proname)
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
                $('#fm').submit();
			}
			
			var se = 0;
			var num = 0;
			$("#addStorage").click(function(event) {
				if(num >= 4){
					alert("最多只能上传4张图片!");
					return false;
				}
			    //$('#storageUpload').empty().append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="storage'+se+'"><div style="height:270px; width: 217px;" id="storage-'+se+'"></div><input id="storage_'+se+'" name="storage'+se+'" type="file" accept="image/*" style="width:160px" onchange="setImagePreview(this.id)"/></a>');
			    //$('#storageUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="storage'+se+'"><div style="height:270px; width: 217px;" id="storage-'+se+'"></div><input id="storage_'+se+'" name="storage'+se+'" type="file" accept="image/*" style="width:160px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除" onclick="delContract('+se+')"/></a>');
			    $('#storageUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="storage'+se+'"><div style="height:270px; width: 217px;" id="storage-'+se+'"></div><input id="storage_'+se+'" name="storage'+se+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delContract('+se+')"/></</a>');
			    $('#storage_'+se).trigger('click');
			    se = se + 1;
			    num++;
			});
			
			function delContract(o){  
				num--;
			    $('#storage'+o).remove();  
			}
			
			var pe = 0;
			var peNum = 0;
			$("#addPledge").click(function() {
				if(peNum >= 4){
					alert("最多只能上传4张图片!");
					return false;
				}
			    $('#pledgeUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="pledge'+pe+'"><div style="height:270px; width: 217px;" id="pledge-'+pe+'"></div><input id="pledge_'+pe+'" name="pledge'+pe+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delPeContract('+pe+')"/></</a>');  
			    $('#pledge_'+pe).trigger('click');
			    pe = pe + 1; 
			    peNum++;
			});
			
			function delPeContract(o){  
				peNum--;
			    $('#pledge'+o).remove();  
			}
			
			function startValidateAndUpload() {
				var flag = true;
				$.ajaxSettings.async = false; 
				$.getJSON('${pageContext.request.contextPath}/product/check/name', {
				   id: 0, 
				   fieldId: 0, 
				   fieldValue: $('#name').val() 
				}, function(data){
					 if(data && data.length>0 && data[1]){
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
											alert("投资上限不能小于起购金额!");
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
						 /* if(flag){
					    	var countFundFlow = 0;
							$('input[name^="fundFlow"]').each(function(){
								if($(this).val() != ''){
									countFundFlow = countFundFlow + 1;
								}
							});
							if(countFundFlow <= 0){
								alert('商户流水证明不能为空 ');
								flag = false;
							}
					     } */
						 
						 /* if(flag){
					    	var countCommitmentLetter = 0;
							$('input[name^="commitmentLetter"]').each(function(){
								if($(this).val() != ''){
									countCommitmentLetter = countCommitmentLetter + 1;
								}
							});
							if(countCommitmentLetter <= 0){
								alert('商户承诺书不能为空 ');
								flag = false;
							}
					    } */
						 
						/* if(flag){
					    	var countPledge = 0;
							$('input[name^="pledge"]').each(function(){
								if($(this).val() != ''){
									countPledge = countPledge + 1;
								}
							});
							if(countPledge <= 0){
								alert('商户物品清单不能为空 ');
								flag = false;
							}
					    } */
					 }else{
						 $('#name').focus();
						   alert('【'+$('#name').val()+'】此名称已被使用请重新选择!');
						   $.ajaxSettings.async = true;
						   flag = false;
					 }  
				});
				$.ajaxSettings.async = true;
				return flag;
			} 
			
			function colcDateTime(){
			if ($("#financePeriod").val()>0){
			var proName = $("#tempdata").val();
			if(proName == 0){
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
								  var productTempName = result.productTempName;
								  $("#tempProjectData").val(result.type);
								  $("#productNameTempdata").val(result.productTempName);
								  var val = $("#tempProjectData").val();
									if(val == 2 ){
									  $("#pname").val(productName);
									}
									$("#name").val(productName);
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
					  }  
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
				var label ="COMMON";
				if(ev != null && $(ev).val() != undefined && $(ev).val() !=''){
					label = $(ev).find("option:selected").attr("data");
					var productCategory = $("#category option:selected").text();
					if(productCategory == "新手专享"){
						$("#lowestMoney option:first").prop("selected", 'selected'); 
					}else {
						$("#lowestMoney option:last").prop("selected", 'selected');
					}
				}
				$('#productCategoryProperty').val(label);
				//$('#sTotalAmountGroup').hide();
				//$('#sLowestMoneyGroup').hide();
				$('#highestMoney').removeClass('validate[required,custom[integer],min[1],max[10000]]');
				$('#higheLabel').html(' 投资上限');
				$('#highestMoney').removeClass('validate[required,custom[integer],min[1],max[500000]]');
				$('#lowestMoney').removeAttr('name');
				$('#sLowestMoney').removeAttr('name');
				//$('#sDueTimeGroup').hide();
				$('#bonus').attr('disabled', false);
				$('#raisePeriodGroup').show();
				$('#sRaisePeriodGroup').hide();
				if(label == 'EXPERIENCE' || label == 'NOVICE'){
					$('#base').show();
					//$('#introduce').hide();
					//$('#safe').hide();
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
						$('#highestMoney').val(10000);
						$('#higheLabel').html('<span class="required">*</span> 投资上限');
						//$("#remark").val('');	         
					}else{
						$('#lowestMoneyGroup').hide();
						//$('#sLowestMoneyGroup').show();
						$('#sLowestMoney').attr('name','lowestMoney');
						$('#highestMoney').val('');
						$('#highestMoney').addClass('validate[required,custom[integer],min[1],max[500000]]');
						$('#higheLabel').html('<span class="required">*</span> 享受金额');
						//$("#remark").val('');	
					}
					//$('#dueTimeGroup').hide();
					$('#bonusGroup').hide();
					//$('#refundGroup').hide();
					$('#increaseInterestGroup').show();
					$('#increaseInterest').val('0');
				}else{
					$('#base').show();
					$('#introduce').show();
					//$('#safe').show();
					$('#totalAmountGroup').show();
					$('#interestDateGroup').show();
					//$('#sInterestDateGroup').hide();
					$('#raisePeriodGroup').show();
					$('#sRaisePeriodGroup').hide();
					$('#lowestMoneyGroup').show();
					$('#lowestMoney').attr('name','lowestMoney');
					$('#higheLabel').empty().append("投资上限");
					$('#highestMoney').val('');
					if(label == 'ACTIVITY'){
// 						$('#highestMoney').attr('disabled', false);
// 						$('#higheLabel').html('<span class="required">*</span> 投资上限');
// 						$('#highestMoney').addClass('validate[required,custom[integer],min[1],max[1000000]]');
// 						$('#highestMoney').val(10000);
						$('#highestMoney').attr('disabled', 'disabled');
					}else{
						$('#highestMoney').attr('disabled', 'disabled');
					}
					//$('#dueTimeGroup').show();
					$('#bonusGroup').show();
					//$('#refundGroup').hide();
					$('#increaseInterestGroup').show();
					//$("#remark").val('');
				}
				if(label == 'ACTIVITY'){
					$('#bonus').attr('disabled',true);
				}
				if(label == 'EXPERIENCE' || label == 'NOVICE'){
					$('#highestMoney').val('');
				}
			}
			
			function showMerchantInfo(merchantId){
			var proName = $("#tempdata").val();
		    if(proName == 0){
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
							  $("#name").val(productName);
							  $("#tempProjectData").val(result.type)
							  $("#productNameTempdata").val(result.productTempName);
							  var val = $("#tempProjectData").val();
								if(val == 2 ){
								  $("#pname").val(productName);
								}
						    }
					});
				}
		    }	
				var ls = 0;
				var lp = 0;
				var rd = 0;
				var cr = 0;
				if($.trim(merchantId) == ''){
					return;
				}
				$.ajax({
		             type: 'POST',
		             async: false,
		             url: '${pageContext.request.contextPath}/product/get/merchant/info/'+merchantId,
		             data: {},
		             dataType: "json",
		             success: function(result){
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
		             }
		         });
				var workImg=document.getElementsByTagName('img'); 
				for(var i=0; i<workImg.length; i++) {
					workImg[i].onclick=ImgShow;
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
			
			
			function fix(num, length) {
			  return ('' + num).length < length ? ((new Array(length + 1)).join('0') + num).slice(-length) : '' + num;
			}
			
			function quit() {
				window.location.href='${pageContext.request.contextPath}/product/1';
		    }
			
			var index = 1;
			var flag = 0;
			var totleAmount = 0;
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
				if(projectType==1){
					$('#financial_th').hide();
					$('#financial').hide();
				}else{
					$('#financial_th').show();
					$('#financial').show();
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
				    	   	if(projectType != 1){
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
			var tempindex = 0;
			function choiceLender(lenderId, name, loanAmount, loanPeriod, idcard){
				temp = temp +1;
				 var val = $("#tempProjectData").val();
					if(val == 1){
						 var proname =  $("#productNameTempdata").val();
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
					    }
				//var val = $("#tempProjectData").val();
				if(val == 2 && flag <= 0){
				$.post('${pageContext.request.contextPath}/client/query/lender/count',{"lenderId": lenderId}, function(result){
					var  value = $("#name").val();
					var idcardData ="";
					if(idcard !="" && idcard.length >=6){
						idcardData = idcard.substring((idcard.length)-6);
			    	}
					tempindex=result.loanCount;
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
							temp = temp - 1;
							 var val = $("#tempProjectData").val();
								if(val == 1){
									 var proname =  $("#productNameTempdata").val();
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
				if (projectType == 1){
					$('#quantityGroup').append('<tr id="divl'+index+'"><td><input id="lenderIds'+index+'" name="lenderIds"  value="'+lenderId+'" type="hidden" ><span>'+ name +'</span></td><td><span>'+ idcard.substr(0, 2) + "****" + idcard.substr(16) +'</span></td><td><span>'+ loanAmount +'</span></td><td><input type="button" class="btn btn-lg" value ="删除" onclick=remove("divl'+index+'",'+loanAmount+') ></td></tr>');
				} else {
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
				temp = temp - 1;
				 var val = $("#tempProjectData").val();
					if(val == 1){
						 var proname =  $("#productNameTempdata").val();
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
					    }else if(val == 2){
					    	var pname = $("#pname").val();
					    	$("#name").val(pname);
					    }
				flag --;
				totleAmount -= loanAmount;
				countLender--;
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
				index=1;
				count=0;
				indextemp=1;
			  var proName = $("#tempdata").val();
			  if(proName == 0){
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
								  $("#name").val(productName);
								  $("#tempProjectData").val(result.type);
								  $("#productNameTempdata").val(result.productTempName);
								  var val = $("#tempProjectData").val();
									if(val == 2 ){
									  $("#pname").val(productName);
									}
							    }
						});
					}
			  }	
				var ge = 0;
				var bt = 0;
				var od = 0;
				if($.trim(projectId) == ''){
					return;
				}
				$('#idcardOd').empty();
				$('#idcardUrl').empty();
				$('#otherData').empty();
				$('#od').empty();
				index = 1;
				flag = 0;
				totleAmount = 0;
				countLender = 0;
				$('#quantityGroup').empty();
				$('#totleAmountDiv').empty();
				$.ajax({
		             type: 'POST',
		             async: false,
		             url: '${pageContext.request.contextPath}/product/get/project/info/'+projectId,
		             data: {},
		             dataType: "json",
		             success: function(result){
		            	 if(result != null && result.project != null){
		            		 projectType = result.project.type;
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
		            	 }
		            	 if(result != null && result.project != null){
		            		$('#coreEnterprise').val(result.project.coreEnterprise);
							$('#fundPurpose').val(result.project.fundPurpose);
							$('#riskWarning').val(result.project.riskWarning);
							UE.getEditor('productDesc').setContent(result.project.introduce);
							UE.getEditor('productDesc').setDisabled('fullscreen');
							UE.getEditor('assetsSafety').setContent(result.project.securityDesc);
							UE.getEditor('assetsSafety').setDisabled('fullscreen');
		            	 }
		            	 if(result != null && result.project != null && result.project.attachments != null){
		            		    $('#projectOd').empty().append('其他资料');
								$('#projectOtherData').empty();
								$(result.project.attachments).each(function(index,element){
									$('#projectOtherData').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="guarantee'+ge+'"><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+element.url+'"/></span></a>');
									od++;
								});
								/* $('#bt').empty().append('回购协议');
								$('#buyBackAttachment').empty();
								$(result.project.attachments).each(function(index,element){
									$('#buyBackAttachment').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="guarantee'+ge+'"><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+element.url+'"/></span></a>');
									bt++;
								}); */
								
						}
						 if(result != null && result.project != null && result.project.guaranteeAttachments != null){
							$('#ge').empty().append('担保合同');
							$('#guarantee').empty();
							$(result.project.guaranteeAttachments).each(function(index,element){
								$('#guarantee').append('<a class="thumbnail" style="float: left; height:270px; width: 217px;" id="guarantee'+ge+'"><span ><img  name="licenses" style="height:270px; width: 217px;" src="'+element.url+'"/></span></a>');
								ge++;
							});
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
			$(function() {
				$('#financePeriod').blur(showLender(0));
			})
			
			function showLender(){
				if($('#totalAmount').val()>0 && $('#financePeriod').val()>0){
				var financePeriod = $('#financePeriod').val();
				if(financePeriod > 0){
					if(flag <= 30){
						getLender(1, category);
						getFirstLender(1, category);
						}
				   }
				}
			}
			function getFirstLender(page){
				var financePeriod = $('#financePeriod').val();
				if(projectType <= 0){
					return;
				}
				$.post('${pageContext.request.contextPath}/client/lender/period/list/'+ page,{"loanPeriod": financePeriod, "projectType" : projectType}, function(result){
					if (result.total > 0) {
						var money=$("#totalAmount").val();
						//alert(projectType);
						if(projectType == 2){
						var b=result.lenders[0];
						choiceLender(b.id,$.trim(b.name),b.loanAmount,b.loanPeriod,b.idcard);
						}else{
							for(var i=0;i<=result.total-1; i++ ){
								money -=result.lenders[i].loanAmount; 
								if(money >= 0){
								 choiceLender(result.lenders[i].id,$.trim(result.lenders[i].name),result.lenders[i].loanAmount,result.lenders[i].loanPeriod,result.lenders[i].idcard);
								}else{
									return;
								}
							}
						}
					    }
					});
			}
		   var count =0;
		   var indextemp=1;
		   function deleteLender(){
			    
				if(projectType==1){
				    if($("#quantityGroup").find("tr").length>0){
				    	var length=$("#quantityGroup").find("tr").length;
				    	for(var index=1 ; index<=length ;index++ ){
				    		var money=$("#totalAmount").val();
				    		remove('divl'+(count+index),money); 
				    	}
				    		$("#totalAmount").attr("value",0);
				    		count+=length;
				    		
				    } 
				}
				if(projectType==2){
					if($("#quantityGroup").find("tr").length>0){
						//alert(indextemp);
						remove('divl'+indextemp,$("#totalAmount").val());
						indextemp++;
				    	$("#totalAmount").attr("value",0);
					}
				}
				
			}
		    function deleteLendermoney(){
				colcDateTime();
				deleteLender();
				if(projectType==2){
				  var options=$("#projectId option:selected");
				  //alert( options.text() );
				  var str=$("#name").val(); 
				  //alert((tempindex+"").length);
				  if(tempindex>=100 && tempindex<1000){
				  $("#name").val(str.substring(0,str.length-9));					  
				  }
				  if(tempindex>=1000 && tempindex<10000){
				  $("#name").val(str.substring(0,str.length-10));					  					  
				  }
				  if(tempindex<100){
				  $("#name").val(str.substring(0,str.length-8));					  					  
				  }
				}
			}
		    function showLenderTime(){
		    	colcDateTime();
		    	showLender(0);
		    }
		    function checkIncreaseInterest(){
				var increaseInterest=$('#increaseInterest').val();
				if(increaseInterest==''){
					$('#increaseInterest').val(0);
				}
			}
         
		   
		</script>
	</body>
</html>