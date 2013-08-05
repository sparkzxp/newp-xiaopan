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
@Transactional(propagation = Propagation.SUPPORTS, readOnly = false, rollbackFor = Exception.class)
public interface IKeyService {

	Key query(Key key);

	List<Key> queryList(Key key);

	String add(Key key);

	Integer update(Key key);

	Integer delete(Key key);
}
