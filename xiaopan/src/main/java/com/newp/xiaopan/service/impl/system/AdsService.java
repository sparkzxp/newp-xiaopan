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

import com.newp.xiaopan.bean.system.Ads;
import com.newp.xiaopan.dao.system.IAdsDao;
import com.newp.xiaopan.service.system.IAdsService;

/**
 * @author 张霄鹏
 * 
 */
@Service
public class AdsService extends BaseService implements IAdsService {

	@Autowired
	private IAdsDao adsDao;

	public List<Ads> queryList(Ads ads) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("ads", ads);
		return this.adsDao.query(params);
	}

	public Ads query(Ads ads) {
		List<Ads> list = this.queryList(ads);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Ads ads) {
		return this.adsDao.add(ads);
	}

	public Integer update(Ads ads) {
		return this.adsDao.update(ads);
	}

	public Integer delete(Ads ads) {
		return this.adsDao.delete(ads);
	}

}
