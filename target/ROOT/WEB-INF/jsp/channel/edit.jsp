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
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div class="block-content collapse in">
			                    <form class="form-horizontal" enctype="multipart/form-data" id="fm2" method="post"  action="${pageContext.request.contextPath}/thirdparty/channel/save">
									<div class="well" style="padding-bottom: 20px; margin: 0;">
										<input id="id" name="id" value="${channel.id}" type="hidden">
										<input id="couponId" name="coupon.id" value="${channel.coupon.id}" type="hidden">
				                    	<input name="page" value="${page }" type="hidden">
				                    	<div class="control-group">
											<label class="control-label"><span class="required">*</span> 渠道ID</label>
											<div class="controls"><input type="text" id="id" name="id" value="${channel.id}" readonly class="text-input span2" /></div>
										</div>
				                    	<div class="control-group">
				                    		<label class="control-label"><span class="required">*</span> 渠道类型</label>
				                    		<div class="controls">
												<select id="category" name="category">
											      	<option value="0" >一类渠道</option>
											      	<option value="1" >二类渠道</option>
											      	<option value="2" >三类渠道</option>
												</select>
											</div>
										</div>									
				                    	<div class="control-group">
											<label class="control-label"><span class="required">*</span> 渠道名称</label>
											<div class="controls"><input type="text" id="name" name="name" value="${channel.name}" <c:if test="${channel.name !=null && channel.name!=''}">readonly</c:if> class="validate[required, minSize[4], maxSize[30]] text-input span11" placeholder="不超过30个字符" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
										</div>
										<%-- <div class="control-group">
											<label class="control-label"><span class="required">*</span> 推广地址</label>
											<div class="controls"><input type="text" id="downloadUrl" name="downloadUrl" value="${channel.downloadUrl}" readonly  class="text-input span11" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
										</div> --%>
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 注册地址</label>
											<div class="controls"><input type="text" id="registerUrl" name="registerUrl"  value="${channel.registerUrl}" readonly class="text-input span11" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
										</div>
										<div class="control-group">
											<label class="control-label"><span class="required">*</span> 下载地址</label>
											<div class="controls"><input type="text" id="spreadUrl" name="spreadUrl" value="${channel.spreadUrl}" readonly  class="text-input span11" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/></div>
										</div>
										<div class="control-group">
											<label class="control-label"><span class="required"></span>推广背景图</label>
											<div class="controls" id="bigBackImage">
												<c:if test="${!empty channel.backgroundUrl}">
													<img style="height:200px; width: 600px;" class="thumbnail" id="backUrl" src="${channel.backgroundUrl}"/>
												</c:if>
											</div>
											<div class="control-group">
												<label class="control-label"></label>
												<div class="controls" id="imageBackUpload"><a href="javascript:backReUpload();"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
											</div>
										</div>
										<br>
										<div class="control-group">
											<label class="control-label"><span class="required"></span>Banner图</label>
											<div class="controls" id="bigImage">
												<c:if test="${!empty channel.banner}">
													<img style="height:200px; width: 600px;" class="thumbnail" id="url" src="${channel.banner}"/>
												</c:if>
											</div>
											<div class="control-group">
												<label class="control-label"></label>
												<div class="controls" id="imageUpload"><a href="javascript:reUpload();"><button type="button" class="btn btn-primary">重新上传 </button></a></div>
											</div>
										</div>
										<br>
										<div class="row-fluid">
											<div class="span5">
												<div class="control-group">
													<label class="control-label">按钮背景颜色</label>
													<div class="controls"><input type="text" id="backgroundColor" name="backgroundColor" value="${channel.backgroundColor}" class="text-input span9" /></div>
												</div>
											</div>
											<div class="span5">
												<div class="control-group">
													<label class="control-label">按钮文字颜色</label>
													<div class="controls"><input type="text" id="textColor" name="textColor" value="${channel.textColor}" class="text-input span9" /></div>
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="control-group" id="contentWrap">
												<label class="control-label"><span class="required"></span>活动规则</label>
												<div class="controls">
													<textarea cols="80" id="rule" name="rule">${channel.rule}</textarea>
												</div>
											</div>
										</div>
										<div class="row-fluid">
						      				<div class="control-group" id="forwardCategoryGroup">
												<label class="control-label"><span class="required"></span>立即参与</label>
												<div class="controls">
													<div class="span6">
														<input type="radio" name="forwardCategory" value="0" class="span1" style="margin-top: -1px;margin-left: -7px">
														<span> 跳转至注册 </span>
													</div>
													<div class="span6">
														<input type="radio"  name="forwardCategory" value="1"  class="span1" style="margin-top: -1px">
														<span> 跳转至下载  </span>
													</div>
												</div>
											</div>
						      			</div>
						      			<div class="row-fluid">
						      				<div class="control-group" id="couponGoup">
												<label class="control-label"><span class="required"></span>注册送</label>
												<div class="controls">
													<div class="span6">
														<input type="radio" name="couponId" value="0" class="span1" onclick="showDialog(this.value)" style="margin-top: -1px">
														<span> 红包 </span>
													</div>
													<div class="span6">
														<input type="radio" name="couponId" value="1" class="span1" onclick="showDialog(this.value)" style="margin-top: -1px">
														<span> 加息券</span>
														
													</div>
													<div class="span6">
														<input type="radio" name="couponId" value="2" class="span1" style="margin-left: -20px">
														<span> 无 </span>
													</div>
												</div>
											</div>
						      			</div>
						      			<div class="row-fluid">
						      				<div class="control-group" id="couponGoup">
												<label class="control-label"><span class="required"></span>优惠预览</label>
												<div class="controls">
													<c:if test="${channel.coupon.id > 0}">
														<c:if test="${channel.coupon.category <=  3}">
															<input type="text" id="couponName" value="${channel.coupon.amount}元  ${channel.coupon.condition}" class="text-input span7" readonly/>
														</c:if>
														<c:if test="${channel.coupon.category >  3}">
															<input type="text" id="couponName" value="加息: ${channel.coupon.amount}% ${channel.coupon.increaseDays}天  ${channel.coupon.condition}" class="text-input span7" readonly/>
														</c:if>
													</c:if>
													<c:if test="${channel.coupon.id == 0}">
														<input type="text" id="couponName" value="" class="text-input span7" readonly/>
													</c:if>
												</div>
											</div>
						      			</div>
										<div class="control-group">
											<label class="control-label"></label>
											<div class="controls">
												<button type="button" id="save" class="btn btn-icon btn-primary glyphicons circle_ok"><i></i>保存</button>
												<a type="reset" class="btn btn-icon btn-default glyphicons circle_remove" href="javascript:quit()"><i></i>返回</a>
											</div>
										</div>
									</div>
								</form>
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
					</div>
                </div>
            </div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script type="text/javascript">
		    var index = 0;
		    var rule = '';
		    $(function() {
		    	$('#category').find("option[value='${channel.category}']").attr("selected",true);
		    	$('#save').click(function(){
		    		if($('#name').val()!=''){
		    			if(confirm('渠道名称保存后无法修改，请确认')){
		    				var flag = true;
		    				$.ajaxSettings.async = false;
		    				$.getJSON('${pageContext.request.contextPath}/thirdparty/channel/validate/name', {
		    					   id: $('#id').val(), 
		    					   fieldId:$('#id').val(), 
		    					   fieldValue: $('#name').val()
		    				}, function(data){
		    				   if(data && data.length >0 && data[1]){
		    					   $("#fm2").submit();
		    				   }else{
		    					   $('#name').focus();
		    					   alert('【'+$('#name').val()+'】此渠道名称已被使用请重新选择!');
		    					   flag = false;
		    				   }
		    				});
		    				$.ajaxSettings.async = true;
		    				return flag;
		    			}
		    		} else {
		    			$('#name').focus();
		    		}
		    	});
		    	
		    	$('#startTime').datetimepicker({
					minDate:'',
					minTime:'',
					format:'Y-m-d H:i:s',
					lang:'ch',
					scrollInput:false,
					timepicker:true
				});
		    	rule = UE.getEditor('rule');
		    	$('#fm2').validationEngine('attach', {
			        promptPosition:'bottomLeft',
			        showOneMessage: true,
			        focusFirstField:true,
			        scroll: true
			    });
			    
		        $('#couponGoup').find('input:radio').click(function(){
		        	if($(this).attr('value') <= 1){
		        		$('#couponName').addClass('validate[required]');
		        	}else{
		        		$('#couponName').removeClass('validate[required]');
		        		$('#couponId').val(0);
		        		$('#couponName').val('');
		        	}
		        	
		        });
		        if ('${channel.coupon}' && '${channel.coupon.id}' > 0) {
		        	if($.trim('${channel.coupon.category}') <= 3 && $.trim('${channel.coupon.category}') >= 0){
			        	$('#couponGoup').find('input:radio').eq(0).attr('checked','checked');
			        }else if($.trim('${channel.coupon.category}') == 4){
			        	$('#couponGoup').find('input:radio').eq(1).attr('checked','checked');
			        }
		        } else {
		        	$('#couponGoup').find('input:radio').eq(2).attr('checked','checked');
		        }
		        /* if($.trim('${channel.coupon.category}') <= 3 && $.trim('${channel.coupon.category}') >= 0){
		        	$('#couponGoup').find('input:radio').eq(0).attr('checked','checked');
		        }else if($.trim('${channel.coupon.category}') == 4){
		        	$('#couponGoup').find('input:radio').eq(1).attr('checked','checked');
		        }else{
		        } */
		        
		        if($.trim('${channel.forwardCategory}') == 0){
		        	$('#forwardCategoryGroup').find('input:radio').eq(0).attr('checked','checked');
		        }else if($.trim('${channel.forwardCategory}') == 1){
		        	$('#forwardCategoryGroup').find('input:radio').eq(1).attr('checked','checked');
		        }
		        
			    if('${operation}' == 'edit'){
			    	$('.breadcrumb').html('<li class="active">渠道管理&nbsp;/&nbsp;<a href="javascript:quit();">渠道管理</a>&nbsp;/&nbsp;渠道编辑</li>');
					$('#save').show();
				}else{
					$('.breadcrumb').html('<li class="active">渠道管理&nbsp;/&nbsp;<a href="javascript:quit();">渠道管理</a>&nbsp;/&nbsp;渠道查看</li>');
					$('#save').hide();
					readOnly();
				}
			    
			    if($.trim('${channel.banner}') == ''){  
			    	reUpload()
			    }
			    if($.trim('${channel.backgroundUrl}') == ''){  
			    	backReUpload()
			    }
		   });
		   
	      function showDialog(category){
			  $('#coupon').modal('show');
			  getCoupon(1,category);
		  }
		  
		  function getCoupon(page,category){
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
					    	   var _t = b.condition;
					    	   _t = _t.replace(' ', '');
					    	   $('#couponBody').append('<td><a href=javascript:choiceCoupon('+b.id+',"'+ _t +'"'+','+b.amount+',0'+',0'+');>选择</a></td>');
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
					            	getCoupon(page,category);
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
						   $('#couponBody').html("");
					       for (var i = 0; i < result.bonus.length; i++) {
					    	   var b = result.bonus[i];
					    	   $('#couponBody').append('<tr>');
					    	   $('#couponBody').append('<td class="hidden">'+b.id+'</td>');
					    	   $('#couponBody').append('<td>'+(i+1)+'</td>');
					    	   $('#couponBody').append('<td style="width:45%">'+b.condition+'</td>');
					    	   $('#couponBody').append('<td>'+b.amount+'%</td>');
					    	   $('#couponBody').append('<td>'+b.increaseDays+'天</td>');
					    	   var _t = b.name;
					    	   _t = _t.replace(' ', '');
					    	   $('#couponBody').append('<td><a href=javascript:choiceCoupon('+b.id+',"'+ _t +'"'+','+b.amount+','+b.increaseDays+',1'+');>选择</a></td>');
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
					            	getCoupon(page,category);
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
		  
		    function choiceCoupon(couponId,tempConcent,amount, time, type){
		    	$('#couponId').val(couponId);
		    	if(type == 0){
		    		$('#couponName').val(amount + '元 '+tempConcent);
		    	}
		    	if(type == 1){
		    		$('#couponName').val('加息:' +amount + '% '+time+'天 '+tempConcent);
		    	}
				
				//$('#couponName').val(tempConcent);
				$('#coupon').modal('hide');
			}
			
			function reUpload() {
		    	  if($.trim('${channel.banner}') != ''){
					var name = getFileName('${image.url}');
					name = name ? name : null;
					index++;
					$.post('${pageContext.request.contextPath}/client/merchant/loan/contract/delete', {'name' : name}, function(result){
						document.getElementById('bigImage').innerHTML = '';
						document.getElementById('imageUpload').style.display = 'none';
						document.getElementById('bigImage').innerHTML = '<img id="preview" /><input id="urls" type="file" name="urls" accept="image/jpeg, image/png" onchange="selectFile();" /><span><font style="color:red;">（建议尺寸：750*1334，png或者jpg格式）</font></span>';
					}); 
		    	  }else{
		    		  document.getElementById('bigImage').innerHTML = '';
					  document.getElementById('imageUpload').style.display = 'none';
					  if('${operation}' == 'edit'){
						  document.getElementById('bigImage').innerHTML = '<img id="preview" /><input id="urls" type="file" name="urls" accept="image/jpeg, image/png" onchange="selectFile();" /><span><font style="color:red;">（建议尺寸：750*1334，png或者jpg格式）</font></span>';
					  }

		    	  }
				   	
			   }
			
			function backReUpload() {
	    	  if($.trim('${channel.backgroundUrl}') != ''){
					var name = getFileName('${image.backUrl}');
					name = name ? name : null;
					index++;
					$.post('${pageContext.request.contextPath}/client/merchant/loan/contract/delete', {'name' : name}, function(result){
						document.getElementById('bigBackImage').innerHTML = '';
						document.getElementById('imageBackUpload').style.display = 'none';
						document.getElementById('bigBackImage').innerHTML = '<img id="backPreview" /><input id="backUrls" type="file" name="backUrls" accept="image/jpeg, image/png" onchange="selectBackFile();" /><span><font style="color:red;">（建议尺寸：750*1334，png或者jpg格式）</font></span>';
					}); 
		    	  }else{
		    		  document.getElementById('bigBackImage').innerHTML = '';
					  document.getElementById('imageBackUpload').style.display = 'none';
					  if('${operation}' == 'edit'){
						  document.getElementById('bigBackImage').innerHTML = '<img id="backPreview" /><input id="backUrls" type="file" name="backUrls" accept="image/jpeg, image/png" onchange="selectBackFile();" /><span><font style="color:red;">（建议尺寸：750*1334，png或者jpg格式）</font></span>';
					  }
		    	  }
			   }
			   
			   function getFileName(url){
				   var pos = url.lastIndexOf("/");
				   if(pos == -1){
				     pos = url.lastIndexOf("\\");
				   }
				   return url.substr(pos +1);
			   }
			   
			   function selectFile() {
				   var file = document.getElementById('urls').files[0];
		           if (file) {
		        	   var suffix = file.name.split('.').pop().toLowerCase();
		        	   if (suffix == 'png' || suffix == 'jpg') {
		        		  if (Math.round(file.size * 100 / 1024) / 100 > 2048) {
				           	  alert('亲，图片不能超过2兆');
				        	  $('#urls').val('');
					          return false;
				          }
			        	  $('#preview').css({'display':'block','width':'600px', 'height':'200px'});
						  $('#preview').attr('src', window.URL.createObjectURL(file));
		        		  return true; 
		        	   } else {
		        		   alert('请选择png、jpg的图片！');
		        		   $('#urls').val('');
			               return false;
		        	   }
		           }
			   }
			   
			   function selectBackFile() {
				   var file = document.getElementById('backUrls').files[0];
		           if (file) {
		        	   var suffix = file.name.split('.').pop().toLowerCase();
		        	   if (suffix == 'png' || suffix == 'jpg') {
		        		  if (Math.round(file.size * 100 / 1024) / 100 > 2048) {
				           	  alert('亲，图片不能超过2兆');
				        	  $('#backUrls').val('');
					          return false;
				          }
			        	  $('#backPreview').css({'display':'block','width':'600px', 'height':'200px'});
						  $('#backPreview').attr('src', window.URL.createObjectURL(file));
		        		  return true; 
		        	   } else {
		        		   alert('请选择png、jpg的图片！');
		        		   $('#backUrls').val('');
			               return false;
		        	   }
		           }
			   }
		   
		   function   readOnly()   
			{   
		        var  a =  document.getElementsByTagName("input");   
		        for(var   i=0;   i<a.length;   i++)   {   
		           if(a[i].type=="checkbox" || a[i].type=="radio"){
		        	   a[i].readOnly = true;
		        	   a[i].disabled = "disabled";
		           }
		           if(a[i].type=="text"){
		        	   a[i].readOnly = true; 
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
		        
		        UE.getEditor('rule').addListener("ready", function () {
		        	UE.getEditor('rule').setDisabled('fullscreen');
				});
		        document.getElementById('imageUpload').style.display = 'none';
		        document.getElementById('imageBackUpload').style.display = 'none';
			}
		   
		   function quit() {
			   window.location.href='${pageContext.request.contextPath}/thirdparty/channel/list/1';
		   }
		</script>
	</body>
</html>