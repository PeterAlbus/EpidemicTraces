package com.peteralbus.domain;

import java.sql.Date;

public class ClockInInfo
{
    int clock_id;
    int stu_id;
    String stu_name;
    String stu_address;
    String stu_class;
    double stu_tmp;
    boolean is_out;
    String stu_des;
    String stu_out;
    String stu_back;
    String clock_date;

    public ClockInInfo(int stu_id, String stu_name, String stu_address, String stu_class, double stu_tmp, boolean is_out, String stu_des, String stu_out, String stu_back, String clock_date) {
        clock_id=0;
        this.stu_id = stu_id;
        this.stu_name = stu_name;
        this.stu_address = stu_address;
        this.stu_class = stu_class;
        this.stu_tmp = stu_tmp;
        this.is_out = is_out;
        this.stu_des = stu_des;
        this.stu_out = stu_out;
        this.stu_back = stu_back;
        this.clock_date = clock_date;
    }

    public ClockInInfo(int clock_id,int stu_id, String stu_name, String stu_address, String stu_class, double stu_tmp, boolean is_out, String stu_des, String stu_out, String stu_back, Date clock_date) {
        this.clock_id=clock_id;
        this.stu_id = stu_id;
        this.stu_name = stu_name;
        this.stu_address = stu_address;
        this.stu_class = stu_class;
        this.stu_tmp = stu_tmp;
        this.is_out = is_out;
        this.stu_des = stu_des;
        this.stu_out = stu_out;
        this.stu_back = stu_back;
        this.clock_date = clock_date.toString();
    }

    public String getClock_date() {
        return clock_date;
    }

    public void setClock_date(String clock_date) {
        this.clock_date = clock_date;
    }

    public int getStu_id() {
        return stu_id;
    }

    public void setStu_id(int stu_id) {
        this.stu_id = stu_id;
    }

    public String getStu_name() {
        return stu_name;
    }

    public void setStu_name(String stu_name) {
        this.stu_name = stu_name;
    }

    public String getStu_address() {
        return stu_address;
    }

    public void setStu_address(String stu_address) {
        this.stu_address = stu_address;
    }

    public String getStu_class() {
        return stu_class;
    }

    public void setStu_class(String stu_class) {
        this.stu_class = stu_class;
    }

    public double getStu_tmp() {
        return stu_tmp;
    }

    public void setStu_tmp(double stu_tmp) {
        this.stu_tmp = stu_tmp;
    }

    public boolean isIs_out() {
        return is_out;
    }

    public void setIs_out(boolean is_out) {
        this.is_out = is_out;
    }

    public String getStu_des() {
        return stu_des;
    }

    public void setStu_des(String stu_des) {
        this.stu_des = stu_des;
    }

    public String getStu_out() {
        return stu_out;
    }

    public void setStu_out(String stu_out) {
        this.stu_out = stu_out;
    }

    public String getStu_back() {
        return stu_back;
    }

    public void setStu_back(String stu_back) {
        this.stu_back = stu_back;
    }
}
