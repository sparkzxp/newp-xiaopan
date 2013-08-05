package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.User;
import com.newp.xiaopan.common.PagerUtil;
import com.newp.xiaopan.common.bean.Pager;
import com.newp.xiaopan.dao.system.IUserDao;
import com.newp.xiaopan.service.system.IUserService;

/**
 * 用户管理
 */
@Service
public class UserService implements IUserService {

	@Autowired
	private IUserDao userDao;

	public List<User> queryByPager(User user, Pager pager) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("user", user);
		pager.setTotalSize(this.userDao.count(param));
		PagerUtil.setPager(pager);
		if (pager.getTotalSize() > 0) {
			param.put("pager", pager);
			return this.userDao.queryByPager(param);
		}
		return null;
	}

	public User query(User user) {
		List<User> list = this.queryList(user);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public List<User> queryList(User user) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("user", user);
		return userDao.query(param);
	}

	public Integer updatePart(User user) {
		return this.userDao.updatePart(user);
	}
}
