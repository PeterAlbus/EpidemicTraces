package com.peteralbus.service.impl;

import com.peteralbus.dao.CountryMapDao;
import com.peteralbus.dao.WorldTimeDao;
import com.peteralbus.domain.WorldTime;
import com.peteralbus.service.WorldTimeService;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Service("WorldTimeService")
public class WorldTimeServiceImpl implements WorldTimeService
{
    @Override
    public List<WorldTime> findAll()
    {
        try {
            InputStream in= Resources.getResourceAsStream("SqlMapConfig.xml");
            SqlSessionFactoryBuilder build=new SqlSessionFactoryBuilder();
            SqlSessionFactory factory=build.build(in);
            SqlSession sqlSession=factory.openSession();
            WorldTimeDao worldTimeDao =sqlSession.getMapper(WorldTimeDao.class);
            return worldTimeDao.findAll();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
