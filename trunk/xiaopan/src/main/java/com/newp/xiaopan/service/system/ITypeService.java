package com.newp.xiaopan.service.system;

import java.util.List;
import java.util.Map;

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

	List<Type> queryList(Map<String, Object> params);

	List<Type> queryList(Type type);

	List<Type> queryquerySecondNodes();

	List<Type> queryDistinctList(Type type);

	/**
	 * @param params:1,type;2,siteId;3,siteIds
	 */
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Map<String, Object> params);

	/**
	 * @param params:1,type;2,siteId;3,siteIds
	 */
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(Map<String, Object> params);

	/**
	 * @param params:1,type.id;2,siteId
	 */
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String delete(Map<String, Object> params);
}
