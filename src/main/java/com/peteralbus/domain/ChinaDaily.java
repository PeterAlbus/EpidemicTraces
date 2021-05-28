package com.peteralbus.domain;

import java.sql.Date;

public class ChinaDaily
{
    Date date;
    int NewCase;
    int Comulative;
    int Death;

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getNewCase() {
        return NewCase;
    }

    public void setNewCase(int newCase) {
        NewCase = newCase;
    }

    public int getComulative() {
        return Comulative;
    }

    public void setComulative(int comulative) {
        Comulative = comulative;
    }

    public int getDeath() {
        return Death;
    }

    public void setDeath(int death) {
        Death = death;
    }

    @Override
    public String toString() {
        return "china_daily{" +
                "date=" + date +
                ", NewCase=" + NewCase +
                ", Comulative=" + Comulative +
                ", Death=" + Death +
                '}';
    }
}
