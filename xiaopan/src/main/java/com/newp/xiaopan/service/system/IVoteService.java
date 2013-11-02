package com.newp.xiaopan.service.system;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Vote;

/**
 * @author 张霄鹏
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface IVoteService {

	List<Map<String, Object>> queryStat(Vote vote);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Vote vote);
}