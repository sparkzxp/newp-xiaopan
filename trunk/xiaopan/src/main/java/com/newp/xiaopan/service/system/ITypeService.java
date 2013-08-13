/**
 * 
 */
package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Type;

/**
 * @author 张霄鹏
 * 
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface ITypeService {

	Type query(Type type);

	List<Type> queryList(Type type);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Type type);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(Type type);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(Type type);
}
