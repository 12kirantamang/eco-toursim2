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

public class User {
    private int userId;
    private String userName;
    private String email;
    private String passwordHash;
    private String role;   // ADMIN or VISITOR
    private String status; // ACTIVE or BLOCKED
    private Timestamp createdAt;
   
    
}
