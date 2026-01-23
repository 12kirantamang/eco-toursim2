<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Places - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .table-container { max-height: 600px; overflow-y: auto; }
        table tbody tr:hover { background-color: #e0f2fe; }
        table thead th { position: sticky; top: 0; background-color: #1e3a8a; z-index: 10; }
        .status-active { background-color: #dcfce7; color: #166534; padding: 4px 12px; border-radius: 12px; font-weight: 500; }
        .status-inactive { background-color: #fee2e2; color: #991b1b; padding: 4px 12px; border-radius: 12px; font-weight: 500; }
    </style>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-900 text-white p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-2xl font-bold"><i class="fas fa-map-marked-alt"></i> Manage Places</h1>
        <nav class="flex space-x-4 items-center">
            <a href="<c:url value='/admin/dashboard' />" class="hover:text-blue-200">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a href="<c:url value='/admin/users' />" class="hover:text-blue-200">
                <i class="fas fa-users"></i> Users
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
            <h2 class="text-xl font-semibold text-gray-800">Places Management</h2>
            <p class="text-gray-600 text-sm">Manage tourist attractions and destinations</p>
        </div>
        <a href="<c:url value='/admin/places?action=add' />" 
           class="bg-green-600 hover:bg-green-700 text-white px-6 py-3 rounded-lg font-semibold shadow-md transition">
            <i class="fas fa-plus"></i> Add New Place
        </a>
    </div>

    <!-- Search Bar -->
    <div class="bg-white p-4 rounded-lg shadow-md mb-6">
        <input type="text" 
               id="searchInput" 
               placeholder="🔍 Search by place name, code, or status..." 
               class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
               onkeyup="filterTable()">
    </div>

    <!-- Places Table -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
        <div class="table-container">
            <table class="min-w-full" id="placesTable">
                <thead>
                    <tr class="bg-blue-900 text-white">
                        <th class="p-4 text-left">ID</th>
                        <th class="p-4 text-left">Image</th>
                        <th class="p-4 text-left">Code</th>
                        <th class="p-4 text-left">Place Name</th>
                        <th class="p-4 text-left">Description</th>
                        <th class="p-4 text-left">Price (¥)</th>
                        <th class="p-4 text-left">Status</th>
                        <th class="p-4 text-left">Created At</th>
                        <th class="p-4 text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty places}">
                            <tr>
                                <td colspan="9" class="p-8 text-center text-gray-500">
                                    <i class="fas fa-inbox text-4xl mb-3 block"></i>
                                    No places found. Add your first place!
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="place" items="${places}">
                                <tr class="border-b hover:bg-blue-50 transition">
                                    <td class="p-4">${place.placeId}</td>
                                    <td class="p-4">
                                        <c:choose>
                                            <c:when test="${not empty place.imageUrl}">
                                                <img src="<c:url value='/${place.imageUrl}' />" 
                                                     alt="${place.placeName}" 
                                                     class="h-16 w-20 object-cover rounded shadow">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="h-16 w-20 bg-gray-200 rounded flex items-center justify-center">
                                                    <i class="fas fa-image text-gray-400"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="p-4 font-mono text-sm">${place.placeCode}</td>
                                    <td class="p-4 font-semibold">${place.placeName}</td>
                                    <td class="p-4 text-sm text-gray-600">
                                        <c:choose>
                                            <c:when test="${fn:length(place.description) > 50}">
                                                ${fn:substring(place.description, 0, 50)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${place.description}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="p-4">
                                        <fmt:formatNumber value="${place.pricePerPerson}" pattern="#,##0.00" />
                                    </td>
                                    <td class="p-4">
                                        <c:choose>
                                            <c:when test="${place.status == 'AVAILABLE'}">
                                                <span class="status-active">
                                                    <i class="fas fa-check-circle"></i> AVAILABLE
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-inactive">
                                                    <i class="fas fa-times-circle"></i> UNAVAILABLE
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="p-4 text-sm">
                                        <fmt:formatDate value="${place.createdAt}" pattern="MMM dd, yyyy" />
                                    </td>
                                    <td class="p-4">
                                        <div class="flex justify-center space-x-2">
                                            <a href="<c:url value='/admin/places?action=edit&id=${place.placeId}' />" 
                                               class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded text-sm"
                                               title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="<c:url value='/admin/places?action=delete&id=${place.placeId}' />" 
                                               class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-sm"
                                               title="Deactivate"
                                               onclick="return confirm('Are you sure you want to deactivate this place?')">
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
    <div class="grid grid-cols-3 gap-6 mt-6">
        <div class="bg-green-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-map-marker-alt text-4xl text-green-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-green-800">${places.size()}</h3>
            <p class="text-gray-600">Total Places</p>
        </div>
        <div class="bg-blue-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-check-circle text-4xl text-blue-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-blue-800">
                ${places.stream().filter(p -> p.status == 'AVAILABLE').count()}
            </h3>
            <p class="text-gray-600">Available Places</p>
        </div>
        <div class="bg-red-100 p-6 rounded-lg shadow-md text-center">
            <i class="fas fa-times-circle text-4xl text-red-600 mb-2"></i>
            <h3 class="text-2xl font-bold text-red-800">
                ${places.stream().filter(p -> p.status == 'UNAVAILABLE').count()}
            </h3>
            <p class="text-gray-600">Unavailable Places</p>
        </div>
    </div>

</main>

<script>
    function filterTable() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toUpperCase();
        const table = document.getElementById('placesTable');
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
