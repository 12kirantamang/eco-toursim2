<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty_user ? 'Add New User' : 'Edit User'} - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-900 text-white p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-2xl font-bold">
            <i class="fas fa-user-edit"></i> 
            ${empty_user ? 'Add New User' : 'Edit User'}
        </h1>
        <nav class="flex space-x-4 items-center">
            <a href="<c:url value='/admin/users' />" class="hover:text-blue-200">
                <i class="fas fa-arrow-left"></i> Back to Users
            </a>
            <a href="<c:url value='/admin/dashboard' />" class="hover:text-blue-200">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <span class="border-l border-blue-700 h-6"></span>
            <span>Welcome, ${sessionScope.user.userName}</span>
            <a href="<c:url value='/auth?action=logout' />" 
               class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded">
               <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </nav>
    </div>
</header>

<main class="container mx-auto p-6 max-w-3xl">
    
    <!-- Form Card -->
    <div class="bg-white rounded-lg shadow-lg p-8">
        
        <div class="mb-6">
            <h2 class="text-2xl font-bold text-gray-800 mb-2">
                ${empty_user ? 'Create New User Account' : 'Update User Information'}
            </h2>
            <p class="text-gray-600">
                ${empty_user ? 'Fill in the details to create a new user account' : 'Modify the user details below'}
            </p>
        </div>

        <form action="<c:url value='/admin/users' />" method="post" id="userForm">
            
            <!-- Action and User ID -->
            <input type="hidden" name="action" value="${empty_user ? 'insert' : 'update'}">
            <c:if test="${not empty_user}">
                <input type="hidden" name="userId" value="${user.userId}">
            </c:if>

            <div class="space-y-6">
                
                <!-- User Name -->
                <div>
                    <label for="userName" class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-user"></i> User Name <span class="text-red-500">*</span>
                    </label>
                    <input type="text" 
                           id="userName" 
                           name="userName" 
                           value="${user.userName}" 
                           required
                           placeholder="Enter full name"
                           class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <!-- Email -->
                <div>
                    <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-envelope"></i> Email Address <span class="text-red-500">*</span>
                    </label>
                    <input type="email" 
                           id="email" 
                           name="email" 
                           value="${user.email}" 
                           required
                           placeholder="user@example.com"
                           class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <!-- Password -->
                <div>
                    <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-lock"></i> Password 
                        <c:if test="${empty_user}"><span class="text-red-500">*</span></c:if>
                    </label>
                    <input type="password" 
                           id="password" 
                           name="password" 
                           <c:if test="${empty_user}">required</c:if>
                           placeholder="<c:choose><c:when test='${empty_user}'>Enter password</c:when><c:otherwise>Leave blank to keep current password</c:otherwise></c:choose>"
                           minlength="6"
                           class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <p class="text-xs text-gray-500 mt-1">
                        ${empty_user ? 'Minimum 6 characters' : 'Only enter a password if you want to change it'}
                    </p>
                </div>

                <!-- Role -->
                <div>
                    <label for="role" class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-user-tag"></i> Role <span class="text-red-500">*</span>
                    </label>
                    <select id="role" 
                            name="role" 
                            required
                            class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">-- Select Role --</option>
                        <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>
                            <i class="fas fa-user"></i> User
                        </option>
                        <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>
                            <i class="fas fa-user-shield"></i> Admin
                        </option>
                    </select>
                    <p class="text-xs text-gray-500 mt-1">Admin users have full system access</p>
                </div>

                <!-- Status -->
                <div>
                    <label for="status" class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-toggle-on"></i> Account Status <span class="text-red-500">*</span>
                    </label>
                    <select id="status" 
                            name="status" 
                            required
                            class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">-- Select Status --</option>
                        <option value="ACTIVE" ${user.status == 'ACTIVE' || empty_user ? 'selected' : ''}>
                            <i class="fas fa-check-circle"></i> Active
                        </option>
                        <option value="BLOCKED" ${user.status == 'BLOCKED' ? 'selected' : ''}>
                            <i class="fas fa-ban"></i> Blocked
                        </option>
                    </select>
                    <p class="text-xs text-gray-500 mt-1">Blocked users cannot log in</p>
                </div>

            </div>

            <!-- Form Actions -->
            <div class="mt-8 flex space-x-4">
                <button type="submit" 
                        class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg shadow-md transition">
                    <i class="fas fa-save"></i> 
                    ${empty_user ? 'Create User' : 'Update User'}
                </button>
                <a href="<c:url value='/admin/users' />" 
                   class="flex-1 bg-gray-500 hover:bg-gray-600 text-white font-semibold py-3 px-6 rounded-lg shadow-md text-center transition">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>

        </form>

    </div>

    <!-- Help Card -->
    <div class="bg-yellow-50 border-l-4 border-yellow-500 p-4 mt-6 rounded">
        <div class="flex items-start">
            <i class="fas fa-exclamation-triangle text-yellow-500 text-xl mr-3 mt-1"></i>
            <div>
                <h3 class="font-semibold text-yellow-900 mb-1">Important Notes:</h3>
                <ul class="text-sm text-yellow-800 space-y-1">
                    <li>• Admin users have access to all administrative functions</li>
                    <li>• Blocked users cannot log in to their accounts</li>
                    <li>• Email addresses must be unique across all users</li>
                    <li>• Passwords are securely encrypted before storage</li>
                </ul>
            </div>
        </div>
    </div>

</main>

<script>
    // Form validation
    document.getElementById('userForm').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const isNewUser = <c:choose><c:when test="${empty_user}">true</c:when><c:otherwise>false</c:otherwise></c:choose>;
        
        if (isNewUser && password.length < 6) {
            e.preventDefault();
            alert('Password must be at least 6 characters long!');
            return false;
        }
        
        if (password && password.length > 0 && password.length < 6) {
            e.preventDefault();
            alert('Password must be at least 6 characters long!');
            return false;
        }
    });
</script>

</body>
</html>
