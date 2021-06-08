package com.peteralbus.service.impl;

import com.peteralbus.dao.IndRNNDao;
import com.peteralbus.dao.PredictDao;
import com.peteralbus.domain.IndRNN;
import com.peteralbus.service.IndRNNService;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/*Created on 2021/6/8.*/
/*@author PeterAlbus*/
@Service("IndRNNService")
public class IndRNNServiceImpl implements IndRNNService
{

    @Override
    public List<IndRNN> findAll()
    {
        try {
            InputStream in= Resources.getResourceAsStream("SqlMapConfig.xml");
            SqlSessionFactoryBuilder build=new SqlSessionFactoryBuilder();
            SqlSessionFactory factory=build.build(in);
            SqlSession sqlSession=factory.openSession();
            IndRNNDao indRNNDao=sqlSession.getMapper(IndRNNDao.class);
            return indRNNDao.findAll();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}

