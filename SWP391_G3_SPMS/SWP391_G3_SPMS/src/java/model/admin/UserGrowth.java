/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class UserGrowth {

    private int t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12;

    public UserGrowth() {
    }

    public void setMonth(int month, int value) {
        switch (month) {
            case 1:
                this.t1 = value;
                break;
            case 2:
                this.t2 = value;
                break;
            case 3:
                this.t3 = value;
                break;
            case 4:
                this.t4 = value;
                break;
            case 5:
                this.t5 = value;
                break;
            case 6:
                this.t6 = value;
                break;
            case 7:
                this.t7 = value;
                break;
            case 8:
                this.t8 = value;
                break;
            case 9:
                this.t9 = value;
                break;
            case 10:
                this.t10 = value;
                break;
            case 11:
                this.t11 = value;
                break;
            case 12:
                this.t12 = value;
                break;
        }
    }

    // Getters (t1 to t12) nếu cần dùng ở JSP
    public int getT1() {
        return t1;
    }

    public int getT2() {
        return t2;
    }

    public int getT3() {
        return t3;
    }

    public int getT4() {
        return t4;
    }

    public int getT5() {
        return t5;
    }

    public int getT6() {
        return t6;
    }

    public int getT7() {
        return t7;
    }

    public int getT8() {
        return t8;
    }

    public int getT9() {
        return t9;
    }

    public int getT10() {
        return t10;
    }

    public int getT11() {
        return t11;
    }

    public int getT12() {
        return t12;
    }

    @Override
    public String toString() {
        return "UserGrowth{" + "t1=" + t1 + ", t2=" + t2 + ", t3=" + t3 + ", t4=" + t4 + ", t5=" + t5 + ", t6=" + t6 + ", t7=" + t7 + ", t8=" + t8 + ", t9=" + t9 + ", t10=" + t10 + ", t11=" + t11 + ", t12=" + t12 + '}';
    }
    
    
}
