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
                <form id="searchForm" action="${pageContext.request.contextPath}/banner/list/1/7" method="post" class="form-search"  style="margin: 0px">
                    <div id="search" style="position:relative; left:6px;">
                        <span >显示平台</span>
                        <select class="marginTop" id="dPlatform" name="dPlatform" style="width:163px">
                            <option value="-1">全部</option>
                            <option value="1">app</option>
                            <option value="2">web</option>
                        </select>
                        <a href="javascript:search();" id="226"><button type="button" class="btn">查询</button></a>
                    </div>
                </form>
            </div>
            <div class="row-fluid">
                <div class="block">
                    <div id="authorityButton" class="navbar navbar-inner block-header" >
                        <input type="hidden" id="size" name="size" value="${size}" />
                        <a href="javascript:add();" id="2070"><button type="button" class="btn btn-success">新增 </button></a>
                        <a href="javascript:edit();" id="2072"><button type="button" class="btn btn-primary">编辑 </button></a>
                        <a href="javascript:detail();" id="2071"><button type="button" class="btn btn-primary" >查看</button></a>
                        <a href="javascript:enable(1);" id="2073"><button type="button" class="btn btn-primary">启用</button></a>
                        <a href="javascript:enable(0);" id="2074"><button type="button" class="btn btn-primary">禁用</button></a>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table id="images" class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>名称</th>
                                    <th>缩略图</th>
                                    <th>显示平台</th>
                                    <!-- <th>排序</th> -->
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody class="bannerSortable">
                                <c:choose>
                                    <c:when test="${fn:length(activityEntrance) > 0}">
                                        <c:forEach var ="image" items="${activityEntrance}" varStatus="status">
                                            <tr onclick="getRow(this, '#BFBFBF')" id="appId${image.id}N${image.sortNumber}">
                                                <td class="hidden">${image.id}</td>
                                                <td class="vertical">${status.count}</td>
                                                <td class="vertical">${image.name}</td>
                                                <td class="vertical"><img class="thumbnail" src="${image.url}" style="height: 60px;width: 100px"/></td>
                                                <td class="vertical"><c:if test="${image.displayPlatform > 1}">web</c:if><c:if test="${image.displayPlatform < 2}">app</c:if></td>
                                                <td class="vertical hidden">${image.sortNumber}</td>
                                                <td class="vertical"><c:if test="${image.status > 0}">启用</c:if><c:if test="${image.status < 1}">禁用</c:if></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="10">暂时没有广告图数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="10"><div id="image-page"></div></td>
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
<jsp:include page="${pageContext.request.contextPath}/footer" flush="true" />
</body>
<script type="text/javascript">
    $('#2074').hide();
    $('#2073').hide();
    $('#2072').hide();
    $('.vertical').css('vertical-align', 'middle');
    $('.thumbnailSize').css('height', '60px');
    $('.breadcrumb').html('<li class="active">图片管理 &nbsp;/&nbsp;弹窗公告管理</li>');

    $(document).ready(function(){
        $('.marginTop').css('margin', '2px auto auto auto');
        $('#dPlatform').find("option[value='${dPlatform}']").attr('selected',true);
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
                    $('#searchForm').attr('action','${pageContext.request.contextPath}/banner/list/'+page+'/7');
                    $('#searchForm').submit();
                }
            };
            $('#image-page').bootstrapPaginator(options);
        }
        changeSort('${pageContext.request.contextPath}/banner/change/sort','bannerSortable','tr:contains("\u542f\u7528")',/appId/g,'N');
        $( ".bannerSortable" ).sortable("disable");
    });

    function search() {
        $('#searchForm').attr('action','${pageContext.request.contextPath}/banner/list/1/7');
        $('#searchForm').submit();
    }

    function add() {
        window.location.href = '${pageContext.request.contextPath}/banner/notice/add';
    }

    function edit() {
        if (rowId > 0) {
            $('#searchForm').attr('action','${pageContext.request.contextPath}/banner/notice/edit/' + rowId);
            $('#searchForm').attr('method','get');
            $('#searchForm').submit();
        } else {
            alert('请选择一条要修改的数据');
        }
    }

    function detail() {
        if (rowId > 0) {
            $('#searchForm').attr('action','${pageContext.request.contextPath}/banner/notice/detail/' + rowId );
            $('#searchForm').attr('method','get');
            $('#searchForm').submit();
        } else {
            alert('请选择一条要查看的数据');
        }
    }

    var rowId = 0;
    var sortNumber = 0;
    $('#2071').hide();
    function getRow(tr, color) {
        if (rowId == tr.getElementsByTagName('td')[0].innerHTML) {
            $(tr).css('background-color', 'white');
            rowId = 0;
            $('#2071').hide();
            $('#2073').hide();
            $('#2074').hide();
            $('#2072').hide();
        } else {
            $('#2071').show();
            $('#appId'+rowId+'N'+sortNumber).css('background-color', 'white');
            $(tr).css('background-color', color);
            rowId = $.trim(tr.getElementsByTagName("td")[0].innerHTML);
            sortNumber = $.trim(tr.getElementsByTagName('td')[5].innerHTML);
            var status = $.trim(tr.getElementsByTagName('td')[6].innerHTML);
            if (status == '禁用') {
                $('#2072').show();
                $('#2073').show();
                $('#2074').hide();
            } else if (status == '启用') {
                $('#2072').hide();
                $('#2073').hide();
                $('#2074').show();
            }
        }
    }

    function enable(value) { 
    $.ajaxSettings.async = false;
   	var flag = true ;
    	if(value == 1 ){
    	    var image= null;
    		var imglist= eval('${activityEntrance}');
    		for (var i = 0; i < imglist.length; i++) {
				if(imglist[i].id ==rowId){
					image=imglist[i];
					break;
				} 
			}
    		$.post('${pageContext.request.contextPath}/banner/notice/all', function(result){
    			if(result.code){
    				var allimages=result.list;
		    		for(var i = 0; i < allimages.length; i++){
		    			if(allimages[i].id == rowId){
		    				continue;
		    			}
		    			if(allimages[i].displayPlatform == image.displayPlatform){
		    				if(allimages[i].status >0){
		    					flag=false;
		    					alert("请禁用掉相同显示平台的其他广告弹窗数据");
		    				}
		    			}
		    		}
    			}
    		});	
    	}
    	if(flag){
	        $.post('${pageContext.request.contextPath}/banner/enable/'+rowId+'/'+value, function(result){
	            if (result) {
	                $('#searchForm').attr('action','${pageContext.request.contextPath}/banner/list/1/7');
	                $('#searchForm').submit();
	            }
	        }, 'json');
    	}
    }

    $('#search').css('visibility','visible');
    $('#search').children().show();
</script>
<jsp:include page="${pageContext.request.contextPath}/authority" flush="true" />
</html>