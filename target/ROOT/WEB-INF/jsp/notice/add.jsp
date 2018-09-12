<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                    	<form class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post"  action="${pageContext.request.contextPath}/notice/save"  autocomplete="off">
                    		<div class="well" style="padding-bottom: 20px; margin: 0;">
								<div class="control-group" id="noticeType">
									<label class="control-label">类型</label>
									<div class="controls">
										<div class="row-fluid">
											<div class="span2">
												<input type="radio" name="type" value="1" checked="checked" class="validate[required] radio span4">
												<span>网站公告</span>
											</div>
											<div class="span2">
												<input type="radio" name="type" value="3"  class="validate[required] radio span4">
												<span>媒体报道</span>
											</div>
											<div class="span2">
												<input type="radio" name="type" value="4"  class="validate[required] radio span4">
												<span>行业资讯</span>
											</div>
											<div class="span2">
												<input type="radio" name="type" value="6"  class="validate[required] radio span4">
												<span>理财专栏</span>
											</div>
										</div>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><span class="required">*</span>选择新闻</label>
									<div class="controls">
										<input type="text" class="validate[required] text-input span8" id="title" name="news.title" readonly onclick="showNewsDialog()"/>
										<button type="button" class="btn btn-icon btn-default" onclick="preview()">预览</button>
										<input type="hidden" id="newsId" name="news.id" value="0">	
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"></label>
									<div class="controls">
										<button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok" ><i></i>保存</button>
										<button type="reset" class="btn btn-icon btn-default glyphicons circle_remove" onclick="quit();"><i></i>返回</button>
									</div>
								</div>
                    		</div>
                    	</form>
                    </div>
                    <!-- content end -->
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
		        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		        			<span aria-hidden="true">&times;</span>
		        		</button>
		        		<h3 id="message_title"></h3>
		      		</div>
		      		<div class="modal-body" id="message_content" style="padding:6px;min-height:450px;">
		      			
		      		</div>
		      		<div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		      		</div>
		    	</div>
		    </div>
		</div> 
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
	
		$(function() {
			$('#fm').validationEngine('attach', {
		        promptPosition:'bottomLeft',
		        showOneMessage: true,
		        focusFirstField:true,
		        scroll: true
		    });
		});
		$('.breadcrumb').html('<li class="active">消息管理&nbsp;/&nbsp;<a href="javascript:quit();">新闻公告管理</a>&nbsp;/&nbsp;新增新闻公告</li>');
		function quit(){
			window.location.href='${pageContext.request.contextPath}/notice/list/1';
		}
		
		function showNewsDialog() {
			search(1);
			$('#newsList').modal('show');
		}
		function search(page) {
		    $.post('${pageContext.request.contextPath}/message/news/list/'+page+'/15', function(result){
			   if (result.total > 0) {
				   $('#newsBody').html("");
			       for (var i = 0; i < result.newsList.length; i++) {
			    	   var news = result.newsList[i];
			    	   $('#newsBody').append('<tr>');
			    	   $('#newsBody').append('<td class="hidden">'+news.id+'</td>');
			    	   $('#newsBody').append('<td>'+(i+1)+'</td>');
			    	   $('#newsBody').append('<td>'+news.title+'</td>');
			    	   $('#newsBody').append('<td><a href=javascript:choice('+news.id+');>选择</a></td>');
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
			            	search(page);
			            }  
				    };
					$('#news-page').bootstrapPaginator(options);
		       }else{
		    	   $('#newsBody').html('<tr><td colspan="3">请先添加新闻素材</td></tr>');	
		       }
           }); 
		}
		
		function preview(){
			if($('#newsId').val()<1){
				alert('请选择新闻内容');
				return false;
			}
			$.post('${pageContext.request.contextPath}/message/news/'+$('#newsId').val()).done(function(res){
				$('#message_title').html(res.title);
				$('#message_content').empty();
				var pdom = $('<p style="padding: 5px 0;">').append('来源：'+res.source)
					.append('&nbsp;&nbsp;&nbsp;&nbsp;')
					.append(new Date(res.createTime).format('yyyy-MM-dd HH:mm:ss'));
				$('#message_content').append(pdom);
				if(res.type==1){
					$('#message_content').append('<p>'+res.content+'</p>');
				}else{
					$('#message_content').append('<iframe src="'+res.link+'" style="border:none;width:320px;min-height:410px;" scrolling="auto"></iframe>');
				}
				$('#preview').modal('show');
			});
		}
		
		function choice(id) {
			$('#newsId').val(id);
			$.post('${pageContext.request.contextPath}/message/news/'+id, function(news){
	    	    $('#title').val(news.title);
			});
            $('#newsList').modal('hide');
            $('.titleformError').hide();
		}
	</script>
</html>