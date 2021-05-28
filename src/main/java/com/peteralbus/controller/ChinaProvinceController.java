package com.peteralbus.controller;

import com.peteralbus.domain.ChinaProvince;
import com.peteralbus.service.ChinaProvinceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class ChinaProvinceController
{
    @Autowired
    private ChinaProvinceService chinaProvinceService;
    @RequestMapping("/ChinaProvince")
    public ModelAndView ChinaProvince()
    {
        List<ChinaProvince> chinaProvinceList = chinaProvinceService.getconfirm();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("chinaProvinceList",chinaProvinceList);
        modelAndView.setViewName("/pages/time_series/china_province.jsp");
        return modelAndView;
    }
    @RequestMapping("/ChinaNew")
    public ModelAndView ChinaNew()
    {
        List<ChinaProvince> chinaProvinceList = chinaProvinceService.getnewconfirm();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("chinaProvinceList",chinaProvinceList);
        modelAndView.setViewName("/pages/time_series/china_new.jsp");
        return modelAndView;
    }
    @RequestMapping("/ProvinceToday")
    public ModelAndView ProvinceToday()
    {
        List<ChinaProvince> chinaProvinceList = chinaProvinceService.getnewconfirm();
        List<ChinaProvince> chinaProvinceConfirm=chinaProvinceService.getconfirm();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("chinaProvinceNew",chinaProvinceList);
        modelAndView.addObject("chinaProvinceConfirm",chinaProvinceConfirm);
        modelAndView.setViewName("/pages/time_series/province_today.jsp");
        return modelAndView;
    }
}
