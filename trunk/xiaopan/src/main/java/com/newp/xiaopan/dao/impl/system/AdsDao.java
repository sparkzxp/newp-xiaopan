/**
 * 
 */
package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Ads;
import com.newp.xiaopan.dao.system.IAdsDao;

/**
 * @author 张霄鹏
 * 
 */
@Repository
public class AdsDao implements IAdsDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Ads> query(Map<String, Object> params) {
		return this.sqlSession.selectList("adsNpc.query", params);
	}

	public String add(Ads ads) {
		this.sqlSession.insert("adsNpc.add", ads);
		return String.valueOf(ads.getId());
	}

	public Integer update(Ads ads) {
		return this.sqlSession.update("adsNpc.update", ads);
	}

	public Integer delete(Ads ads) {
		return this.sqlSession.delete("adsNpc.delete", ads);
	}

	public String addCitys(Ads ads) {
		this.sqlSession.insert("adsNpc.addCitys", ads);
		return String.valueOf(ads.getId());
	}

	public Integer deleteCitys(Ads ads) {
		return this.sqlSession.delete("adsNpc.deleteCitys", ads);
	}
}
