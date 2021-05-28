package com.peteralbus.service.impl;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.peteralbus.dao.CountryMapDao;
import com.peteralbus.domain.CountryMap;
import com.peteralbus.service.CountryMapService;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

@Service("CountryMapService")
public class CountryMapServiceImpl implements CountryMapService
{
    @Override
    public void updateUSA()
    {
        System.out.println("正在更新美国地图数据");
        try {
            InputStream in= Resources.getResourceAsStream("SqlMapConfig.xml");
            SqlSessionFactoryBuilder build=new SqlSessionFactoryBuilder();
            SqlSessionFactory factory=build.build(in);
            SqlSession sqlSession=factory.openSession();
            CountryMapDao countryMapDao = sqlSession.getMapper(CountryMapDao.class);
            CountryMap countryMap=new CountryMap();
            StringBuilder json = new StringBuilder();
            try {
                URL urlObject = new URL("https://view.inews.qq.com/g2/getOnsInfo?name=disease_foreign");
                URLConnection uc = urlObject.openConnection();
                BufferedReader bin = new BufferedReader(new InputStreamReader(uc.getInputStream(), "utf-8"));
                String inputLine = null;
                while ((inputLine = bin.readLine()) != null) {
                    json.append(inputLine);
                }
                bin.close();
            } catch (Exception e) {
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
                JsonArray foreignList = object.get("foreignList").getAsJsonArray();
                JsonObject usa=foreignList.get(0).getAsJsonObject();
                JsonArray children=usa.get("children").getAsJsonArray();
                for (int i = 0; i < children.size()-7; i++) {
                    JsonObject current=children.get(i).getAsJsonObject();
                    String name=current.get("nameMap").getAsString();
                    int confirm=current.get("confirm").getAsInt();
                    System.out.println(name+","+confirm);
                    countryMap.setCount(confirm);
                    countryMap.setCity(name);
                    countryMapDao.updateUSAMap(countryMap);
                }
            }
            sqlSession.commit();
            sqlSession.close();
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @Override
    public void updateChina()
    {
        System.out.println("正在更新中国地图数据");
        try {
            InputStream in= Resources.getResourceAsStream("SqlMapConfig.xml");
            SqlSessionFactoryBuilder build=new SqlSessionFactoryBuilder();
            SqlSessionFactory factory=build.build(in);
            SqlSession sqlSession=factory.openSession();
            CountryMapDao countryMapDao = sqlSession.getMapper(CountryMapDao.class);
            CountryMap countryMap=new CountryMap();
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
            if (element.isJsonObject()) {
                JsonObject object = element.getAsJsonObject();
                JsonArray areaTree = object.get("areaTree").getAsJsonArray();
                JsonObject china=areaTree.get(0).getAsJsonObject();
                JsonArray children=china.get("children").getAsJsonArray();
                for (int i = 0; i < children.size(); i++) {
                    JsonObject current=children.get(i).getAsJsonObject();
                    String name=current.get("name").getAsString();
                    JsonObject total=current.get("total").getAsJsonObject();
                    int confirm=total.get("confirm").getAsInt();
                    System.out.println(name+","+confirm);
                    countryMap.setCount(confirm);
                    countryMap.setCity(name);
                    countryMapDao.updateChinaMap(countryMap);
                }
            }
            sqlSession.commit();
            sqlSession.close();
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<CountryMap> getUSAMap()
    {
        try {
            InputStream in= Resources.getResourceAsStream("SqlMapConfig.xml");
            SqlSessionFactoryBuilder build=new SqlSessionFactoryBuilder();
            SqlSessionFactory factory=build.build(in);
            SqlSession sqlSession=factory.openSession();
            CountryMapDao countryMapDao =sqlSession.getMapper(CountryMapDao.class);
            return countryMapDao.findUSAMap();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<CountryMap> getChinaMap()
    {
        try {
            InputStream in= Resources.getResourceAsStream("SqlMapConfig.xml");
            SqlSessionFactoryBuilder build=new SqlSessionFactoryBuilder();
            SqlSessionFactory factory=build.build(in);
            SqlSession sqlSession=factory.openSession();
            CountryMapDao countryMapDao =sqlSession.getMapper(CountryMapDao.class);
            return countryMapDao.findChinaMap();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


}
