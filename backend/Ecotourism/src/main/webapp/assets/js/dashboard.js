
//FILTER TABLE
function filterTable(tableId, keyword) {
    keyword = keyword.toLowerCase();
    const rows = document.getElementById(tableId).rows;
    for (let i = 1; i < rows.length; i++) {
        rows[i].style.display =
            rows[i].innerText.toLowerCase().includes(keyword) ? "" : "none";
    }
}

// FILTER BOOKINGS BY DATE
function filterBookingByDate(date) {
    const rows = document.getElementById("bookingsTable").rows;
    for (let i = 1; i < rows.length; i++) {
        rows[i].style.display =
            rows[i].cells[2].innerText.includes(date) ? "" : "none";
    }
}

// OPEN MODAL FOR ADD USER
function openAddUserModal() {
    document.getElementById('modalTitle').innerText = "Add User";
    document.getElementById('formAction').value = "insert";
    document.getElementById('userId').value = "";
    
    // Name & Email editable
    document.getElementById('userName').value = "";
    document.getElementById('userName').removeAttribute("readonly");
    document.getElementById('email').value = "";
    document.getElementById('email').removeAttribute("readonly");

    // Password placeholder for ADD
    const passwordInput = document.getElementById('password');
    passwordInput.value = "";
    passwordInput.placeholder = "Enter password"; 

    // Role & Status defaults
    document.getElementById('role').value = "VISITOR";
    document.getElementById('status').value = "ACTIVE";

    document.getElementById('userModal').style.display = "block";
}

// OPEN MODAL FOR EDIT USER
function openEditUserModal(id, name, email, role, status) {
    document.getElementById('modalTitle').innerText = "Reset User / Update Role";
    document.getElementById('formAction').value = "update";
    document.getElementById('userId').value = id;

    // Name & Email are readonly
    document.getElementById('userName').value = name;
    document.getElementById('userName').setAttribute("readonly", true);
    document.getElementById('email').value = email;
    document.getElementById('email').setAttribute("readonly", true);

    // Password placeholder for EDIT
    const passwordInput = document.getElementById('password');
    passwordInput.value = "";
    passwordInput.placeholder = "Leave blank to keep current password"; 

    // Role & Status
    document.getElementById('role').value = role;
    document.getElementById('status').value = status;

    document.getElementById('userModal').style.display = "block";
}

// CLOSE MODAL
function closeUserModal() {
    document.getElementById('userModal').style.display = "none";
}

// CLOSE MODAL ON OUTSIDE CLICK
window.onclick = function(event) {
    const modal = document.getElementById('userModal');
    if (event.target === modal) closeUserModal();
}

// OPTIONAL: CLOSE MODAL ON ESC KEY
window.addEventListener('keydown', function(e) {
    if (e.key === "Escape") closeUserModal();
});

// OPEN MODAL FOR ADD PLACE
function openAddPlaceModal() {
    document.getElementById('placeModalTitle').innerText = "Add Place";
    document.getElementById('placeFormAction').value = "insert";
    document.getElementById('placeId').value = "";
    document.getElementById('placeCode').value = "";
    document.getElementById('placeName').value = "";
    document.getElementById('description').value = "";
    document.getElementById('pricePerPerson').value = "";
    document.getElementById('statusPlace').value = "AVAILABLE";
    document.getElementById('imagePreview').style.display = "none";
    document.getElementById('imagePreview').src = "";
    document.getElementById('image').value = "";
    document.getElementById('placeModal').style.display = "block";
}

// OPEN MODAL FOR EDIT PLACE
function openEditPlaceModal(place) {
    document.getElementById('placeModalTitle').innerText = "Edit Place";
    document.getElementById('placeFormAction').value = "update";
    document.getElementById('placeId').value = place.placeId;
    document.getElementById('placeCode').value = place.placeCode;
    document.getElementById('placeName').value = place.placeName;
    document.getElementById('description').value = place.description;
    document.getElementById('pricePerPerson').value = place.pricePerPerson;
    document.getElementById('statusPlace').value = place.status;

    if(place.imageUrl) {
        document.getElementById('imagePreview').src = place.imageUrl;
        document.getElementById('imagePreview').style.display = "block";
    } else {
        document.getElementById('imagePreview').style.display = "none";
        document.getElementById('imagePreview').src = "";
    }

    document.getElementById('image').value = "";
    document.getElementById('placeModal').style.display = "block";
}

// IMAGE PREVIEW
function previewPlaceImage(event) {
    const preview = document.getElementById('imagePreview');
    preview.src = URL.createObjectURL(event.target.files[0]);
    preview.style.display = "block";
}

// CLOSE MODAL
function closePlaceModal() {
    document.getElementById('placeModal').style.display = "none";
}

// CLOSE MODAL ON OUTSIDE CLICK
window.addEventListener('click', function(event) {
    const modal = document.getElementById('placeModal');
    if(event.target === modal) closePlaceModal();
});

// ESC key to close modal
window.addEventListener('keydown', function(e) {
    if(e.key === "Escape") closePlaceModal();
});

function openBookingModalFromElement(el) {
    const userName = el.dataset.userName;
    const bookingDate = el.dataset.bookingDate;
    const visitors = el.dataset.visitors;
    const total = el.dataset.total;
    const placesJson = el.dataset.places;

    let places = [];
    try {
        places = JSON.parse(placesJson);
    } catch (e) {
        console.error("Invalid JSON for booking places", e);
    }

    document.getElementById('modalBookingUser').innerText = userName;
    document.getElementById('modalBookingDate').innerText = bookingDate;
    document.getElementById('modalBookingVisitors').innerText = visitors;
    document.getElementById('modalBookingTotal').innerText = "$" + total;

    const ul = document.getElementById('modalBookingPlaces');
    ul.innerHTML = "";

    if (places.length > 0) {
        places.forEach(p => {
            const li = document.createElement("li");
            li.innerText = `${p.placeName} ($${p.pricePerPerson})`;
            ul.appendChild(li);
        });
    } else {
        ul.innerHTML = "<li>N/A</li>";
    }

    document.getElementById('bookingModal').style.display = "block";
}

function closeBookingModal() {
    document.getElementById('bookingModal').style.display = "none";
}

window.addEventListener('click', e => {
    if (e.target === document.getElementById('bookingModal')) {
        closeBookingModal();
    }
});

window.addEventListener('keydown', e => {
    if (e.key === "Escape") closeBookingModal();
});

