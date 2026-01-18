<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - EcoTourism Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">

    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
        <h2 class="text-2xl font-bold mb-6 text-center">Register</h2>

        <!-- Error message -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 text-red-700 p-3 mb-4 rounded">${error}</div>
        </c:if>

        <form action="auth" method="post" id="registerForm">
            <input type="hidden" name="action" value="register">

            <div class="mb-4">
                <label for="name" class="block text-gray-700 font-semibold mb-2">Name</label>
                <input type="text" name="name" id="name" placeholder="Enter your name"
                       class="w-full p-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                       required>
            </div>

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
                Register
            </button>
        </form>

        <p class="mt-4 text-center text-gray-600">
            Already have an account? <a href="login.jsp" class="text-blue-500 hover:underline">Login here</a>
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
