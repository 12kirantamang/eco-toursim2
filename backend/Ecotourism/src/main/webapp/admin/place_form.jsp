<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty place ? 'Add New Place' : 'Edit Place'} - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-900 text-white p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-2xl font-bold">
            <i class="fas fa-map-marked-alt"></i> 
            ${empty place ? 'Add New Place' : 'Edit Place'}
        </h1>
        <nav class="flex space-x-4 items-center">
            <a href="<c:url value='/admin/places' />" class="hover:text-blue-200">
                <i class="fas fa-arrow-left"></i> Back to Places
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

<main class="container mx-auto p-6 max-w-4xl">
    
    <!-- Form Card -->
    <div class="bg-white rounded-lg shadow-lg p-8">
        
        <div class="mb-6">
            <h2 class="text-2xl font-bold text-gray-800 mb-2">
                ${empty place ? 'Create New Place' : 'Update Place Information'}
            </h2>
            <p class="text-gray-600">
                ${empty place ? 'Fill in the details to add a new tourist attraction' : 'Modify the place details below'}
            </p>
        </div>

        <form action="<c:url value='/admin/places' />" method="post" enctype="multipart/form-data" id="placeForm">
            
            <!-- Hidden field for edit mode -->
            <c:if test="${not empty place}">
                <input type="hidden" name="placeId" value="${place.placeId}">
            </c:if>

            <div class="grid grid-cols-2 gap-6">
                
                <!-- Place Code -->
                <div>
                    <label for="placeCode" class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-barcode"></i> Place Code <span class="text-red-500">*</span>
                    </label>
                    <input type="text" 
                           id="placeCode" 
                           name="placeCode" 
                           value="${place.placeCode}" 
                           required
                           placeholder="e.g., OKY-001"
                           class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <p class="text-xs text-gray-500 mt-1">Unique identifier for the place</p>
                </div>

                <!-- Place Name -->
                <div>
                    <label for="placeName" class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-map-marker-alt"></i> Place Name <span class="text-red-500">*</span>
                    </label>
                    <input type="text" 
                           id="placeName" 
                           name="placeName" 
                           value="${place.placeName}" 
                           required
                           placeholder="e.g., Okayama Castle"
                           class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <p class="text-xs text-gray-500 mt-1">Full name of the attraction</p>
                </div>

                <!-- Price Per Person -->
                <div>
                    <label for="pricePerPerson" class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-yen-sign"></i> Price Per Person (¥) <span class="text-red-500">*</span>
                    </label>
                    <input type="number" 
                           id="pricePerPerson" 
                           name="pricePerPerson" 
                           value="${place.pricePerPerson}" 
                           required
                           min="0"
                           step="0.01"
                           placeholder="e.g., 500.00"
                           class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <p class="text-xs text-gray-500 mt-1">Entry fee per visitor</p>
                </div>

                <!-- Status -->
                <div>
                    <label for="status" class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-toggle-on"></i> Status <span class="text-red-500">*</span>
                    </label>
                    <select id="status" 
                            name="status" 
                            required
                            class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="AVAILABLE" ${place.status == 'AVAILABLE' ? 'selected' : ''}>
                            <i class="fas fa-check-circle"></i> AVAILABLE
                        </option>
                        <option value="UNAVAILABLE" ${place.status == 'UNAVAILABLE' ? 'selected' : ''}>
                            <i class="fas fa-times-circle"></i> UNAVAILABLE
                        </option>
                    </select>
                    <p class="text-xs text-gray-500 mt-1">Available places are visible to users</p>
                </div>

            </div>

            <!-- Description -->
            <div class="mt-6">
                <label for="description" class="block text-sm font-semibold text-gray-700 mb-2">
                    <i class="fas fa-align-left"></i> Description <span class="text-red-500">*</span>
                </label>
                <textarea id="description" 
                          name="description" 
                          required
                          rows="5"
                          placeholder="Describe the place, its history, attractions, and what visitors can expect..."
                          class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">${place.description}</textarea>
                <p class="text-xs text-gray-500 mt-1">Provide a detailed description for visitors</p>
            </div>

            <!-- Image Upload -->
            <div class="mt-6">
                <label for="image" class="block text-sm font-semibold text-gray-700 mb-2">
                    <i class="fas fa-image"></i> Place Image
                </label>
                
                <c:if test="${not empty place.imageUrl}">
                    <div class="mb-4">
                        <p class="text-sm text-gray-600 mb-2">Current Image:</p>
                        <img src="<c:url value='/${place.imageUrl}' />" 
                             alt="${place.placeName}" 
                             class="h-48 w-64 object-cover rounded-lg shadow-md">
                    </div>
                </c:if>

                <input type="file" 
                       id="image" 
                       name="image" 
                       accept="image/*"
                       class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                       onchange="previewImage(event)">
                <p class="text-xs text-gray-500 mt-1">
                    ${empty place ? 'Upload an image for the place' : 'Upload a new image to replace the current one (optional)'}
                </p>
                
                <!-- Image Preview -->
                <div id="imagePreview" class="mt-4 hidden">
                    <p class="text-sm text-gray-600 mb-2">New Image Preview:</p>
                    <img id="preview" class="h-48 w-64 object-cover rounded-lg shadow-md">
                </div>
            </div>

            <!-- Form Actions -->
            <div class="mt-8 flex space-x-4">
                <button type="submit" 
                        class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg shadow-md transition">
                    <i class="fas fa-save"></i> 
                    ${empty place ? 'Create Place' : 'Update Place'}
                </button>
                <a href="<c:url value='/admin/places' />" 
                   class="flex-1 bg-gray-500 hover:bg-gray-600 text-white font-semibold py-3 px-6 rounded-lg shadow-md text-center transition">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>

        </form>

    </div>

    <!-- Help Card -->
    <div class="bg-blue-50 border-l-4 border-blue-500 p-4 mt-6 rounded">
        <div class="flex items-start">
            <i class="fas fa-info-circle text-blue-500 text-xl mr-3 mt-1"></i>
            <div>
                <h3 class="font-semibold text-blue-900 mb-1">Tips:</h3>
                <ul class="text-sm text-blue-800 space-y-1">
                    <li>• Use a unique place code for easy identification</li>
                    <li>• Write clear, engaging descriptions to attract visitors</li>
                    <li>• Upload high-quality images (max 10MB, JPG/PNG format recommended)</li>
                    <li>• Set the status to AVAILABLE to make the place visible to users</li>
                </ul>
            </div>
        </div>
    </div>

</main>

<script>
    function previewImage(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const preview = document.getElementById('preview');
                const previewContainer = document.getElementById('imagePreview');
                preview.src = e.target.result;
                previewContainer.classList.remove('hidden');
            };
            reader.readAsDataURL(file);
        }
    }

    // Form validation
    document.getElementById('placeForm').addEventListener('submit', function(e) {
        const price = parseFloat(document.getElementById('pricePerPerson').value);
        if (price < 0) {
            e.preventDefault();
            alert('Price cannot be negative!');
            return false;
        }
    });
</script>

</body>
</html>
