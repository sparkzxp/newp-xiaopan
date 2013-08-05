/**
 * 
 */
package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Arctype;

/**
 * @author 张霄鹏
 * 
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = false, rollbackFor = Exception.class)
public interface IArctypeService {

	Arctype query(Arctype arctype);

	List<Arctype> queryList(Arctype arctype);

	String add(Arctype arctype);

	Integer update(Arctype arctype);
}
