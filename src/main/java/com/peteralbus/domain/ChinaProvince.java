package com.peteralbus.domain;

public class ChinaProvince implements Comparable<ChinaProvince>
{
    String name;
    int value;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    @Override
    public int compareTo(ChinaProvince o) {
        return this.value-o.value;
    }
}
