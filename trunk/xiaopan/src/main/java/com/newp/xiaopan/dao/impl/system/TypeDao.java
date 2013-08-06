/**
 * 
 */
package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.dao.system.ITypeDao;

/**
 * @author 张霄鹏
 * 
 */
@Repository
public class TypeDao implements ITypeDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Type> query(Map<String, Object> params) {
		return this.sqlSession.selectList("typeNpc.query", params);
	}

	public String add(Type type) {
		this.sqlSession.insert("typeNpc.add", type);
		return String.valueOf(type.getId());
	}

	public Integer update(Type type) {
		return this.sqlSession.update("typeNpc.update", type);
	}

	public Integer delete(Type type) {
		return this.sqlSession.delete("typeNpc.delete", type);
	}
}