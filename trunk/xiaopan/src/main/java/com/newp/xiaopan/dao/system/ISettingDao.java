package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Setting;

/**
 * @author 张霄鹏
 */
public interface ISettingDao {

	List<Setting> query(Map<String, Object> params);

	Integer update(Setting setting);
}
