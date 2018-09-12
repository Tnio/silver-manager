<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
	var roleId = '${sessionsilverfoxkey.role.id}';
	$.get('${pageContext.request.contextPath}/get/function/'+roleId, function(data) {
		if (data && data.length > 0) {
			for (var i = 0; i < data.length; i++) {
				if(data[i] == '131'){
					$( ".productSortable" ).sortable("enable");
				}
				if(data[i] == '202'){
					$( ".goodsSortable" ).sortable("enable");
				}
				if(data[i] == '362'){
					$( ".activitySortable" ).sortable("enable");
				}
				if(data[i] == '242'){
					$( ".faqSortable" ).sortable("enable");
				}
				if(data[i] == '222'){
					$( ".bannerSortable" ).sortable("enable");
				}
				if(data[i] == '251'){
					$( ".noticeSortable" ).sortable("enable");
				}
				if(data[i] == '372'){
					$( ".photoSortable" ).sortable("enable");
				}
				if(data[i] == '542'){
					$( ".receSortable" ).sortable("enable");
				}
				$('#' + data[i]).css('visibility','visible');
				$('#' + data[i]).children().show();
			}
		}
	});
</script>

