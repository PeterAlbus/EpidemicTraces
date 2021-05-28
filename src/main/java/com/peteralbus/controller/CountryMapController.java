package com.peteralbus.controller;

import com.peteralbus.domain.CountryMap;
import com.peteralbus.service.CountryMapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class CountryMapController
{
    @Autowired
    private CountryMapService countryMapService;
    @RequestMapping("/chinamap")
    public ModelAndView ChinaMap()
    {
        List<CountryMap> countryMapList = countryMapService.getChinaMap();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("chinamaplist", countryMapList);
        modelAndView.setViewName("/pages/map/china_map.jsp");
        return modelAndView;
    }
    @RequestMapping("/USAMap")
    public ModelAndView USAMap()
    {
        List<CountryMap> countryMapList = countryMapService.getUSAMap();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("USAmaplist", countryMapList);
        modelAndView.setViewName("/pages/map/usa_map.jsp");
        return modelAndView;
    }
    @RequestMapping("/UpdateChina")
    ModelAndView UpdateChina()
    {
        countryMapService.updateChina();
        return new ModelAndView("redirect:/chinamap");
    }
    @RequestMapping("/UpdateUSA")
    ModelAndView UpdateUSA()
    {
        countryMapService.updateUSA();
        return new ModelAndView("redirect:/USAMap");
    }
}
