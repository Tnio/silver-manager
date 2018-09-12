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
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div class="block-content collapse in">
			                    <form class="form-horizontal" enctype="multipart/form-data" id="fm" method="post" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/product/project/save">
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<input id="id" name="id" value="${project.id}" type="hidden">
										<input id="merchantId" name="merchant.id" value="${project.merchant.id }" type="hidden">
										<input id="otherData" name="otherData" value="${project.otherData}" type="hidden">
										<input id="guaranteeAttachment" name="guaranteeAttachment" value="${project.guaranteeAttachment}" type="hidden">
				                    	<input id="address" name="merchant.address" value="" type="hidden">
				                    	<input name="page" value="${page }" type="hidden">
				                    	<input name="size" value="${size }" type="hidden">
				                    	<input name="status" value="0" type="hidden">
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
											<div class="span12">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>项目名称</label>
													<div class="controls"><input type="text" value="${project.name }" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="30个字符以内" class="validate[required, minSize[1], maxSize[30]] text-input span10" id="name" name="name" /></div>
												</div>
											</div>
										</div>
										<div class="row-fluid merchantInfoGroup" style="display: none">
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>债权人姓名</label>
													<div class="controls"><input type="text" name="merchant.name" value="${project.merchant.name }" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="20个字符以内" class="validate[required, minSize[1], maxSize[20]] text-input span12" /></div>
												</div>
											</div>
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>身份证号</label>
													<div class="controls"><input type="text" name="merchant.licenseNO" value="${project.merchant.licenseNO }" placeholder="15-18位" class="validate[required, minSize[15] maxSize[18]] text-input span12"/></div>
												</div>
											</div>
										</div>
										<div class="row-fluid merchantInfoGroup" style="display: none">
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>手机号</label>
													<div class="controls"><input type="text" name="merchant.cellphone" value="${project.merchant.cellphone }" placeholder="11位数字" class="validate[required, custom[integer] minSize[11] maxSize[11]] text-input span12" /></div>
												</div>
											</div>
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>电子账户</label>
													<div class="controls"><input type="text" name="merchant.accountId" value="${project.merchant.accountId }" placeholder="19位数字" class="validate[required, custom[integer] minSize[19] maxSize[19]] text-input span12"/></div>
												</div>
											</div>
										</div>
										<div class="row-fluid merchantInfoGroup" style="display: none">
											<div class="span5">
												<div class="control-group">
													<label class="control-label"><span class="required">*</span>提现卡号</label>
													<div class="controls"><input type="text" name="merchant.cardNO" value="${project.merchant.cardNO }" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" placeholder="16-19位数字" class="validate[required, minSize[16], maxSize[19]] text-input span12" /></div>
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
										<div class="row-fluid" id="dataAuditingGroup">
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
										       	<textarea id="introduce" class="span10"  name="introduce" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')">${project.introduce}</textarea>
									           </div>
									        </div>
									 	</div>
									    <div class="row-fluid coreEnterpriseGroup">
											<div class="control-group">
										       <label class="control-label">核心企业</label>
										       <div class="controls">
										       	<textarea id="coreEnterprise" class="span10 validate[maxSize[500]]" name="coreEnterprise" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')">${project.coreEnterprise}</textarea>
									           </div>
									        </div>
									 	</div>
									 	<div class="row-fluid">
											<div class="control-group securedPartyDescGroup">
										       <label class="control-label">担保方介绍</label>
										       <div class="controls">
										       	<textarea id="securedPartyDesc" class="span10 validate[maxSize[500]]" name="securedPartyDesc" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')">${project.securedPartyDesc}</textarea>
									           </div>
									        </div>
									 	</div>
									 	<div class="row-fluid">
											<div class="control-group">
										       <label class="control-label"><span class="required">*</span>资金用途</label>
										       <div class="controls">
										       	<textarea id="fundPurpose" class="span10 validate[required, minSize[1], maxSize[480]]" name="fundPurpose" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')">${project.fundPurpose}</textarea>
									           </div>
									        </div>
									 	</div>
									 	<div class="row-fluid">
											<div class="control-group">
										       <label class="control-label"><span class="required">*</span>风险提示</label>
										       <div class="controls">
										       	<textarea id="riskWarning" class="span10 validate[required, minSize[1], maxSize[480]]" name="riskWarning" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')">${project.riskWarning}</textarea>
									           </div>
									        </div>
									 	</div>
									 	<div class="row-fluid">
											<div class="control-group">
										       <label class="control-label"><span class="required">*</span>安全保障</label>
										       <div class="controls">
										       	<textarea id="securityDesc" class="span10"  name="securityDesc" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')">${project.securityDesc}</textarea>
									           </div>
									        </div>
									 	</div>
									 	<div class="row-fluid guaranteeGroup">
											<div class="control-group">
												<label class="control-label">担保合同</label>
												<div class="controls">
													<div id="guaranteeUpload">
														<c:forEach items="${project.guaranteeAttachments}" var="attachment">
															<a id="${attachment.id}" class="thumbnail" style="float: left; height:300px; width: 217px;">
												        		<span ><img  name="guaranteeImg" style="height:270px; width: 217px;" src="${attachment.url}"/></span>
												        		<div align="right"><button type="button" class="btn btn-lg" onclick="javascript:deleteGuaranteeAttachment(${attachment.id})">删除</button></div>
													      	</a>
												        </c:forEach>
													</div>
												    <a class="thumbnail" id="addGuaranteeDiv" style="float: left; height:300px; width: 217px;">
														<div style="height:270px; width: 217px;"></div>
														<button type="button" id="addGuarantee" class="btn btn-lg">添加</button>
													</a>
											    </div>
										    </div>
									    </div>
									 	<div class="row-fluid">
											<div class="row-fluid">
												<label class="control-label">其他资料</label>
												<div class="controls">
													<div id="attachmentUpload">
														<c:forEach items="${project.attachments}" var="attachment">
															<a id="${attachment.id}" class="thumbnail" style="float: left; height:300px; width: 217px;">
												        		<span ><img  name="attachmentImg" style="height:270px; width: 217px;" src="${attachment.url}"/></span>
												        		<div align="right"><button type="button" class="btn btn-lg" onclick="javascript:deleteAttachment(${attachment.id})">删除</button></div>
													      	</a>
												        </c:forEach>
													</div>
												    <a class="thumbnail" id="addDiv" style="float: left; height:300px; width: 217px;">
														<div style="height:270px; width: 217px;"></div>
														<button type="button" id="addAttachment" class="btn btn-lg">添加</button>
													</a>
											    </div>
										    </div>
									    </div>
										<div class="form-actions">
											<button id="save" type="submit" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
											<a href="javascript:quit();" class="btn">返回</a>
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
			function deleteAttachment(id, url){
				document.getElementById(id).style.display = 'none';
				document.getElementById(id).parentNode.removeChild(document.getElementById(id));
				geCount = geCount - 1;
				$('#otherData').val($('#otherData').val().replace(id, ''));
		   }
		   function deleteGuaranteeAttachment(id, url){
				document.getElementById(id).style.display = 'none';
				document.getElementById(id).parentNode.removeChild(document.getElementById(id));
				geCount1 = geCount1 - 1;
				$('#guaranteeAttachment').val($('#guaranteeAttachment').val().replace(id, ''));
		   }
		   
		   function delGuarantee1(o){ 
			    $('#guarantee'+o).remove();
			    geCount1 = geCount1 - 1;
		    	$('#addGuaranteeDiv').show();
			}
		   
		    var ge1 = 0;
		    var geCount1 = document.getElementsByName('guaranteeImg').length;
		    if (geCount1 >= 5) {
		    	$('#addGuaranteeDiv').hide();
		    }
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
		    var geCount = document.getElementsByName('attachmentImg').length;
		    if (geCount >= 10) {
		    	$('#addDiv').hide();
		    }
			$("#addAttachment").click(function() {
				if(geCount <= 10){
					$('#attachmentUpload').append('<a class="thumbnail" style="float: left; height:300px; width: 217px;" id="attachment'+ge+'"><div style="height:270px; width: 217px;" id="attachment-'+ge+'"></div><input id="attachment_'+ge+'" name="otherData'+ge+'"type="file" accept="image/*" style="width:163px" onchange="setImagePreview(this.id)"/><input type="button" class="btn btn-lg" value="删除"  onclick="delGuarantee('+ge+')"/></</a>');  
				    $('#attachment_'+ge).trigger('click');
				    ge = ge + 1;
				    geCount = geCount + 1;
				    if (geCount < 10) {
				    	$('#addDiv').show();
				    } else {
				    	$('#addDiv').hide();
				    }
				}else{
					 alert('其他资料数量不超过10张!');
				}
			});
			
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
			
			var introduce = '';
			var securityDesc = '';
		    $(function() {
		    	introduce = UE.getEditor('introduce');
		    	securityDesc = UE.getEditor('securityDesc');
		    	$('#fm').validationEngine('attach', { 
			        promptPosition: 'bottomLeft', 
			        scroll: false,
			        showOneMessage : true
			    });
		    	$('#name').focus();
		    	
		    	$.each('${project.dataAuditing}'.split(','),function(i,value){
					$('#dataAuditingGroup').find('input:checkbox').each(function(j,element){
						if($(this).attr('value') == value){
							$(this).trigger('click');
						}
					});
				});
		    	
		    	$('#projectTypeGroup').find('input:radio').eq('${project.type}').trigger('click');
		    	var projectType = '${project.type}';
				if(projectType == 0){
					$('.merchantInfoGroup').hide();
					$('.coreEnterpriseGroup').show();
					$('.securedPartyDescGroup').show();
					$('.securedPartyDescGroup').show();
					$('.guaranteeGroup').show();
				}
				
				if(projectType == 1){
					$('.merchantInfoGroup').hide();
					$('.coreEnterpriseGroup').hide();
					$('.securedPartyDescGroup').hide();
					$('.guaranteeGroup').hide();
				}
				
				if(projectType == 2){
					$('.merchantInfoGroup').hide();
					$('.coreEnterpriseGroup').hide();
					$('.securedPartyDescGroup').hide();
					$('.guaranteeGroup').hide();
				}
				$('input[name="type"]').attr("disabled","disabled");
				
				$('.provinceCode').css('width', '20%');
				$('.payVoucher').css('width', '42%');
				/* if($.trim('${project.merchant.address}') != null && $.trim('${project.merchant.address}') != ''){
					var province='${fn:split(project.merchant.address, "-")[0]}';
				    $('#province').find("option[value='"+province+"']").attr("selected",true);
				    $("#province").trigger('onchange');
				    var city='${fn:split(merchant.address, "-")[1]}';
				    $('#city').find("option[value='"+city+"']").attr("selected",true);
				    $("#city").trigger('onchange');
				    var county='${fn:split(merchant.address, "-")[2]}';
				    $('#county').find("option[value='"+county+"']").attr("selected",true);
				} */
				
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
						  } 
		              });
				   });
				
				 $('#cityCode').change(function() {
					  var city = $('#cityCode').val();
					  var provinceCode = $('#provinceCode').val();
					  var bankCode = $('#bankNO').val();
					  if (bankCode) {
						  $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode + '/' + bankCode, {'city':city}, function(result){  
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
						  $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode, {'city':city}, function(result){  
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
					  var provinceCode = $('#provinceCode').val();
					  var bankCode = $('#bankNO').val();
					  if (city) {
						  $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode + '/' + bankCode, {'city':city}, function(result){  
							  if (result && result.length > 0) {
						   	    	var html = '<option value="">选择支行</option>';
						   	    	for (var i = 0; i < result.length; i++) {
						   	    		html += '<option value="' + result[i].payVoucher + '">' + result[i].brabankName + '</option>';
						   	    	}
						   	    	$('#payVoucher').html(html);
						   	    	$('#payVoucher').select2('val', result[0].payVoucher);
							  } 
			              });
					  }
			    });
				 
			   var bankNO = '${project.merchant.bankNO}';
			   $('#bankNO').find('option[value='+bankNO+']').attr('selected',true);
			   var provinceCode = '${project.merchant.provinceCode}';
			   $('#provinceCode').find('option[value='+provinceCode+']').attr('selected',true);
			   var city = '${project.merchant.cityCode}';
			   if (provinceCode) {
				   $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/city/' + provinceCode, function(result){
					  if (result && result.length > 0) {
				   	    	var html = '';
				   	    	for (var i = 0; i < result.length; i++) {
				   	    		html += '<option value="' + result[i].city + '">' + result[i].city + '</option>';
				   	    	}
				   	    	$('#cityCode').html(html);
						    $('#cityCode').select2('val', city);
					  } 
	              });
			   }
			   
			   var payVoucher = '${merchant.merchant.payVoucher}';
			   if (city) {
				   var bankCode = '${merchant.bankNO}';
				   var provinceCode = $('#provinceCode').val();
				   $.get('${pageContext.request.contextPath}/client/merchant/loan/bank/voucher/' + provinceCode + '/' + bankCode, {'city':city}, function(result){  
						  if (result && result.length > 0) {
					   	    	var html = '';
					   	    	for (var i = 0; i < result.length; i++) {
					   	    		html += '<option value="' + result[i].payVoucher + '">' + result[i].brabankName + '</option>';
					   	    	}
					   	    	$('#payVoucher').html(html);
					   	    	$('#payVoucher').select2('val', payVoucher);
						  } 
		              });
			   }
			   
			   if('${operation}' == 'edit'){
			    	$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">项目管理&nbsp;</a>/&nbsp;编辑项目</li>');
			        $('#save').show();
			    }else{
				   $('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;<a href="javascript:quit();">项目管理&nbsp;</a>/&nbsp;查看项目</li>');
				   $('#save').hide();
				   readOnly();
				   introduce.addListener('ready',function(){  
					   introduce.setDisabled();  
				   });
				   securityDesc.addListener('ready',function(){  
					   securityDesc.setDisabled();  
				   });
			    }
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
			    
			    var leng = securityDesc.getContentLength(true,[]);
			    if(leng <= 0){
			    	$('#securityDesc').addClass('validate[required]');
			    }else if(leng > 10000){
			    	 alert('项目介绍字数超出限制');
			    	 flag = false;
			    }else{
			    	$('#securityDesc').removeClass('validate[required]');
			    }
			    var address = $('#province').val() + '-' + $('#city').val() + '-' + $('#county').val()
				$('#address').val(address);
				return flag;
		   }
		   
		   function quit() {
			   window.location.href='${pageContext.request.contextPath}/product/project/list/1';
		   }
		   
		   function readOnly() {   
		        var a = document.getElementsByTagName("input");   
		        for(var i=0; i<a.length; i++) {   
		           if(a[i].type=="checkbox" || a[i].type=="text" || a[i].type=="radio"){
		        	   a[i].readOnly = true;
		        	   a[i].disabled = "disbaled";
		           }     
		        }
		        
		        var  b  =  document.getElementsByTagName("select");   
		        for(var i=0; i<b.length; i++) {   
		              b[i].disabled="disabled";   
		        }
		        
		        var c = document.getElementsByTagName("textarea");
		        for (var i=0; i<c.length; i++) {   
		              c[i].disabled="disabled";   
		        }
		        
		        var d = document.getElementsByTagName("button");
		        for (var i=0; i<d.length; i++) {   
		        	d[i].disabled="disabled";   
		        } 
			}
		   
		   var workImg=document.getElementsByTagName('img'); 
		   for(var i=0; i<workImg.length; i++) {
			   workImg[i].onclick=ImgShow;
		   }
		</script>
	</body>
</html>