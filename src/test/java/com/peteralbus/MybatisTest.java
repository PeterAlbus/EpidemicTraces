package com.peteralbus;

import com.peteralbus.dao.china_dailyDao;
import com.peteralbus.domain.ChinaDaily;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class MybatisTest
{
    private InputStream in;
    private SqlSession sqlSession;
    private china_dailyDao chinadailyDao;
    @Before
    public void init() throws IOException {
        in= Resources.getResourceAsStream("SqlMapConfig.xml");
        SqlSessionFactoryBuilder build=new SqlSessionFactoryBuilder();
        SqlSessionFactory factory=build.build(in);
        sqlSession=factory.openSession();
        chinadailyDao=sqlSession.getMapper(china_dailyDao.class);
    }
    @After
    public void destroy() throws IOException {
        sqlSession.commit();
        sqlSession.close();
        in.close();
    }
    @Test
    public void testfindAll() throws IOException
    {
        List<ChinaDaily> dailyList=chinadailyDao.findAll();
        for(ChinaDaily cd:dailyList)
        {
            System.out.println(cd);
        }
    }
}
