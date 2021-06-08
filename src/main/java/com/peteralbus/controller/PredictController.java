package com.peteralbus.controller;

import com.peteralbus.domain.IndRNN;
import com.peteralbus.domain.Predict;
import com.peteralbus.service.IndRNNService;
import com.peteralbus.service.PredictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class PredictController
{
    @Autowired
    private PredictService predictService;
    @Autowired
    private IndRNNService indRNNService;
    @RequestMapping("/GlobalDeathPredict")
    public ModelAndView GlobalDeathPredict()
    {
        List<Predict> predictList=predictService.findAll();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("predictList",predictList);
        modelAndView.setViewName("/pages/predict/global_death.jsp");
        return modelAndView;
    }
    @RequestMapping("/GlobalConfirmPredict")
    public ModelAndView GlobalConfirmPredict()
    {
        List<Predict> predictList=predictService.findAll();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("predictList",predictList);
        modelAndView.setViewName("/pages/predict/global_confirmed.jsp");
        return modelAndView;
    }
    @RequestMapping("/ChinaConfirmPredict")
    public ModelAndView ChinaConfirmPredict()
    {
        List<Predict> predictList=predictService.findAll();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("predictList",predictList);
        modelAndView.setViewName("/pages/predict/china_confirmed.jsp");
        return modelAndView;
    }
    @RequestMapping("/USAConfirmPredict")
    public ModelAndView USAConfirmPredict()
    {
        List<Predict> predictList=predictService.findAll();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("predictList",predictList);
        modelAndView.setViewName("/pages/predict/usa_confirmed.jsp");
        return modelAndView;
    }
    @RequestMapping("/IndRNNPredict")
    public ModelAndView IndRNNPredict()
    {
        List<IndRNN> predictList=indRNNService.findAll();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("predictList",predictList);
        modelAndView.setViewName("/pages/predict/IndRNN.jsp");
        return modelAndView;
    }
}
