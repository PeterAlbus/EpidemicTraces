package com.peteralbus.service.impl;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.peteralbus.dao.china_dailyDao;
import com.peteralbus.domain.ChinaDaily;
import com.peteralbus.service.china_dailyService;
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

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service("china_dailyService")
public class china_dailyServiceImpl implements china_dailyService
{
    @Override
    public List<ChinaDaily> getfromJson() throws ParseException {
        List<ChinaDaily> chinaDailyList = new ArrayList<ChinaDaily>();
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
                int NewCase=oneday.get("nowConfirm").getAsInt();
                int Comulative=oneday.get("confirm").getAsInt();
                int Death=oneday.get("dead").getAsInt();
                str+=oneday.get("y").getAsString();
                str+='-';
                String date=oneday.get("date").getAsString();
                String[] strings = date.split("\\.");
                str+= strings[0];
                str+='-';
                str+= strings[1];
                java.util.Date utilDate= new SimpleDateFormat("yyyy-MM-dd").parse(str);
                Date sqlDate=new Date(utilDate.getTime());
                ChinaDaily chinaDaily=new ChinaDaily();
                chinaDaily.setComulative(Comulative);
                chinaDaily.setDate(sqlDate);
                chinaDaily.setDeath(Death);
                chinaDaily.setNewCase(NewCase);
                chinaDailyList.add(chinaDaily);
            }
        }
        return chinaDailyList;
    }

    @Override
    public List<ChinaDaily> findAll(){
        try {
            InputStream in= Resources.getResourceAsStream("SqlMapConfig.xml");
            SqlSessionFactoryBuilder build=new SqlSessionFactoryBuilder();
            SqlSessionFactory factory=build.build(in);
            SqlSession sqlSession=factory.openSession();
            china_dailyDao chinadailyDao=sqlSession.getMapper(china_dailyDao.class);
            return chinadailyDao.findAll();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
