package model;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;

public class Booking {
    private int bookingId;
    private int userId;
    private LocalDate bookingDate; // YYYY-MM-DD
    private String timeSlot;       // e.g., "09:00-11:00"
    private int visitorCount;
    private double totalAmount;
    private Timestamp createdAt;
    
    private String userName;
    private List<BookingPlace> bookingPlaces;
	public int getBookingId() {
		return bookingId;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public LocalDate getBookingDate() {
		return bookingDate;
	}
	public void setBookingDate(LocalDate bookingDate) {
		this.bookingDate = bookingDate;
	}
	public String getTimeSlot() {
		return timeSlot;
	}
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	public int getVisitorCount() {
		return visitorCount;
	}
	public void setVisitorCount(int visitorCount) {
		this.visitorCount = visitorCount;
	}
	public double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public List<BookingPlace> getBookingPlaces() { 
		return bookingPlaces; 
	}
    public void setBookingPlaces(List<BookingPlace> bookingPlaces) { 
    	this.bookingPlaces = bookingPlaces;
    }
    public String getUserName() { 
    	return userName;
    }
    public void setUserName(String userName) { 
    	this.userName = userName;
    }

}
