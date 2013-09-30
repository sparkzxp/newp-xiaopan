package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Role;
import com.newp.xiaopan.dao.system.IRoleDao;

/**
 * @author 张霄鹏
 */
@Repository
public class RoleDao implements IRoleDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Role> query(Map<String, Object> params) {
		return this.sqlSession.selectList("roleNpc.query", params);
	}

	public String add(Role role) {
		this.sqlSession.insert("roleNpc.add", role);
		return String.valueOf(role.getId());
	}

	public String addResources(Role role) {
		this.sqlSession.insert("roleNpc.addResources", role);
		return String.valueOf(role.getId());
	}

	public Integer update(Role role) {
		return this.sqlSession.update("roleNpc.update", role);
	}

	public Integer delete(Role role) {
		return this.sqlSession.delete("roleNpc.delete", role);
	}

	public Integer deleteResources(Role role) {
		return this.sqlSession.delete("roleNpc.deleteResources", role);
	}
}
