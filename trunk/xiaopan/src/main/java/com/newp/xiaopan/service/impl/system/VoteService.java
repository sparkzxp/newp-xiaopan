package com.newp.xiaopan.service.impl.system;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Vote;
import com.newp.xiaopan.dao.system.IVoteDao;
import com.newp.xiaopan.service.system.IVoteService;

/**
 * @author 张霄鹏
 * 
 */
@Service
public class VoteService implements IVoteService {

	@Autowired
	private IVoteDao voteDao;

	public List<Map<String, Object>> queryStat(Vote vote) {
		return this.voteDao.queryStat(vote);
	}

	public String add(Vote vote) {
		String result = "投票失败，请稍候再试";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("vote", vote);
		params.put("voteDt", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		if (this.voteDao.count(params) > 1) {
			result = "亲，你所在的IP今日已投满两票，请明天再来吧";
		} else {
			this.voteDao.add(vote);
			result = "success";
		}
		return result;
	}

}
