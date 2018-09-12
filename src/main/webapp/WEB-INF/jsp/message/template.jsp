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
                    	<div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
	                            <!-- <a href="javascript:add();" id="520"><button type="button" class="btn btn-success">新增</button></a> -->
	                            <a href="javascript:enable(1);" id="521"><button type="button" class="btn btn-primary">启用 </button></a>
                       			<a href="javascript:enable(0);" id="522"><button type="button" class="btn btn-primary">禁用 </button></a>
		                    </div>
                            <div class="block-content collapse in">
	                            <div class="span12">
	                            	<form id="search" action="${pageContext.request.contextPath}/message/template/list/1" method="post">
		                            	<table id="templates" style="word-wrap: break-word; word-break: break-all;" cellpadding="0" cellspacing="0" border="0" class="table">
			                                <thead>
			                                    <tr>
			                                        <th>序号</th>
			                                        <th>模板内容</th>
			                                        <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                	<c:choose>
		                                   		<c:when test="${fn:length(templates) > 0}">
		                                   			<c:forEach var ="template" items="${templates}" varStatus="status">
														<tr onclick="getRow(this, '#BFBFBF')" id="templateId${template.id}">
	                                      					<td class="hidden" >${template.id}</td>
	                                      					<td style="width:10%;" >${status.count}</td>
		                                   					<td style="width:80%;" >${template.content}</td>
		                                   					<td style="width:10%;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:if test="${template.status > 0}">启用</c:if><c:if test="${template.status < 1}">禁用</c:if></td>
		                                   				</tr>
		                                   			</c:forEach>
		                                   		</c:when>
			                                   	<c:otherwise>
		                                   			<tr>
		                                   				<td colspan="10">暂时没有短信模板数据</td>
		                                   			</tr>
		                                   		</c:otherwise>
		                                 	</c:choose>
		                                     </tbody>
		                                     <tfoot>
		                                     	<tr>
		                                        	<td colspan="10"><div id="template-page"></div></td>
		                                        </tr>
		                                     </tfoot>
		                                </table>
		                            </form>
	                        	</div>
                            </div>
                        </div>
                    </div>
                    <!-- content end -->
                </div>
            </div>
        </div>
        <div class="modal hide fade" style="width:500px; height:280px;" id="templateDiv" role="dialog">
			<form id="saveForm" class="form-horizontal" style="margin-bottom: 0;" id="fm" method="post" action="${pageContext.request.contextPath}/message/template/save" autocomplete="off">
         		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        		<h4 class="modal-title">新增短信模板</h4>
	      		</div>
				<div class="input-group span6" id="silverfoxCodeDiv">
			  	  <span class="required">*</span>模板内容：
				  <textarea id="templateContent" name="templateContent" rows="4" class="validate[maxSize[300]] span3" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></textarea>
	            </div>
				<div style="margin-left:110px;margin-top:120px;">
		            <button type="button" onclick="javascript:save()" class="btn btn-primary">确认</button>
		            <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
		        </div>
           	</form>		 
		</div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	
	<script type="text/javascript">
		var rowId = 0;
		$(document).ready(function(){
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">短信模板管理&nbsp;/&nbsp;短信模板管理</li>');
			$('[rel="tooltip"]').tooltip();
			if(totalPages > 0) {
				var options = {
			        currentPage: '${page}',
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/message/template/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#template-page').bootstrapPaginator(options);
			}
		});
		
		$('#521').hide();
		$('#522').hide();
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				rowId = 0;
				$('#521').hide();
				$('#522').hide();
			} else {
				$('#templateId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				status = tr.getElementsByTagName('td')[3].innerHTML;
				if(status.replace(/\&nbsp;/g,'') == '禁用'){
					$('#521').show();
					$('#522').hide();
				} else {
					$('#521').hide();
					$('#522').show();
				}
			}
		}
		
		function add(){
    		$('#templateDiv').modal('show');
			$('#saveForm').validationEngine();
		}
		
		function save(){
			var content = $.trim($('#templateContent').val());
			if(content == null || content ==''){
				alert('请先录入短信模板信息');
				return false;
			}
			$.ajax({
				type: 'post',
				url: '${pageContext.request.contextPath}/message/template/save',
		    	data: {
		    		content : content
		    	},
				success: function(result){
					if(result) {
						alert('保存成功!');
						window.location.href='${pageContext.request.contextPath}/message/template/list/1';
					} else {
						alert('保存失败,请重试!');
					};
				}
			});
		};
		
		function enable(status){
			var enables = '';
			if(status == 0){
				enables ='禁用';
			}else{
				enables ='启用';
			}
			if(confirm("确认要"+enables+"本条记录吗?")){
				$.ajax({
					type: 'post',
					url: '${pageContext.request.contextPath}/message/template/audit',
			    	data: {
			    		id : rowId,
			    		status : status
			    	},
					success: function(result){
						if(result) {
							alert(enables+'成功!');
							window.location.href='${pageContext.request.contextPath}/message/template/list/1';
						} else {
							alert(enables+'失败,请重试!');
						};
					}
				});
			};
		};
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>