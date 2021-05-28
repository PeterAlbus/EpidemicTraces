package com.peteralbus.service.impl;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.peteralbus.domain.ChinaProvince;
import com.peteralbus.service.ChinaProvinceService;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service("ChinaProvinceService")
public class ChinaProvinceServiceImpl implements ChinaProvinceService
{
    @Override
    public List<ChinaProvince> getnewconfirm()
    {
        List<ChinaProvince> chinaProvinceList=new ArrayList<ChinaProvince>();
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
            JsonArray areaTree = object.get("areaTree").getAsJsonArray();
            JsonObject china=areaTree.get(0).getAsJsonObject();
            JsonArray children=china.get("children").getAsJsonArray();
            for (int i = 0; i < children.size(); i++)
            {
                ChinaProvince chinaProvince=new ChinaProvince();
                JsonObject current=children.get(i).getAsJsonObject();
                String name=current.get("name").getAsString();
                JsonObject today=current.get("today").getAsJsonObject();
                int confirm=today.get("confirm").getAsInt();
                chinaProvince.setName(name);
                chinaProvince.setValue(confirm);
                chinaProvinceList.add(chinaProvince);
            }
        }
        return chinaProvinceList;
    }

    @Override
    public List<ChinaProvince> getconfirm()
    {
        List<ChinaProvince> chinaProvinceList=new ArrayList<ChinaProvince>();
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
            JsonArray areaTree = object.get("areaTree").getAsJsonArray();
            JsonObject china=areaTree.get(0).getAsJsonObject();
            JsonArray children=china.get("children").getAsJsonArray();
            for (int i = 0; i < children.size(); i++)
            {
                ChinaProvince chinaProvince=new ChinaProvince();
                JsonObject current=children.get(i).getAsJsonObject();
                String name=current.get("name").getAsString();
                JsonObject total=current.get("total").getAsJsonObject();
                int confirm=total.get("confirm").getAsInt();
                chinaProvince.setName(name);
                chinaProvince.setValue(confirm);
                chinaProvinceList.add(chinaProvince);
            }
        }
        Collections.sort(chinaProvinceList);
        return chinaProvinceList;
    }
}
