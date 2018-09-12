<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			                    <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/product/project/save">
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<input id="id" name="id" value="0" type="hidden">
										<input id="merchantId" name="merchant.id" value="0" type="hidden">
										<div class="row-fluid">
											<div class="control-group" id="projectTypeGroup">
												<label class="control-label"><span class="required">*</span>项目类型</label>
												<div class="controls">
													<span class="span3">
														<input type="radio" name="type" value="0" style="margin-top: -1px"> 供应链
													</span>
													<span class="span3">
														<input type="radio" name="type" value="1" style="margin-top: -1px"> 信用贷
													</span>
													<span class="span3">
														<input type="radio" name="type" value="2" style="margin-top: -1px"> 抵押贷
													</span>
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="control-group">
												<label class="control-label"><span class="required">*</span>项目名称</label>
												<div class="controls"><input type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="40个字符以内" class="validate[required, minSize[1], maxSize[40]] text-input span10" id="name" name="name" /></div>
											</div>
										</div>
										<div class="row-fluid merchantInfoGroup" style="display: none">
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>债权人姓名</label>
													<div class="controls"><input type="text" name="merchant.name" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="20个字符以内" class="validate[required, minSize[1], maxSize[20]] text-input span12" /></div>
												</div>
											</div>
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>身份证号</label>
													<div class="controls"><input type="text" name="merchant.licenseNO" placeholder="15-18位" class="validate[required, minSize[15] maxSize[18]] text-input span12"/></div>
												</div>
											</div>
										</div>
										<div class="row-fluid merchantInfoGroup" style="display: none">
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>手机号</label>
													<div class="controls"><input type="text" name="merchant.cellphone" placeholder="11位数字" class="validate[required, custom[integer] minSize[11] maxSize[11]] text-input span12" /></div>
												</div>
											</div>
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>电子账户</label>
													<div class="controls"><input type="text" name="merchant.accountId" placeholder="19位数字" class="validate[required, custom[integer] minSize[19] maxSize[19]] text-input span12"/></div>
												</div>
											</div>
										</div>
										<div class="row-fluid merchantInfoGroup" style="display: none">
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>提现卡号</label>
													<div class="controls"><input type="text" name="merchant.cardNO" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="16-19位数字" class="validate[required, minSize[16], maxSize[19]] text-input span12" /></div>
												</div>
											</div>
											<div class="span5">
												<label class="control-label"><span class="required">*</span> 所属银行</label>
												<div class="controls">
													<select id="bankNO" name="merchant.bankNO" class="validate[required] span12">
														<option value=""></option>
			                                            <c:forEach items="${unionPayBanks}" var="bank">
				                                            <option value="${bank.bankNO}">${bank.bankName}</option>
			                                            </c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div class="row-fluid merchantInfoGroup" style="display: none">
											<div class="span10">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span> 开户支行名称</label>
													<div class="controls">
														<select id="provinceCode" data-plugin-selectTwo name="merchant.provinceCode" class="provinceCode" >
															<option value="">选择省份</option>
				                                            <c:forEach items="${provinces}" var="province">
					                                            <option value="${province.provinceCode}">${province.province}</option>
				                                            </c:forEach>
														</select>
														<select id="cityCode" data-plugin-selectTwo name="merchant.cityCode" class="provinceCode">
														</select>
														<select id="payVoucher" name="merchant.payVoucher" data-plugin-selectTwo class="payVoucher">
														</select> 
													</div>
												</div> 
											</div>
										</div>
										<div class="row-fluid">
											<div class="control-group">
										       <label class="control-label" style="margin-top: -5px;"><span class="required">*</span>资料审核</label>
										       <div class="controls">
										        	<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="1"> 营业执照
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="2"> 法人代表身份证
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="3"> 银行开户许可证
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="4"> 流水证明
									        		</span>
									        		<br>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="5"> 信用审核
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="6"> 涉诉信息
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="7"> 质押物估值
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="8"> 仓储监管
									        		</span>
									        		<br>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="9"> 担保合同
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="10"> 回购协议
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="11"> 身份证件
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="12"> 银行流水
									        		</span>
									        		<br>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="13"> 收入证明
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="14"> 征信报告
									        		</span>
									        		<span class="span3" style="margin-left:0;">
									        			<input type="checkbox" name="dataAuditing" class="validate[required]" style="margin-top: 0px;" value="15"> 贷款用途
									        		</span>
									           </div>
									        </div>
										</div>
									 	<div class="row-fluid">
											<div class="control-group">
										       <label class="control-label"><span class="required">*</span>项目介绍</label>
										       <div class="controls">
										       	<textarea id="introduce" class="span10" name="introduce" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
									           </div>
									        </div>
									 	</div>
									    <div class="row-fluid coreEnterpriseGroup">
											<div class="control-group">
										       <label class="control-label">核心企业</label>
										       <div class="controls">
										       	<textarea id="coreEnterprise" class="span10 validate[maxSize[500]]" name="coreEnterprise" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
									           </div>
									        </div>
									 	</div>
									 	<div class="row-fluid">
											<div class="control-group securedPartyDescGroup">
										       <label class="control-label">担保方介绍</label>
										       <div class="controls">
										       	<textarea id="securedPartyDesc" class="span10 validate[maxSize[500]]" name="securedPartyDesc" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
									           </div>
									        </div>
									 	</div>
									 	<div class="row-fluid">
											<div class="control-group">
										       <label class="control-label"><span class="required">*</span>资金用途</label>
										       <div class="controls">
										       	<textarea id="fundPurpose" class="span10 validate[required, minSize[1], maxSize[480]]" name="fundPurpose" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
									           </div>
									        </div>
									 	</div>
									 	<div class="row-fluid">
											<div class="control-group">
										       <label class="control-label"><span class="required">*</span>风险提示</label>
										       <div class="controls">
										       	<textarea id="riskWarning" class="span10 validate[required, minSize[1], maxSize[480]]" name="riskWarning" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')">1、信用风险：因其他交易方未按时足额履约导致最终本金和收益变化； 
2、市场风险：项目预期收益受经济、政策因素和交易制度等影响导致收益水平变化。</textarea>
									           </div>
									        </div>
									 	</div>
									 	<div class="row-fluid">
									 		<div class="control-group">
										       <label class="control-label"><span class="required">*</span>安全保障</label>
										       <div class="controls">
										       	<textarea id="securityDesc" class="span10" name="securityDesc" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
									           </div>
									        </div>
									 	</div>
									 	<div class="row-fluid guaranteeGroup">
											<div class="row-fluid">
												<label class="control-label">担保合同</label>
												<div class="controls">
													<div id="guaranteeUpload"></div>
												    <a class="thumbnail" id="addGuaranteeDiv" style="float: left; height:300px; width: 217px;">
														<div style="height:270px; width: 217px;"></div>
														<button type="button" id="addGuarantee" class="btn btn-lg">添加</button>
													</a>
											    </div>
										    </div>
									    </div>
									 	<div class="row-fluid">
		                    				<label class="control-label" id="ge"></label>
											<div class="controls">
												<div id="guaranteeImage"></div>
										    </div>
									    </div>
									 	<div class="row-fluid">
											<div class="row-fluid">
												<label class="control-label">其他资料</label>
												<div class="controls">
													<div id="attachmentUpload"></div>
												    <a class="thumbnail" id="addDiv" style="float: left; height:300px; width: 217px;">
														<div style="height:270px; width: 217px;"></div>
														<button type="button" id="addAttachment" class="btn btn-lg">添加</button>
													</a>
											    </div>
										    </div>
									    </div>
										<div class="form-actions">
											<button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
											<a href="javascript:quit();"><button type="button" class="btn">返回</button></a>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
                </div>
            </div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/js/area.js"></script>
		<script src="${pageContext.request.contextPath}/plugin/select/modernizr.js"></script>
		<script src="${pageContext.request.contextPath}/plugin/select/nanoscroller.js"></script>
		<script src="${pageContext.request.contextPath}/plugin/select/select2.js"></script>
		<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
		<script type="text/javascript">
			var ge1 = 0;
		    var geCount1 = 0;
			$("#addGuarantee").click(function() {
				if(geCount1 <= 4){
					$('#guaranteeUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="guarantee'+ge1+'"><div style="height:270px; width: 217px;" id="guarantee-'+ge1+'"></div><input id="guarantee_'+ge1+'" name="guarantee'+ge1+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delGuarantee1('+ge1+')"/></</a>');  
				    $('#guarantee_'+ge1).trigger('click');
				    ge1 = ge1 + 1;
				    geCount1 = geCount1 + 1;
				    if (geCount1 < 5) {
				    	$('#addGuaranteeDiv').show();
				    } else {
				    	$('#addGuaranteeDiv').hide();
				    }
				}else{
					 alert('担保函数量不超过5张!');
				}
			});
			
			var ge = 0;
		    var geCount = 0;
			$("#addAttachment").click(function() {
				if(geCount <= 10){
					$('#attachmentUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="attachment'+ge+'"><div style="height:270px; width: 217px;" id="attachment-'+ge+'"></div><input id="attachment_'+ge+'" name="otherData'+ge+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delGuarantee('+ge+')"/></</a>');  
				    $('#attachment_'+ge).trigger('click');
				    ge = ge + 1;
				    geCount = geCount + 1;
				    if (geCount < 11) {
				    	$('#addDiv').show();
				    } else {
				    	$('#addDiv').hide();
				    }
				}else{
					 alert('其他资料数量不超过10张!');
				}
			});
			
			$('#projectTypeGroup').find('input:radio').click(function(){
				if($(this).val() == 0){
					$('.merchantInfoGroup').hide();
					$('.coreEnterpriseGroup').show();
					$('.securedPartyDescGroup').show();
					$('.securedPartyDescGroup').show();
					$('.guaranteeGroup').show();
				}
				
				if($(this).val() == 1){
					$('.merchantInfoGroup').show();
					$('.coreEnterpriseGroup').hide();
					$('.securedPartyDescGroup').hide();
					$('.guaranteeGroup').hide();
				}
				
				if($(this).val() == 2){
					$('.merchantInfoGroup').show();
					$('.coreEnterpriseGroup').hide();
					$('.securedPartyDescGroup').hide();
					$('.guaranteeGroup').hide();
				}
			});
			$('#projectTypeGroup').find('input:radio').eq(0).trigger('click');
			
			function delGuarantee1(o){ 
			    $('#guarantee'+o).remove();
			    geCount1 = geCount1 - 1;
		    	$('#addGuaranteeDiv').show();
			}
			
			function delGuarantee(o){ 
			    $('#attachment'+o).remove();
			    geCount = geCount - 1;
		    	$('#addDiv').show();
			}
		
			function setImagePreview(fileInput) {
				var urlObj = $('#'+fileInput)[0];
				if(urlObj){
					var suffix = urlObj.files[0].name.split('.').pop().toLowerCase();
					if (suffix == 'png' || suffix == 'jpg') {
						if(urlObj.files[0].size <= (2102957)){
							if(urlObj.files && urlObj.files[0]){
								 var img = $('<img style="height:270px; width: 217px;" src="'+window.URL.createObjectURL(urlObj.files[0])+'">');
					             $('#'+(fileInput.split('_')[0]+'-'+fileInput.split('_')[1])).empty().append(img);
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
			
			var introduce = '';
			var securityDesc = '';
		    $(function() {
		    	$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">项目管理&nbsp;</a>/&nbsp;项目新增</li>');
		    	$('#fm').validationEngine('attach', { 
			        promptPosition: 'bottomLeft', 
			        scroll: false,
			        showOneMessage : true
			    });
		    	$('#name').focus();
		    	introduce = UE.getEditor('introduce');
		    	securityDesc = UE.getEditor('securityDesc');
		    	$('.provinceCode').css('width', '25%');
				$('.payVoucher').css('width', '48%');
			    $('#provinceCode').change(function() {
					  var code = $('#provinceCode').val();
					  $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/city/' + code, function(result){
						  if (result && result.length > 0) {
					   	    	var html = '<option value="">选择城市</option>';
					   	    	for (var i = 0; i < result.length; i++) {
					   	    		html += '<option value="' + result[i].city + '">' + result[i].city + '</option>';
					   	    	}
					   	    	$('#cityCode').html(html);
					   	    	$('#cityCode').select2('val', '');
					   	    	//$('#cityCode').select2('val', result[0].cityCode);
						  } 
		              });
				   });

				   $('#cityCode').change(function() {
					  var city = $('#cityCode').val();
					  var provinceCode = $('#provinceCode').val();
					  var bankCode = $('#bankNO').val();
					  if (bankCode) {
						  $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode + '/' + bankCode, {'city' : city}, function(result){  
							  if (result && result.length > 0) {
						   	    	var html = '<option value="">选择支行</option>';
						   	    	for (var i = 0; i < result.length; i++) {
						   	    		html += '<option value="' + result[i].payVoucher + '">' + result[i].brabankName + '</option>';
						   	    	}
						   	    	$('#payVoucher').html(html);
						   	    	$('#payVoucher').select2('val', result[0].payVoucher);
							  } else {
								  alert('该城市下暂无支行！');						  
							  }
			              });
					  } else {
						  $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode, {'city' : city}, function(result){  
							  if (result && result.length > 0) {
						   	    	var html = '<option value="">选择支行</option>';
						   	    	for (var i = 0; i < result.length; i++) {
						   	    		html += '<option value="' + result[i].payVoucher + '">' + result[i].brabankName + '</option>';
						   	    	}
						   	    	$('#payVoucher').html(html);
						   	    	//$('#payVoucher').select2('val', result[0].payVoucher);
							  } else {
								  alert('该城市下暂无支行！');						  
							  }
			              });
					  }			  
				   });
				   
				   $('#bankNO').change(function() {
						  var city = $('#cityCode').val();
						  var bankCode = $('#bankNO').val();
						  var provinceCode = $('#provinceCode').val();
						  if (city) {
							  $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode + '/' + bankCode, {'city' : city}, function(result){  
								  if (result && result.length > 0) {
							   	    	var html = '<option value="">选择支行</option>';
							   	    	for (var i = 0; i < result.length; i++) {
							   	    		html += '<option value="' + result[i].payVoucher + '">' + result[i].brabankName + '</option>';
							   	    	}
							   	    	$('#payVoucher').html(html);
							   	    	$('#payVoucher').select2('val', result[0].payVoucher);
								  } else {
									  alert('该城市下暂无支行！');
								  }
				              });
						  }
				   });
		   });
		    
		   
		   function startValidate() {
			    var flag = true;
			    var len = introduce.getContentLength(true,[]);
			    if(len <= 0){
			    	$('#introduce').addClass('validate[required]');
			    }else if(len > 10000){
			    	 alert('项目介绍字数超出限制');
			    	 flag = false;
			    }else{
			    	$('#introduce').removeClass('validate[required]');
			    }
			    
			    var lena = securityDesc.getContentLength(true,[]);
			    if(lena <= 0){
			    	$('#securityDesc').addClass('validate[required]');
			    }else if(lena > 10000){
			    	 alert('安全保障字数超出限制');
			    	 flag = false;
			    }else{
			    	$('#securityDesc').removeClass('validate[required]');
			    }
			   
				return flag;
		   }
		   
		   function quit() {
			   window.location.href='${pageContext.request.contextPath}/product/project/list/1';
		   }
		   
		   var workImg=document.getElementsByTagName('img'); 
		   for(var i=0; i<workImg.length; i++) {
			   workImg[i].onclick=ImgShow;
		   }
		</script>
	</body>
</html>