package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.User;
import com.newp.xiaopan.dao.system.IUserDao;

/**
 * 用户管理
 */
@Repository
public class UserDao implements IUserDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<User> query(Map<String, Object> param) {
		return this.sqlSession.selectList("userNpc.query", param);
	}

	public Integer count(Map<String, Object> param) {
		return Integer.valueOf(this.sqlSession.selectOne("userNpc.count", param).toString());
	}

	public List<User> queryByPager(Map<String, Object> param) {
		return this.sqlSession.selectList("userNpc.queryByPager", param);
	}
}
