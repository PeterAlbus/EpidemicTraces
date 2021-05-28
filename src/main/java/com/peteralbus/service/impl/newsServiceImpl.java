package com.peteralbus.service.impl;

import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import com.peteralbus.domain.ChinaDaily;
import com.peteralbus.domain.ChinaProvince;
import com.peteralbus.domain.News;
import com.peteralbus.service.newsService;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

@Service("newsService")
public class newsServiceImpl implements newsService
{
    @Override
    public ChinaDaily getTodayData()
    {
        ChinaDaily chinaDaily = new ChinaDaily();
        StringBuilder json = new StringBuilder();
        try
        {
            URL urlObject = new URL("https://view.inews.qq.com/g2/getOnsInfo?name=disease_h5");
            URLConnection uc = urlObject.openConnection();
            BufferedReader bin = new BufferedReader(new InputStreamReader(uc.getInputStream(), "utf-8"));
            String inputLine = null;
            while ((inputLine = bin.readLine()) != null) {
                json.append(inputLine);
            }
            bin.close();
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(String.valueOf(json));
        String data = "data";
        if (element.isJsonObject()) {
            JsonObject object = element.getAsJsonObject();
            data = object.get("data").getAsString();
        }
        element = parser.parse(data);
        if (element.isJsonObject())
        {
            JsonObject object = element.getAsJsonObject();
            JsonObject chinaTotal = object.get("chinaTotal").getAsJsonObject();
            int confirm=chinaTotal.get("confirm").getAsInt();
            int nowConfirm=chinaTotal.get("nowConfirm").getAsInt();
            int death=chinaTotal.get("dead").getAsInt();
            chinaDaily.setNewCase(nowConfirm);
            chinaDaily.setDeath(death);
            chinaDaily.setComulative(confirm);
        }
        return chinaDaily;
    }

    @Override
    public List<News> getNews()
    {
        StringBuilder json = new StringBuilder();
        try {
            URL urlObject = new URL("https://lab.isaaclin.cn/nCoV/api/news");
            URLConnection uc = urlObject.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(),"utf-8"));
            String inputLine = null;
            while ( (inputLine = in.readLine()) != null) {
                json.append(inputLine);
            }
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String info=json.toString();
        JsonParser jp = new JsonParser();
        JsonObject jo = jp.parse(info).getAsJsonObject();
        if(!jo.get("success").getAsString().equals("true"))
        {
            System.out.println("获取新闻信息失败");
            return null;
        }
        Gson gson = new Gson();
        System.out.println("获取新闻信息成功");
        return gson.fromJson(jo.get("results").getAsJsonArray(), new TypeToken<List<News>>(){}.getType());
    }
}
