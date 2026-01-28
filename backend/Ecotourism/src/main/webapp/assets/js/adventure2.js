function openBookingModal(placeId, placeName, price) {
    document.getElementById("bookingModal").style.display = "block";
    document.getElementById("modalPlaceName").innerText = placeName;
    document.getElementById("modalPrice").innerText = "$" + price + " per person";
    document.getElementById("placeId").value = placeId;
}

function closeBookingModal() {
    document.getElementById("bookingModal").style.display = "none";
}

// Close when clicking outside
window.onclick = function (e) {
    const modal = document.getElementById("bookingModal");
    if (e.target === modal) {
        modal.style.display = "none";
    }
};
