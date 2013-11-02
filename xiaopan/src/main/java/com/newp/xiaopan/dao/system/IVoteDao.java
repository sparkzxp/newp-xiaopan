package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Vote;

/**
 * @author 张霄鹏
 */
public interface IVoteDao {

	List<Map<String, Object>> queryStat(Vote vote);

	String add(Vote vote);

	/**
	 * 
	 * @param params:vote.ipAddress,voteDt
	 */
	Integer count(Map<String, Object> params);
}