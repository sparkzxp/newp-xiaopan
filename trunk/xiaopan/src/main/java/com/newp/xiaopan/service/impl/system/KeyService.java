package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Key;
import com.newp.xiaopan.dao.system.IKeyDao;
import com.newp.xiaopan.service.system.IKeyService;

/**
 * @author 张霄鹏
 */
@Service
public class KeyService extends BaseService implements IKeyService {

	@Autowired
	private IKeyDao keyDao;

	public List<Key> queryList(Key key) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("key", key);
		return this.keyDao.query(params);
	}

	public Key query(Key key) {
		List<Key> list = this.queryList(key);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Key key) {
		return this.keyDao.add(key);
	}

	public Integer update(Key key) {
		return this.keyDao.update(key);
	}

	public Integer delete(Key key) {
		return this.keyDao.delete(key);
	}

}
