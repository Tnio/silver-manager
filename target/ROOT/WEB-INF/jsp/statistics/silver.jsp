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
                    <!-- content begin -->
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <div class="block-content collapse in">
	                            <form id="search" action="${pageContext.request.contextPath}/statistics/silver" method="post" >
	                            	<div class="input-group">
	                           			<div class="input-group marginDivTop" >
		                           			<span>时间</span> 
		                           				<input type="text" id="beginTime" name="beginTime" value="${beginTime}" class="marginTop span2" onkeypress="return false" style="background: white; width:163px"/> 至
		                           				<input type="text" id="endTime" name="endTime"  value="${endTime}" class="marginTop span2" onkeypress="return false" style="background: white; width:163px" />
		                                    <input type="submit" class="btn btn-default span1" value="查询"/>
	                                    </div>
	                                 </div>
	                            </form>
                                <div class="span12">
                               		<div class="span5"id="obtainCharts"></div>
	                               		<div class="span5">
		                                	<table id="obtainSilvers" cellpadding="0" cellspacing="0" border="0" class="table" >
		                                        <thead>
		                                            <tr>
		                                                <th class="center">银子获得渠道</th>
		                                                <th class="center">银子数量（两）</th>
		                                                <th class="center">占比（%）</th>
		                                            </tr>
		                                        </thead>
		                                        <tbody>
		                                        	<c:choose>
		                                        		<c:when test="${fn:length(obtainSilvers) > 0}">
		                                        			<c:forEach var ="obtain" items="${obtainSilvers}" varStatus="status">
		                                        				<tr>
		                                        					<td class="longcss" >${obtain.channel}</td>
		                                        					<td class="longcss" >${obtain.amount}</td>
		                                        					<td class="longcss" ><fmt:formatNumber value="${obtain.amount*100/obtainTotal}" pattern="##0" maxFractionDigits="1"/></td>
		                                        				</tr>
		                                        			</c:forEach>
		                                        		</c:when>
		                                        		<c:otherwise>
		                                        			<tr>
		                                        				<td colspan="6">暂时没有获得银子数据</td>
		                                        			</tr>
		                                        		</c:otherwise>
		                                        	</c:choose>
		                                        </tbody>
		                                   	</table>
	                                   	</div>
	                                </div>
	                                <div class="span5"id="consumeCharts"></div>
                               			<div class="span5">
		                                    <table id="consumeSilvers" cellpadding="0" cellspacing="0" border="0" class="table" >
		                                        <thead>
		                                            <tr>
		                                                <th class="center">银子使用渠道</th>
		                                                <th class="center">银子数量（两）</th>
		                                                <th class="center">占比（%）</th>
		                                            </tr>
		                                        </thead>
		                                        <tbody>
		                                        	<c:choose>
		                                        		<c:when test="${fn:length(consumeSilvers) > 0}">
		                                        			<c:forEach var ="consume" items="${consumeSilvers}" varStatus="status">
		                                        				<tr>
		                                        					<td class="longcss" >${consume.channel}</td>
		                                        					<td class="longcss" >${0-consume.amount}</td>
		                                        					<td class="longcss" ><fmt:formatNumber value="${consume.amount*100/consumeTotal}" pattern="##0" maxFractionDigits="1"/></td>
		                                        				</tr>
		                                        			</c:forEach>
		                                        		</c:when>
		                                        		<c:otherwise>
		                                        			<tr>
		                                        				<td colspan="6">暂时没有使用银子数据</td>
		                                        			</tr>
		                                        		</c:otherwise>
		                                        	</c:choose>
		                                        </tbody>
		                                    </table>
		                                </div>
		                        	</div>
	                            </div>
	                        </div>
                        <!-- /block -->
                    </div>
                    <!-- content end -->
                </div>
            </div>
		<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
		<script src="${pageContext.request.contextPath}/plugin/echarts/echarts.js"></script>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.marginTop').css('margin', '2px auto auto auto');
			$('.marginDivTop').css('margin', '10px auto auto auto');
			$('.longcss').css({width:80});
			$('.breadcrumb').html('<li class="active">统计管理&nbsp;/&nbsp;银子统计</li>');
			$('#obtainCharts').css('height', '350px');
			$('#obtainCharts').css('width', '50%');
			$('#consumeCharts').css('height', '350px');
			$('#consumeCharts').css('width', '50%');
			$.ajaxSetup({
		    	async: false
		    });
			statistics('obtain');
			statistics('consume');
			
			$('#beginTime').datetimepicker({
				format:'Y-m-d',
				maxDate:new Date().toLocaleDateString(),
				lang:'ch',
				timepicker:false,
				scrollInput:false,
				onShow:function() {
					if ($('td').hasClass('xdsoft_other_month')) {
						$('td').removeClass('xdsoft_other_month');
					} 
				},
				onSelectDate:function() {
					getBeginTime();
				}
			});
			
			$('#endTime').datetimepicker({
				 format:'Y-m-d',
				 maxDate:new Date().toLocaleDateString(),
				 lang:'ch',
				 timepicker:false,
				 scrollInput:false,
				 onShow:function() {
					if ($('td').hasClass('xdsoft_other_month')) {
						$('td').removeClass('xdsoft_other_month');
					} 
				},
				onSelectDate:function() {
					getEndTime();
				}
			});
			getBeginTime();
			getEndTime();
			
		});
		
		function getBeginTime(){
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
		
		function getEndTime(){
			var toDate = $('#endTime').val();
			var endDate = new Date(Date.parse(toDate.replace(/-/g,"/")));
			$('#beginTime').datetimepicker({
				format:'Y-m-d',
				maxDate:endDate.getFullYear()+'/'+(endDate.getMonth()+1)+'/'+endDate.getDate(),
				lang:'ch',
				timepicker:false
			});
		}
		
		function statistics(category){
			var chart = echarts.init(document.getElementById(category+'Charts'));
			$(window).resize(function () {
				chart.resize();
			});
			var text = '';
			var silvers=[];
			if(category =='obtain'){
				text = '获得'; 
				silvers='${obtainSilvers}';
			}else{
				text = '消耗';
				silvers='${consumeSilvers}';
			}
			option = {
			    title : {
			        text: '银子'+text+'情况统计',
			        x:'center'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    noDataLoadingOption: {
                    text: '暂无数据',
                    effect: 'bubble',
                    effectOption: {
                        effect: {
                            n: 0
                        }
                    },
                    textStyle : {
                        fontSize : 32
                    }
				},
			    series : [{
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data: function(){
		            	if (silvers) {
			            	var serie=[];
							obtains = eval(silvers);
							for (var i = 0; i < obtains.length; i++) {
								var item={
						        	name:obtains[i].channel,
						            value:obtains[i].amount
								};
						        serie.push(item);
							}
							return serie;
		            	}
					}(),
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
			    }]
			};
			chart.setOption(option,true);
		};
	
	</script>
</html>