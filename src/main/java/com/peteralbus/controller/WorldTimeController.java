package com.peteralbus.controller;

import com.peteralbus.domain.WorldTime;
import com.peteralbus.service.WorldTimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class WorldTimeController
{
    @Autowired
    private WorldTimeService worldTimeService;
    @RequestMapping("/WorldTime")
    public ModelAndView WorldTime()
    {
        List<WorldTime> worldTimeList=worldTimeService.findAll();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("worldTimeList",worldTimeList);
        modelAndView.setViewName("/pages/time_series/world_time.jsp");
        return modelAndView;
    }
}
