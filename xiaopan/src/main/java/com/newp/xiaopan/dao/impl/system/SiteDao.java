/**
 * 
 */
package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.dao.system.ISiteDao;

/**
 * @author 张霄鹏
 * 
 */
@Repository
public class SiteDao implements ISiteDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Site> query(Map<String, Object> params) {
		return this.sqlSession.selectList("siteNpc.query", params);
	}

	public String add(Site site) {
		this.sqlSession.insert("siteNpc.add", site);
		return String.valueOf(site.getId());
	}

	public Integer update(Site site) {
		return this.sqlSession.update("siteNpc.update", site);
	}

	public Integer delete(Site site) {
		return this.sqlSession.delete("siteNpc.delete", site);
	}
}
