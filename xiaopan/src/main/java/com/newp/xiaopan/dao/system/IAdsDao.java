package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Ads;

/**
 * @author 张霄鹏
 * 
 */
public interface IAdsDao {

	List<Ads> query(Map<String, Object> params);

	String add(Ads ads);

	Integer update(Ads ads);

	Integer delete(Ads ads);

	String addCitys(Ads ads);

	Integer deleteCitys(Ads ads);
}
