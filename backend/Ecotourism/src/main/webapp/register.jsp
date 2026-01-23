<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentLocale" value="${sessionScope.locale != null ? sessionScope.locale : pageContext.request.locale}" />
<fmt:setLocale value="${currentLocale}" />
<fmt:setBundle basename="resources.messages" />

<!DOCTYPE html>
<html lang="${currentLocale.language}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="register.title" /> - EcoTourism Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">

    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
        <h2 class="text-2xl font-bold mb-6 text-center"><fmt:message key="register.title" /></h2>
        <p class="text-center text-gray-600 mb-4"><fmt:message key="register.subtitle" /></p>

        <!-- Error message -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 text-red-700 p-3 mb-4 rounded">${error}</div>
        </c:if>

        <form action="auth" method="post" id="registerForm">
            <input type="hidden" name="action" value="register">

            <div class="mb-4">
                <label for="name" class="block text-gray-700 font-semibold mb-2"><fmt:message key="register.name" /></label>
                <input type="text" name="name" id="name" placeholder=""
                       class="w-full p-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                       required>
            </div>

            <div class="mb-4">
                <label for="email" class="block text-gray-700 font-semibold mb-2"><fmt:message key="register.email" /></label>
                <input type="email" name="email" id="email" placeholder=""
                       class="w-full p-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                       required>
            </div>

            <div class="mb-4">
                <label for="password" class="block text-gray-700 font-semibold mb-2"><fmt:message key="register.password" /></label>
                <input type="password" name="password" id="password" placeholder=""
                       class="w-full p-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                       required>
            </div>

            <div class="mb-4">
                <label for="role" class="block text-gray-700 font-semibold mb-2">Role</label>
                <select name="role" id="role"
                        class="w-full p-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                        required>
                    <option value="VISITOR" selected>Visitor</option>
                    <option value="ADMIN">Admin</option>
                </select>
            </div>

            <button type="submit"
                    class="w-full bg-green-500 text-white p-3 rounded hover:bg-green-600 transition-colors">
                <fmt:message key="register.submit" />
            </button>
        </form>

        <p class="mt-4 text-center text-gray-600">
            <fmt:message key="register.hasAccount" /> <a href="login.jsp" class="text-blue-500 hover:underline"><fmt:message key="register.signIn" /></a>
        </p>
    </div>

    <!-- Basic JS validation -->
    <script>
        document.getElementById('registerForm').addEventListener('submit', function (e) {
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();

            if (!name || !email || !password) {
                alert('Please fill in all fields.');
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
