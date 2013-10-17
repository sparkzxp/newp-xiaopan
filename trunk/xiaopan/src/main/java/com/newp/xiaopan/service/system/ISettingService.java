package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Setting;

/**
 * @author 张霄鹏
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface ISettingService {

	Setting query(Setting setting);

	List<Setting> queryList(Setting setting);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(Setting setting);
}
