package com.newp.xiaopan.bean.system;

import java.sql.Timestamp;
import java.util.List;

/**
 * @author 张霄鹏
 */
public class Ads extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String title;
	private String imageurl;
	private String imageurl2;
	private String weburl;
	private Timestamp startdate;
	private Timestamp enddate;
	private String error;
	private String place;
	private String address;
	private String tel;
	private String latitude;
	private String longitude;
	private String indexShow;
	private String siteId;
	private List<City> citys;
	private Integer sort;

	public Ads() {
		super();
	}

	public Ads(String siteId) {
		super();
		this.siteId = siteId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImageurl() {
		return imageurl;
	}

	public void setImageurl(String imageurl) {
		this.imageurl = imageurl;
	}

	public String getImageurl2() {
		return imageurl2;
	}

	public void setImageurl2(String imageurl2) {
		this.imageurl2 = imageurl2;
	}

	public String getWeburl() {
		return weburl;
	}

	public void setWeburl(String weburl) {
		this.weburl = weburl;
	}

	public Timestamp getStartdate() {
		return startdate;
	}

	public void setStartdate(Timestamp startdate) {
		this.startdate = startdate;
	}

	public Timestamp getEnddate() {
		return enddate;
	}

	public void setEnddate(Timestamp enddate) {
		this.enddate = enddate;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getIndexShow() {
		return indexShow;
	}

	public void setIndexShow(String indexShow) {
		this.indexShow = indexShow;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	/**
	 * @return the sort
	 */
	public Integer getSort() {
		return sort;
	}

	/**
	 * @param sort
	 *            the sort to set
	 */
	public void setSort(Integer sort) {
		this.sort = sort;
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
}
