package model;

import java.sql.Timestamp;
import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Booking {
    private int bookingId;
    private int userId;
    private LocalDate bookingDate; // YYYY-MM-DD
    private String timeSlot;       // e.g., "09:00-11:00"
    private int visitorCount;
    private double totalAmount;
    private Timestamp createdAt;

}
