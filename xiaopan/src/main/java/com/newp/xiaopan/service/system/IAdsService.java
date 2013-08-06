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
@Transactional(propagation = Propagation.SUPPORTS, readOnly = false, rollbackFor = Exception.class)
public interface IAdsService {

	Ads query(Ads ads);

	List<Ads> queryList(Ads ads);

	String add(Ads ads);

	Integer update(Ads ads);

	Integer delete(Ads ads);
}
