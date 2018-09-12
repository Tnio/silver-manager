<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta name="format-detection" content="telephone=no">
<html>
	<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
	<body>
		<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
		<input type="hidden" id="productStatue1" value="">
        <div class="container-fluid">
            <div class="row-fluid">
                <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
                <div class="span10" id="content">
                    <!-- content begin -->
	                    	<jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
						<div id="searchWell" class="well" style="height:60px;">
							<div class="row-fluid">
								<form id="search"  action="${pageContext.request.contextPath}/product/1" method="post">
									<input type="hidden" id="size" name="size" value="${size}" />
									<input type="hidden" id="data" name="data" value="" />
		                         	<div class="row-fluid">
		                         		<span style="vertical-align: 3px">产品状态</span>
                                  		<select id="productStatue" name="productStatue" onchange="javascript:showSearch(this.value, 1)">
                                  			<option value="INTHESALE" <c:if test="${productStatue == 'INTHESALE'}">selected="selected"</c:if> >在售</option>
                                  			<option value="NOTSTARTED" <c:if test="${productStatue == 'NOTSTARTED'}">selected="selected"</c:if> >自动上架</option>
                                  			<option value="WAITAUDIT" <c:if test="${productStatue == 'WAITAUDIT'}">selected="selected"</c:if> >待审核</option>
                                  			<option value="WAITPAYMENT" <c:if test="${productStatue == 'WAITPAYMENT'}">selected="selected"</c:if> >待放款</option>
                                  			<option value="PAYMENTING" <c:if test="${productStatue == 'PAYMENTING'}">selected="selected"</c:if> >放款中</option>
                                  			<option value="PAYMENTED" <c:if test="${productStatue == 'PAYMENTED'}">selected="selected"</c:if> >放款成功</option>
                                  			<option value="PAYBACKING" <c:if test="${productStatue == 'PAYBACKING'}">selected="selected"</c:if> >还款中</option>
                                  			<option value="PAYBACKED" <c:if test="${productStatue == 'PAYBACKED'}">selected="selected"</c:if> >还款成功</option>
										</select>&nbsp;
		                         	</div>
		                         	<div class="row-fluid projectInfoGroup" style="display: none">
		                         		<span style="vertical-align: 3px">项目类型</span>
                                  		<select id="projectType" name="projectType">
                                  			<option value=""></option>
                                  			<option value="0" <c:if test="${projectType == 0}">selected="selected"</c:if> >供应链</option>
                                  			<option value="1" <c:if test="${projectType == 1}">selected="selected"</c:if> >信用贷</option>
                                  			<option value="2" <c:if test="${projectType == 2}">selected="selected"</c:if> >抵押贷</option>
										</select>&nbsp;
										<span style="vertical-align: 3px">产品名称</span>
										<input class="span2" id="productName" name="productName" value="${productName}" type="text"/>&nbsp;
										<span style="vertical-align: 3px">借款人</span>
										<input class="span2" id="merchantName" name="merchantName" value="${merchantName}" type="text"/>&nbsp;
		                         	</div>
		                         	<div class="row-fluid merchantInfoGroup" style="display: none">
		                         	<c:if test="${productStatue == 'PAYMENTED'}">
		                         	    <div style="position:relative;left: 60px">
	                         			<select name="projectTimeType" style="width:100px">
                                  			<option value="1"  <c:if test="${projectTimeType == 1}">selected="selected"</c:if>>放款时间</option>
                                  			<option value="2"  <c:if test="${projectTimeType == 2}">selected="selected"</c:if>>应还时间</option>
										</select>&nbsp;
										<input id="beginTime" class="datepicker marginTop" style="background:white;width:90px" onkeypress="return false" name="beginTime" type="text" value="${beginTime}" />
										-
							  			<input class="datepicker marginTop" id="endTime" style="background:white;width:90px" onkeypress="return false" name="endTime" type="text" value="${endTime}" />
									    </div>
									</c:if>
										<c:if test="${productStatue == 'PAYBACKED'}">
										<span>起始时间</span>
										<input id="beginTime" class="datepicker marginTop" style="background:white;width:90px" onkeypress="return false" name="beginTime" type="text" value="${beginTime}" />
										-
							  			<input class="datepicker marginTop" id="endTime" style="background:white;width:90px" onkeypress="return false" name="endTime" type="text" value="${endTime}" />
										</c:if>
							  			
										<%-- <span style="vertical-align: 3px">还款渠道</span>
                                  		<select id="payChannel" name="payChannel">
                                  			<option value=""></option>
                                  			<option value="1" <c:if test="${payChannel == 1}">selected="selected"</c:if> >连连支付</option>
                                  			<option value="2" <c:if test="${payChannel == 2}">selected="selected"</c:if> >银行存管</option>
										</select>&nbsp; --%>
		                         	</div>
		                         	<c:if test="${productStatue == 'PAYMENTED'}">
		                         	 <div style="position:relative;left: 60px">
		                         	   <div class="row-fluid">
		                         		<input type="submit" value="查询" style="margin-top: -10px" class="btn btn-default" />
										<input type="reset" value="重置" onclick="resetData()" style="margin-top: -10px" class="btn btn-default" />	
		                         	  </div>
		                         	</div>
		                         	</c:if>
		                        <div id="ss">
		                         	<div class="row-fluid">
		                         		<input type="submit" value="查询" style="margin-top: -10px" class="btn btn-default" />
										<input type="reset" value="重置" onclick="resetData()" style="margin-top: -10px" class="btn btn-default" />	
		                         	</div>
		                       </div> 
								</form>
							</div>
						</div>
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <div id="authorityButton" class="navbar navbar-inner block-header">
                                 <a href="javascript:add()" id="130"><button class="btn btn-lg btn-success">新增</button></a>
                                 <a href="javascript:detail()" id="132"><button class="btn btn-lg btn-primary" >查看<i class=""></i></button></a>
                                 <a href="javascript:edit()" id="131"><button class="btn btn-lg btn-primary" >编辑<i class=""></i></button></a>
                                 <!-- <a href="javascript:split()" id="133"><button class="btn btn-lg btn-primary">拆分<i class=""></i></button></a> -->
                                 <!-- <a href="javascript:recommends('recommend')"  id="134"><button class="btn btn-lg btn-primary" >推荐</button></a>
                                 <a href="javascript:recommends('canceled')"  id="135"><button class="btn btn-lg btn-primary" >取消推荐</button></a> -->
                                 <a href="javascript:setStatus('soldout')" id="137"><button class="btn btn-lg btn-primary" >设为满标</button></a>
                                 <a href="javascript:payment();" id="312"><button class="btn btn-lg btn-primary" >放款</button></a>
                                 <a href="javascript:audit();" id="2061"><button class="btn btn-lg btn-primary" >修改上架时间</button></a>
                                 <a href="javascript:recall();" id="2059"><button class="btn btn-lg btn-primary" >撤回</button></a>
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="product" cellpadding="0" cellspacing="0" border="0" class="div_table">
                                         <thead>
                                         	<c:if test="${productStatue == 'INTHESALE' || productStatue == 'WAITAUDIT' || productStatue == 'NOTSTARTED'}">
                                         		<tr>
	                                                <th>序号</th>
	                                                <th>产品名称</th>
	                                                <th>年化收益</th>
	                                                <!-- <th>产品加息</th> -->
	                                                <th>募集金额(元)</th>
	                                                <!-- <th>募集周期</th> -->
	                                                <c:if test="${productStatue == 'INTHESALE' || productStatue == 'NOTSTARTED'}">
	                                                	<th>募集进度</th>
	                                                </c:if>
	                                                <!--  <th>投资风险</th> -->
	                                                <th>所属分类</th>
	                                                <!--  <th>父产品</th> -->
	                                                <th>理财期限</th>
	                                                <!-- <th>状态</th> -->
	                                                <c:if test="${productStatue == 'WAITAUDIT' }">
	                                                	<th>审核状态</th>
	                                                </c:if>
	                                                <!-- <th>排序</th>     -->
	                                                <c:if test="${productStatue == 'INTHESALE' || productStatue == 'NOTSTARTED'}">
	                                                	<th>上架时间</th>
	                                                </c:if>
	                                                <c:if test="${productStatue == 'INTHESALE' && movePermit == true}">
	                                                    <th id="130"  class="span2"></th>
	                                                </c:if>
	                                                <!-- <th>显示平台</th> -->
	                                            </tr>
                                         	</c:if>
                                         	<c:if test="${productStatue == 'WAITPAYMENT'}">
                                         		<tr>
	                                                <th>序号</th>
	                                                <th>产品名称</th>
	                                                <th>放款金额</th>
	                                                <th>起息时间</th>
	                                                <th>理财期限</th>
	                                                <th>借款人</th>
	                                            </tr>
                                         	</c:if>
                                         	<c:if test="${productStatue == 'PAYMENTING'}">
                                         		<tr>
	                                                <th>序号</th>
	                                                <th>产品名称</th>
	                                                <th>放款时间</th>
	                                                <th>放款金额(元)</th>
	                                                <th>起息时间</th>
	                                                <th>借款人</th>
	                                            </tr>
                                         	</c:if>
                                         	<c:if test="${productStatue == 'PAYMENTED'}">
                                         		<tr>
	                                                <th>序号</th>
	                                                <th>产品名称</th>
	                                                <th>放款成功时间</th>
	                                                <th>放款金额(元)</th>
	                                                <th>放款应还时间</th>
	                                                <th>应还金额(元)</th>
	                                                <th>借款人</th>
	                                                <th>还款渠道</th>
	                                            </tr>
                                         	</c:if>
                                         	<c:if test="${productStatue == 'PAYBACKING'}">
                                         		<tr>
	                                                <th>序号</th>
	                                                <th>产品名称</th>
	                                                <th>还款时间</th>
	                                                <th>还款金额(元)</th>
	                                                <th>服务费</th>
	                                                <th>用户本息(元)</th>
	                                                <th>借款人</th>
	                                                <!--   <th>还款渠道</th>-->
	                                            </tr>
                                         	</c:if>
                                         	<c:if test="${productStatue == 'PAYBACKED'}">
                                         		<tr>
	                                                <th>序号</th>
	                                                <th>产品名称</th>
	                                                <th>还款成功时间</th>
	                                                <th>还款金额(元)</th>
	                                                <th>服务费</th>
	                                                <th>用户本息(元)</th>
	                                                <th>借款人</th>
	                                                <!--  <th>还款渠道</th>-->
	                                            </tr>
                                         	</c:if>
                                        </thead>
                                        <tbody class="productSortable">
	                                        <c:if test="${productStatue == 'INTHESALE' || productStatue == 'WAITAUDIT' || productStatue == 'NOTSTARTED'}">
												<c:choose>
		                                          <c:when test="${fn:length(products) > 0}">
		                                            <c:forEach var="product" items="${products}" varStatus="status">
		                                            <c:set var="shippedTime">
														<fmt:formatDate value="${product.shippedTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
													</c:set>
													
		                                            <tr onclick="getRow(this, '#BFBFBF')" id="productId${product.id}N${product.sortNumber}">
		                                                <td class="hiddenid">${product.id}</td>
		                                                <td class="hiddenid">${systemTime}</td>
		                                                <td class="hiddenid">${product.status}</td>
		                                                <td class="hiddenid">${product.totalAmount}</td>
		                                                <td class="hiddenid">${product.actualAmount}</td>
		                                                <td class="hiddenid">${product.category.property}</td>
		                                                <td class="hiddenid">${product.sortNumber}</td>
		                                                <td>${status.count}</td>
		                                                <td style="text-align: left">${product.name}</td>
		                                                <td>
		                                                 <c:choose>
		                                                 	<c:when test="${product.increaseInterest > 0}">
		                                                 		${product.yearIncome}%+${product.increaseInterest}%
		                                                 	</c:when>
		                                                 	<c:otherwise>
		                                                 		${product.yearIncome}%
		                                                 	</c:otherwise>
		                                                 </c:choose>
		                                                </td>
		                                                <td><fmt:formatNumber type="currency" value="${product.totalAmount}" currencySymbol="" /></td>
		                                                <c:if test="${productStatue == 'INTHESALE' || productStatue == 'NOTSTARTED'}">
		                                                	<td>
		                                                	   <c:choose>
			                                                	<c:when test="${product.status == 1}">
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
			                                                	</c:when>
			                                                	<c:otherwise>
			                                                		<span style="color:green;">--</span> 
			                                                	</c:otherwise>
														    </c:choose>
		                                                </td>
		                                                </c:if>
		                                                <td>${product.category.name}</td>
		                                                <td>${product.financePeriod}天</td>
		                                                <td class="status hiddenid">
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
		                                                <td   <c:if test="${productStatue != 'WAITAUDIT' }">class="hiddenid"</c:if>>
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
															   <c:when test="${product.status == 3}">
															        <span style="color:#0C0;">登记失败</span> 
															   </c:when>
															   <c:otherwise>
															   		<span style="color:green;">--</span> 
															   </c:otherwise>
		                                               		</c:choose>
		                                                </td>
		                                                <td class="sortNumber hiddenid">
		                                                	<c:choose>
		                                                		<c:when  test="${ !empty product.sortNumber}">
		                                                			${product.sortNumber}
		                                                		</c:when>
		                                                		<c:otherwise></c:otherwise>
		                                                	</c:choose>
		                                                </td>
		                                                <c:if test="${productStatue == 'INTHESALE' || productStatue == 'NOTSTARTED'}">
															<c:choose>
																<c:when  test="${product.shippedTime == 'Thu Jan 01 08:00:00 CST 1970'}">
																	<td>自动上架</td>
																</c:when>
																<c:otherwise>
																	<td><fmt:formatDate value="${product.shippedTime}" type="both" pattern="yyyy-MM-dd HH:mm" />		
																</c:otherwise>
															</c:choose>
		                                                </c:if>
		                                                <c:if test="${productStatue == 'INTHESALE' && movePermit == true}">
		                                                  <td ><button style="display:none ;" onclick="changesSort('${product.id}','${product.sortNumber}')" id="productId${product.id}" class="btn btn-lg btn-primary">移动到此处</button></td>
		                                                </c:if>
		                                            </tr>            
		                                            </c:forEach>
		                                          </c:when>
		                                          <c:otherwise>
		                                        	<tr>
		                                                <td colspan="18">暂时还没产品列表</td>
		                                            </tr>  
		                                          </c:otherwise>
		                                        </c:choose>
											</c:if>
											<c:if test="${productStatue == 'WAITPAYMENT'}">
												<c:choose>
													<c:when test="${fn:length(products) > 0}">
														<c:forEach var="product" items="${products}" varStatus="status">
															<tr onclick="getRow(this, '#BFBFBF')" id="productId${product.id}N${product.sortNumber}">
																<td class="hiddenid">${product.id}</td>
				                                                <td class="hiddenid">${product.sortNumber}</td>
																<td>${status.count}</td>
		                                                		<td style="text-align: left">${product.name}</td>
		                                                		<td style="text-align: left"><fmt:formatNumber type="currency" value="${product.payMoney}" currencySymbol="" /></td>
		                                                		<td style="text-align: left">${product.interestDate}</td>
		                                                		<td style="text-align: left">${product.financePeriod}</td>
		                                                		<td style="text-align: left">
		                                                			<c:if test="${product.productDetail.project.type == 0 || product.productDetail.project.type == 2}">
		                                                				${product.merchant.name}
		                                                			</c:if>
		                                                			<c:if test="${product.productDetail.project.type == 1}">
		                                                				<a href="javascript:showLender(${product.id})">查看借款人信息</a>
		                                                			</c:if>
		                                                		</td>
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr>
			                                                <td colspan="18">暂时还没产品列表</td>
			                                            </tr>
													</c:otherwise>
												</c:choose>
											</c:if>
											<c:if test="${productStatue == 'PAYMENTING'}">
												<c:choose>
													<c:when test="${fn:length(products) > 0}">
														<c:forEach var="product" items="${products}" varStatus="status">
															<tr onclick="getRow(this, '#BFBFBF')" id="productId${product.id}N${product.sortNumber}">
																<td class="hiddenid">${product.id}</td>
				                                                <td class="hiddenid">${product.sortNumber}</td>
																<td>${status.count}</td>
		                                                		<td style="text-align: left">${product.name}</td>
		                                                		<td style="text-align: left"><fmt:formatDate value="${product.paybackSuccessTime}" type="both" pattern="yyyy-MM-dd" /></td>
		                                                		<td style="text-align: left"><fmt:formatNumber type="currency" value="${product.payMoney}" currencySymbol="" /></td>
		                                                		<td style="text-align: left">${product.interestDate}</td>
		                                                		<td style="text-align: left">
		                                                			<c:if test="${product.productDetail.project.type == 0 || product.productDetail.project.type == 2}">
		                                                				${product.merchant.name}
		                                                			</c:if>
		                                                			<c:if test="${product.productDetail.project.type == 1}">
		                                                				<a href="javascript:showLender(${product.id})">查看借款人信息</a>
		                                                			</c:if>
		                                                		</td>
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr>
			                                                <td colspan="18">暂时还没产品列表</td>
			                                            </tr>
													</c:otherwise>
												</c:choose>
											</c:if>
											<c:if test="${productStatue == 'PAYMENTED'}">
												<c:choose>
													<c:when test="${fn:length(products) > 0}">
														<c:forEach var="product" items="${products}" varStatus="status">
															<tr onclick="getRow(this, '#BFBFBF')" id="productId${product.id}N${product.sortNumber}">
																<td class="hiddenid">${product.id}</td>
				                                                <td class="hiddenid">${product.sortNumber}</td>
																<td>${status.count}</td>
		                                                		<td style="text-align: left">${product.name}</td>
		                                                		<td style="text-align: left"><fmt:formatDate value="${product.paybackSuccessTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
		                                                		<td style="text-align: left"><fmt:formatNumber type="currency" value="${product.payMoney}" currencySymbol="" /></td>
		                                                		<td style="text-align: left"><fmt:formatDate value="${product.shouldPaybackTime}" type="both" pattern="yyyy-MM-dd" /></td>
		                                                		<td style="text-align: left"><fmt:formatNumber type="currency" value="${product.paybackMoney}" currencySymbol="" /></td>
		                                                		<td style="text-align: left">
		                                                			 <c:if test="${product.productDetail.project.type == 0 || product.productDetail.project.type == 2}">
		                                                				${product.merchant.name}
		                                                			</c:if>
		                                                			<c:if test="${product.productDetail.project.type == 1}">
		                                                				<a href="javascript:showLender(${product.id})">查看借款人信息</a>
		                                                			</c:if> 
		                                                			<%-- ${product.merchant.name} --%>
		                                                		</td>
		                                                		<td style="text-align: left"><c:if test="${product.payChannel==0}">连连支付</c:if><c:if test="${product.payChannel != 0}">银行存管</c:if></td>
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr>
			                                                <td colspan="18">暂时还没产品列表</td>
			                                            </tr>
													</c:otherwise>
												</c:choose>
											</c:if>
											<c:if test="${productStatue == 'PAYBACKING'}">
												<c:choose>
													<c:when test="${fn:length(products) > 0}">
														<c:forEach var="product" items="${products}" varStatus="status">
															<tr onclick="getRow(this, '#BFBFBF')" id="productId${product.id}N${product.sortNumber}">
																<td class="hiddenid">${product.id}</td>
				                                                <td class="hiddenid">${product.sortNumber}</td>
																<td>${status.count}</td>
		                                                		<td style="text-align: left">${product.name}</td>
		                                                		<td style="text-align: left"><fmt:formatDate value="${product.paybackSuccessTime}" type="both" pattern="yyyy-MM-dd" /></td>
		                                                		<td style="text-align: left"><fmt:formatNumber type="currency" value="${product.paybackMoney}" currencySymbol="" /></td>
		                                                		<td style="text-align: left"><fmt:formatNumber type="currency" value="${product.serviceCharge}" currencySymbol="" /></td>
		                                                		<td style="text-align: left"><fmt:formatNumber type="currency" value="${product.tradeAmount}" currencySymbol="" /></td>
		                                                		<td style="text-align: left">
		                                                			<c:if test="${product.productDetail.project.type == 0 || product.productDetail.project.type == 2}">
		                                                				${product.merchant.name}
		                                                			</c:if>
		                                                			<c:if test="${product.productDetail.project.type == 1}">
		                                                				<a href="javascript:showLender(${product.id})">查看借款人信息</a>
		                                                			</c:if>
		                                                		</td>
		                                                		<!-- <td style="text-align: left"><c:if test="${product.payChannel==0}">连连支付</c:if><c:if test="${product.payChannel != 0}">银行存管</c:if></td> -->
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr>
			                                                <td colspan="18">暂时还没产品列表</td>
			                                            </tr>
													</c:otherwise>
												</c:choose>
											</c:if>
											<c:if test="${productStatue == 'PAYBACKED'}">
												<c:choose>
													<c:when test="${fn:length(products) > 0}">
														<c:forEach var="product" items="${products}" varStatus="status">
															<tr onclick="getRow(this, '#BFBFBF')" id="productId${product.id}N${product.sortNumber}">
																<td class="hiddenid">${product.id}</td>
				                                                <td class="hiddenid">${product.sortNumber}</td>
																<td>${status.count}</td>
		                                                		<td style="text-align: left">${product.name}</td>
		                                                		<td style="text-align: left"><fmt:formatDate value="${product.paybackSuccessTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
		                                                		<td style="text-align: left"><fmt:formatNumber type="currency" value="${product.paybackMoney}" currencySymbol="" /></td>
		                                                		<td style="text-align: left"><fmt:formatNumber type="currency" value="${product.serviceCharge}" currencySymbol="" /></td>
		                                                		<td style="text-align: left"><fmt:formatNumber type="currency" value="${product.tradeAmount}" currencySymbol="" /></td>
		                                                		<td style="text-align: left">
		                                                			<c:if test="${product.productDetail.project.type == 0 || product.productDetail.project.type == 2}">
		                                                				${product.merchant.name}
		                                                			</c:if>
		                                                			<c:if test="${product.productDetail.project.type == 1}">
		                                                				<a href="javascript:showLender(${product.id})">查看借款人信息</a>
		                                                			</c:if>
		                                                		</td>
		                                                		 <!-- <td style="text-align: left"><c:if test="${product.payChannel==0}">连连支付</c:if><c:if test="${product.payChannel != 0}">银行存管</c:if></td> -->
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr>
			                                                <td colspan="18">暂时还没产品列表</td>
			                                            </tr>
													</c:otherwise>
												</c:choose>
											</c:if> 
                                        </tbody>
                                        <tfoot>
                                        	<c:if test="${productStatue == 'WAITPAYMENT'}">
                                        		<td colspan="18">
                                        			数量:${total} &nbsp; 
                                        			总金额:<fmt:formatNumber value="${waitpaymentMoney}" pattern="#,##0.00" /> &nbsp;
                                        		</td>
                                        	</c:if>
                                        	<c:if test="${productStatue == 'PAYMENTED'}">
                                        		<td colspan="18">
                                        			数量:${total} &nbsp; 
                                        			放款总金额:<fmt:formatNumber value="${paymentMoney }" pattern="#,##0.00" />&nbsp;
                                        			应还总金额:<fmt:formatNumber value="${shouldPaybackmentMoney }" pattern="#,##0.00" />&nbsp;
                                        		</td>
                                        	</c:if>
                                        	<c:if test="${productStatue == 'PAYBACKED'}">
                                        		<td colspan="18">
                                        			数量:${total} &nbsp; 
                                        			还款总金额:<fmt:formatNumber value="${shouldPaybackmentMoney }" pattern="#,##0.00" /> &nbsp;
                                        			服务费:<fmt:formatNumber value="${serviceCharge }" pattern="#,##0.00" /> &nbsp;
                                        			用户本息:<fmt:formatNumber value="${tradeAmount }" pattern="#,##0.00" />&nbsp;
                                        		</td>
                                        	</c:if>
                                        	<tr>
                                        		<td colspan="18"><div id="product-page"></div></td>
                                        	</tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /block -->
                         <div class="modal hide fade " id="auditDiv" role="dialog" style="margin-top: 200px;width: 500px" >
				<form id="audit" class="modal-content form-horizontal password-modal" >
					  <div class="modal-header">
				        <h4>修改上架时间</h4>
				      </div>
				    
				      <div  class="input-group span12" id="auditResultGroup">
				      		<div class="control-group">
								<label class="control-label"><span class="required">*</span>审核结果</label>
								<div class="controls">
									<span class="span3">
										<input type="radio" name="type3" value="enable"> 通过
									</span>
									<span class="span3">
										<input type="radio" name="type3" value="disabled"> 不通过
									</span>
								</div>
							</div>
					  </div>
					<div class="input-group span12" id="auditTypeGroup">
						<div class="control-group">
							<label class="control-label"><span class="required">*</span>上架类型</label>
							<div class="controls">
										<span class="span3">
											<input type="radio" name="type2" value="enable"> 自动上架
										</span>
								<span class="span3">
											<input type="radio" name="type2" value="disabled" checked="checked"> 定时上架
										</span>
							</div>
						</div>
					</div>
				      <div class="input-group span12 shippedTimeGroup">
				      		<div class="control-group">
								<label class="control-label"><span class="required">*</span>上架日期</label>
								<div class="controls">
									<select id="shippedTimeDay" class="validate[required] span6" >
                                    </select>
								</div>
							</div>
					  </div>
					  <div class="input-group span12 shippedTimeGroup">
				      		<div class="control-group">
								<label class="control-label"><span class="required">*</span>上架时间</label>
								<div class="controls">
									<select id="shippedTimeHour" class="validate[required] span3" >
                                    	<option value="00" >00</option>
                                    	<option value="01" >01</option>
                                    	<option value="02" >02</option>
                                    	<option value="03" >03</option>
                                    	<option value="04" >04</option>
                                    	<option value="05" >05</option>
                                    	<option value="06" >06</option>
                                    	<option value="07" >07</option>
                                    	<option value="08" >08</option>
                                    	<option value="09" >09</option>
                                    	<option value="10" >10</option>
                                    	<option value="11" >11</option>
                                    	<option value="12" >12</option>
                                    	<option value="13" >13</option>
                                    	<option value="14" >14</option>
                                    	<option value="15" >15</option>
                                    	<option value="16" >16</option>
                                    	<option value="17" >17</option>
                                    	<option value="18" >18</option>
                                    	<option value="19" >19</option>
                                    	<option value="20" >20</option>
                                    	<option value="21" >21</option>
                                    	<option value="22" >22</option>
                                    	<option value="23" >23</option>
                                    </select>点
                                    <select id="shippedTimeMinute" class="validate[required] span3" >
                                    	<option value="00" >00</option>
                                    	<option value="10" >10</option>
                                    	<option value="20" >20</option>
                                    	<option value="30" >30</option>
                                    	<option value="40" >40</option>
                                    	<option value="50" >50</option>
                                    </select>分
								</div>
							</div>
					  </div>
				      <div class="input-group span12" style="margin-bottom: 10px">
				      	<span class="span12" style="text-align: center;display:block;" >
				      		<a class="btn btn-primary" onclick="changeStatus()">确认</a>
				      		<a class="btn btn-default" onclick="quitAuditDiv()">取消</a>
				      	</span>
				      </div>
				    
				</form>		   
			</div>
                    </div>
                    <!-- content end -->
                </div>
            </div>
        </div>
        <div class="modal hide fade" style="width:400px; height:250px;" id="authorizationDiv" role="dialog" >
			<form id="fmg" class="modal-content form-horizontal password-modal" >
           	  <input type="hidden" id="id" name="id">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4>请输入银狐令</h4>
		      </div>
			  <div class="input-group span6" style="margin-top:15px;" id="silverfoxCodeDiv">
	          	  <input id="authCode" style="margin-left:25px;" name="authCode" type="text" style="ime-mode:disabled" onkeyup="return validateNumber($(this),value)" placeholder="银狐令" >
	          	  <div id="errorMsg"><span style="color:red;margin-left:30px;">银狐令或手机时间有误</span></div>
	          </div>
		      <div style="margin-left:105px;margin-top:120px;">
		        <button type="button" style="vertical-align:middle;" class="btn btn-primary" onclick="confirmed()">确认</button>
		        <button type="button" class="btn btn-default" onclick="quitAudition()">取消</button>
		      </div>
			  <div id="loading" style="margin-top:-100px;margin-left:100px; z-index:100000;">
				  <img alt="" src="${pageContext.request.contextPath}/images/loading.gif">
			  </div>	   
			</form>	
		</div>
		<form id="lenderShowForm" method="get">
			<input id="productId" name="productId" type="hidden">
			<input id="lenderType" name="type" type="hidden">
		</form>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script type="text/javascript">
	$(document).ready(function(){
		    $("#2061").hide();
		    $("#2059").hide();
		if(${productStatue == 'PAYMENTED'}){
			$("#ss").hide();
		}
		if(${productStatue != 'INTHESALE'}){
			$(".productSortable").removeClass("productSortable");
		}
	});
	    var rowId = 0;
	    var shippedTime = '';
	    var systemTime = '';
	    var status = '';
	    var parentId = '';
	    var actualAmount = '';
	    var totalAmount = '';
	    var category = 0;
	    var sortNumber = 0;
	   /*  var dm = ''; */
	   $('#312').hide();
	   function payment() {
			  $('#errorMsg').hide();
			  $('#authorizationDiv').modal('show');
			  $('#authCode').val('');
			  $('#loading').hide();
		}
	   
	    function quitAudition() {
			$('#authorizationDiv').modal('hide');
		}
	    
	    function confirmed() {
	    	if (rowId > 0) {
				var userName = '${sessionsilverfoxkey.admin.name}';
			  	var authCode = $('#authCode').val();
			  	$.ajaxSettings.async = false;
			  	$.post('${pageContext.request.contextPath}/client/code/gauth', {'userName' : userName, 'authCode':authCode}, 
					function(result){
				  		if(result) {
							var flag = 0;
           			 		$('#loading').show();
           			 		$.post('${pageContext.request.contextPath}/product/merchant/loan/payment', {'id':rowId, 'flag':flag}, function(result){
  	              				$('#authorizationDiv').modal('hide');
  		              		  	$('#loading').hide();
  	              			  	if(result){
  									alert('信息提交成功');
  								  	$('#search').attr('action','${pageContext.request.contextPath}/product/1');
  					              	$('#search').submit();
  							  	}else{
  									alert('放款失败,具体原因请联系管理员!');
  							  	}
 							});
            	  	} else {
            		  	$('#errorMsg').show();
            		  	return false;
            	  	} 
			  	});
	    	} else {
	    		alert('请选择要放款的产品！');
	    	}
		}
 function  changesSort(productId, sort){
		var products = eval('${products}');
	    var ids = '';
	    var sorts = '';
	    for (var i = 0; i < products.length; i++) {
	    	var p = products[i];
	    	if(p.id == productId){
    			ids += rowId+','+productId+',';
				sorts += sortNumber+','+sort+',';
	    	} else if(p.id == rowId){
				continue;
		    }else {
				ids += p.id+',';
				sorts += p.sortNumber+',';
			}
		}
	    $.post('${pageContext.request.contextPath}/product/change/sort',{'ids':ids,'sorts':sorts}, function(result){
	    	if(result){
	    		location.href='${pageContext.request.contextPath}/product/${page}?productStatue=INTHESALE';
	    	}
	    });
		    
	  }		$(document).ready(function(){
			var totalPages = '${pages}';
			$('.breadcrumb').html('<li class="active">产品管理&nbsp;/&nbsp;定期产品管理</li>');
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/product/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#product-page').bootstrapPaginator(options);
			}
			
			$('input').iCheck({
				checkboxClass: 'icheckbox_flat-green',
			});
			
			$('input').on('ifChanged', function(){
				displayPlatform($(this).val());
			});
			
			$('#search').validationEngine('attach', {
		        promptPosition:'bottomLeft',
		        showOneMessage: true,
		        focusFirstField:true,
		        scroll: false
		    });
			if($('.productSortable').length > 0){
				changeSort('${pageContext.request.contextPath}/product/change/sort','productSortable','tr:contains("\u5728\u552e")',/productId/g,'N');
			}
			$( ".productSortable" ).sortable("disable");
			$('#merchantId').find('option[value=${merchantId}]').attr('selected',true);
			$('#merchantId').comboSelect();
			
			
			$('#131').hide();
			$('#132').hide();
			$('#134').hide();
			$('#135').hide();
			$('#133').hide();
			$('#137').hide();
			$('#2061').hide();
			$('#2059').hide();
			if('${productStatue}' == 'WAITAUDIT'){
				$('#130').show();
			}else{
				$('#130').hide();
			}
// 			if('${productStatue}' == 'NOTSTARTED'){
// 				$('#2061').show();
// 			}else{
// 				$('#2061').hide();
// 			}
			$('#beginTime').datetimepicker({
			      format:'Y-m-d',
				  lang:'ch',
		          timepicker:false,
		          //maxDate:new Date().toLocaleDateString(),
		          onSelectDate:function() {
						var fromDate = $('#beginTime').val();
						var startDate = new Date(Date.parse(fromDate.replace(/-/g,"/")));
						$('#endTime').datetimepicker({
							format:'Y-m-d',
							minDate:startDate.getFullYear()+'/'+(startDate.getMonth()+1)+'/'+startDate.getDate(),
							//maxDate:new Date().toLocaleDateString(),
							lang:'ch',
							timepicker:false
						});
					}
			  });
			  
			  $('#endTime').datetimepicker({
			      format:'Y-m-d',
				  lang:'ch',
		          timepicker:false,
		          //maxDate:new Date().toLocaleDateString(),
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
			  $('#productStatue').find('option[value=${productStatue}]').attr('selected',true);
			  showSearch('${productStatue}', 2);
		});
		
		function getRow(tr, color) {
			   var productID = tr.id;
			   var split = productID.split('N');
			   var products = eval('${products}');
			    for (var i = 0; i < products.length; i++) {
			    	if(products[i].shippedTime > Date.parse(new Date())){
			    		$("#productId"+products[i].id).css('display','none');
			    	}else{
			    		$("#productId"+products[i].id).css('display','block');
			    	}
			    }
			    $("#"+split[0]).css('display','none');
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				$('#135').hide();
				$('#134').hide();
				$('#133').hide();
				$('#137').hide();
				$('#132').hide();
				$('#131').hide();
				$('#312').hide();
				$('#130').hide();
				$('#2061').hide();
				$('#2059').hide();
				rowId = 0;
			}else{
				var productStatue = '${productStatue}';				
				if (productStatue == 'WAITPAYMENT') {
					$('#312').show();
					$('#132').show();
				} else {
					$('#312').hide();
				}
				if(productStatue == 'WAITAUDIT'){
					$('#130').show();
					$('#132').show();
					$('#131').show();
				}else{
					$('#130').hide();
					$('#131').hide();
				}

				if(productStatue == 'NOTSTARTED'){
					$('#132').show();
					$('#2061').show();
					$('#2059').show();
					
				}else{
					$('#2061').hide();
					$('#2059').hide();
				}
				$('#productId'+rowId+'N'+sortNumber).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = $.trim(tr.getElementsByTagName('td')[0].innerHTML);
  				if(productStatue == 'WAITAUDIT' || productStatue == 'INTHESALE' || productStatue == 'NOTSTARTED'){
					sortNumber = $.trim(tr.getElementsByTagName('td')[6].innerHTML);
				}else{
					sortNumber = $.trim(tr.getElementsByTagName('td')[1].innerHTML);
				}
				if(productStatue != 'WAITPAYMENT'){
					systemTime = $.trim(tr.getElementsByTagName('td')[1].innerHTML);
					status = $.trim(tr.getElementsByTagName('td')[2].innerHTML);
					//parentId = $.trim(tr.getElementsByTagName('td')[6].innerHTML);
					
					totalAmount = $.trim(tr.getElementsByTagName('td')[3].innerHTML);
					actualAmount = $.trim(tr.getElementsByTagName('td')[4].innerHTML);
					category = $.trim(tr.getElementsByTagName('td')[5].innerHTML);
					
					//shippedTime = $.trim(tr.getElementsByTagName('td')[17].innerHTML);
					buttonShowOrHide(shippedTime,systemTime,status,parentId);
				}
			}
		}
		
		function buttonShowOrHide(shippedTime,systemTime,status,parentId){
			$('#135').hide();
			$('#134').hide();
			$('#133').hide();
			$('#137').hide();
			$('#132').show();
			if(status == 0){
				$('#135').hide();
				$('#134').hide();
				$('#133').hide();
				$('#137').hide();
			}else if(status == 1){
				if(shippedTime < systemTime){
					if(parseFloat(actualAmount) < parseFloat(totalAmount)){
						if(parseFloat(actualAmount) > 0){
							$('#137').show();
						}
						if((parseFloat(actualAmount) > 0) && ($.trim(parentId) == ' ' || $.trim(parentId) == '无')){
							$('#133').show();
						}
					}
					
					if(parseFloat(actualAmount) < parseFloat(totalAmount)){
						$('#134').show();
						$('#135').hide();
					}
				}
				/* if(parseFloat(actualAmount) >= parseFloat(totalAmount) && ($.trim(category)=='EXPERIENCE' || $.trim(category)=='NOVICE')){
					$('#131').show();
				}else{
					$('#131').hide();
				} */
			}else{
				$('#135').hide(); 
				$('#134').hide();
				$('#133').hide();
				$('#137').hide();
			}
		}
		

		function resetData() {
			$('#projectType').val('')
			$('#productName').val('');
			$('#merchantName').val('');
			$('#productRisk').val('');
			$('#productFinancePeriod').val('');
			$('#categoryId').val('');
			$('#merchantId').val('');
			$('#beginTime').val('');
			$('#endTime').val('');
			$('#periodStart').val('');
			$('#periodEnd').val('');
			$('#search').attr('action','${pageContext.request.contextPath}/product/1');
            $('#search').submit();
		}
		
		function add(){
			$('#search').attr('action','${pageContext.request.contextPath}/product/add/${page}');
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
				alert('请先选择您想查看的产品!');
			}
		}
		
		function recall() {
			if (rowId > 0) {
				if(confirm("确定撤回吗 ？")){
				   $.get('${pageContext.request.contextPath}/product/recall/'+rowId, function(result){
					        if(result.status){
					        	alert("撤回成功 ！");
					        	window.location.href='${pageContext.request.contextPath}/product/${page}?productStatue=NOTSTARTED';
					        }
	                 });
				}
			}else{
				alert('请先选择您想撤回的产品!');
			}
		}
		function split(){
			if(rowId > 0){
				if($.trim(parentId) == "" || $.trim(parentId) == '无'){
					$('#search').attr('action','${pageContext.request.contextPath}/product/'+rowId+'/split/${page}');
	                $('#search').submit();
				}else{
					alert("此产品无法再次拆分");
				}
			}else{
				alert('请先选择您想拆分的产品！');
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
		
		function setStatus(Sstatus){
			if(rowId > 0){
			  	var msg = "您确认要将此产品设为满标吗?";
			  	if (confirm(msg)==true){
				  	$('#search').attr('action','${pageContext.request.contextPath}/product/'+rowId+'/'+Sstatus+'/${page}');
	              	$('#search').submit();
			  	}  
			}else{
				alert('请先选择一条记录！');
			}
		}
		
		function showLender(pId){
			$('#productId').val(pId);
			$('#lenderType').val(1);
			$('#lenderShowForm').attr('action', '${pageContext.request.contextPath}/product/lender/list/1');
			$('#lenderShowForm').submit();
		}
		
		function showSearch(productStatus, flag){
			$('.projectInfoGroup').hide();
			$('.merchantInfoGroup').hide();
			$('#searchWell').css('height', '60px');
			if(productStatus == 'PAYMENTED' || productStatus == 'PAYBACKED'){
				$('#productStatue1').val(productStatus);
				$('#searchWell').css('height', '130px');
				$('.projectInfoGroup').show();
				$('.merchantInfoGroup').show();
			}
			if(flag == 1){				
				$('#projectType').val('')
				$('#productName').val('');
				$('#merchantName').val('');
				$('#productRisk').val('');
				$('#productFinancePeriod').val('');
				$('#categoryId').val('');
				$('#merchantId').val('');
				$('#beginTime').val('');
				$('#endTime').val('');
				$('#periodStart').val('');
				$('#periodEnd').val('');
			}
		}
		
		function addClass(id){
			/* $('#'+id).blur(); */
			if(id == 'periodStart'){
				if($.trim($('#periodEnd').val()) == ''){
					$('#'+id).removeClass('validate[min[1],max[999]]');
					$('#'+id).addClass('validate[min[1],max[999]]');
				}else{
					$('#'+id).removeClass('validate[min[1],max['+$.trim($('#periodEnd').val())+']]');
					$('#'+id).addClass('validate[min[1],max['+$.trim($('#periodEnd').val())+']]');
				}
			}
			
			if(id == 'periodEnd'){
				if($.trim($('#periodStart').val()) == ''){
					$('#'+id).removeClass('validate[min[1],max[999]]');
					$('#'+id).addClass('validate[min[1],max[999]]');
				}else{
					$('#'+id).removeClass('validate[min['+$.trim($('#periodStart').val())+'],max[999]]');
					$('#'+id).addClass('validate[min['+$.trim($('#periodStart').val())+'],max[999]]');
				}
			}
		}
		function audit(){
			if (rowId > 0) {
				$("#shippedTimeDay").html("");
				var date = new Date();
				var today=date.format("yyyy-MM-dd");
				$("#shippedTimeDay").append('<option  value='+today+' data='+today+'>'+today+'</option>');
				date.setTime(date.getTime()+24*60*60*1000);
				var tomorrow=date.format("yyyy-MM-dd");
				$("#shippedTimeDay").append('<option  value='+tomorrow+' data='+tomorrow+'>'+tomorrow+'</option>');
				var newDate=new Date();
				newDate.setTime(date.getTime()+10*60*1000);
				var hours=newDate.getHours();
				$('#shippedTimeHour').find('option[value='+hours+']').attr('selected',true);
				var minutes=newDate.getMinutes();
				minutes=Math.floor(minutes/10)*10;
				$('#shippedTimeMinute').find('option[value='+minutes+']').attr('selected',true);
				$('#auditDiv').modal('show');
				$('#auditTypeGroup').hide();
				$('#auditResultGroup').hide();
			} else {
				alert('请先选择您想修改上架时间的产品!');
			}
		}

		function changeStatus(){
			var Sstatus = $('#auditTypeGroup input[name="type2"]:checked').val();
			auditStatus = Sstatus;
				var auditShippedTime = $('#shippedTimeDay').val() + " " + $('#shippedTimeHour').val()+':'+$('#shippedTimeMinute').val()+':00';
				var systemTime = new Date(Date.parse('${systemTime}'.replace(/-/g,"/")));
				var auditTime = new Date(Date.parse(auditShippedTime.replace(/-/g,"/")));
				if(parseInt(systemTime.getTime() - auditTime.getTime()) > 0){
					alert("上架时间不能小于当前时间,请修改上架时间审核!");
					return;
				}
				$('#shippedTime').val(auditShippedTime);
				
				$.post('${pageContext.request.contextPath}/product/register',{'productId':rowId},function(result){
					if(result != null && (result.retCode == '00000000' || result.retCode == 'JX900122')){
					   	$.post('${pageContext.request.contextPath}/product/reaudit',{'productId':rowId,'shippedTime':auditShippedTime,'status':Sstatus},function(result){
					   		if(!result){
					   			alert("审核失败,请联系管理员");
					   		}else{
					   		location.href='${pageContext.request.contextPath}/product/${page}?productStatue=NOTSTARTED';
					   		}
					   	});
					}else{
						alert("审核失败,请联系管理员");
					}
					
				});
		}
		
		function quitAuditDiv(){
			$('#auditDiv').modal('hide');
		}
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>