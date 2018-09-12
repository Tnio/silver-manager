<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<c:import url="/header" />
	<body>
		<c:import url="/menu"></c:import>
        <div class="container-fluid">
            <div class="row-fluid">
                <c:import url="/sidebar"></c:import>
                <div class="span10" id="content">
                    <c:import url="/breadcrumb"></c:import>
                    <!-- content begin -->
                        <!-- block -->
                        <div class="block">
							<div id="authorityButton" class="navbar navbar-inner block-header">
								&nbsp; <a href="javascript:showDialog()" id="976" class="btn btn-lg btn-primary">导入</a>
								&nbsp; <a href="javascript:usedRecord()" id="977" class="btn btn-lg btn-primary">发放明细</a>
							</div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                	<form id="search" name="search" action="${pageContext.request.contextPath}/coupon/card/list" method="post" enctype="multipart/form-data">
										<input type="file" id="fileUrl" name="codeFile" accept=".csv" onchange="javascript:showFileName(this)" style="display: none;" >
			                    		<input type="hidden" id="page" name="page" value="${page}" />
			                    		<input type="hidden" id="size" name="size" value="${size}" />
			                    		<input type="hidden" id="used" name="used" value="${used}" />
			                    		<input type="hidden" id="name" name="name"/>
			                    		<input type="hidden" id="amount" name="amount"/>
	                                    <table id="coupon" cellpadding="0" cellspacing="0" border="0" class="table">
	                                         <thead>
	                                            <tr align="center">
		                                            <th>序号</th>
		                                            <th>名称</th>
		                                            <th>卡券金额</th>
		                                            <th>剩余库存</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        <c:choose>
	                                          <c:when test="${fn:length(couponCards) > 0}">
	                                            <c:forEach var="couponCard" items="${couponCards}" varStatus="status">
	                                            <tr id="couponId${couponCard.id}">
	                                                <td>${status.count}</td>
	                                                <td>${couponCard.name}</td>
	                                                <td><fmt:formatNumber value="${couponCard.amount}" pattern="#,##0" /></td>
	                                                <td><c:if test="${couponCard.orderNO > 0}"><a href="javascript:void(0);" onclick="stock('${couponCard.name}',${couponCard.amount})">${couponCard.orderNO}</a></c:if><c:if test="${couponCard.orderNO <= 0}">${couponCard.orderNO}</c:if></td>
	                                            </tr>
	                                            </c:forEach>
	                                          </c:when>
	                                          <c:otherwise>
	                                        	<tr>
	                                                <td colspan="9">暂时还没有第三方卡券列表</td>
	                                            </tr>  
	                                          </c:otherwise>
	                                        </c:choose>
	                                        </tbody>
	                                         <tfoot>
	                                            <tr>
	                                       		    <td colspan="7"><div id="couponCard-page"></div></td>
	                                          	</tr>
	                                        </tfoot>
	                                    </table>
	                             	</form>
                                </div>
                            </div>
                        </div> 
                        <!-- /block -->
                    </div>
                    <!-- content end -->
                </div>
                <div class="modal hide fade" id="couponDialog" role="dialog" >
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
				                   <tbody id="couponBody">
		                     	   </tbody>
		                     	   <tfoot>
		                      	        <tr>
		                      				<td colspan="2">
		                      					<div id="tfoot" align="right"></div>
		                      				</td>
		                      			</tr>
		                      		</tfoot>
		             			</table>
				      		</div>
				    	</div>
				    </div>
				</div>
            </div>
		<c:import url="/footer"></c:import>
	</body>
	<script type="text/javascript">
	    var beforeDate = "";
	    var rowId = 0;
	    var id = 0;
	    var status = 0;
	    $('.breadcrumb').html('<li class="active">券码管理&nbsp;&nbsp;/&nbsp;第三方卡券列表</li>');
		$(document).ready(function(){
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/coupon/card/list');
		            	$('#page').val(page);
		                $('#search').submit();
		            }  
			    };
				$('#couponCard-page').bootstrapPaginator(options);
			}
		});
		
		function showDialog(){
		   $('#myModalLabel').empty().html('第三方卡券导入     '+'<a href="javascript:chooseFile()">选择文件</a>');
		   $('#couponBody').html("");
		   $('#tfoot').html('');
	       $('#couponDialog').modal('show');
		}
		
		function chooseFile(){
	    	$('#fileUrl').trigger('click');
	    }
	    
	    function showFileName(imgFile){
	    	d3.csv(window.URL.createObjectURL(imgFile.files[0]), function(d) {
	    		if(d.name && d.cardno && d.password && d.amount && d.amount > 0){
	    			if(d.cardno.length <= 30 && d.password.length <= 30){
	    				return {
			    			length: + d.length // convert "Length" column to number
			    		};
	    			}
	    		}
    		}, function(error, rows) {
    			if(typeof(rows)  == 'undefined' || rows.length <= 0){
    				$('#couponBody').html('<span style="color:red">所选文件格式不正确，或无数据，请重新选择文件</span>');
    				$('#tfoot').html('');
    				$('#fileUrl').val('');
    			}else{
    				$('#couponBody').html("");
    		    	$('#couponBody').append('<tr>');
    		    	$('#couponBody').append('<td style="width:80px">文件名称</td>');
    		    	$('#couponBody').append('<td>'+imgFile.value+'</td>');
    		    	$('#couponBody').append('</tr>');
    		    	$('#couponBody').append('<tr>');
    		    	$('#couponBody').append('<td style="width:80px">读取数量</td>');
    		    	$('#couponBody').append('<td>'+rows.length+'行</td>');
    		    	$('#couponBody').append('</tr>');
    		    	$('#couponBody').append('<tr>');
    		    	$('#couponBody').append('<td style="width:80px">导入数量</td>');
    		    	if(rows.length < 1000){
    		    		$('#couponBody').append('<td>'+rows.length+'行</td>');
    		    	}else{
    		    		$('#couponBody').append('<td>'+1000+'行   <span style="color:red">(系统一次最多导入1000 行数据!)</span></td>');
    		    	}
    		    	$('#couponBody').append('</tr>');
    		    	$('#tfoot').html('<button type="button" class="btn btn-primary" onclick="importCode()">确定</button> <button type="button" class="btn btn-default" onclick="quit()">取消</button>');

    			} 
    		});			       
	    }
	    
	    function quit(){
	    	$('#couponDialog').modal('hide');
	    }
	    
	    function importCode(){
	    	var form = $('form[name=search]');
			var options  = {    
				url:'${pageContext.request.contextPath}/coupon/card/import',    
				type:'post', 
				dataType: 'json',
				success:function(result){
					if(result != null){
						if(result.code == 200){
							$('#search').attr('action','${pageContext.request.contextPath}/coupon/card/list');
			                $('#search').submit();
						}
						if(result.code == 500){
							$('#couponBody').html('<span style="color:red">卡号 : '+result.msg+' 已存在,或重复!</span>');
							$('#tfoot').html('');
						}
						if(result.code == 501){
							$('#couponBody').html('<span style="color:red">系统错误,请联系管理员!</span>');
							$('#tfoot').html('');
						}
						if(result.code == 502){
							$('#couponBody').html('<span style="color:red">数据格式有误,请仔细核对后再试!</span>'); 
							$('#tfoot').html('');
						}
					}
				}  
			};    
			form.ajaxSubmit(options);
	    }
	    
	    function stock(name, amount){
	    	$('#search').attr('action','${pageContext.request.contextPath}/coupon/card/record/1');
			$('#name').val(name);
			$('#amount').val(amount);
	        $('#search').submit();
	    }
	    
	   	function usedRecord(){
		   $('#search').attr('action','${pageContext.request.contextPath}/coupon/card/used/record');
		   $('#used').val(1);
		   $('#page').val(1);
           $('#search').submit();
	   	}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>