package model;

import java.sql.Timestamp;


public class User {
    private int userId;
    private String userName;
    private String email;
    private String passwordHash;
    private String role;   // ADMIN or VISITOR
    private String status; // ACTIVE or BLOCKED
    private Timestamp createdAt;
    

	public User() {
		super();
	}
    
	public User(int userId, String userName, String email, String passwordHash, String role, String status,
			Timestamp createdAt) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.email = email;
		this.passwordHash = passwordHash;
		this.role = role;
		this.status = status;
		this.createdAt = createdAt;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}  
    
}
