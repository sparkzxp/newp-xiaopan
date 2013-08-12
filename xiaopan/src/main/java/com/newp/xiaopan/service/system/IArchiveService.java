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
@Transactional(propagation = Propagation.SUPPORTS, readOnly = false, rollbackFor = Exception.class)
public interface IArchiveService {

	Archive query(Archive archive);

	List<Archive> queryTopList(Archive archive, Integer top);

	List<Archive> queryList(Archive archive);

	List<Archive> queryListByPager(Archive archive, Pager pager);

	Integer count(Archive archive);

	String add(Archive archive);

	Integer update(Archive archive);

	Integer delete(Archive archive);
}