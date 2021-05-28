package com.peteralbus.service;

import com.peteralbus.domain.ClockInInfo;

import java.util.List;

public interface InfoCollectService
{
    int ClockIn(ClockInInfo clockInInfo);
    List<ClockInInfo> findAll();
}
