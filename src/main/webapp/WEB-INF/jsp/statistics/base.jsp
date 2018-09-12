<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                    <!-- content begin -->
                    <div class="row-fluid">
                    	<div class="block" style="border: 0px solid #ccc;">
                    		<table align="left" >
						        <tr>
						        	<td height="60" colspan="4" rowspan="4"><a href="javascript:counToday();"><img src="${pageContext.request.contextPath}/images/main_today_user.png" alt="" /></a></td>
						        	<td>&nbsp;</td>
						        	<td height="60" colspan="4" rowspan="4"><a href="javascript:countTodayCustomer();"><img src="${pageContext.request.contextPath}/images/main_new_customer.png" alt="" /></a></td>
						        	<td>&nbsp;</td>
							        <td height="60" colspan="4" rowspan="4"><a href="javascript:counOrder();"><img src="${pageContext.request.contextPath}/images/main_order.png" alt="" /></a></td>
							        <td>&nbsp;</td>
							        <td height="60" colspan="4" rowspan="4"><a href="javascript:counMoney();"><img src="${pageContext.request.contextPath}/images/main_money.png" alt="" /></a></td>
							        <td>&nbsp;</td>
						      	</tr>
						      	<tr>
							        <td class="tdWidth">今日新增用户</td>
							        <td class="tdWidth">今日新增交易用户</td>
							        <td class="tdWidth">今日交易笔数</td>
							        <td class="tdWidth">今日交易总金额(元)</td>
							    </tr>
							    <tr>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							    </tr>
							    <tr>
							        <td class="stronger">${allCustomerAtToday}</td>
							        <td class="stronger">${todayCustomer}</td>
							        <td><span class="stronger">${currentCommonOrder}</span><br></td>
							        <td><span class="stronger"><fmt:formatNumber value="${currentCommonMoney}" pattern="#,##0" /></span></td>
							    </tr>
							    <tr>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							    </tr>
							    <tr>
							    	<td colspan="25"><hr class="separator" ></td>
							    </tr>  
							    <tr>
							    	<td colspan="25"><div id="charts"></div></td>
							    </tr> 
						    </table>
                        </div>		
                    </div>
                    <!-- content end -->
                </div>
            </div>
        </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/plugin/echarts/echarts.js"></script>
	</body>
	<script type="text/javascript">
		$('.breadcrumb').html('<li class="active">统计管理&nbsp;/&nbsp;基础信息</li>');
		$('.stronger').css('font-weight', 'bold');
		$('.stronger').css('font-size', '24px');
		$('.tdWidth').css('width', '200px');
		$('#charts').css('height', '460px');
		$('#charts').css('width', '100%');
		$.ajaxSetup({
	    	async: false
	    });
		var chart = echarts.init(document.getElementById('charts'));
		$(window).resize(function () {
			chart.resize();
		});
	    var option = {
    	    title : {
    	        text: '用户总数'
    	    },
    	    tooltip : {
    	        trigger: 'axis',
    	        //backgroundColor : 'red',
    	        formatter: function (params,ticket,callback) {
		            var res = params[0].name;
		            for (var i = 0, l = params.length; i < l; i++) {
		                res += '<br/>' + params[i].seriesName + '&nbsp;&nbsp;当前数量:' + params[i].value;
		            }
		            setTimeout(function (){
		                callback(ticket, res);
		            }, 100);
		            return 'loading';
		        },
    	        axisPointer : {
    	        	type: 'line',
    	            lineStyle: {
    	                color: 'blank',
    	                width: 2,
    	                type: 'solid'
    	            }
    	        }
    	    },
    	    legend: {
    	        data:['今日','昨日'],
    	        orient:'vertical' 
    	    },
    	    calculable : false,
    	    xAxis : [
    	        {
    	            type : 'category',
    	            axisLine : {
    	            	show : true,
    	            	lineStyle : {         
    	            		color : 'blank'
    	            	}
    	            },
    	            boundaryGap : false,
    	            data : ['1点','2点','3点','4点','5点','6点','7点','8点','9点','10点','11点','12点','13点','14点','15点','16点','17点','18点','19点','20点','21点','22点','23点','24点']
    	        }
    	    ],
    	    yAxis : [
    	        {
    	            type : 'value',
    	            axisLine : {
    	            	show : true,
    	            	lineStyle : {
    	            		color : 'blank'
    	            	}
    	            },
    	            axisLabel : {
    	                formatter: function(data){
    	                    return formatNumber(data,'#,##0');
    	                }
    	            }
    	        }
    	    ],
    	    series : [
    	        {
    	            name:'今日',
    	            type:'line',
    	            smooth:true,
    	            itemStyle: {
    	                normal: {
    	                    color: 'orange',
    	                    lineStyle: {      
    	                        width: 2,
    	                        type: 'dashed'
    	                    }
    	                },
    	                emphasis: {
    	                    color: 'blank'
    	                }
    	            },
    	            data:[]
    	        },
    	        {
    	            name:'昨日',
    	            type:'line',
    	            smooth:true,
    	            itemStyle: {
    	                normal: {
    	                	color: 'blue',
    	                    lineStyle: {      
    	                        width: 2,
    	                        type: 'dashed'
    	                    }
    	                },
    	                emphasis: {
    	                    color: 'blank'
    	                }
    	            },
    	            data:[]
    	        }
    	    ]
    	};
	    counToday();
	    
	    function countTodayCustomer() {
	    	var todayLegendName = '今日总数:';
	    	var yestoayLegendName = '昨日总数:';
	    	var amount = 0;
	    	option.title.text='今日新增交易用户';
	    	$.get('${pageContext.request.contextPath}/trade/customer/current/yestoday', function(result){ 
		    	if (result.length > 0) {
		    		for (var i = 0; i < result.length; i++) {
		    			option.series[1].data[i] = result[i];
			    		amount += result[i];
		    		}
				}
	        });
		    
		    $.get('${pageContext.request.contextPath}/trade/customer/current/today', function(result){
		    	if (result.length > 0) {
		    		for (var i = 0; i < result.length; i++) {
			    		option.series[0].data[i] = result[i];
		    		}
				}
	        });
		    option.tooltip.formatter = function (params,ticket,callback) {
		    	var beginPoint = (parseInt(params[0].name) - 1);
	            var res = beginPoint + '点-' +params[0].name;
	            for (var i = 0, l = params.length; i < l; i++) {
	                res += '<br/>' + params[i].seriesName + '&nbsp;&nbsp;当前数量:' + params[i].value;
	            }
	            setTimeout(function (){
	                callback(ticket, res);
	            }, 100);
	            return 'loading';
	        };
    		yestoayLegendName += amount;
    		todayLegendName += '${todayCustomer}';
    		option.series[0].name = todayLegendName;
    		option.series[1].name = yestoayLegendName;
    		option.legend.data[0] = todayLegendName;
	    	option.legend.data[1] = yestoayLegendName;
	    	chart.setOption(option,true); 
	    	chart.refresh();
	    }
        
	    function counToday() {
	    	var todayLegendName = '今日总数:';
	    	var yestoayLegendName = '昨日总数:';
	    	var amount = 0;
	    	option.title.text='今日新增用户';
	    	$.get('${pageContext.request.contextPath}/customer/current/yestoday', function(result){  
		    	if (result.length > 0) {
		    		for (var i = 0; i < result.length; i++) {
		    			option.series[1].data[i] = result[i];
			    		amount += result[i];
		    		}
				}
	        });
		    
		    $.get('${pageContext.request.contextPath}/customer/current/today', function(result){  
		    	if (result.length > 0) {
		    		for (var i = 0; i < result.length; i++) {
			    		option.series[0].data[i] = result[i];
		    		}
				}
	        });
		    option.tooltip.formatter = function (params,ticket,callback) {
	            var beginPoint = (parseInt(params[0].name) - 1);
	            var res = beginPoint + '点-' +params[0].name;
	            for (var i = 0, l = params.length; i < l; i++) {
	                res += '<br/>' + params[i].seriesName + '&nbsp;&nbsp;当前数量:' + params[i].value;
	            }
	            setTimeout(function (){
	                callback(ticket, res);
	            }, 100);
	            return 'loading';
	        };
    		todayLegendName += '${allCustomerAtToday}';
    		option.series[0].name = todayLegendName;
    		option.legend.data[0] = todayLegendName;
    		yestoayLegendName += amount;
    		option.series[1].name = yestoayLegendName;
	    	option.legend.data[1] = yestoayLegendName;
	    	chart.setOption(option,true); 
	    	chart.refresh();
	    }
	    
	    function counOrder() {
	    	var todayLegendName = '今日笔数:';
	    	var yestoayLegendName = '昨日笔数:';
	    	var amount = 0;
	    	option.title.text='今日交易笔数';
	    	var commonDataArry = new Array();
	    	$.get('${pageContext.request.contextPath}/customer/order/current/yestoday', function(result){  
	    		if (result['common'].length > 0) {
	    			commonDataArry[1] = result['common'];
	    			for (var i = 0; i < result['common'].length; i++) {
		    			var commonData = result['common'][i];
			    		option.series[1].data[i] = commonData;
			    		amount += commonData;
		    		}
				}
	        });
		    
		    $.get('${pageContext.request.contextPath}/customer/order/current/today', function(result){  
		    	if (result['common'].length > 0) {
	    			commonDataArry[0] = result['common'];
		    		for (var i = 0; i < result['common'].length; i++) {
		    			var commonData = result['common'][i];
			    		option.series[0].data[i] = commonData;
		    		}
				}
	        });
		    yestoayLegendName += amount;
    		todayLegendName += '${currentCommonOrder}';
    		option.tooltip.formatter = function (params,ticket,callback) {
    			var beginPoint = (parseInt(params[0].name) - 1);
	            var res = beginPoint + '点-' +params[0].name;
	            for (var i = 0; i < params.length; i++) {
	            	var point = parseInt(params[i]['1'])-1;
	            	var commonAmount = commonDataArry[i][point];
	            	if (isNaN(commonAmount)) {
	            		commonAmount = '-';
	            	}
	                res += '<br/>' + params[i].seriesName + '&nbsp;&nbsp;当前笔数:' + commonAmount;
	            }
	            setTimeout(function (){
	                callback(ticket, res);
	            }, 100);
	            return 'loading';
	        };
    		option.series[0].name = todayLegendName;
    		option.series[1].name = yestoayLegendName;
    		option.legend.data[0] = todayLegendName;
	    	option.legend.data[1] = yestoayLegendName;
	    	chart.setOption(option,true); 
	    	chart.refresh();
	    }
	    
	    function counMoney() {
	    	var todayLegendName = '今日金额:';
	    	var yestoayLegendName = '昨日金额:';
	    	var amount = 0;
	    	option.title.text='今日交易总金额(元)';
	    	var commonDataArry = new Array();
	    	$.get('${pageContext.request.contextPath}/order/principal/current/yestoday', function(result){  
	    		if (result['common'].length > 0) {
	    			commonDataArry[1] = result['common'];
	    			for (var i = 0; i < result['common'].length; i++) {
		    			var commonData = result['common'][i];
			    		option.series[1].data[i] = commonData;
			    		amount += commonData;
		    		}
				}
	        });
		    
		    $.get('${pageContext.request.contextPath}/order/principal/current/today', function(result){  
		    	if (result['common'].length > 0) {
	    			commonDataArry[0] = result['common'];
		    		for (var i = 0; i < result['common'].length; i++) {
		    			var commonData = result['common'][i];
			    		option.series[0].data[i] = commonData;
		    		}
				}
	        });
		    
		    yestoayLegendName += formatNumber(amount,'#,##0');
    		todayLegendName += formatNumber('${currentCommonMoney}','#,##0');
    		option.tooltip.formatter = function (params,ticket,callback) {
    			var beginPoint = (parseInt(params[0].name) - 1);
	            var res = beginPoint + '点-' +params[0].name;
	            for (var i = 0; i < params.length; i++) {
	            	var point = parseInt(params[i]['1'])-1;
	            	var commonAmount = commonDataArry[i][point];
	            	if (isNaN(commonAmount)) {
	            		commonAmount = '-';
	            	}
	                res += '<br/>' + params[i].seriesName + '&nbsp;&nbsp;当前金额:' + commonAmount;
	            }
	            setTimeout(function (){
	                callback(ticket, res);
	            }, 100);
	            return 'loading';
	        };
    		option.series[0].name = todayLegendName;
    		option.series[1].name = yestoayLegendName;
    		option.legend.data[0] = todayLegendName;
	    	option.legend.data[1] = yestoayLegendName;
	    	chart.setOption(option,true); 
	    	chart.refresh();
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