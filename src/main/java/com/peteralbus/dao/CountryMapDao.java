package com.peteralbus.dao;

import com.peteralbus.domain.CountryMap;

import java.util.List;

public interface CountryMapDao
{
    public List<CountryMap> findChinaMap();
    public List<CountryMap> findUSAMap();
    public void updateChinaMap(CountryMap countryMap);
    public void updateUSAMap(CountryMap countryMap);
}
