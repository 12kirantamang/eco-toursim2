<%@ include file="../common/header.jsp" %>

<h2>Register</h2>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>
<c:if test="${not empty success}">
    <p style="color:green;">${success}</p>
</c:if>

<form action="<c:url value='/auth'/>" method="post">
    <input type="hidden" name="action" value="register">
    
    <label>Name:</label>
    <input type="text" name="name" required><br><br>

    <label>Email:</label>
    <input type="email" name="email" required><br><br>

    <label>Password:</label>
    <input type="password" name="password" required><br><br>

    <label>Role:</label>
    <select name="role">
        <option value="VISITOR" selected>Visitor</option>
        <option value="GUIDE">Guide</option>
        <option value="ADMIN">Admin</option>
    </select><br><br>

    <button type="submit">Register</button>
</form>

<p>Already have an account? <a href="login.jsp">Login here</a></p>

<%@ include file="../common/footer.jsp" %>
