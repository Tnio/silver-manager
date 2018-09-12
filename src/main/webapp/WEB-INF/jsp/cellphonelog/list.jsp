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
            <div class="viewIimg-fluid" style="margin:0 auto;width:800px;height:auto;">
               <div class="viewIimg" style="width:800px;position: absolute;z-index:800;margin-top: 50px;"></div>
            </div>
            <div class="row-fluid">
                <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
                <div class="span10" id="content">
               		 <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
               	     <div class="well">
                         <form id="search" style="height:45px;" action="${pageContext.request.contextPath}/cellphonelog/list/1" method="post" class="form-search">
	                          <input type="hidden" id="size" name="size" value="${size}" />
	                          <div class="input-group">
	                              <span>原手机号:</span>
	                              <input class="horizontal" type="text" id="oldCellphone" name="oldCellphone" value="${oldCellphone}" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')" class="span3" />
                              	  <input type="submit" value="查询" style="margin-top: 3px" class="btn btn-default marginTop" />
                              	  <input type="reset" value="重置" style="margin-top: 3px" onclick="resetData()" class="btn btn-default marginTop" /> 
							  </div>
                         </form>
                    </div>
                    <div class="row-fluid">
                    	<div class="block">
                    	    <div id="authorityButton" class="navbar navbar-inner block-header"> <!-- authorityButton -->
	                            <a href="javascript:audit();" id="420"><button type="button" class="btn btn-primary">审核</button></a>
                            </div>                    	
                            <div class="block-content collapse in">   
                                <div class="span12">
                                    <table id="product" cellpadding="0" cellspacing="0" border="0" class="table">
                                         <thead>
                                             <tr>
	                                             <th width="5%">序号</th>
	                                             <th width="10%">原手机号</th>
	                                             <th width="10%">新手机号</th>
	                                             <th>手持身份证照片</th>
	                                             <th>身份证正面照片</th>
	                                             <th>身份证反面照片</th>
	                                             <th>审核状态</th>
                                             </tr>
                                        </thead>
                                        <tbody>
	                                        <c:choose>
	                                            <c:when test="${fn:length(cellphonelogs) > 0}">
		                                            <c:forEach var="cellphonelog" items="${cellphonelogs}" varStatus="status">
			                                            <tr onclick="getRow(this, '#BFBFBF')" id="message${cellphonelog.id}">
			                                                <td class="hidden" >${cellphonelog.id}</td>
			                                                <td class="hidden" >${cellphonelog.userId}</td>
			                                                <td>${status.count}</td>
			                                                <td>${cellphonelog.oldCellphone}</td>
			                                                <td>${cellphonelog.newCellphone}</td>
			                                                <td><img style="width:75px;height: 50px" src="${cellphonelog.idcardPhoto}"/></td>
			                                                <td><img style="width:75px;height: 50px" src="${cellphonelog.idcardFacade}"/></td>
			                                                <td><img style="width:75px;height: 50px" src="${cellphonelog.idcardBack}"/></td>
                                                            <td id="stb${cellphonelog.id}">
	                                                            <c:if test="${cellphonelog.status == 0}">未审核</c:if>
	                                                            <c:if test="${cellphonelog.status == 1}">已通过</c:if>
	                                                            <c:if test="${cellphonelog.status == 2}">未通过</c:if>
	                                                            <c:if test="${cellphonelog.status == 3}">更换完成</c:if>                                                        
                                                            </td>
			                                             </tr>
                           
		                                            </c:forEach>
	                                            </c:when>	                      
	                                        </c:choose>
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                       		    <td colspan="8"><div id="cellphone-page">没有数据~</div></td>
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
         <div class="modal hide fade" style="width:400px; height:180px;" id="authorizationDiv" role="dialog" >
			<form id="fmg" class="modal-content form-horizontal password-modal" >
           	  <input type="hidden" id="id" name="id">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4>请确认审核结果！</h4>
		      </div>
		      <div class="modal-body span6">
			      	<div class="row-fluid">
						<div class="span4">
							<div class="control-group">
								<input type="radio" id="toplaywith" name="audit" value="TOPLAYWITH" checked="checked">
								<span>通过</span>
							</div>
						</div>
						<div class="span4">
							<div class="control-group">
								<input type="radio" id="auditdidnotpass" name="audit" value="AUDITDIDNOTPASS">
								<span>不通过</span>
							</div>
						</div>
					</div>
			  </div>
		      <div style="margin-left:80px;margin-top:60px;">
		        <button type="button" style="vertical-align:middle;" class="btn btn-primary" onclick="setStatus()">确认</button>
		        <button type="button" class="btn btn-default" onclick="quitAudition()">取消</button>
		      </div>
			</form>		   
		</div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
	</body>
	<script src="${pageContext.request.contextPath}/js/show.original.image.js"></script>
	<script type="text/javascript">

		var rowId = 0;
		var status = '';
		var timer ='';
		$('.breadcrumb').html('<li class="active">审核管理&nbsp;/&nbsp;更换手机号</li>');
		$('.marginTop').css('margin', '5px auto auto auto');
		$(document).ready(function(){  	
		    timer = window.setInterval(reloadimg, 1000);		        
			$('#420').hide();				
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
		            	$('#search').attr('action','${pageContext.request.contextPath}/cellphonelog/list/'+page);
		                $('#search').submit();
		            }  
			    };
				$('#cellphone-page').bootstrapPaginator(options);
			}
			var workImg=document.getElementsByTagName('img'); 
			for(var i=0; i<workImg.length; i++) {
				workImg[i].onclick=ImgShow;
			}
		});
	
		function audit(){
		    if (rowId > 0) {
			    $('#errorMsg').hide();
			    $('#authorizationDiv').modal('show');
		    } else {
			    alert('请选择一条(待审批)的数据!');
		    }
	    }
		
		var newCellphone = null;
		var oldCellphone = null;
		function getRow(tr, color) {
			$('#420').hide();
			if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
				$(tr).css('background-color', 'white');
				rowId = 0;
				$('#420').hide();
			} else {
				$('#message'+rowId).css('background-color', 'white');
				$(tr).css('background-color', color);
				rowId = tr.getElementsByTagName('td')[0].innerHTML;	
				status = tr.getElementsByTagName('td')[8].innerHTML;
				oldCellphone= tr.getElementsByTagName('td')[3].innerHTML;
				newCellphone= tr.getElementsByTagName('td')[4].innerHTML;
				if($.trim(status)=='未审核') {
					$('#420').show();
				} else {
					$('#420').hide();
				}
			}
		}	
		
		function quitAudition() {
			$('#authorizationDiv').modal('hide');
		}
		
	    function setStatus(){
	    	if (rowId > 0 && newCellphone) {
			    var result = $('[name=audit]').filter(':checked').attr('value');
			    var status = 0;
			    if(result == 'TOPLAYWITH') {
			    	status = 1;
			    } else {
			    	status = 2;
			    }
			   	$.ajax({
		             type: "post",
		             url: "${pageContext.request.contextPath}/cellphonelog/audit/"+rowId+'/'+status,	             
		             dataType: "json",
		             success: function(data){
	           	         if(data==-1){
	           	            alert("新手机号码已存在");
	           	         }else if(data==1){
	           	        	$('#authorizationDiv').modal('hide');
	           	        	location.href='${pageContext.request.contextPath}/cellphonelog/list/${page}';
	           	        	$.post('${pageContext.request.contextPath}/log/cellphone/smscode', {'status':status, 'cellphone':newCellphone}, function(result){
	           	        	});
	           	         }else{
	           	        	location.href='${pageContext.request.contextPath}/cellphonelog/list/${page}';
	           	        }                       
		            }
		       });
		    } else {
			    alert('请选择一条[待审核]的数据');
		    }
		} 
	    
		function viewImg(src) {
			$('.viewIimg').show();
		    $('.viewIimg').html("<img style='width: 100%' src='"+src+"'/>");
		}	
		
		$(".viewIimg").click(function(){
			$(this).html('');
			$(this).hide();
		});		
		function resetData() {
		    $('#oldCellphone').val('');
		}
		function reloadimg(){
			var n=0;
			if(isIE = navigator.userAgent.indexOf("MSIE")!=-1) { 
			    $("img").each(function(){		    
				    if (!this.complete) {
				         var imgcrc=this.src+"?100";
				         this.src=imgcrc;	
					     n=1; 		   			    
				    }					      		    
			    });	         
	         }else{			              
                if(document.readyState=="complete") {     
				    $("img").each(function(){		    
					    if (this.complete) {
					         var imgcrc=this.src;
					         this.src=imgcrc;	   			    
					    }else{						  
							 n=1;							  
						}  					      		    
				    });	    		               		                                    		                   		                   
                }else{
                    n=1;
                }           
	         } 		
		     if (n==0) {
		        clearInterval(timer);
		     } else {		        
		        n=0; 
		     }	
		      			    
		}
					
	</script>
	<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>