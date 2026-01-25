package model;

public class BookingPlace {
    private int bookingPlaceId;
    private int bookingId;
    private int placeId;

    // Optional: add place details for display
    private String placeName;
    private double pricePerPerson;

    // Constructors
    public BookingPlace() {}

    // ===== Getters & Setters =====
    public int getBookingPlaceId() {
        return bookingPlaceId;
    }

    public void setBookingPlaceId(int bookingPlaceId) {
        this.bookingPlaceId = bookingPlaceId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getPlaceId() {
        return placeId;
    }

    public void setPlaceId(int placeId) {
        this.placeId = placeId;
    }

    public String getPlaceName() {
        return placeName;
    }

    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }

    public double getPricePerPerson() {
        return pricePerPerson;
    }

    public void setPricePerPerson(double pricePerPerson) {
        this.pricePerPerson = pricePerPerson;
    }
}
