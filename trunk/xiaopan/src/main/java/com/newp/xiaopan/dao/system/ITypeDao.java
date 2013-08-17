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

	List<Type> queryDistinct(Map<String, Object> params);

	String add(Type type);

	Integer update(Type type);

	Integer delete(Type type);
}
