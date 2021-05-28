package com.peteralbus.service.impl;

import com.peteralbus.dao.StudentInfoDao;
import com.peteralbus.dao.china_dailyDao;
import com.peteralbus.domain.ClockInInfo;
import com.peteralbus.service.InfoCollectService;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Service("InfoCollectService")
public class InfoCollectServiceImpl implements InfoCollectService
{
    @Override
    public int ClockIn(ClockInInfo clockInInfo)
    {
        try {
            InputStream in= Resources.getResourceAsStream("SqlMapConfig.xml");
            SqlSessionFactoryBuilder build=new SqlSessionFactoryBuilder();
            SqlSessionFactory factory=build.build(in);
            SqlSession sqlSession=factory.openSession();
            StudentInfoDao studentInfoDao = sqlSession.getMapper(StudentInfoDao.class);
            int id=studentInfoDao.ClockIn(clockInInfo);
            sqlSession.commit();
            sqlSession.close();
            in.close();
            return id;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public List<ClockInInfo> findAll()
    {
        try {
            InputStream in= Resources.getResourceAsStream("SqlMapConfig.xml");
            SqlSessionFactoryBuilder build=new SqlSessionFactoryBuilder();
            SqlSessionFactory factory=build.build(in);
            SqlSession sqlSession=factory.openSession();
            StudentInfoDao studentInfoDao = sqlSession.getMapper(StudentInfoDao.class);
            return studentInfoDao.findAll();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
