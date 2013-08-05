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

import com.newp.xiaopan.bean.system.Arctype;
import com.newp.xiaopan.dao.system.IArctypeDao;
import com.newp.xiaopan.service.system.IArctypeService;

/**
 * @author 张霄鹏
 * 
 */
@Service
public class ArctypeService extends BaseService implements IArctypeService {

	@Autowired
	private IArctypeDao arctypeDao;

	public List<Arctype> queryList(Arctype arctype) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("arctype", arctype);
		return this.arctypeDao.query(params);
	}

	public Arctype query(Arctype arctype) {
		List<Arctype> list = this.queryList(arctype);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Arctype arctype) {
		return this.arctypeDao.add(arctype);
	}

	public Integer update(Arctype arctype) {
		return this.arctypeDao.update(arctype);
	}

	public Integer delete(Arctype arctype) {
		return this.arctypeDao.delete(arctype);
	}

}
