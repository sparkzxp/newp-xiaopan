package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.City;

/**
 * @author 张霄鹏
 */
public interface ICityDao {

	List<City> query(Map<String, Object> params);

	String add(City city);

	Integer update(City city);

	Integer delete(City city);
}
