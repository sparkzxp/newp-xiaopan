package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.City;

/**
 * @author 张霄鹏
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface ICityService {

	City query(City city);

	List<City> queryList(City city);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(City city);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(City city);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(City city);
}
