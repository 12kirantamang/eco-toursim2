package model;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Place {
    private int placeId;
    private String placeCode;
    private String placeName;
    private String description;
    private double pricePerPerson;
    private String status; // ACTIVE, INACTIVE
    private Timestamp createdAt;

   
}
