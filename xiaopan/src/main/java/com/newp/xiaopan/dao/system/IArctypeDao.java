/**
 * 
 */
package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Arctype;

/**
 * @author 张霄鹏
 * 
 */
public interface IArctypeDao {

	List<Arctype> query(Map<String, Object> params);
}
