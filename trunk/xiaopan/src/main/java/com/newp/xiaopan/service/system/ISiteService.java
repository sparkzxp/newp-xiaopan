/**
 * 
 */
package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Site;

/**
 * @author 张霄鹏
 * 
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface ISiteService {

	Site query(Site site);

	List<Site> queryList(Site site);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Site site);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(Site site);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(Site site);
}
