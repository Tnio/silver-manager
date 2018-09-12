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
                    <div class="row-fluid">
                        <!-- block -->
                        <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                        <div class="block">
                        	<form id="search" name="search" action="${pageContext.request.contextPath}/coupon/card/record/1" method="post" enctype="multipart/form-data">
	                    		<input type="hidden" id="page" name="page"/>
	                    		<input type="hidden" id="size" name="size" value="${size}" />
	                    		<input type="hidden" id="used" name="used" value="${used}" />
	                    		<input type="hidden" id="amount" name="amount" value="${amount}" />
	                    		<input type="hidden" id="name" name="name" value="${name}" />
	                    		<div class="navbar navbar-inner block-header">
	                    			<div style="margin:2px auto auto auto">
		                            	<span>卡号</span>
	                         			<input type="text" id="cardNO" name="cardNO" style="background:white;width:140px;" value="${cardNO}" class="horizontal marginTop"/>
										&nbsp;
										<input type="submit" value="查询" style="margin-top: -10px" class="btn btn-default" />
									</div>
                      			</div>
	                        </form>
	                        <div id="authorityButton" class="navbar navbar-inner block-header" style="border-top: none;">
	                            <a href="javascript:grant();" id="978"><button type="button" class="btn btn-primary">发放</button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="coupon" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                            <tr align="center">
	                                            <th>序号</th>
	                                            <th>名称</th>
	                                            <th>卡号</th>
	                                            <th>密码</th>
	                                            <th>卡券金额</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(couponCards) > 0}">
                                            <c:forEach var="couponCard" items="${couponCards}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="couponCardId${couponCard.id}">
                                                <td class="hidden">${couponCard.id}</td>
                                                <td>${status.count}</td>
                                                <td>${couponCard.name}</td>
                                                <td>${couponCard.cardNO}</td>
                                                <td><c:out value="${fn:substring(couponCard.password, 0, 4)}" />****<c:out value="${fn:substring(couponCard.password, fn:length(couponCard.password) - 4,fn:length(couponCard.password))}" /></td>
                                                <td><fmt:formatNumber value="${couponCard.amount}" pattern="#,##0" /></td>
                                            </tr>
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr>
                                                <td colspan="5">暂时还没有第三方卡券的剩余库存列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                       		    <td colspan="9"><div id="couponCard-page"></div></td>
                                          	</tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div> 
                        <div class="modal hide fade" id="grantDiv" role="dialog" style="margin-top:200px; width:400px">
							<form id="fmg" onsubmit="return validate()" class="modal-content form-horizontal password-modal" >
				           		<input type="hidden" id="id" name="id">
						      	<div class="modal-header">
						        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						        	<h4 class="modal-title">发放第三方卡券</h4>
						      	</div>
						      	<div class="modal-body">
									填写手机号：<input type="text" id="cellphone" name="cellphone" class="validate[required,custom[cellphone]] text-input span5" maxlength="11" />
							    	<div class="modal-footer">
							        	<button type="button" class="btn btn-primary" onclick="grantCard()">发放</button>
							    	</div>
						    	</div>
							</form>		   
						</div>
                        <!-- /block -->
                    </div>
                    <!-- content end -->
                </div>
            </div>
        </div>
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
	    $('.breadcrumb').html('<li class="active">券码管理&nbsp;&nbsp;/&nbsp;第三方卡券剩余库存</li>');
	    var rowId = 0;
		$(document).ready(function(){
			$('#fmg').validationEngine('attach', { 
		        promptPosition: 'centerRight', 
		        showOneMessage: true,
		        focusFirstField:true,
		        scroll: true
		   	});
			var totalPages = '${pages}';
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/card/record/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#couponCard-page').bootstrapPaginator(options);
			}
		    $('#978').hide();
		});
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				rowId = 0;
				$('#978').hide();
			} else {
				$('#couponCardId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;
				$('#978').show();
			}
		}
		
		function grant(){
			if(rowId > 0){
				if(confirm("是否将该优惠券标记为已发放?")){
					$('#cellphone').val('');
					$('#grantDiv').modal('show');
				}
			}else{
				alert('请先选择一条记录!');
			}
		}
		
		function grantCard(){
			var cellphone = $('#cellphone').val();
			if(rowId > 0 && cellphone != null && cellphone !=''){
				$.post('${pageContext.request.contextPath}/client/validate/customer/'+cellphone, function(result){
				   	if(result){
				   		$.post('${pageContext.request.contextPath}/coupon/card/grant/'+rowId+'/'+cellphone, function(res){
						   	if(!res){
							   	alert('发放失败!');
						   	}else{
							   	$('#search').attr('action','${pageContext.request.contextPath}/coupon/card/record/1');
					           	$('#search').submit(); 
						   	}
					   	})
				   	}else{
					   	alert('该手机号未注册,请重新核对!');
				   	}
			   	})
			}
		}
	</script>
	<c:import url="/authority"></c:import>
</html>