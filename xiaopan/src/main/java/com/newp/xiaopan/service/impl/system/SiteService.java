/**
 * 
 */
package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.dao.system.ISiteDao;
import com.newp.xiaopan.service.system.ISiteService;

/**
 * @author 张霄鹏
 * 
 */
@Service
public class SiteService extends BaseService implements ISiteService {

	@Autowired
	private ISiteDao siteDao;

	public List<Site> queryList(Site site) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("site", site);
		return this.siteDao.query(params);
	}

	public Site query(Site site) {
		List<Site> list = this.queryList(site);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Site site) {
		return this.siteDao.add(site);
	}

	public Integer update(Site site) {
		return this.siteDao.update(site);
	}

	public Integer delete(Site site) {
		return this.siteDao.delete(site);
	}

}
