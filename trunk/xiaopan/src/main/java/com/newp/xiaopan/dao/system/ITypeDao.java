/**
 * 
 */
package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Type;

/**
 * @author 张霄鹏
 * 
 */
public interface ITypeDao {

	List<Type> query(Map<String, Object> params);

	List<Type> queryquerySecondNodes();

	List<Type> queryDistinct(Map<String, Object> params);

	String add(Type type);

	String addSites(Type type);

	Integer update(Type type);

	Integer delete(Type type);

	/**
	 * @param params:1,type.id;2,siteIds
	 */
	Integer deleteSites(Map<String, Object> params);
}
