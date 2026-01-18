<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - EcoTourism Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">

    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
        <h2 class="text-2xl font-bold mb-6 text-center">Login</h2>

        <!-- Error message -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 text-red-700 p-3 mb-4 rounded">${error}</div>
        </c:if>

        <!-- Success message -->
        <c:if test="${not empty success}">
            <div class="bg-green-100 text-green-700 p-3 mb-4 rounded">${success}</div>
        </c:if>

        <form action="auth" method="post" id="loginForm">
            <input type="hidden" name="action" value="login">

            <div class="mb-4">
                <label for="email" class="block text-gray-700 font-semibold mb-2">Email</label>
                <input type="email" name="email" id="email" placeholder="Enter your email"
                       class="w-full p-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                       required>
            </div>

            <div class="mb-4">
                <label for="password" class="block text-gray-700 font-semibold mb-2">Password</label>
                <input type="password" name="password" id="password" placeholder="Enter your password"
                       class="w-full p-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                       required>
            </div>

            <button type="submit"
                    class="w-full bg-blue-500 text-white p-3 rounded hover:bg-blue-600 transition-colors">
                Login
            </button>
        </form>

        <p class="mt-4 text-center text-gray-600">
            Don't have an account? <a href="register.jsp" class="text-blue-500 hover:underline">Register here</a>
        </p>
    </div>

    <!-- Basic JS validation -->
    <script>
        document.getElementById('loginForm').addEventListener('submit', function (e) {
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();

            if (!email || !password) {
                alert('Please fill in both email and password.');
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
