package model.customer;

import java.util.Date;
/**
 *
 * @author LAZYVL
 */
public class Contact {
    private int contactId;
    private Integer userId;
    private String name;
    private String email;
    private String subject;
    private String content;
    private Date createdAt;
    private boolean isResolved;

    public Contact() {
    }

    public Contact(int contactId, Integer userId, String name, String email, String subject, String content, Date createdAt, boolean isResolved) {
        this.contactId = contactId;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.subject = subject;
        this.content = content;
        this.createdAt = createdAt;
        this.isResolved = isResolved;
    }

    public int getContactId() {
        return contactId;
    }

    public void setContactId(int contactId) {
        this.contactId = contactId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isResolved() {
        return isResolved;
    }

    public void setResolved(boolean resolved) {
        isResolved = resolved;
    }
}
