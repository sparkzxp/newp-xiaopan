package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.User;
import com.newp.xiaopan.common.bean.Pager;

/**
 * 用户管理
 * 
 * @author 张霄鹏
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface IUserService {

	User query(User user);

	List<User> queryList(User user);

	List<User> queryByPager(User user, Pager pager);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer updatePart(User user);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(User user);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(User user);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(User user);
}
