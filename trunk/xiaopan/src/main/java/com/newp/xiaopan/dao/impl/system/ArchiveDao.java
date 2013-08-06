/**
 * 
 */
package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Archive;
import com.newp.xiaopan.dao.system.IArchiveDao;

/**
 * @author 张霄鹏
 * 
 */
@Repository
public class ArchiveDao implements IArchiveDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Archive> query(Map<String, Object> params) {
		return this.sqlSession.selectList("archiveNpc.query", params);
	}

	public String add(Archive archive) {
		this.sqlSession.insert("archiveNpc.add", archive);
		return String.valueOf(archive.getId());
	}

	public Integer update(Archive archive) {
		return this.sqlSession.update("archiveNpc.update", archive);
	}

	public Integer delete(Archive archive) {
		return this.sqlSession.delete("archiveNpc.delete", archive);
	}
}
