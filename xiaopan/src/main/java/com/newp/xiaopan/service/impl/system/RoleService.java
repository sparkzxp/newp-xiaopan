package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Role;
import com.newp.xiaopan.dao.system.IRoleDao;
import com.newp.xiaopan.service.system.IRoleService;

/**
 * @author 张霄鹏
 */
@Service
public class RoleService extends BaseService implements IRoleService {

	@Autowired
	private IRoleDao roleDao;

	public List<Role> queryList(Role role) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("role", role);
		return this.roleDao.query(params);
	}

	public Role query(Role role) {
		List<Role> list = this.queryList(role);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Role role) {
		String ret = this.roleDao.add(role);
		this.roleDao.addResources(role);
		return ret;
	}

	public Integer update(Role role) {
		Integer ret = this.roleDao.update(role);
		this.roleDao.deleteResources(role);
		this.roleDao.addResources(role);
		return ret;
	}

	public Integer delete(Role role) {
		Integer ret = this.roleDao.delete(role);
		this.roleDao.deleteResources(role);
		return ret;
	}

}
