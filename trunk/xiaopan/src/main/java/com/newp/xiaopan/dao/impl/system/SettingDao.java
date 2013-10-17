package com.newp.xiaopan.dao.impl.system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newp.xiaopan.bean.system.Setting;
import com.newp.xiaopan.dao.system.ISettingDao;

/**
 * @author 张霄鹏
 */
@Repository
public class SettingDao implements ISettingDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Setting> query(Map<String, Object> params) {
		return this.sqlSession.selectList("settingNpc.query", params);
	}

	public Integer update(Setting setting) {
		return this.sqlSession.update("settingNpc.update", setting);
	}
}
