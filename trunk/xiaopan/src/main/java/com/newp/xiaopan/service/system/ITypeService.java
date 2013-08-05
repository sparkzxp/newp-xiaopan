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
@Transactional(propagation = Propagation.SUPPORTS, readOnly = false, rollbackFor = Exception.class)
public interface ITypeService {

	Type query(Type type);

	List<Type> queryList(Type type);

	String add(Type type);

	Integer update(Type type);

	Integer delete(Type type);
}
