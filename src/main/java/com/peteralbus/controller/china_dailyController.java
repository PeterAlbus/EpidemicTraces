package com.peteralbus.controller;

import com.peteralbus.domain.ChinaDaily;
import com.peteralbus.service.china_dailyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.text.ParseException;
import java.util.List;

@Controller
public class china_dailyController
{
    @Autowired
    private china_dailyService chinaDailyService;
    @RequestMapping("/china_daily")
    public ModelAndView findAll() throws ParseException
    {
        List<ChinaDaily> chinaDailyList;
        chinaDailyList =chinaDailyService.getfromJson();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("chinalist", chinaDailyList);
        modelAndView.setViewName("/pages/time_series/china_daily.jsp");
        return modelAndView;
    }
}
