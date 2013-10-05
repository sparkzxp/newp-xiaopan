package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.User;

/**
 * 用户管理
 */
public interface IUserDao {
	List<User> query(Map<String, Object> param);

	List<User> queryByPager(Map<String, Object> param);

	Integer count(Map<String, Object> param);

	Integer updatePart(User user);

	String add(User key);

	Integer update(User key);

	Integer delete(User key);
}
