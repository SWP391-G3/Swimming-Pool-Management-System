/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 *
 * @author Lenovo
 */
public class Pool {
    private int pool_id;
    private String pool_name;
    private String pool_road;
    private String pool_address;
    private int max_slot;
    private LocalTime open_time;
    private LocalTime close_time;
    private boolean pool_status;
    private LocalDate created_at;
    private LocalDate updated_at;

    public Pool(int pool_id, String pool_name, String pool_road, String pool_address, int max_slot, LocalTime open_time, LocalTime close_time, boolean pool_status, LocalDate created_at, LocalDate updated_at) {
        this.pool_id = pool_id;
        this.pool_name = pool_name;
        this.pool_road = pool_road;
        this.pool_address = pool_address;
        this.max_slot = max_slot;
        this.open_time = open_time;
        this.close_time = close_time;
        this.pool_status = pool_status;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getPool_id() {
        return pool_id;
    }

    public void setPool_id(int pool_id) {
        this.pool_id = pool_id;
    }

    public String getPool_name() {
        return pool_name;
    }

    public void setPool_name(String pool_name) {
        this.pool_name = pool_name;
    }

    public String getPool_road() {
        return pool_road;
    }

    public void setPool_road(String pool_road) {
        this.pool_road = pool_road;
    }

    public String getPool_address() {
        return pool_address;
    }

    public void setPool_address(String pool_address) {
        this.pool_address = pool_address;
    }

    public int getMax_slot() {
        return max_slot;
    }

    public void setMax_slot(int max_slot) {
        this.max_slot = max_slot;
    }

    public LocalTime getOpen_time() {
        return open_time;
    }

    public void setOpen_time(LocalTime open_time) {
        this.open_time = open_time;
    }

    public LocalTime getClose_time() {
        return close_time;
    }

    public void setClose_time(LocalTime close_time) {
        this.close_time = close_time;
    }

    public boolean isPool_status() {
        return pool_status;
    }

    public void setPool_status(boolean pool_status) {
        this.pool_status = pool_status;
    }

    public LocalDate getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDate created_at) {
        this.created_at = created_at;
    }

    public LocalDate getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDate updated_at) {
        this.updated_at = updated_at;
    }
    
    
}
