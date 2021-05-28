package com.peteralbus.dao;

import com.peteralbus.domain.ClockInInfo;

import java.util.List;

public interface StudentInfoDao
{
    int ClockIn(ClockInInfo clockInInfo);
    List<ClockInInfo> findAll();
}
