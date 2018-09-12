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
                <div class="span10">
                    <!-- content begin -->
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div class="block-content collapse in">
	                            <form id="fm" action="${pageContext.request.contextPath}/message/save" method="post" class="form-horizontal" onsubmit="return validate()" >
								<div class="well" style="padding-bottom: 20px; margin: 0;">
									<div class="control-group">
										<input id="id" name="id" value="${message.id}" type="hidden">
										<input name="page" value="${page}" type="hidden">
		                    			<input name="size" value="${size}" type="hidden">
		                    			<input name="beginTime" value="${beginTime}" type="hidden">
		                    			<input name="endTime" value="${endTime}" type="hidden">
		                    		</div>
			                    	<div class="control-group">
										<label class="control-label"><span class="required">*</span>推送标题</label>
										<div class="controls">
											<input type="text" id="title" name="title" class="validate[required] text-input span3" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
										</div>
									</div>
									<!-- <div class="control-group">
										<label class="control-label"><span class="required">*</span>内容简介</label>
										<div class="controls">
											<input type="text" id="content" name="content" class="validate[required] text-input span3 content" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
										</div>
									</div> -->
									<div class="control-group">
										<label class="control-label"><span class="required">*</span>内容简介</label>
										<div class="controls">
										<textarea  id="content" name="content" rows="2" class="validate[required,minSize[6],maxSize[200]] span6" placeholder="最多不能超过200个字符"></textarea>
										</div>
									</div>
									<div class="control-group" id="pushType">
										<label class="control-label">推送类型</label>
										<div class="controls">
											<div class="row-fluid">
												<div class="span2">
													<input type="radio" name="pushType" value="0" class="validate[required] radio span4">
													<span>无</span>
												</div>
												<div class="span2">
													<input type="radio" name="pushType" value="1" class="validate[required] radio span4">
													<span>理财产品</span>
												</div>
												<div class="span2">
													<input type="radio" name="pushType" value="2" class="validate[required] radio span4">
													<span>新闻素材</span>
												</div>
											</div>
										</div>
									</div>
									<div class="control-group" id="product">
										<label class="control-label">产品名称</label>
										<div class="controls">
											<div class="row-fluid">
												<div class="span2">
										            <span id="productName" name="productName" style="height:30px; line-height:30px"></span>
										            <input type="hidden" id="productId" name="productId" value="0">	
										        </div>
										     </div>
										</div>
									</div>
									<div class="control-group" id="news">
										<label class="control-label">新闻素材</label>
										<div class="controls">
											<div class="row-fluid">
									            <input type="text" id="newsTitle" class="text-input span5" readonly onclick="showNewsDialog()"/>
												<input type="hidden" id="newsId" name="newsId" value="0">	
									            <a type="button" class="btn btn-icon btn-default" href="javascript:preview();">预览</a>
										     </div>
										</div>
									</div>
									<div class="control-group" id="osType">
										<label class="control-label">选择系统</label>
										<div class="controls">
											<div class="row-fluid">
												<div class="span2">
													<input type="radio" name="osType" value="0" class="validate[required] radio span4">
													<span>全部</span>
												</div>
												<div class="span2">
													<input type="radio" name="osType" value="1" class="validate[required] radio span4">
													<span>ANDROID</span>
												</div>
												<div class="span2">
													<input type="radio" name="osType" value="2" class="validate[required] radio span4">
													<span>IOS</span>
												</div>
											</div>
										</div>
									</div>
									<div class="control-group" id="sendType" >
										<label class="control-label">发送类型</label>
										<div class="controls">
											<div class="row-fluid">
												<div class="span2">
													<input type="radio" name="sendType" value="0" class="validate[required] radio span4">
													<span>立即发送</span>
												</div>
												<div class="span2">
													<input type="radio" name="sendType" value="1" class="validate[required] radio span4">
													<span>定时发送</span>
												</div>
												<div class="span2 sendTime">
												    <input type="text" id="sendTime" name="sendTime" class="validate[] span3" />
												</div>
											</div>
										</div>
									</div>
									<div class="control-group" id="sendTarget">
										<label class="control-label">发送对象</label>
										<div class="controls">
											<div class="row-fluid">
												<div class="span2">
													<input type="radio" name="sendTarget" value="0" class="validate[required] radio span4">
													<span>全部人员</span>
												</div>
												<div class="span2">
													<input type="radio" name="sendTarget" value="1" class="validate[required] radio span4">
													<span>指定人员</span>
												</div>		
											</div>
										</div>
									</div>
									<div class="control-group" id="equipmentbox">
										<label class="control-label"><span class="required">*</span>设备号<br><span style="color:red"></span></label>
										<div class="controls">
											 <textarea id="equipment" name="equipment" rows="5" placeholder="多个设备号之间以    ; 区分">${message.equipment}</textarea>
	                                	</div>
									</div>
									<hr class="separator" />
									<div class="form-actions">
										<button type="submit" id="save" class="btn btn-icon btn-primary glyphicons circle_ok" ><i></i>保存</button>
										<a type="reset" id="reset" class="btn btn-icon btn-default glyphicons circle_remove" href="javascript:quit();"><i></i>返回</a>
									</div>
								</div>
							</form>
                            </div>
                        </div>
                        <!-- /block -->
                    </div>
                    <!-- content end -->
                </div>
            </div>
        </div>
        <div class="modal hide fade" id="productList" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
		  	<div class="modal-dialog modal-lg">
		    	<div class="modal-content">
		      		<div class="modal-header">
		        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        		<h4 class="modal-title" id="myModalLabel">产品列表</h4>
		      		</div>
		      		<div class="modal-body">
		      			<div class="navbar-inner block-header modal-header">
	                   		<div id="productForm" class="input-group pull-left form-search">
	                       		<span>产品名称</span>
	                           	<input class="horizontal" id="productSearchName" type="text" />
	                         	<input type="submit" value="查询" onclick="search()" class="btn btn-default" />
	                       	</div>
                    	</div>
		      			<table id="products" cellpadding="0" cellspacing="0" border="0" class="table table-striped">
		                	<thead>
		                    	<tr>
	                                <th>序号</th>
	                                <th>产品名称</th>
	                                <th>年化收益</th>
	                                <th>募集金额</th>
	                                <th>理财期限</th>
	                                <th>状态</th>
	                                <th>操作</th>
		                        </tr>
		                   </thead>
		                   <tbody id="productBody">   
                     	   </tbody>
                     	   <tfoot>
                      	       <tr>
                      		       <td colspan="8"><div id="product-page"></div></td>
                      		   </tr>
                      	   </tfoot>
             			</table>
		      		</div>
		      		<div class="modal-footer">
		        	</div>
		    	</div>
		    </div>
		</div> 
		<div class="modal hide fade" id="newsList" role="dialog" >
		  	<div class="modal-dialog modal-lg">
		    	<div class="modal-content">
		      		<div class="modal-header">
		        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		        			<span aria-hidden="true">&times;</span>
		        		</button>
		        		<h4 class="modal-title" id="myModalLabel">选择新闻</h4>
		      		</div>
		      		<div class="modal-body">
                        <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
		                	<thead>
		                    	<tr>
	                                <th>序号</th>
	                                <th>新闻标题</th>
	                                <th>操作</th>
		                        </tr>
		                   </thead>
		                   <tbody id="newsBody">
                     	   </tbody>
                     	   <tfoot>
                      	        <tr>
                      				<td colspan="3">
                      					<div id="news-page"></div>
                      				</td>
                      			</tr>
                      		</tfoot>
             			</table>
		      		</div>
		    	</div>
		    </div>
		</div> 
		<div class="modal hide fade" id="preview" role="dialog" style="width:320px;height:568px;">
		  	<div class="modal-dialog modal-lg">
		    	<div class="modal-content">
		      		<div class="modal-header">
		        		<a type="button" class="close" data-dismiss="modal" aria-label="Close">
		        			<span aria-hidden="true">&times;</span>
		        		</a>
		        		<h3 id="news_title"></h3>
		      		</div>
		      		<div class="modal-body" id="news_content" style="padding:0px;min-height:450px;">
		      		</div>
		      		<div class="modal-footer">
                        <a class="btn" data-dismiss="modal" aria-hidden="true">关闭</a>
		      		</div>
		    	</div>
		    </div>
		</div> 
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
		$(function(){
			$('#sendTime').css({width:'150px'});
			$('#equipment').css({width:'300px'});
			$('#productList').css({width:'50%'});
			$("#product").hide();
			$("#news").hide();
			$("#sendTime").hide();
			$("#equipmentbox").hide();
			$('#fm').validationEngine('attach', { 
				promptPosition:'bottomLeft',
				 validationEventTrigger:'blur',
				 binded:true,
			     showOneMessage: true,
			     focusFirstField:true,
			     scroll: true
		    });

			$('#pushType').find('input:radio').click(function(){
				var val=$(this).val();
				if(val==0){
					$("#news").hide();
					$("#product").hide();
				}else if(val==1){
					productsData();
					$("#news").hide();
					$("#product").show();
				}else if(val==2){
					$("#product").hide();
					$("#news").show();
				}else{
				}
			});
			
			$('#sendType').find('input:radio').click(function(){
				var val=$(this).val();
				if(val==0){
					$("#sendTime").removeClass('validate[required]');
					$("#sendTime").val('');
					$('.sendTime').hide();
				}else{
					$("#sendTime").show();
					$("#sendTime").addClass('validate[required]');
					$('#sendTime').blur();
					$('.sendTime').show();
				}
				
			});
			
			$('#sendTarget').find('input:radio').click(function(){
				var val=$(this).val();
				if(val==0){
					$("#equipmentbox").hide();
				}else{
					$("#equipmentbox").show();
				}
			});
			
			$('#sendTime').datetimepicker({
					lang:'ch',
					format:'Y-m-d H:00:00',
					timepicker:true,
					//minTime:true,
					minDate:new Date().toLocaleDateString(),
					onSelectTime : function() {
						var selectedDatetime = $('#sendTime').val();
						var start=new Date(selectedDatetime.replace("-", "/").replace("-", "/"));
						if (new Date() > start) {
							$('#sendTime').val('');
						}
					},
					onSelectDate : function() {
						var selectedDatetime = $('#sendTime').val();
						var start=new Date(selectedDatetime.replace("-", "/").replace("-", "/"));
						if (new Date() > start) {
							$('#sendTime').val('');
						}
					}/* ,
					onClose : function() {
						var selectedDatetime = $('#sendTime').val();
						var start=new Date(selectedDatetime.replace("-", "/").replace("-", "/"));
						return start > new Date();
					} */
			   }
			);
			
			initEdit();
			if('${operation}' == 'edit'){
				$('.breadcrumb').html('<li class="active">消息管理&nbsp;/&nbsp;<a href="javascript:quit();">APP推送管理</a>&nbsp;/&nbsp;编辑推送</li>');
				$('#save').show();
			}else{
				$('.breadcrumb').html('<li class="active">消息管理&nbsp;/&nbsp;<a href="javascript:quit();">APP推送管理</a>&nbsp;/&nbsp;查看推送</li>');
				$('#save').hide();
				readOnly();
			}
		});
		
	    function validate() {
	    	if($("input[name='sendTarget']:checked").val()==1) {
		    	var equipments= $('#equipment').val();
	            if(equipments=="") {
	            	alert('如指定人员，请加设备号。');
	            	return false;
	            }
				if(equipments.split('\n').length > 20){
					alert('设备最多20个。');
					return false ;
				}
	    	}
            return true;
	    }
		
		function initEdit()
		{
			$('#title').val('${message.title}');
			$('#content').val('${message.content}');
			$('#sendTime').val('<fmt:formatDate value="${message.sendTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />');
			$('#productName').html('${productName}');
			$('#productId').val('${message.productId}');
			$('#newsTitle').val('${news.title}');
			$('#newsId').val('${message.newsId}');
			
			if('${message.pushType}'=='0') {
				$('#pushType').find('input:radio').eq(0).attr('checked','checked');
				$('#product').hide();
				$('#news').hide();
			}else if('${message.pushType}'=='1'){
				$('#pushType').find('input:radio').eq(1).attr('checked','checked');
				$('#product').show();
				$('#news').hide();
			}else if('${message.pushType}'=='2'){
				$('#pushType').find('input:radio').eq(2).attr('checked','checked');
				$('#product').hide();
				$('#news').show();
			}else{
			}
			
			if('${message.osType}'==0) {
				$('#osType').find('input:radio').eq(0).attr('checked','checked');
			} else if('${message.osType}'==1) {
				$('#osType').find('input:radio').eq(1).attr('checked','checked');
			} else {
				$('#osType').find('input:radio').eq(2).attr('checked','checked');
			}
			if('${message.sendType}'==0) {
				$('#sendType').find('input:radio').eq(0).attr('checked','checked');
				$('#sendTime').hide();
				$('#sendTime').val('');
				$("#sendTime").removeClass('validate[required]');
			} else {
				$('#sendType').find('input:radio').eq(1).attr('checked','checked');	
				$('#sendTime').show();
				$("#sendTime").addClass('validate[required]');
			}
			if('${message.sendTarget}'==0) {
				$('#sendTarget').find('input:radio').eq(0).attr('checked','checked');
			} else {
				$('#sendTarget').find('input:radio').eq(1).attr('checked','checked');
				$("#equipmentbox").show();
			}
		}
		
		function productsData() {
			search();
			$('#productList').modal('show');
		}
		
		function choice(id,name) {
			$('#productName').html(name);
			$('#productId').val(id);
            $('#productList').modal('hide');
		}
		
		function search() {
			   var name = $('#productSearchName').val() ? $('#productSearchName').val() : null;
			   $.get('${pageContext.request.contextPath}/product/list/${productPage}/${productSize}', {'productName' : name}, function(result){ 
				   if (result['products'].length > 0) { 
				       $('#productBody').html("");
				       var now = new Date();
				       for (var i = 0; i < result['products'].length; i++) {
				    	   $('#productBody').append('<tr>');
				    	   $('#productBody').append('<td class="hidden" >'+result['products'][i].id+'</td>');
				    	   $('#productBody').append('<td>'+(i+1)+'</td>');
				    	   $('#productBody').append('<td>'+result['products'][i].name+'</td>');
				    	   $('#productBody').append('<td>'+result['products'][i].yearIncome+'</td>');
				    	   $('#productBody').append('<td>'+result['products'][i].totalAmount+'</td>');
				    	   $('#productBody').append('<td>'+result['products'][i].financePeriod+'天</td>');
				    	   if(result['products'][i].shippedTime > now.getTime()){
					    	   $('#productBody').append('<td style="color:green;">待售</td>');
				    	   }else{
				    		   $('#productBody').append('<td style="color:green;">在售</td>');
				    	   }
				    	   $('#productBody').append('<td><a href=javascript:choice('+result['products'][i].id+',"'+result['products'][i].name+'");>选择</a></td>');
				    	   $('#productBody').append('</tr>');
					   }
				       var totalPages = Math.ceil(result['productTotal'] / '${productSize}');
				       var options = {
					        currentPage: '${productPage}',
					        totalPages: totalPages,
					        size: 'normal',
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
							alignment: 'center'
				       };
				       $('#product-page').bootstrapPaginator('setOptions', options);
				   } else {
					   $('#productBody').html('<tr><td colspan="8">暂时没有产品数据</td></tr>');
			  	   } 
            }); 
		}
		
		function showNewsDialog() {
			searchNews(1);
			$('#newsList').modal('show');
		}
		
		function choiceNews(id, name) {
			$('#newsTitle').val(name);
			$('#newsId').val(id);
            $('#newsList').modal('hide');
		}
		
		function searchNews(page) {
		    $.post('${pageContext.request.contextPath}/message/news/list/'+page+'/15', function(result){
			   if (result.total > 0) {
				   $('#newsBody').html("");
			       for (var i = 0; i < result.newsList.length; i++) {
			    	   var news = result.newsList[i];
			    	   $('#newsBody').append('<tr>');
			    	   $('#newsBody').append('<td class="hidden">'+news.id+'</td>');
			    	   $('#newsBody').append('<td>'+(i+1)+'</td>');
			    	   $('#newsBody').append('<td>'+news.title+'</td>');
			    	   //去掉换行和空格
			    	   var _t = news.title;
			    	   _t = _t.replace(' ', '');
			    	   $('#newsBody').append('<td><a href=javascript:choiceNews('+news.id+',"'+_t+'");>选择</a></td>');
			    	   $('#newsBody').append('</tr>');
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
			            	searchNews(page);
			            }  
				    };
					$('#news-page').bootstrapPaginator(options);
		       }else{
		    	   $('#newsBody').html('<tr><td colspan="3">请先添加新闻素材</td></tr>');	
		       }
           }); 
		}
		
		function readOnly() {   
	        var a = document.getElementsByTagName('input');   
	        for(var i=0; i<a.length; i++) {   
	           if(a[i].type=='checkbox' || a[i].type=='radio' || a[i].type=='text'){
	        	   a[i].readOnly = true;
	        	   a[i].disabled = 'disabled';
	           }     
	        }
	        
	        var b = document.getElementsByTagName('select');   
	        for(var i=0; i<b.length; i++) {   
	        	b[i].disabled="disabled";   
	        }
	        
	        var c = document.getElementsByTagName('textarea');
	        for (var i=0; i<c.length; i++) {   
	            c[i].disabled='disabled';   
	        }
	        
	        var d = document.getElementsByTagName('button');
	        for (var i=0; i<d.length; i++)   {   
	            d[i].disabled='disabled';   
	        }
		}
		
		function preview(){
			if($('#newsId').val()>0){
				$.post('${pageContext.request.contextPath}/message/news/'+$('#newsId').val()).done(function(res){
					$('#news_title').html(res.title);
					$('#news_content').empty();
					var pdom = $('<p style="padding: 5px 0;">').append('来源：'+res.source)
						.append('&nbsp;&nbsp;&nbsp;&nbsp;')
						.append(new Date(res.createTime).format('yyyy-MM-dd HH:mm:ss'));
					$('#news_content').append(pdom);
					if(res.type==1){
						$('#news_content').append('<p>'+res.content+'</p>');
					}else{
						$('#news_content').append('<iframe src="'+res.link+'" style="border:none;width:320px;min-height:410px;" scrolling="auto"></iframe>');
					} 
					$('#preview').modal('show');
				});
			}
		}
		
		function quit() {
		   window.location.href='${pageContext.request.contextPath}/message/list/${page}';
	    }
	</script>
</html>