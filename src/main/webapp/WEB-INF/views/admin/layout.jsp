<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>${pageTitle}</title>
    <jsp:include page="/WEB-INF/views/admin/include/headerResources.jsp"/>
</head>
<body class="admin-page">

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/include/header.jsp"/>

    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/include/left.jsp"/>

        <main class="admin-content">
            <jsp:include page="${contentPage}"/>
        </main>
    </div>

    <jsp:include page="/WEB-INF/views/admin/include/footer.jsp"/>
</div>

<jsp:include page="/WEB-INF/views/admin/include/footerResources.jsp"/>

</body>
</html>