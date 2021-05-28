package com.peteralbus.service;

import com.peteralbus.domain.ChinaDaily;
import com.peteralbus.domain.News;

import java.util.List;

public interface newsService
{
    public List<News> getNews();
    public ChinaDaily getTodayData();
}
