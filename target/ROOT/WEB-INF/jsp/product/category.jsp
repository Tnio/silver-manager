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
                    	<div class="block">
                    		<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a href="javascript:add();" id="120"><button class="btn btn-success">新增</button></a>
                                 <a href="javascript:enable(1);" id="121"><button type="button" class="btn btn-primary">启用</button></a>
	                             <a href="javascript:enable(0);" id="122"><button type="button" class="btn btn-primary">禁用</button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12" id="productCategory">
                                    <table  cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr>
	                                            <th>序号</th>
	                                            <th>分类名称</th>
	                                            <!-- <th>字典类型</th> -->
	                                            <th>状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(categories) > 0}">
                                            <c:forEach var="category" items="${categories}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="categoryId${category.id}">
                                                <td class="hidden">${category.id}</td>
                                                <td class="hidden">${category.property}</td>
                                                <td>${status.count}</td>
                                                <td>${category.name}</td>
                                               <%--  <td>${category.property}</td> --%>
                                                <td><c:if test="${category.status == 0}">禁用</c:if><c:if test="${category.status == 1}">启用</c:if></td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="4">暂时还没有产品分类列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>		
                    </div>
                </div>
            </div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
        <div class="modal hide fade" id="productCategoryDialog" role="dialog">
			<div class="modal-dialog">
		    	<form id="fm" onsubmit="return validate()" class="modal-content form-horizontal" action="${pageContext.request.contextPath}/product/category/save" method="post">
		    		<input id="id" name="id" value="0" type="hidden">
		        	<div class="modal-header">
		        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        		<h4 class="modal-title">新增产品分类</h4>
		      		</div>
		        	<div class="control-group">
						<label class="control-label"><span class="required">*</span> 分类名称</label>
						<div class="controls"><input id="name" name="name" placeholder="4~40个字符" class="validate[required, minSize[4], maxSize[40], ajax[ajaxProductCategoryName]] text-input" type="text" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"></div>
					</div>
					<div class="control-group">
						<label class="control-label"><span class="required">*</span>字典类型</label>
						<div class="controls">
						    <select id="property"  name="property" class="validate[required]">
							    <option></option>
	                            <c:forEach items="${propertys}" var="property">
	                             <option value="${property.key}">${property.value}</option>
	                            </c:forEach>
							</select>
					    </div>
					</div>
					<div class="control-group">
						<label class="control-label">分类描述</label>
						<div class="controls">
							<textarea id="remark" name="remark" rows="5" cols="200" placeholder="最多不能超过60个字符" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" class="validate[maxSize[60]]"></textarea>
						</div>
					</div> 
			        <div class="modal-footer">
			            <button type="submit" class="btn btn-primary">确认</button>
			            <button type="reset" class="btn btn-default" data-dismiss="modal">返回</button>
			        </div>
		    	</form>
		  	</div> 
		</div>
	</body>
	<script type="text/javascript">
		var rowId = 0;
		var property='';
		$(document).ready(function(){
			$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;产品分类管理</li>');
			$('#121').hide();
			$('#122').hide();
		});
		
		var rowId = 0;
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				rowId = 0;
				$('#121').hide();
				$('#122').hide();
			} else {
				$('#categoryId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName("td")[0].innerHTML;
				property = tr.getElementsByTagName("td")[1].innerHTML;
				var status = tr.getElementsByTagName('td')[4].innerHTML;
				if ($.trim(status) == '禁用') {
					$('#121').show();
					$('#122').hide();
				} else if (status == '启用') {
					$('#122').show();
					$('#121').hide();
				}else{
					$('#122').hide();
					$('#121').hide();
				}
			}
	    }
		
		function enable(value) {
			$.post('${pageContext.request.contextPath}/product/category/enable/'+rowId+'/'+value, function(result){
				if (result) {
 					window.location.href = '${pageContext.request.contextPath}/product/category/list';
				}
			});
		}
		
		function validate(){
			var flag = true;
			$.ajaxSettings.async = false;
			$.getJSON('${pageContext.request.contextPath}/product/category/duplicate/name', {
				   id: 0, 
				   fieldId: 0, 
				   fieldValue: $('#name').val()
			}, function(data){
			   if(data && data.length>0 && data[1]){
				  if($('#property').val() == 'EXPERIENCE'){
					  $.getJSON('${pageContext.request.contextPath}/product/category/duplicate/property', {
						  property: $('#property').val()
					  }, function(result){
						   if(result){
							  flag = true;
						   }else{
							   alert("此体验类型已被占用,请选择其他类型");
							   $.ajaxSettings.async = true;
							   flag = false;
						   }
					   });
				  }
				  if($('#property').val() == 'NOVICE'){
					  $.getJSON('${pageContext.request.contextPath}/product/category/duplicate/property', {
						  property: $('#property').val()
					  }, function(result){
						   if(result){
							   flag = true;
						   }else{
							   alert("此新手型已被占用,请选择其他类型");
							   $.ajaxSettings.async = true;
							   flag = false;
						   }
					   });
				  }
				  if($('#property').val() == 'ACTIVITY'){
					  $.getJSON('${pageContext.request.contextPath}/product/category/duplicate/property', {
						  property: $('#property').val()
					  }, function(result){
						   if(result){
							   flag = true;
						   }else{
							   alert("此活动类型型已被占用,请选择其他类型");
							   $.ajaxSettings.async = true;
							   flag = false;
						   }
					   });
				  }
				  if($('#property').val() == 'TREASURE'){
					  $.getJSON('${pageContext.request.contextPath}/product/category/duplicate/property', {
						  property: $('#property').val()
					  }, function(result){
						   if(result){
							   flag = true;
						   }else{
							   alert("此活期产品型已被占用,请选择其他类型");
							   $.ajaxSettings.async = true;
							   flag = false;
						   }
					   });
				  }
			   }else{
				   $('#name').focus();
				   alert('此名称已被使用请重新输入!');
				   $.ajaxSettings.async = true;
				   flag = false;
			   }
			});
			$.ajaxSettings.async = true;
			return flag;
		}
		
		function add() {
			$('#name').val('');
			$('#property').val('');
			$('#remark').val('');
			$('#fm')[0].reset();
			$('#productCategoryDialog').modal('show');
			$('#fm').validationEngine('attach', { 
		        promptPosition: 'centerRight', 
		        scroll: false,
		        showOneMessage : true
		   }); 
		}
		
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>