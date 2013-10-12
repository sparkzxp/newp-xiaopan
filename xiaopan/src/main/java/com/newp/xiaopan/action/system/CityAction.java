package com.newp.xiaopan.action.system;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.City;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.ICityService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class CityAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private ICityService cityService;

	private City city;
	private List<City> citys;

	public String toList() {
		citys = this.cityService.queryList(city);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		if (null != city && StringUtils.isNotEmpty(city.getId())) {
			city = this.cityService.query(city);
		}
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();
		if (StringUtils.isEmpty(city.getId())) {
			String id = this.cityService.add(city);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			this.cityService.update(city);
			jsonObject.put("result", "success");
			jsonObject.put("id", city.getId());
		}
		this.ajax(jsonObject.toJSONString());
	}

	public void doDelete() {
		this.cityService.delete(city);
		this.ajax(true);
	}

	/**
	 * @return the citys
	 */
	public List<City> getCitys() {
		return citys;
	}

	/**
	 * @param citys
	 *            the citys to set
	 */
	public void setCitys(List<City> citys) {
		this.citys = citys;
	}

	/**
	 * @return the city
	 */
	public City getCity() {
		return city;
	}

	/**
	 * @param city
	 *            the city to set
	 */
	public void setCity(City city) {
		this.city = city;
	}
}
