package com.peteralbus.controller;

import com.peteralbus.domain.ClockInInfo;
import com.peteralbus.service.InfoCollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class InfoCollectController
{
    @Autowired
    private InfoCollectService infoCollectService;
    @RequestMapping("/InfoCollection")
    public String CollectForm()
    {
        return "/pages/info_collection/info_collection.jsp";
    }
    @RequestMapping("/clock_in")
    public ModelAndView ClockIn(HttpServletRequest request, HttpServletResponse response)
    {
        int stu_id= Integer.parseInt(request.getParameter("stu_id"));
        String stu_name=request.getParameter("stu_name");
        String stu_address=request.getParameter("stu_address");
        String stu_class=request.getParameter("stu_class");
        double stu_tmp= Double.parseDouble(request.getParameter("stu_tmp"));
        boolean is_out= Boolean.parseBoolean(request.getParameter("is_out"));
        String stu_des=request.getParameter("stu_des");
        String stu_out=request.getParameter("stu_time_out");
        String stu_back=request.getParameter("stu_time_back");
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat( " yyyy-MM-dd" );
        String nowTime = sdf.format(date);
        ClockInInfo clockInInfo=new ClockInInfo(stu_id,stu_name,stu_address,stu_class,stu_tmp,is_out,stu_des,stu_out,stu_back,nowTime);
        int id=infoCollectService.ClockIn(clockInInfo);
        System.out.println(id);
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("clock_in",clockInInfo);
        modelAndView.setViewName("/pages/info_collection/success.jsp");
        return modelAndView;
    }
    @RequestMapping("/clocklist")
    public ModelAndView ClockList()
    {
        List<ClockInInfo> clockInInfoList=infoCollectService.findAll();
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("clockInInfoList",clockInInfoList);
        modelAndView.setViewName("/pages/info_collection/info_display.jsp");
        return modelAndView;
    }
}
