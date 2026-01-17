<%@ include file="../common/header.jsp" %>

<h2>Login</h2>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>
<c:if test="${not empty success}">
    <p style="color:green;">${success}</p>
</c:if>

<form action="<c:url value='/auth'/>" method="post">
    <input type="hidden" name="action" value="login">
    <label>Email:</label>
    <input type="email" name="email" required><br><br>

    <label>Password:</label>
    <input type="password" name="password" required><br><br>

    <button type="submit">Login</button>
</form>

<p>Don't have an account? <a href="<c:url value='register.jsp'/>">Register here</a></p>

<%@ include file="../common/footer.jsp" %>
