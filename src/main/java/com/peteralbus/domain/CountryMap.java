package com.peteralbus.domain;

public class CountryMap
{
    String city;
    int count;

    @Override
    public String toString() {
        return "CountryMap{" +
                "city='" + city + '\'' +
                ", count=" + count +
                '}';
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
