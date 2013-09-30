package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Resource;

/**
 * @author 张霄鹏
 */
public interface IResourceDao {

	List<Resource> query(Map<String, Object> params);

	String add(Resource resource);

	Integer update(Resource resource);

	Integer delete(Resource resource);
}
