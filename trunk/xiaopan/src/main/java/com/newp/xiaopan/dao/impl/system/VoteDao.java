package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Vote;
import com.newp.xiaopan.dao.system.IVoteDao;

/**
 * @author 张霄鹏
 */
@Repository
public class VoteDao implements IVoteDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Map<String, Object>> queryStat(Vote vote) {
		return this.sqlSession.selectList("voteNpc.queryStat", vote);
	}

	public String add(Vote vote) {
		this.sqlSession.insert("voteNpc.add", vote);
		return String.valueOf(vote.getId());
	}

	public Integer count(Map<String, Object> params) {
		return this.sqlSession.selectOne("voteNpc.count", params);
	}
}
