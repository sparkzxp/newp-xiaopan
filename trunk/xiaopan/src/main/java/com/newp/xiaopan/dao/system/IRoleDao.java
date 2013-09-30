package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Role;

/**
 * @author 张霄鹏
 */
public interface IRoleDao {

	List<Role> query(Map<String, Object> params);

	String add(Role role);

	String addResources(Role role);

	Integer update(Role role);

	Integer delete(Role role);

	Integer deleteResources(Role role);
}
