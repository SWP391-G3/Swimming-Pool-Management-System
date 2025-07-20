/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

import java.time.LocalDate;

/**
 *
 * @author Lenovo
 */
public class ContactWithAdmin {
    private int contact_id;
    private int customer_id;
    private String customer_name;
    private String customer_email;
    private String subject;
    private String content;
    private LocalDate created_at;
    private Boolean is_resolved;

    public ContactWithAdmin() {
    }

    public ContactWithAdmin(int contact_id, int customer_id, String customer_name, String customer_email, String subject, String content, LocalDate created_at, Boolean is_resolved) {
        this.contact_id = contact_id;
        this.customer_id = customer_id;
        this.customer_name = customer_name;
        this.customer_email = customer_email;
        this.subject = subject;
        this.content = content;
        this.created_at = created_at;
        this.is_resolved = is_resolved;
    }

    public int getContact_id() {
        return contact_id;
    }

    public void setContact_id(int contact_id) {
        this.contact_id = contact_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public String getCustomer_name() {
        return customer_name;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public String getCustomer_email() {
        return customer_email;
    }

    public void setCustomer_email(String customer_email) {
        this.customer_email = customer_email;
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

    public LocalDate getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDate created_at) {
        this.created_at = created_at;
    }

    public Boolean getIs_resolved() {
        return is_resolved;
    }

    public void setIs_resolved(Boolean is_resolved) {
        this.is_resolved = is_resolved;
    }

    @Override
    public String toString() {
        return "ContactWithAdmin{" + "contact_id=" + contact_id + ", customer_id=" + customer_id + ", customer_name=" + customer_name + ", customer_email=" + customer_email + ", subject=" + subject + ", content=" + content + ", created_at=" + created_at + ", is_resolved=" + is_resolved + '}';
    }
    
    
}
