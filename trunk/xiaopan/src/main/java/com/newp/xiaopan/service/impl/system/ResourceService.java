package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Resource;
import com.newp.xiaopan.dao.system.IResourceDao;
import com.newp.xiaopan.service.system.IResourceService;

/**
 * @author 张霄鹏
 */
@Service
public class ResourceService extends BaseService implements IResourceService {

	@Autowired
	private IResourceDao resourceDao;

	public List<Resource> queryList(Resource resource) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("resource", resource);
		return this.resourceDao.query(params);
	}

	public Resource query(Resource resource) {
		List<Resource> list = this.queryList(resource);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Resource resource) {
		return this.resourceDao.add(resource);
	}

	public Integer update(Resource resource) {
		return this.resourceDao.update(resource);
	}

	public Integer delete(Resource resource) {
		return this.resourceDao.delete(resource);
	}

}
