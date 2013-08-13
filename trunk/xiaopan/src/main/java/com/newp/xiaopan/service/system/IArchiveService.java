/**
 * 
 */
package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Archive;
import com.newp.xiaopan.common.bean.Pager;

/**
 * @author 张霄鹏
 * 
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface IArchiveService {

	Archive query(Archive archive);

	List<Archive> queryTopList(Archive archive, Integer top);

	List<Archive> queryList(Archive archive);

	List<Archive> queryListByPager(Archive archive, Pager pager);

	Integer count(Archive archive);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Archive archive);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(Archive archive);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(Archive archive);
}
