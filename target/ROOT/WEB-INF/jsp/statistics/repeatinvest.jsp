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
                     	<form id="search" action="${pageContext.request.contextPath}/statistics/customer/repeat/invest" method="post">
                    		<input type="hidden" id="size" name="size" value="${size}" />
                	  		<div class="input-group pull-left">
                       			<span>回款日期</span>
								<input id="paybackDate" class="marginTop" name="paybackDate" type="text" value="${paybackDate}" />
                        		<input type="submit" value="查询" class="btn btn-default" />
                     		</div>
                 		</form>
                    </div>
                    <div class="row-fluid">
                       	<div class="block">
                       		<div class="navbar navbar-inner block-header">
                       		</div>
	                        <!-- block -->
                            <div class="block-content collapse in">
                                <div class="span12">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th>日期</th>
                                               <th>复投金额</th>
                                               <th>复投金额占比</th>
                                               <th>复投人数</th>
                                               <th>复投人数占比</th>
                                           </tr>
                                       </thead>
                                       <tbody id="data">
                           					<tr>
												<td>${row.paybackDate}</td>
												<td><fmt:formatNumber value="${row.investAmount}" pattern="#,##0" /></td>
												<td><c:if test="${row.paybackAmount == 0}">0</c:if><c:if test="${row.paybackAmount > 0}"><fmt:formatNumber value="${row.investAmount/row.paybackAmount*100}" pattern="#,##0.##" /></c:if>%</td>
												<td><fmt:formatNumber value="${row.investCustomers}" pattern="#,##0" /></td>
												<td><c:if test="${row.paybackCustomers == 0}">0</c:if><c:if test="${row.paybackCustomers > 0}"><fmt:formatNumber value="${row.investCustomers/row.paybackCustomers*100}" pattern="#,##0.##" /></c:if>%</td>
                           					</tr>
                                       </tbody>
                                       <tfoot>
                                       	<c:if test="${hasNext == 1}">
	                                       	<tr>
	                                       		<td colspan="5"><div id="nextDay" style="text-align: center;"><a href="javascript:nextData()"><button class="btn btn-lg" >下一天<i class=""></i></button></a></div></td>
	                                       	</tr>
                                       	</c:if>
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
		var row = 1;
		function nextData(){
			$('#nextDay').hide();
			$.get('${pageContext.request.contextPath}/statistics/customer/reinvest/data', {'paybackDate': addDate('${paybackDate}', row)}, function(result){  
				row++;
				if (result) {
					if (result.hasNext == 0) {
						$('#nextDay').hide();
					} else {
						$('#nextDay').show();
					}
					var html = '<tr>';
					html += '<td>' + result.data.paybackDate + '</td>';
					html += '<td>' + formatNumber(result.data.investAmount,'#,##0') + '</td>';
					html += '<td>';
					if (result.data.paybackAmount == 0) {
						html += '0';
					} else {
						html += formatNumber(result.data.investAmount/result.data.paybackAmount*100,'#,##0.##');
					}
					html += '%</td>';
					html += '<td>' + formatNumber(result.data.investCustomers,'#,##0') + '</td>';
					html += '<td>';
					if (result.data.paybackCustomers == 0) {
						html += '0';
					} else {
						html += formatNumber(result.data.investCustomers/result.data.paybackCustomers*100,'#,##0.##');
					}
					html += '%</td>';
					html += '</tr>';
					$('#data').append(html);
		    	}
	        });
		}
		
		$('.breadcrumb').html('<li class="active">统计管理&nbsp;/&nbsp;复投统计</li>');
		$('.marginTop').css('margin', '2px auto auto auto');
		defaultDate = new Date();
		var yy = defaultDate.getFullYear();      
		var mm = defaultDate.getMonth() + 1;     
		var dd = defaultDate.getDate();  
		mm = mm > 9 ? mm : '0'+mm; 
		dd = dd > 9 ? dd : '0'+dd; 
		currentDate = yy+'-'+mm+'-'+dd;
		
		$('#paybackDate').datetimepicker({
	      	format:'Y-m-d',
		  	lang:'ch',
          	timepicker:false,
          	maxDate:addDate(currentDate, -1),
	  	});
		  
		function addDate(date, num){
			date = new Date(date.replace('-','/').replace('-','/')).valueOf();
			date = date + num * 24 * 60 * 60 * 1000
			date = new Date(date);
			var day = date.getDate();
			if(day.toString().length == 1){
				day = '0' + day;
			}
			var month = date.getMonth() + 1;
			if(month.toString().length == 1){
				month='0'+month;
			}
			return date.getFullYear() + '-' + month + '-' + day;
		}
		  
		  
		  function getDays(startDate, endDate) {
			  var startArr = startDate.split('-');
			  var endArr = endDate.split('-');
			  var eRDate = new Date(endArr[0], endArr[1], endArr[2]);
			  var sRDate = new Date(startArr[0], startArr[1], startArr[2]);
			  return (eRDate-sRDate)/(24*60*60*1000);
		 }
		  
		  function formatNumber(num,pattern){  
			    var strarr = num?num.toString().split('.'):['0'];  
			    var fmtarr = pattern?pattern.split('.'):[''];  
			    var retstr='';  
			    var str = strarr[0];  
			    var fmt = fmtarr[0];  
			    var i = str.length-1;    
			    var comma = false;  
			    for(var f=fmt.length-1;f>=0;f--){  
				    switch(fmt.substr(f,1)){  
				      case '#':  
				        if(i>=0 ) retstr = str.substr(i--,1) + retstr;  
				        break;  
				      case '0':  
				        if(i>=0) retstr = str.substr(i--,1) + retstr;  
				        else retstr = '0' + retstr;  
				        break;  
				      case ',':  
				        comma = true;  
				        retstr=','+retstr;  
				        break;  
				    }  
				}  
			  	if(i>=0){  
				    if(comma){  
				      var l = str.length;  
				      for(;i>=0;i--){  
				        retstr = str.substr(i,1) + retstr;  
				        if(i>0 && ((l-i)%3)==0) retstr = ',' + retstr;   
				      }  
				    }  
				    else retstr = str.substr(0,i+1) + retstr;  
				}  
				retstr = retstr+'.';  
			  	str=strarr.length>1?strarr[1]:'';  
			  	fmt=fmtarr.length>1?fmtarr[1]:'';  
			  	i=0;  
			  	for(var f=0;f<fmt.length;f++){  
				    switch(fmt.substr(f,1)){  
				      case '#':  
				        if(i<str.length) retstr+=str.substr(i++,1);  
				        break;  
				      case '0':  
				        if(i<str.length) retstr+= str.substr(i++,1);  
				        else retstr+='0';  
				        break;  
				    }  
				}  
			  	return retstr.replace(/^,+/,'').replace(/\.$/,'');  
			} 
	</script>
</html>