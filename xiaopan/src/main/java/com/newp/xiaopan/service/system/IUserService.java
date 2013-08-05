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
@Transactional(propagation = Propagation.SUPPORTS, readOnly = false, rollbackFor = Exception.class)
public interface IUserService {

	User query(User user);

	List<User> queryList(User user);

	List<User> queryByPager(User user, Pager pager);

	Integer updatePart(User user);
}
