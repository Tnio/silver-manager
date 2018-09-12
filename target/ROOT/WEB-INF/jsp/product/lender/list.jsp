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
                    <!-- content begin -->
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="well">
	                    <form id="search" onsubmit="return startValidate();" action="${pageContext.request.contextPath}/product/lender/list/1" method="post">
		                	<%-- <input type="hidden" id="size" name="size" value="${size}" /> --%>
		                	<input type="hidden" id="productId" name="productId" value="${productId}" />
		                   	<div class="input-group">
                       			<div style="margin:15px auto auto auto">
									<span>借款人姓名</span>
                                 	<input type="text" id="name" name="name" value="${name}" class="text-input span2"/>
									<span>&nbsp;&nbsp;&nbsp;手机号</span>
                                 	<input type="text" id="cellphone" name="cellphone" value="${cellphone}" class="text-input span2"/> 
                         			<span>借款期限</span>
									<input type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"
										   onpaste="return !clipboardData.getData('text').match(/\D/)" id="startNum" name="startNum" value="${startNum}" class="text-input span2" />
                             		<span>至</span>
									<input type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"
										   onpaste="return !clipboardData.getData('text').match(/\D/)" id="endNum" name="endNum" value="${endNum}" class="text-input span2">
                           		</div>
                           		<div style="margin:15px auto auto auto">
                             		<span>&nbsp;&nbsp;&nbsp;借款状态</span>
                             		<select id="status" name="status" class="text-input span2">
                           				<option value="-1">全部</option>
                           				<option value="0">未借</option>
                                		<option value="1">已借</option>
                                		<option value="2">已还</option>
								    </select>
								    <span style="vertical-align: 3px">借款类型</span>
									<select id="type" name="type" class="text-input span2">
										<option value="2">抵押贷</option>
										<option value="1">信用贷</option>
									</select>
									<input type="submit" value="查询" style="margin-top: -10px" class="btn btn-default" />
                           		</div>
                           	</div>
		                </form>
                    </div>
                    <div class="row-fluid">
                        <!-- block -->
                       	<div class="block">
                       		<div id="authorityButton" class="navbar navbar-inner block-header">
                       			<c:if test="${type == 2 }">
				                    <a href="javascript:add();" id="2051"><button type="button" class="btn btn-success">新增</button></a>
				                    <a href="javascript:detail()" id="2053"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
				                    <a href="javascript:edit();" id="2052"><button type="button" class="btn btn-primary">编辑 </button></a>
                       			</c:if>
                       		</div>
	                        <!-- block -->
                            <div class="block-content collapse in">
                                <div class="span12">
                                   <table id="companies" class="table">
                                       <thead>
                                           <tr>
                                               <th>序号</th>
                                               <th>借款人姓名</th>
                                               <th>手机号</th>
                                               <th>借款金额（元）</th>
                                               <th>借款期限（天）</th>
                                               <th>借款状态</th>
                                           </tr>
                                       </thead>
                                       <tbody>
                                       	<c:choose>
                                       		<c:when test="${fn:length(lenders) > 0}">
                                       			<c:forEach var ="lender" items="${lenders}" varStatus="status">
                                       				<tr onclick="getRow(this, '#BFBFBF')" id="lenderId${lender.id}">
                                       					<td class="hidden">${lender.id}</td>
														<td>${status.count}</td>
                                       					<td>${lender.name}</td>
                                       					<td>${lender.cellphone}</td>
                                       					<td><fmt:formatNumber value="${lender.loanAmount}" pattern="#,##0" /></td>
                                       					<td>${lender.loanPeriod }</td>
                                       					<td>
                                       						<c:if test="${lender.status == 0 }">未借</c:if>
                                       						<c:if test="${lender.status == 1 }">已借</c:if>
                                       						<c:if test="${lender.status == 2 }">已还</c:if>
                                       					</td>
                                       				</tr>
                                       			</c:forEach>
                                       		</c:when>
                                       		<c:otherwise>
                                       			<tr>
                                       				<td colspan="8">暂时没有债权信息</td>
                                       			</tr>
                                       		</c:otherwise>
                                       	</c:choose>
                                       </tbody>
                                       <tfoot>
                                       	<tr>
                                       		<td colspan="8"><div id="lender-page"></div></td>
                                       	</tr>
                                       </tfoot>
                                   </table>
                                </div>
                            </div>
                        </div>
                        <!-- /block -->
                    </div>
                    <!-- content end -->
                </div>
            </div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
		function startValidate() {
			var flag = true;
			var startNum = $('#startNum').val();
			var endNum = $('#endNum').val();
            if (parseInt(startNum) >= parseInt(endNum)) {
                flag = false;
                alert("借款期限后面的值必须大于前面的值");
                return flag;
            }
            return flag;
		}
	
		var rowId = 0;
		$('#2052').hide();
		$('#2053').hide();
		$('.marginTop').css('margin', '2px auto auto auto');
		$('#status').find('option[value=${status}]').attr('selected',true);
		$('#type').find('option[value=${type}]').attr('selected',true);
		$(document).ready(function(){
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;债权管理</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/product/lender/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#lender-page').bootstrapPaginator(options);
			}
		});
		
		function getRow(tr, color) {
			var type = '${type}';
			if (type == 2) {
				if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
					$('#2052').hide();
					$('#2053').hide();
					$(tr).css('background-color', 'white');
					rowId = 0;
				} else {
					$('#2053').show();
					$('#2052').show();
					$('#lenderId'+rowId).css('background-color', 'white');
					$(tr).css('background-color', color);
					rowId = tr.getElementsByTagName("td")[0].innerHTML;
				}
			}
	    }
		
		function add() {
			location.href = '${pageContext.request.contextPath}/product/lender/add';
		}
		
		function edit() {
			if (rowId > 0) {
				location.href = '${pageContext.request.contextPath}/product/lender/edit/' + rowId;
			} else {
				alert('请选择一条要修改的数据');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				location.href = '${pageContext.request.contextPath}/product/lender/detail/' + rowId;
			} else {
				alert('请选择一条要查看的数据');
			}
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>