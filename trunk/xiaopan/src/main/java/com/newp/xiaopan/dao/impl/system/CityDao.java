package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.City;
import com.newp.xiaopan.dao.system.ICityDao;

/**
 * @author 张霄鹏
 */
@Repository
public class CityDao implements ICityDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<City> query(Map<String, Object> params) {
		return this.sqlSession.selectList("cityNpc.query", params);
	}

	public String add(City city) {
		this.sqlSession.insert("cityNpc.add", city);
		return String.valueOf(city.getId());
	}

	public Integer update(City city) {
		return this.sqlSession.update("cityNpc.update", city);
	}

	public Integer delete(City city) {
		return this.sqlSession.delete("cityNpc.delete", city);
	}
}
