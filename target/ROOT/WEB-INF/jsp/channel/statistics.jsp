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
                    <div class="row-fluid">
                    	<div class="block">
                            <div class="navbar navbar-inner block-header" style="line-height: 42px">
                               	 页面浏览量 
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table cellpadding="0" cellspacing="0" border="0" class="table" id="orders">
                                         <thead>
                                            <tr>
	                                            <th></th>
	                                            <th>网站浏览量</th>
	                                            <th>网站独立访客数</th>
	                                            <th>移动端浏览量</th>
	                                            <th>移动端独立访客数</th>
	                                            
                                            </tr>
                                        </thead>
                                        <tbody>
  	                                       <tr>
                                               <td>渠道推广页面</td>
                                               <td>${webSpreadQuantity}</td>
                                               <td>${webVisitSpreadQuantity}</td> 
                                               <td>${appSpreadQuantity}</td> 
                                               <td>${appVisitSpreadQuantity}</td> 
                                             </tr>
                                             <tr>
                                               <td>渠道注册页面</td>
                                               <td>${webRegQuantity}</td>
                                               <td>${webVisitRegQuantity}</td> 
                                               <td>${appRegQuantity}</td> 
                                               <td>${appVisitRegSpreadQuantity}</td> 
                                             </tr>
                                             <tr>
                                               <td>渠道下载页面</td>
                                               <td>${webDownQuantity}</td>
                                               <td>${webVisitDownQuantity}</td> 
                                               <td>${appDownQuantity}</td> 
                                               <td>${appVisitDownQuantity}</td> 
                                             </tr>
                                         </tbody>
                                         
                                    </table>
                                </div>
                            </div>
                        </div>	
                        
                        <div class="block">
                            <div class="navbar navbar-inner block-header" style="line-height: 42px">
                               	 功能点击量
                            </div>
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table cellpadding="0" cellspacing="0" border="0" class="table" id="orders">
                                         <thead>
                                            <tr>
	                                            <th></th>
	                                            <th>网站点击量</th>
	                                            <th>移动端点击量</th>  
                                            </tr>
                                        </thead>
                                        <tbody>
  	                                       <tr>
                                               <td>渠道推广-立即参与</td>
                                               <td>${webBtnPartakeQuantity}</td>
                                               <td>${appBtnPartakeQuantity}</td> 
                                             </tr>
                                             <tr>
                                               <td>渠道注册-注册</td>
                                               <td>${webBtnRegQuantity}</td>
                                               <td>${appBtnRegQuantity}</td> 
                                             </tr>
                                              <tr>
                                               <td>渠道下载-下载app</td>
                                               <td>${webBtnDownQuantity}</td>
                                               <td>${appBtnDownQuantity}</td> 
                                             </tr>
                                              <tr>
                                               <td>渠道下载-立马理财</td>
                                               <td>${webBtnfinanceQuantity}</td>
                                               <td>${appBtnfinanceQuantity}</td> 
                                             </tr>
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
	</body>
	<script type="text/javascript">

		$(document).ready(function(){
			$('.breadcrumb').html('<li class="active">渠道管理&nbsp;/&nbsp;渠道统计</li>');
		});
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>