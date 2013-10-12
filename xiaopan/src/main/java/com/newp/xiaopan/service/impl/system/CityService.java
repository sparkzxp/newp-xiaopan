package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.City;
import com.newp.xiaopan.dao.system.ICityDao;
import com.newp.xiaopan.service.system.ICityService;

/**
 * @author 张霄鹏
 */
@Service
public class CityService extends BaseService implements ICityService {

	@Autowired
	private ICityDao cityDao;

	public List<City> queryList(City city) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("city", city);
		return this.cityDao.query(params);
	}

	public City query(City city) {
		List<City> list = this.queryList(city);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(City city) {
		return this.cityDao.add(city);
	}

	public Integer update(City city) {
		return this.cityDao.update(city);
	}

	public Integer delete(City city) {
		return this.cityDao.delete(city);
	}

}
