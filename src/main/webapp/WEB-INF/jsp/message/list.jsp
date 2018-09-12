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
               		 <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
               	     <div class="well">
                         <form id="search" style="height:45px;" action="${pageContext.request.contextPath}/message/list/1" method="post" class="form-search">
	                          <input type="hidden" id="size" name="size" value="${size}" />
							  <div class="input-group marginTop">
	                              <span>发送时间:</span>
								  <input id="beginTime" class="datepicker marginTop" style="background:white;width:90px" onkeypress="return false" name="beginTime" type="text" value="${beginTime}" />
									-
								  <input class="datepicker marginTop" id="endTime" style="background:white;width:90px" onkeypress="return false" name="endTime" type="text" value="${endTime}" />
                              	  <input type="submit" value="查询" style="margin-top: 3px" class="btn btn-default" />
                              	  <input type="reset" value="重置" style="margin-top: 3px" onclick="resetData()" class="btn btn-default" /> 
	                          </div>
                         </form>
                    </div>
                    <div class="row-fluid">
                    	<div class="block">
                    	     <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a href="javascript:add()" id="270"><button class="btn btn-success">新增</button></a>
                                 <a href="javascript:detail()" id="271"><button class="btn btn-lg btn-primary">查看<i class=""></i></button></a>
                                 <a href="javascript:edit()" id="272"><button class="btn btn-primary" class="hidden">编辑<i class=""></i></button></a>
                                 <a href="javascript:audit()" id="273"><button class="btn btn-lg" class="hidden">推送<i class=""></i></button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="product" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                             <tr>
	                                             <th width="5%">序号</th>
	                                             <th width="40%">标题</th>
	                                             <th width="20%">系统</th>
	                                             <th>推送状态</th>
	                                             <th>推送类型</th>
	                                             <th>发送时间</th>
                                             </tr>
                                        </thead>
                                        <tbody>
	                                        <c:choose>
	                                            <c:when test="${fn:length(messages) > 0}">
		                                            <c:forEach var="message" items="${messages}" varStatus="status">
			                                            <tr onclick="getRow(this, '#BFBFBF')" id="message${message.id}">
			                                                <td class="hidden">${message.id}</td>
			                                                <td class="hidden">${message.status}</td>
			                                                <td>${status.count}</td>
			                                                <td>${message.title}</td>
			                                                <td><c:if test="${message.osType == 0}">ANDROID,IOS</c:if><c:if test="${message.osType == 1}">ANDROID</c:if><c:if test="${message.osType == 2}">IOS</c:if></td>
			                                                <td>
			                                                <c:choose>
			                                                	<c:when test="${message.status == 0}">
			                                                		未推送
			                                                	</c:when>
			                                                	<c:when test="${message.status == 4}">
			                                                		推送失败
			                                                	</c:when>
			                                                	<c:otherwise>
			                                                		已推送
			                                                	</c:otherwise>
			                                                </c:choose>
			                                                </td>
			                                                <td><c:if test="${message.sendTarget == 0}">全部人员</c:if><c:if test="${message.sendTarget == 1}">指定人员</c:if></td>
			                                                <td>
			                                                	<c:if test="${message.status == 0 and message.sendType == 0}"></c:if>
			                                                	<c:if test="${message.status != 0 or message.sendType != 0}">
					                                                <fmt:formatDate value="${message.sendTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
			                                                	</c:if>
			                                                </td>
			                                             </tr>
		                                            </c:forEach>
	                                            </c:when>
	                                            <c:otherwise>
	                                        	    <tr>
	                                                    <td colspan="6">暂时还没有推送消息</td>
	                                                </tr>  
	                                            </c:otherwise>
	                                        </c:choose>
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                       		    <td colspan="6"><div id="message-page"></div></td>
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
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
		var rowId = 0;
		var status = '';
		var clickCheck = false;
		$('.marginTop').css('margin', '5px auto auto auto');
		$(document).ready(function(){ 
			$('#273').hide();
			$('#272').hide();
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">消息管理&nbsp;/&nbsp;APP推送管理</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/message/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#message-page').bootstrapPaginator(options);
			}
		});
		
		$('#271').hide();
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$('#271').hide();
				$(tr).css('background-color', 'white');
				rowId = 0;
				$('#272').hide();
				$("#273").hide();
			} else {
				$('#271').show();
				$('#message'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				status = tr.getElementsByTagName('td')[1].innerHTML;
				if(status== 0) {
					$('#272').show();
					$("#273").show();
				}
				else {
					$('#272').hide();
					$("#273").hide();
				}
			}
		}
		
		function add(){
			$('#search').attr('action','${pageContext.request.contextPath}/message/add/${page}/${size}');
            $('#search').submit();
		}
		
		function edit() {
			if (rowId > 0) {
				$('#search').attr('action','${pageContext.request.contextPath}/message/edit/'+rowId+'/${page}/${size}');
	            $('#search').submit();
			} else {
				alert('请先选择您想编辑的行!');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				window.location.href='${pageContext.request.contextPath}/message/detail/'+rowId+'/${page}/${size}';
			} else {
				alert('请先选择要查看的数据!');
			}
		}
		
	    function audit(){
	    	var flag=clickCheck;
	    	if(flag==true){
	    		alert('已点击推送,不要重复点击!');
	    	}
	    	clickCheck = true;
			if(rowId > 0){
				if (confirm('要确认推送这条消息吗?')) {
					$.post('${pageContext.request.contextPath}/message/audit/'+rowId+'', function(result){
						if (result) {
		 					window.location.href = '${pageContext.request.contextPath}/message/list/${page}';
						} 
					}, 'json');
				}
			}else{
				alert('请先选择您想推送的消息！');
			}
		}
	    
	    $('#beginTime').datetimepicker({
		      format:'Y-m-d',
			  lang:'ch',
	          timepicker:false,
	          maxDate:new Date().toLocaleDateString(),
	          onSelectDate:function() {
					var fromDate = $('#beginTime').val();
					var startDate = new Date(Date.parse(fromDate.replace(/-/g,"/")));
					$('#endTime').datetimepicker({
						format:'Y-m-d',
						minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
						maxDate:new Date().toLocaleDateString(),
						lang:'ch',
						timepicker:false
					});
				}
		  });
		  
		  $('#endTime').datetimepicker({
		      format:'Y-m-d',
			  lang:'ch',
	          timepicker:false,
	          maxDate:new Date().toLocaleDateString(),
	          onSelectDate:function() {
					var toDate = $('#endTime').val();
					var endDate = new Date(Date.parse(toDate.replace(/-/g,"/")));
					$('#beginTime').datetimepicker({
						format:'Y-m-d',
						maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
						lang:'ch',
						timepicker:false
					});
				}
		  });
		  
		  function resetData() {
				$('#beginTime').val('');
				$('#endTime').val('');
			    $('#search').attr('action','${pageContext.request.contextPath}/message/list/1');
	            $('#search').submit(); 
			}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>