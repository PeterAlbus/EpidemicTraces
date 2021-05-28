package com.peteralbus.controller;

import com.peteralbus.domain.ChinaDaily;
import com.peteralbus.domain.News;
import com.peteralbus.service.newsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class indexController
{
    @Autowired
    private newsService ns;
    @RequestMapping("/index")
    public ModelAndView index()
    {
        List<News> newsList;
        newsList=ns.getNews();
        ChinaDaily chinaDaily=ns.getTodayData();
        if(newsList==null)
        {
            ModelAndView modelAndView=new ModelAndView();
            modelAndView.addObject("message","获取新闻信息失败!");
            modelAndView.setViewName("/pages/message.jsp");
            return modelAndView;
        }
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("newslist",newsList);
        modelAndView.addObject("today",chinaDaily);
        modelAndView.setViewName("/pages/index.jsp");
        return modelAndView;
    }
}
