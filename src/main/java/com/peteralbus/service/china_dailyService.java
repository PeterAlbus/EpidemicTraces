package com.peteralbus.service;

import com.peteralbus.domain.ChinaDaily;

import java.text.ParseException;
import java.util.List;

public interface china_dailyService
{
    public List<ChinaDaily> findAll();
    public List<ChinaDaily> getfromJson() throws ParseException;
}
