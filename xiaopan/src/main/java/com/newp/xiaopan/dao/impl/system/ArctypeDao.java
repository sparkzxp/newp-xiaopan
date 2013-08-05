/**
 * 
 */
package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Arctype;
import com.newp.xiaopan.dao.system.IArctypeDao;

/**
 * @author 张霄鹏
 * 
 */
@Repository
public class ArctypeDao implements IArctypeDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Arctype> query(Map<String, Object> params) {
		return this.sqlSession.selectList("arctypeNpc.query", params);
	}

	public String add(Arctype arctype) {
		this.sqlSession.insert("arctypeNpc.add", arctype);
		return String.valueOf(arctype.getId());
	}

	public Integer update(Arctype arctype) {
		return this.sqlSession.update("arctypeNpc.update", arctype);
	}
}
