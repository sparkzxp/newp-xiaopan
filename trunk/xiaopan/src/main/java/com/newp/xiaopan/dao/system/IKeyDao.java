package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Key;

/**
 * @author 张霄鹏
 */
public interface IKeyDao {

	List<Key> query(Map<String, Object> params);

	String add(Key key);

	Integer update(Key key);

	Integer delete(Key key);
}
