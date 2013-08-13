/**
 * 
 */
package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Ads;

/**
 * @author 张霄鹏
 * 
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface IAdsService {

	Ads query(Ads ads);

	List<Ads> queryList(Ads ads);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Ads ads);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(Ads ads);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(Ads ads);
}
