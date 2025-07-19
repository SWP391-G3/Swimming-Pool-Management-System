/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class BookingTrendStats {
    private int t2,t3,t4,t5,t6,t7,cn;

    public BookingTrendStats() {
    }

    public BookingTrendStats(int t2, int t3, int t4, int t5, int t6, int t7, int cn) {
        this.t2 = t2;
        this.t3 = t3;
        this.t4 = t4;
        this.t5 = t5;
        this.t6 = t6;
        this.t7 = t7;
        this.cn = cn;
    }

    public int getT2() {
        return t2;
    }

    public void setT2(int t2) {
        this.t2 = t2;
    }

    public int getT3() {
        return t3;
    }

    public void setT3(int t3) {
        this.t3 = t3;
    }

    public int getT4() {
        return t4;
    }

    public void setT4(int t4) {
        this.t4 = t4;
    }

    public int getT5() {
        return t5;
    }

    public void setT5(int t5) {
        this.t5 = t5;
    }

    public int getT6() {
        return t6;
    }

    public void setT6(int t6) {
        this.t6 = t6;
    }

    public int getT7() {
        return t7;
    }

    public void setT7(int t7) {
        this.t7 = t7;
    }

    public int getCn() {
        return cn;
    }

    public void setCn(int cn) {
        this.cn = cn;
    }

    @Override
    public String toString() {
        return "BookingTrendStats{" + "t2=" + t2 + ", t3=" + t3 + ", t4=" + t4 + ", t5=" + t5 + ", t6=" + t6 + ", t7=" + t7 + ", cn=" + cn + '}';
    }
    
    
}
