package com.peteralbus;

import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import com.peteralbus.dao.CountryMapDao;
import com.peteralbus.domain.ChinaDaily;
import com.peteralbus.domain.CountryMap;
import com.peteralbus.domain.News;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class JsonTest
{
    @Test
    public void json()
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
        System.out.println(jo.get("success").getAsString());
        Gson gson = new Gson();
        List<News> newsList = gson.fromJson(jo.get("results").getAsJsonArray(), new TypeToken<List<News>>(){}.getType());
        for(News i:newsList)
        {
            System.out.println(i);
        }
    }
    @Test
    public void date()
    {
        Date date = new Date();//获得系统当前时间.
        SimpleDateFormat sdf = new SimpleDateFormat( " yyyy-MM-dd" );
        String nowTime = sdf.format(date);
        System.out.println(nowTime);
    }
    @Test
    public void jsonobject()
    {
        StringBuilder json = new StringBuilder();
        try {
            URL urlObject = new URL("http://49.4.25.117/JKZX/yq_20200719.json");
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
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(String.valueOf(json));
        if (element.isJsonObject()) {
            JsonObject object = element.getAsJsonObject();
            JsonArray features = object.getAsJsonArray("features");  //
            for (int i = 0; i < features.size(); i++) {
                JsonObject a=features.get(i).getAsJsonObject();
                JsonObject properties=a.get("properties").getAsJsonObject();
                String city=properties.get("name").getAsString();
                int confirmed=properties.get("累计确诊").getAsInt();
                System.out.println(city+" "+confirmed);
            }
        }
    }
    @Test
    public void tencentjson() {
        StringBuilder json = new StringBuilder();
        try {
            URL urlObject = new URL("https://view.inews.qq.com/g2/getOnsInfo?name=disease_other");
            URLConnection uc = urlObject.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(), "utf-8"));
            String inputLine = null;
            while ((inputLine = in.readLine()) != null) {
                json.append(inputLine);
            }
            in.close();
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
        if (element.isJsonObject()) {
            JsonObject object = element.getAsJsonObject();
            JsonArray chinaDayList = object.get("chinaDayList").getAsJsonArray();
            for (int i = 0; i < chinaDayList.size(); i++) {
                String str = "";
                JsonObject oneday = chinaDayList.get(i).getAsJsonObject();
                int NewCase = oneday.get("nowConfirm").getAsInt();
                int Comulative = oneday.get("confirm").getAsInt();
                int Death = oneday.get("dead").getAsInt();
                str += oneday.get("y").getAsString();
                str += "-";
                String date = oneday.get("date").getAsString();
                String[] strings = date.split("\\.");
                str += strings[0];
                str += '-';
                str += strings[1];
                System.out.println(str);
            }
        }
    }
    @Test
    public void testUpdate()
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
    @Test
    public void getData()
    {
        StringBuilder json = new StringBuilder();
        try {
            URL urlObject = new URL("https://view.inews.qq.com/g2/getOnsInfo?name=disease_foreign");
            URLConnection uc = urlObject.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(), "utf-8"));
            String inputLine = null;
            while ((inputLine = in.readLine()) != null) {
                json.append(inputLine);
            }
            in.close();
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
            JsonArray globalDailyHistory = object.get("globalDailyHistory").getAsJsonArray();
            for (int i = 0; i < globalDailyHistory.size(); i++)
            {
                JsonObject thisone=globalDailyHistory.get(i).getAsJsonObject();
                String str="";
                str+=thisone.get("y").getAsString();
                str+=".";
                str+=thisone.get("date").getAsString();
                JsonObject all=thisone.get("all").getAsJsonObject();
                int confirm=all.get("confirm").getAsInt();
                int dead=all.get("dead").getAsInt();
                System.out.println(str+","+confirm+","+dead);
            }
        }
    }
    @Test
    public void getChina()
    {
        StringBuilder json = new StringBuilder();
        try {
            URL urlObject = new URL("https://view.inews.qq.com/g2/getOnsInfo?name=disease_other");
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
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(String.valueOf(json));
        String data = "data";
        if (element.isJsonObject())
        {
            JsonObject object = element.getAsJsonObject();
            data = object.get("data").getAsString();
        }
        element=parser.parse(data);
        if (element.isJsonObject())
        {
            JsonObject object=element.getAsJsonObject();
            JsonArray chinaDayList=object.get("chinaDayList").getAsJsonArray();
            for (int i = 0; i < chinaDayList.size(); i++)
            {
                String str="";
                JsonObject oneday=chinaDayList.get(i).getAsJsonObject();
                int Comulative=oneday.get("confirm").getAsInt();
                str+=oneday.get("y").getAsString();
                str+='.';
                String date=oneday.get("date").getAsString();
                String[] strings = date.split("\\.");
                str+= strings[0];
                str+='.';
                str+= strings[1];
                System.out.println(str+","+Comulative);
            }
        }
    }
    @Test
    public void getWorld()
    {
        StringBuilder json = new StringBuilder();
        try {
            URL urlObject = new URL("https://api.inews.qq.com/newsqa/v1/automation/modules/list?modules=FAutoGlobalStatis,FAutoContinentStatis,FAutoGlobalDailyList,FAutoCountryConfirmAdd");
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
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(String.valueOf(json));
        String data = "data";
        if (element.isJsonObject())
        {
            JsonObject object = element.getAsJsonObject();
            JsonObject d=object.get("data").getAsJsonObject();
            JsonArray FAutoGlobalDailyList=d.get("FAutoGlobalDailyList").getAsJsonArray();
            for (int i = FAutoGlobalDailyList.size()-120; i < FAutoGlobalDailyList.size(); i++)
            {
                String str="";
                JsonObject oneday=FAutoGlobalDailyList.get(i).getAsJsonObject();
                int Comulative=oneday.get("all").getAsJsonObject().get("confirm").getAsInt();
                int Dead=oneday.get("all").getAsJsonObject().get("dead").getAsInt();
                str+=oneday.get("y").getAsString();
                str+='.';
                String date=oneday.get("date").getAsString();
                String[] strings = date.split("\\.");
                str+= strings[0];
                str+='.';
                str+= strings[1];
                System.out.println(str+","+Comulative+","+Dead);
            }
        }
    }
    @Test
    public void getChinaProvince() throws ParseException
    {
        System.out.println("日期,北京市,天津市,河北省,山西省,内蒙古自治区,辽宁省,吉林省,黑龙江省,上海市,江苏省,浙江省,安徽省,福建省,江西省,山东省,河南省,湖北省,湖南省,广东省,广西壮族自治区,海南省,重庆市,四川省,贵州省,云南省,西藏自治区,陕西省,甘肃省,青海省,宁夏回族自治区,新疆维吾尔自治区,台湾省,香港特别行政区,澳门特别行政区");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
        String start="20200116";
        String end="20210511";
        Calendar st=Calendar.getInstance();
        Calendar ed=Calendar.getInstance();
        st.setTime(sdf.parse(start));
        ed.setTime(sdf.parse(end));
        while(!st.after(ed))
        {
            String date=sdf.format(st.getTime());
            System.out.print(date);
            String url="http://49.4.25.117/JKZX/yq_"+ date +".json";
            StringBuilder json = new StringBuilder();
            try {
                URL urlObject = new URL(url);
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
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(String.valueOf(json));
            if (element.isJsonObject())
            {
                JsonObject object = element.getAsJsonObject();
                JsonArray features = object.getAsJsonArray("features");  //
                for (int i = 0; i < features.size(); i++) {
                    JsonObject a=features.get(i).getAsJsonObject();
                    JsonObject properties=a.get("properties").getAsJsonObject();
                    int confirmed=properties.get("累计确诊").getAsInt();
                    System.out.print(","+confirmed);
                }
            }
            st.add(Calendar.DAY_OF_YEAR,1);
            System.out.println();
        }
    }
}
