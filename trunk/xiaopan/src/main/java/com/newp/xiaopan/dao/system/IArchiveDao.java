/**
 * 
 */
package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Archive;

/**
 * @author 张霄鹏
 * 
 */
public interface IArchiveDao {

	List<Archive> query(Map<String, Object> params);

	String add(Archive archive);

	Integer update(Archive archive);

	Integer delete(Archive archive);
}
