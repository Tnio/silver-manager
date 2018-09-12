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
							<div class="well" style="height:30px;">
								<div class="row-fluid">
									<form id="search"  action="${pageContext.request.contextPath}/product/treasure/list/1" method="post">
										<%-- <input type="hidden" id="size" name="size" value="${size}"> --%>
										<%--<input type="hidden" id="page" name="page" value="${page}" /> --%>
										<input name="backView" value="TREASURE" type="hidden">
										<div style="margin:2px auto auto auto">
	                                  		<span style="vertical-align: 3px">产品名称</span>
											<input class="span2" id="productName" name="productName" value="${productName}" type="text" onkeyup="this.value=this.value.trim()" />&nbsp;
	                                  		<span style="vertical-align: 3px">产品状态</span>
	                                  		<select id="productStatue" name="productStatue" class="span2">
												<option></option>
	                                           	<c:forEach items="${statused}" var="st">
	                                           		 <c:choose>
		                                            	<c:when test="${st.key == productStatue}">
		                                            		<option value="${st.key}" selected="selected">${st.value}</option>
		                                            	</c:when>
		                                            	<c:otherwise>
		                                            		 <option value="${st.key}">${st.value}</option>
		                                            	</c:otherwise>
	                                            	</c:choose>
	                                           	</c:forEach>
											</select> &nbsp;
											<span style="vertical-align: 3px">审核状态</span>
											<select id="auditStatue" name="auditStatue" class="span2">
												<option></option>
	                                           	<c:forEach items="${auditStatused}" var="as">
		                                            <c:choose>
		                                            	<c:when test="${as.key == auditStatue}">
		                                            		<option value="${as.key}" selected="selected">${as.value}</option>
		                                            	</c:when>
		                                            	<c:otherwise>
		                                            		<option value="${as.key}">${as.value}</option>
		                                            	</c:otherwise>
	                                            	</c:choose>
	                                             </c:forEach>
											</select> 
											<span style="vertical-align: 3px">关联商户</span>
											<select id="merchantId" name="merchantId" class="span2">
											<option></option>
                                            <c:forEach items="${merchants}" var="merchant">
                                            	<c:choose>
                                            		<c:when test="${merchant.id == merchantId}">
                                            			<option value="${merchant.id}" selected="selected">${merchant.name}</option>
                                            		</c:when>
                                            		<c:otherwise>
                                            			<option value="${merchant.id}">${merchant.name}</option>
                                            		</c:otherwise>
                                           		</c:choose>
                                            </c:forEach>	
											</select>
											&nbsp;
											<input type="submit" value="查询" style="margin-top: -10px" class="btn btn-default" />
											<input type="reset" value="重置" onclick="resetData()" style="margin-top: -10px" class="btn btn-default" />			
                                   		</div>
									</form>
								</div>
							</div>
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a href="javascript:add()" id="465"><button class="btn btn-lg btn-success">新增</button></a>
                                 <a href="javascript:detail()" id="462"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                                 <a href="javascript:edit()" id="461"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                                 <!-- <a href="javascript:split()" id="133"><button class="btn btn-lg btn-primary">拆分<i class=""></i></button></a> -->
                                 <!-- <a href="javascript:recommends('recommend')"  id="134"><button class="btn btn-lg btn-primary" >推荐</button></a>
                                 <a href="javascript:recommends('canceled')"  id="135"><button class="btn btn-lg btn-primary" >取消推荐</button></a> -->
                                 <a href="javascript:audit()"  id="463"><button class="btn btn-lg btn-primary" >审核</button></a>
                                 <a href="javascript:setStatus('soldout')" id="139"><button class="btn btn-lg btn-primary" >设为满标</button></a>
                                 <a href="javascript:addChild()" id="138"><button class="btn btn-lg btn-primary">新增子产品<i class=""></i></button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="product" cellpadding="0" cellspacing="0" border="0" class="div_table">
                                         <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>产品名称</th>
                                                <th>年化收益</th>
                                                <!-- <th>产品加息</th> -->
                                                <th>募集金额(元)</th>
                                                <!-- <th>募集周期</th> -->
                                                <th>募集进度</th>
                                                <!--  <th>投资风险</th> -->
                                                <th>父产品</th>
                                                <!-- <th>理财期限</th> -->
                                                <th>状态</th>
                                                <th>审核状态</th>
                                                <!-- <th>排序</th> -->
                                                <th style="display:none;">上架时间</th>
                                               <!--  <th>显示平台</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                          <c:when test="${fn:length(products) > 0}">
                                          	<span ></span>
                                            <c:forEach var="product" items="${products}" varStatus="status">
                                            <c:set var="shippedTime">
												<fmt:formatDate value="${product.shippedTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
											</c:set>          
                                            <tr onclick="getRow(this, '#BFBFBF')" id="productId${product.id}">
                                                <td class="hiddenid" >${product.id}</td>
                                                <td class="hiddenid">${systemTime}</td>
                                                <td class="hiddenid">${product.recommend}</td>
                                                <td class="hiddenid">${product.status}</td>
                                                <td class="hiddenid">${product.totalAmount}</td>
                                                <td class="hiddenid">${product.actualAmount}</td>
                                                <td class="hiddenid">${product.category.property}</td>
                                                <td>${status.count}</td>
                                                <td style="text-align: left"><c:if test="${product.recommend == 1}"><span style="background-color: #E74C3C">荐</span> </c:if>${product.name}</td>
                                                <td>
                                                 <c:choose>
                                                 	<c:when test="${product.bonus.id > 0}">
                                                 		${product.yearIncome}% 起
                                                 	</c:when>
                                                 	<c:otherwise>
                                                 		${product.yearIncome}%
                                                 	</c:otherwise>
                                                 </c:choose>
                                                </td>
                                                <td>
                                                <c:choose>
                                                	<c:when test="${product.parent.id > 0 }">
                                                		<fmt:formatNumber type="currency" value="${product.totalAmount}" currencySymbol="" />
                                                	</c:when>
                                                	<c:when test="${product.parent.id == 0 }">
                                                		无限制
                                                	</c:when>
                                                	 <c:otherwise>
                                                		--
                                                	</c:otherwise>
                                                </c:choose>
                                                </td>
                                                <td>
                                                	<c:choose>
	                                                	<c:when test="${product.status == 1}">
	                                                		<c:choose>
	                                                			<c:when test="${product.category.property == 'TREASURE' && product.parent.id == 0}">
	                                                				--
	                                                			</c:when>
	                                                			<c:otherwise>
	                                                				<c:choose>
		                                               		   			<c:when test="${shippedTime > systemTime && product.actualAmount < product.totalAmount}">
																	   		<div class="progress" style="margin-bottom: 1px;height: 17px;width: 60px">
						                                               			<div class="progress-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width:<fmt:formatNumber value="${fn:substring(product.actualAmount/product.totalAmount * 100,0,5)}" type="number" pattern="#,##0.00"/>%;background-color:green;">
																	    			<span class="sr-only">
																	    				<fmt:formatNumber value="${fn:substring(product.actualAmount/product.totalAmount * 100,0,5)}" type="number" pattern="#,##0.00"/>%
																	    			</span>
																	    		</div>
							                                                </div>
																	   </c:when>
																	   <c:when test="${shippedTime <= systemTime && product.actualAmount < product.totalAmount}">
																	   		<div class="progress" style="margin-bottom: 1px;height: 17px;width: 60px">
						                                               			<div class="progress-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width:<fmt:formatNumber value="${fn:substring(product.actualAmount/product.totalAmount * 100,0,5)}" type="number" pattern="#,##0.00"/>%;background-color:#3498DB;">
																	    			<span class="sr-only">
																	    				<fmt:formatNumber value="${fn:substring(product.actualAmount/product.totalAmount * 100,0,5)}" type="number" pattern="#,##0.00"/>%
																	    			</span>
																	    		</div>
							                                                </div> 
																	   </c:when>
																	   <c:otherwise>
																	   		<div class="progress" style="margin-bottom: 1px;height: 17px;width: 60px">
						                                               			<div class="progress-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width:<fmt:formatNumber value="${fn:substring(product.actualAmount/product.totalAmount * 100,0,5)}" type="number" pattern="#,##0.00"/>%;background-color:#E74C3C;">
																	    			<span class="sr-only">
																	    				<fmt:formatNumber value="${fn:substring(product.actualAmount/product.totalAmount * 100,0,5)}" type="number" pattern="#,##0.00"/>%
																	    			</span>
																	    		</div>
							                                                </div> 
																	   </c:otherwise>
		                                               		   		</c:choose>
	                                                			</c:otherwise>
	                                                		</c:choose>
	                                                		
	                                                	</c:when>
	                                                	<c:otherwise>
	                                                		<span style="color:green;">--</span> 
	                                                	</c:otherwise>
												    </c:choose>
                                                </td>
                                                <td>
                                                <c:choose>
												   <c:when test="${product.parent.id > 0}">
												   		<c:choose>
													   		<c:when test="${!empty product.parent.name}">
													   			${product.parent.name}
													   		</c:when>
													   		<c:otherwise>
													   			父产品丢失
													   		</c:otherwise>
												   		</c:choose>
												   </c:when>
												   <c:otherwise>无
												   </c:otherwise>
												</c:choose>
                                                </td>
                                                <td>
                                                <c:choose>
                                                	<c:when test="${product.status == 1}">
                                                		<c:choose>
                                               		  	   <c:when test="${shippedTime > systemTime && product.actualAmount < product.totalAmount}">
													   			<span style="color:#3498DB;">未开始</span> 
														   </c:when>
														   <c:when test="${shippedTime <= systemTime && product.actualAmount < product.totalAmount}">
														   		<span style="color:#E74C3C;">在售</span> 
														   </c:when>
														   <c:otherwise>
														   		<span style="color:#000000;">售罄</span> 
														   </c:otherwise>
                                               		  	</c:choose>
                                                	</c:when>
                                                	<c:otherwise>
                                                		<span style="color:green;">--</span> 
                                                	</c:otherwise>
												</c:choose>
                                                </td>
                                                <td>
                                                	<c:choose>
                                               		   <c:when test="${product.status == 0}">
													   		<span style="color:fuchsia;">待审核</span> 
													   </c:when>
													   <c:when test="${product.status == 1}">
													   		<span style="color:#3498DB;">通过</span> 
													   </c:when>
													   <c:when test="${product.status == 2}">
													   		<span style="color:#E7BD3C;">不通过</span> 
													   </c:when>
													   <c:otherwise>
													   		<span style="color:green;">--</span> 
													   </c:otherwise>
                                               		</c:choose>
                                                </td>
                                                <td class="hiddenid"><fmt:formatDate value="${product.shippedTime}" type="both" pattern="yyyy-MM-dd HH:mm" /></td>
                                            </tr>            
                                            </c:forEach>
                                          </c:when>
                                          <c:otherwise>
                                        	<tr id="noCount">
                                                <td colspan="18">暂时还没产品列表</td>
                                            </tr>  
                                          </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                        <tfoot>
                                        	<tr>
                                        		<td colspan="18"><div id="product-treasure-page"></div></td>
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
        <div class="modal hide fade" id="authorizationDiv" role="dialog" style="margin-top: 200px">
			<form id="fmg" class="modal-content form-horizontal password-modal" >
           	  <input type="hidden" id="id" name="id">
			  <input type="hidden" id="customer" name="customer" value="${sessionsilverfoxkey.admin.id}">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">审核意见</h4>
		      </div>
		      <div class="modal-body">
		      	请确认审核结果！
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary" onclick="setStatus('enable')">通过</button>
		        <button type="button" class="btn btn-default" onclick="setStatus('disabled')">不通过</button>
		      </div>
		    </div>
		</form>		   
		</div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
	    var rowId = 0;
	    var count = 0;
	    var shippedTime = '';
	    var systemTime = '';
	    var status = '';
	    var parentId = '';
	    var recommend = '';
	    var actualAmount = '';
	    var totalAmount = '';
	    var category = 0;
	    /* var dm = ''; */
		$(document).ready(function(){
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;活期产品管理</li>');
			$('[rel="tooltip"]').tooltip();
			$('td.hiddenid').hide();
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/product/treasure/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#product-treasure-page').bootstrapPaginator(options);
			}
			
			$('input').iCheck({
				checkboxClass: 'icheckbox_flat-green',
			});
			
			$('input').on('ifChanged', function(){
				displayPlatform($(this).val());
			 });
			$('#465').hide();
			$('#461').hide();
			$('#462').hide();
			$('#134').hide();
			$('#463').hide();
			$('#135').hide();
			/* $('#133').hide(); */
			$('#139').hide();
			$('#138').hide();
			if(parseInt('${count}') > 0){
				$('#465').hide();
			}else{
				$('#465').show();
			}
			/* alert('${status.count}');
			if('${status.count}'.length > 0){
				$('#465').hide();
			}else{
				$('#465').show();
			} */
			
		});
		
		function getRow(tr, color) {
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#463').hide();
				$('#135').hide();
				$('#134').hide();
				/* $('#133').hide(); */
				$('#139').hide();
				$('#462').hide();
				$('#461').hide();
				$('#138').hide();
				rowId = 0;
			}else{
				$('#productId'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = $.trim(tr.getElementsByTagName('td')[0].innerHTML);
				shippedTime = $.trim(tr.getElementsByTagName('td')[15].innerHTML);
				systemTime = $.trim(tr.getElementsByTagName('td')[1].innerHTML);
				status = $.trim(tr.getElementsByTagName('td')[3].innerHTML);
				parentId = $.trim(tr.getElementsByTagName('td')[12].innerHTML);
				recommend = $.trim(tr.getElementsByTagName('td')[2].innerHTML);
				totalAmount = $.trim(tr.getElementsByTagName('td')[4].innerHTML);
				actualAmount =$.trim(tr.getElementsByTagName('td')[5].innerHTML);
				category = $.trim(tr.getElementsByTagName('td')[6].innerHTML);
				buttonShowOrHide(shippedTime,systemTime,status,parentId,recommend);
			}
		
		}
			
		function buttonShowOrHide(shippedTime,systemTime,status,parentId,recommend){
			$('#463').hide();
			$('#135').hide();
			$('#134').hide();
			$('#139').hide();
			$('#462').show();
			$('#461').hide();
			$('#138').hide();
			if(status == 0){
				$('#463').show();
				$('#135').hide();
				$('#134').hide();
				$('#139').hide();
				$('#461').show();
			}else if(status == 1){
				if($.trim(parentId) == ' ' || $.trim(parentId) == '无'){
					$('#138').show();
				}
				if(shippedTime < systemTime){
					if(parseFloat(actualAmount) < parseFloat(totalAmount)){
						if(parseFloat(actualAmount) > 0){
							$('#139').show();
						}else{
							$('#139').hide();
						}
					}
				}
				if(parseFloat(actualAmount) >= parseFloat(totalAmount)){
					$('#461').show();
				}else{
					$('#461').hide();
				}
			}else{
				$('#463').hide();
				$('#135').hide(); 
				$('#134').hide();
				/* $('#133').hide(); */
				$('#139').hide();
				$('#461').show();
				$('#138').hide();
			}
		}
		

		function resetData() {
			$('#productName').val('');
			$('#productStatue').val('');
			$('#auditStatue').val('');
			$('#merchantId').val('');
			$('#search').attr('action','${pageContext.request.contextPath}/product/treasure/list/1');
            $('#search').submit();
		}
		
		function add(){
			$('#search').attr('action','${pageContext.request.contextPath}/product/treasure/add/${page}');
            $('#search').submit();
		}
		
		function edit() {
			if (rowId > 0) {
				$('#search').attr('action','${pageContext.request.contextPath}/product/edit/'+rowId+'/${page}');
                $('#search').submit();
			} else {
				alert('请先选择您想编辑的产品!');
			}
		}
		
		function detail() {
			if (rowId > 0) {
				$('#search').attr('action','${pageContext.request.contextPath}/product/detail/'+rowId+'/${page}');
                $('#search').submit();
			} else {
				alert('请先选择您想编辑的产品!');
			}
		}
		
		
		function recommends(status){
			if(rowId > 0){
				$('#search').attr('action','${pageContext.request.contextPath}/product/'+rowId+'/'+status +'/${page}');
                $('#search').submit();
			}else{
				alert('请先选择您想推荐/或要取消推荐的产品！');
			}
		}
		
		function audit(){
			if(rowId > 0){
				$('#authorizationDiv').modal('show');
			}else{
				alert('请先选择一条记录!');
			}
		}
		
		function setStatus(Sstatus){
			if(rowId > 0){
				  if(Sstatus =='soldout'){
					  var msg = "您确认要将此产品设为满标吗?";
					  if (confirm(msg)==true){
						  $('#search').attr('action','${pageContext.request.contextPath}/product/'+rowId+'/'+Sstatus+'/${page}');
			              $('#search').submit();
					  }  
				  }else{
					  $.getJSON('${pageContext.request.contextPath}/product/check/status', {
						   id:rowId,
						   initStatus:status,
					   }, function(result){
						   if(!result){
							   alert('审核失败，产品已被审核!');
						   }else{
							   $('#search').attr('action','${pageContext.request.contextPath}/product/'+rowId+'/'+Sstatus+'/${page}');
					              $('#search').submit(); 
						   }
					   })
					  /* $.getJSON('${pageContext.request.contextPath}/product/check/status', {
						   id:rowId, 
					   }, function(result){
						   if(!result){
							   alert('审核失败，产品已被审核!');
						   }else{
							   $('#search').attr('action','${pageContext.request.contextPath}/product/'+rowId+'/'+status+'/${page}');
					           $('#search').submit(); 
						   }
					   }) */ 
				  }
			}else{
				alert('请先选择一条记录！');
			}
			
		}
		
		function addChild(){
			if(rowId > 0){
				$('#search').attr('action','${pageContext.request.contextPath}/product/treasure/child/add/'+rowId+'/${page}');
	            $('#search').submit();
			}else{
				alert('请先选择一条记录！');
			}
		}
		
		/* function displayPlatform(displayPlatformId){
			$.post('${pageContext.request.contextPath}/product/display/platform',{productId:$.trim(displayPlatformId.split(',')[0]),displayPlatformId:$.trim(displayPlatformId.split(',')[1])},function(result){
				if(result != null){
					if($.trim(result.split(',')[0]) == rowId){
						dm = $.trim(result.split(',')[1]);
					}else{
						dm = "";
					}
				}
			});
		} */
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>