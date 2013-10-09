package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.dao.system.ITypeDao;
import com.newp.xiaopan.service.system.ITypeService;

/**
 * @author 张霄鹏
 * 
 */
@Service
public class TypeService extends BaseService implements ITypeService {

	@Autowired
	private ITypeDao typeDao;

	public List<Type> queryList(Type type) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		return this.typeDao.query(params);
	}

	public List<Type> queryDistinctList(Type type) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		return this.typeDao.queryDistinct(params);
	}

	public Type query(Type type) {
		List<Type> list = this.queryList(type);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Type type) {
		return this.typeDao.add(type);
	}

	public Integer update(Type type) {
		return this.typeDao.update(type);
	}

	public Integer delete(Type type) {
		return this.typeDao.delete(type);
	}

	public List<Type> queryquerySecondNodes() {
		return this.typeDao.queryquerySecondNodes();
	}

}
