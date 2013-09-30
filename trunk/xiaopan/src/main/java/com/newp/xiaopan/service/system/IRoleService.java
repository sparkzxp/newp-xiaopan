package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Role;

/**
 * @author 张霄鹏
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface IRoleService {

	Role query(Role role);

	List<Role> queryList(Role role);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Role role);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(Role role);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(Role role);
}
