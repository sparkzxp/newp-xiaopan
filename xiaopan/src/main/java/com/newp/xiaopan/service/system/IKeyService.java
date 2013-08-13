/**
 * 
 */
package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Key;

/**
 * @author 张霄鹏
 * 
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface IKeyService {

	Key query(Key key);

	List<Key> queryList(Key key);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Key key);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(Key key);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(Key key);
}
