<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="${pageContext.request.contextPath}/header" flush="true" />
<body>
<jsp:include page="${pageContext.request.contextPath}/menu" flush="true" />
<div class="container-fluid">
    <div class="row-fluid">
        <jsp:include page="${pageContext.request.contextPath}/sidebar" flush="true" />
        <div class="span10">
            <!-- content begin -->
            <div class="row-fluid">
                <!-- block -->
                <div class="block">
                    <jsp:include page="${pageContext.request.contextPath}/breadcrumb" flush="true" />
                    <div class="block-content collapse in">
                        <form id="fm" action="${pageContext.request.contextPath}/silver/earn/save" method="post" enctype="multipart/form-data" class="form-horizontal" >
                            <input id="id" name="id" value="${earnSilver.id}" type="hidden">
                            <div class="well" style="padding-bottom: 20px; margin: 0;">
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>任务名称</label>
                                            <div class="controls">
                                                <input type="text" id="name" name="name" value="${earnSilver.name}" class="validate[required,maxSize[16]] text-input span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>任务类型</label>
                                            <div class="controls">
                                                <c:choose>
                                                    <c:when test="${earnSilver.type == 1}">
                                                        <input type="text" value="一次性任务" class="span12" readonly/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="text" value="每日任务" class="span12" readonly/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>奖励文案</label>
                                            <div class="controls">
                                                <input type="text" id="content" name="content" value="${earnSilver.content}" class="validate[required,maxSize[30]] text-input span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="shareContentId" class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>分享文案</label>
                                            <div class="controls">
                                                <input type="text" id="shareContent" name="shareContent" value="${earnSilver.shareContent}" class="validate[maxSize[30]] text-input span12" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="shareId" class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>每次分享奖励</label>
                                            <div class="controls">
                                                <input type="text" id="giveSilver" name="giveSilver" value="${earnSilver.giveSilver}" class="validate[custom[integer],min[0],max[99999]] text-input span11" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>两
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label"><span class="required">*</span>每天最多奖励</label>
                                            <div class="controls">
                                                <input type="text" id="shareNum" name="shareNum" value="${earnSilver.shareNum}" class="validate[custom[integer],min[0],max[9]] text-input span11" onkeyup="this.value=this.value.replace(/(^\s*)/g,'')" onblur="this.value=this.value.replace(/(\s*$)/g,'')"/>次
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group" id="addressId">
                                    <label class="control-label"><span class="required">*</span>跳转地址</label>
                                    <div class="controls">
                                        <input type="text" id="address" name="address" value="${earnSilver.address}" class="validate[maxSize[200]] text-input span12" />
                                    </div>
                                </div>
                                <div class="control-group" id="shareNewsId">
                                    <label class="control-label"><span class="required">*</span>分享页面</label>
                                    <div class="controls">
                                        <input type="hidden" id="newsId" name="news.id" value="${earnSilver.news.id}"/>
                                        <input type="text" id="title" value="${earnSilver.news.title}" readonly onclick="showNewsDialog(0)" class="text-input span11" />
                                        <a type="button" class="btn btn-icon btn-default" href="javascript:preview();">预览</a>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" id="save" class="btn btn-icon btn-primary glyphicons circle_ok">保存</button>
                                    <a id="reset" class="btn btn-icon btn-default glyphicons circle_remove" href="javascript:quit();">返回</a>
                                </div>
                            </div>
                        </form>
                        <div class="modal hide fade" id="news" role="dialog" >
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <h4 class="modal-title" id="myModalLabel">选择新闻素材</h4>
                                    </div>
                                    <div class="modal-body">
                                        <table cellpadding="0" cellspacing="0" border="0" class="table table-striped">
                                            <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>新闻标题</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody id="newsBody"></tbody>
                                            <tfoot>
                                            <tr>
                                                <td colspan="5">
                                                    <div id="news-page"></div>
                                                </td>
                                            </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal hide fade" id="preview" role="dialog" style="width:320px;height:568px;">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <a type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </a>
                                        <h3 id="news_title"></h3>
                                    </div>
                                    <div class="modal-body" id="news_content" style="padding:0px;min-height:450px;">
                                    </div>
                                    <div class="modal-footer">
                                        <a class="btn" data-dismiss="modal" aria-hidden="true">关闭</a>
                                    </div>
                                </div>
                            </div>
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
<script type="text/javascript">
    $(function(){
        var silverId = '${earnSilver.id}';
        if(silverId == 1){
            $('#shareContentId').hide();
            $('#shareId').hide();
            $('#shareNewsId').hide();
            $('#addressId').show();
            $('#address').attr('required', true);
        }else if(silverId == 3){
            $('#shareContentId').show();
            $('#shareId').show();
            $('#shareNewsId').show();
            $('#address').attr('disabled', 'true');
            $('#addressId').hide();
            $('#shareContent').attr('required', true);
            $('#giveSilver').attr('required', true);
            $('#shareNum').attr('required', true);
            $('#newsId').attr('required', true);
        }else{
            $('#shareContentId').hide();
            $('#shareId').hide();
            $('#shareNewsId').hide();
            $('#addressId').show();
            $('#address').attr('disabled', 'false');
        }

        if('${operation}' == 'edit'){
            $('.breadcrumb').html('<li class="active"><li class="active">银子管理&nbsp;/&nbsp;<a href="javascript:quit();">赚银子&nbsp;</a>/&nbsp;编辑</li>');
            $('#save').show();
        }else{
            $('.breadcrumb').html('<li class="active"><li class="active">银子管理&nbsp;/&nbsp;<a href="javascript:quit();">赚银子&nbsp;</a>/&nbsp;查看</li>');
            $('#save').hide();
            readOnly();
        }
        $('#fm').validationEngine('attach', {
            promptPosition:'bottomLeft',
            showOneMessage: true,
            focusFirstField: true,
            scroll: true
        });
    });

    var newsList=null;

    function readOnly(){
        var a = document.getElementsByTagName("input");
        for(var i=0; i<a.length; i++)   {
            if(a[i].type=="text"){
                a[i].readOnly = true;
                a[i].disabled = "disabled";
            }
        }

        var d = document.getElementsByTagName("button");
        for (var i=0; i<d.length; i++) {
            d[i].disabled="disabled";
        }
    }

    function showNewsDialog(){
        getNews(1);
        $('#news').modal('show');
    }

    function getNews(page){
        $.post('${pageContext.request.contextPath}/message/news/all/'+page, function(result){
            if (result.total > 0) {
                $('#newsBody').html("");
                newsList = result.newsList;
                for (var i = 0; i < result.newsList.length; i++) {
                    var news = result.newsList[i];
                    $('#newsBody').append('<tr>');
                    $('#newsBody').append('<td class="hidden">'+news.id+'</td>');
                    $('#newsBody').append('<td>'+(i+1)+'</td>');
                    $('#newsBody').append('<td>'+news.title+'</td>');
                    $('#newsBody').append('<td><a href=javascript:choiceNews('+news.id+');>选择</a></td>');
                    $('#newsBody').append('</tr>');
                }

                var totalPages = Math.ceil(result.total/15);
                var options = {
                    currentPage: result.newsPage,
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
                        getNews(page);
                    }
                };
                $('#news-page').bootstrapPaginator(options);
            }else{
                $('#newsBody').html('<tr><td colspan="3">请先添加新闻素材</td></tr>');
            }
        });
    }

    function choiceNews(id){
        for(var i = 0; i < newsList.length; i++){
            if(newsList[i].id == id){
                $('#title').val(newsList[i].title);
            }
        }
        $('#newsId').val(id);
        $('#title').focus();
        $('#title').blur();
        $('#news').modal('hide');
    }

    function preview(){
        if($('#newsId').val()>0){
            $.post('${pageContext.request.contextPath}/message/news/'+$('#newsId').val()).done(function(res){
                $('#news_title').html(res.title);
                $('#news_content').empty();
                var pdom = $('<p style="padding: 5px 0;">').append('来源：'+res.source)
                    .append('&nbsp;&nbsp;&nbsp;&nbsp;')
                    .append(new Date(res.createTime).format('yyyy-MM-dd HH:mm:ss'));
                $('#news_content').append(pdom);
                if(res.type==1){
                    $('#news_content').append('<p>'+res.content+'</p>');
                }else{
                    $('#news_content').append('<iframe src="'+res.link+'" style="border:none;width:320px;min-height:410px;" scrolling="auto"></iframe>');
                }
                $('#preview').modal('show');
            });
        }
    }

    function quit() {
        window.location.href='${pageContext.request.contextPath}/silver/earn';
    }
</script>
</body>
</html>