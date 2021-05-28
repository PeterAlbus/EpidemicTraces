package com.peteralbus.service;

import com.peteralbus.domain.CountryMap;

import java.util.List;

public interface CountryMapService
{
    public List<CountryMap> getChinaMap();
    public List<CountryMap> getUSAMap();
    public void updateChina();
    public void updateUSA();
}
