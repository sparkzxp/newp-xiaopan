/**
 * 
 */
package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Key;
import com.newp.xiaopan.dao.system.IKeyDao;

/**
 * @author 张霄鹏
 * 
 */
@Repository
public class KeyDao implements IKeyDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Key> query(Map<String, Object> params) {
		return this.sqlSession.selectList("keyNpc.query", params);
	}

	public String add(Key key) {
		this.sqlSession.insert("keyNpc.add", key);
		return String.valueOf(key.getId());
	}

	public Integer update(Key key) {
		return this.sqlSession.update("keyNpc.update", key);
	}

	public Integer delete(Key key) {
		return this.sqlSession.delete("keyNpc.delete", key);
	}
}
