package com.newp.xiaopan.bean.system;

import java.util.List;

/**
 * @author 张霄鹏
 */
public class Shop extends BaseBean {

	private static final long serialVersionUID = 1L;

	private String title;
	private String keyword;
	private String description;
	private String contents;
	private String address;
	private String tel;
	private String contacter;
	private String imagePath;
	private String siteId;
	private String siteName;
	private List<Type> types;
	private Integer click;
	private Integer pingnum;
	private String isClosed;

	public Shop() {
		super();
	}

	public Shop(String siteId) {
		super();
		this.siteId = siteId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
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

	public String getContacter() {
		return contacter;
	}

	public void setContacter(String contacter) {
		this.contacter = contacter;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public Integer getClick() {
		return click;
	}

	public void setClick(Integer click) {
		this.click = click;
	}

	public Integer getPingnum() {
		return pingnum;
	}

	public void setPingnum(Integer pingnum) {
		this.pingnum = pingnum;
	}

	public List<Type> getTypes() {
		return types;
	}

	public void setTypes(List<Type> types) {
		this.types = types;
	}

	/**
	 * @return the isClosed
	 */
	public String getIsClosed() {
		return isClosed;
	}

	/**
	 * @param isClosed
	 *            the isClosed to set
	 */
	public void setIsClosed(String isClosed) {
		this.isClosed = isClosed;
	}

}
