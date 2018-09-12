<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
	<body>
		<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
        <div class="container-fluid">
            <div class="row-fluid">
                <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
                <div class="span10" id="content">
                    <!-- content begin -->
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div class="block-content collapse in">
	                        <form id="fm" action="${pageContext.request.contextPath}/message/app/save" method="post" class="form-horizontal" onsubmit="return validate()" >
								 <div class="well" style="padding-bottom: 20px; margin: 0;">
									<div class="control-group">
										<input id="id" name="id" value="${message.id }" type="hidden">
										<input name="type" value="${message.type }" type="hidden">
										<input name="page" value="${page}" type="hidden">
		                    			<input name="size" value="${size}" type="hidden">
										<input type="hidden" id="title" name="title" value="${message.news.title}" />
		                    		</div>
									<div class="control-group">
										<label class="control-label"><span class="required">*</span>选择内容</label>
										<div class="controls">
											<input type="text" id="news_content" class="text-input span8" value="${message.news.title }" readonly onclick="showNewsDialog()"/>
											<a class="btn btn-icon btn-default" href="javascript:preview();">预览</a>
											<input type="hidden" id="contentId" name="news.id" value="${message.news.id }">	
										</div>
									</div>
									<div class="form-actions">
										<button type="submit" class="btn btn-icon btn-primary glyphicons circle_ok" id="save">保存</button>
										<a class="btn btn-icon btn-default glyphicons circle_remove" href="javascript:quit();">返回</a>
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
         <div class="modal hide fade" id="newsList" role="dialog" >
		  	<div class="modal-dialog modal-lg">
		    	<div class="modal-content">
		      		<div class="modal-header">
		        		<a type="button" class="close" data-dismiss="modal" aria-label="Close">
		        			<span aria-hidden="true">&times;</span>
		        		</a>
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
		        		<h3 id="message_title"></h3>
		      		</div>
		      		<div class="modal-body" id="message_content" style="padding:0px;min-height:450px;">
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
			$('#newsList').css({width:'50%'});
			$('#title').val('${message.news.title}');
			$('#news_content').val('${message.news.title}');
			$('#fm').validationEngine('attach', { 
				 promptPosition:'bottomLeft',
		         showOneMessage: true,
		         focusFirstField:true,
		         scroll: true
		    });
			
			if('${operation}' == 'edit'){
				$('.breadcrumb').html('<li class="active">消息管理&nbsp;/&nbsp;<a href="javascript:quit();">APP消息管理</a>&nbsp;/&nbsp;编辑APP消息</li>');
				$('#save').show();
			}
		});
		
		function validate() {
			if($('#title').val()==null || $('#title').val()==''){
				return false;
			}
			if($('#contentId').val()<1){
				alert('请选择新闻内容');
				return false;
			}
            return true;
		}
		
		function showNewsDialog() {
			search(1);
			$('#newsList').modal('show');
		}
		
		function choice(id, name) {
			$('#contentId').val(id);
			$.post('${pageContext.request.contextPath}/message/news/'+id,{},function(news){
		    	  $('#news_content').val(news.title);
		    	  $('#title').val(news.title);
			})
            $('#newsList').modal('hide');
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
			    	   //去掉换行和空格
			    	   var _t = news.title;
			    	   _t = _t.replace(' ', '');
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
			if($('#title').val() == ''){
				alert('请填写消息标题');
				return false;
			}
			if($('#contentId').val()<1){
				alert('请选择新闻内容');
				return false;
			}
			$.post('${pageContext.request.contextPath}/message/news/'+$('#contentId').val()).done(function(res){
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
		
		function quit() {
		   window.location.href='${pageContext.request.contextPath}/message/app/list/${page}';
	    }
	</script>
</html>