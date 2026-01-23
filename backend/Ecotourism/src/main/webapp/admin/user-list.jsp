<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .table-container { max-height: 600px; overflow-y: auto; }
        table tbody tr:hover { background-color: #e0f2fe; }
        table thead th { position: sticky; top: 0; background-color: #1e3a8a; z-index: 10; }
        .status-active { background-color: #dcfce7; color: #166534; padding: 4px 12px; border-radius: 12px; font-weight: 500; }
        .status-blocked { background-color: #fee2e2; color: #991b1b; padding: 4px 12px; border-radius: 12px; font-weight: 500; }
        .role-admin { background-color: #fef3c7; color: #92400e; padding: 4px 12px; border-radius: 12px; font-weight: 500; }
        .role-user { background-color: #dbeafe; color: #1e3a8a; padding: 4px 12px; border-radius: 12px; font-weight: 500; }
    </style>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-900 text-white p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-2xl font-bold"><i class="fas fa-users"></i> Manage Users</h1>
        <nav class="flex space-x-4 items-center">
            <a href="<c:url value='/admin/dashboard' />" class="hover:text-blue-200">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a href="<c:url value='/admin/places' />" class="hover:text-blue-200">
                <i class="fas fa-map-marked-alt"></i> Places
            </a>
            <a href="<c:url value='/admin/bookings' />" class="hover:text-blue-200">
                <i class="fas fa-calendar-check"></i> Bookings
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

<main class="container mx-auto p-6">
    
    <!-- Action Bar -->
    <div class="bg-white p-4 rounded-lg shadow-md mb-6 flex justify-between items-center">
        <div>
            <h2 class="text-xl font-semibold text-gray-800">User Management</h2>
            <p class="text-gray-600 text-sm">Manage user accounts and permissions</p>
        </div>
        <a href="<c:url value='/admin/users?action=new' />" 
           class="bg-green-600 hover:bg-green-700 text-white px-6 py-3 rounded-lg font-semibold shadow-md transition">
            <i class="fas fa-user-plus"></i> Add New User
        </a>
    </div>

    <!-- Search Bar -->
    <div class="bg-white p-4 rounded-lg shadow-md mb-6">
        <input type="text" 
               id="searchInput" 
               placeholder="🔍 Search by name, email, role, or status..." 
               class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
               onkeyup="filterTable()">
    </div>

    <!-- Users Table -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
        <div class="table-container">
            <table class="min-w-full" id="usersTable">
                <thead>
                    <tr class="bg-blue-900 text-white">
                        <th class="p-4 text-left">ID</th>
                        <th class="p-4 text-left">User Name</th>
                        <th class="p-4 text-left">Email</th>
                        <th class="p-4 text-left">Role</th>
                        <th class="p-4 text-left">Status</th>
                        <th class="p-4 text-left">Created At</th>
                        <th class="p-4 text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty_users}">
                            <tr>
                                <td colspan="7" class="p-8 text-center text-gray-500">
                                    <i class="fas fa-users-slash text-4xl mb-3 block"></i>
                                    No users found.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="user" items="${users}">
                                <tr class="border-b hover:bg-blue-50 transition">
                                    <td class="p-4 font-mono">${user.userId}</td>
                                    <td class="p-4 font-semibold">
                                        <i class="fas fa-user-circle text-blue-600"></i> 
                                        ${user.userName}
                                    </td>
                                    <td class="p-4 text-sm">${user.email}</td>
                                    <td class="p-4">
                                        <c:choose>
                                            <c:when test="${user.role == 'ADMIN'}">
                                                <span class="role-admin">
                                                    <i class="fas fa-user-shield"></i> ADMIN
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="role-user">
                                                    <i class="fas fa-user"></i> USER
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="p-4">
                                        <c:choose>
                                            <c:when test="${user.status == 'ACTIVE'}">
                                                <span class="status-active">
                                                    <i class="fas fa-check-circle"></i> ACTIVE
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-blocked">
                                                    <i class="fas fa-ban"></i> BLOCKED
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="p-4 text-sm">
                                        <fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy HH:mm" />
                                    </td>
                                    <td class="p-4">
                                        <div class="flex justify-center space-x-2">
                                            <a href="<c:url value='/admin/users?action=edit&id=${user.userId}' />" 
                                               class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded text-sm"
                                               title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="<c:url value='/admin/users?action=delete&id=${user.userId}' />" 
                                               class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-sm"
                                               title="Delete"
                                               onclick="return confirm('Are you sure you want to delete this user?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Summary Stats -->
    <div class="grid grid-cols-4 gap-6 mt-6">
        <div class="bg-blue-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-users text-4xl text-blue-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-blue-800">${users.size()}</h3>
            <p class="text-gray-600">Total Users</p>
        </div>
        <div class="bg-yellow-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-user-shield text-4xl text-yellow-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-yellow-800">
                ${users.stream().filter(u -> u.role == 'ADMIN').count()}
            </h3>
            <p class="text-gray-600">Admins</p>
        </div>
        <div class="bg-green-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-check-circle text-4xl text-green-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-green-800">
                ${users.stream().filter(u -> u.status == 'ACTIVE').count()}
            </h3>
            <p class="text-gray-600">Active</p>
        </div>
        <div class="bg-red-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-ban text-4xl text-red-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-red-800">
                ${users.stream().filter(u -> u.status == 'BLOCKED').count()}
            </h3>
            <p class="text-gray-600">Blocked</p>
        </div>
    </div>

</main>

<script>
    function filterTable() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toUpperCase();
        const table = document.getElementById('usersTable');
        const tr = table.getElementsByTagName('tr');

        for (let i = 1; i < tr.length; i++) {
            const td = tr[i].getElementsByTagName('td');
            let found = false;
            
            for (let j = 0; j < td.length; j++) {
                if (td[j]) {
                    const txtValue = td[j].textContent || td[j].innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        found = true;
                        break;
                    }
                }
            }
            
            tr[i].style.display = found ? '' : 'none';
        }
    }
</script>

</body>
</html>
