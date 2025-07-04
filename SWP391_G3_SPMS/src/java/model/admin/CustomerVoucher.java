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
public class CustomerVoucher {
    private int voucher_id;
    private String voucher_name;
    private String description;
    private int usage_count;
    private LocalDate applied_date;

    public CustomerVoucher(int voucher_id, String voucher_name, String description, int usage_count, LocalDate applied_date) {
        this.voucher_id = voucher_id;
        this.voucher_name = voucher_name;
        this.description = description;
        this.usage_count = usage_count;
        this.applied_date = applied_date;
    }

    public int getVoucher_id() {
        return voucher_id;
    }

    public void setVoucher_id(int voucher_id) {
        this.voucher_id = voucher_id;
    }

    public String getVoucher_name() {
        return voucher_name;
    }

    public void setVoucher_name(String voucher_name) {
        this.voucher_name = voucher_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getUsage_count() {
        return usage_count;
    }

    public void setUsage_count(int usage_count) {
        this.usage_count = usage_count;
    }

    public LocalDate getApplied_date() {
        return applied_date;
    }

    public void setApplied_date(LocalDate applied_date) {
        this.applied_date = applied_date;
    }

    @Override
    public String toString() {
        return "CustomerVoucher{" + "voucher_id=" + voucher_id + ", voucher_name=" + voucher_name + ", description=" + description + ", usage_count=" + usage_count + ", applied_date=" + applied_date + '}';
    }
    
    
}
