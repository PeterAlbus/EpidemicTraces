package com.peteralbus.dao;

import com.peteralbus.domain.WorldTime;

import java.util.List;

public interface WorldTimeDao
{
    List<WorldTime> findAll();
}
