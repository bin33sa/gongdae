<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 공간 대여 생각날 때</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
</head>
<body>


<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>


<main>
	
	<!-- 공간 리스트 -->
	 <jsp:include page="/WEB-INF/views/guest/main/homeList.jsp"/>
	
	
	 
		
</main>

<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>