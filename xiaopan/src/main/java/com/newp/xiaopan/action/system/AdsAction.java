package com.newp.xiaopan.action.system;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Ads;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.common.FileUtil;
import com.newp.xiaopan.service.system.IAdsService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class AdsAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(getClass());

	@Autowired
	private IAdsService adsService;

	private Ads ads;
	private List<Ads> adss;

	private File imgFile;
	private String imgFileFileName;
	private String imgFileContentType;
	private boolean pathStatus;
	private String uploadStatus;

	public String toList() {
		adss = this.adsService.queryList(ads);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		if (null != ads && StringUtils.isNotEmpty(ads.getId())) {
			ads = this.adsService.query(ads);
		}
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("deprecation")
	public String doEdit() {
		String oldPath = ads.getImageurl();
		if (StringUtils.isNotBlank(oldPath)) {
			oldPath = oldPath.substring(oldPath.indexOf("xiaopan") + 7, oldPath.length());
		}

		InputStream fis = null;
		FileOutputStream fos = null;
		try {
			if (pathStatus) {
				String path = ServletActionContext.getRequest().getRealPath("/upload/ads/images/");
				File root = new File(path);
				if (!root.isDirectory()) {
					System.out.println("创建新文件夹成功" + path);
					root.mkdirs();
				}

				fis = new FileInputStream(imgFile);
				String filename = FileUtil.gainFileName(imgFileFileName);
				fos = new FileOutputStream(path + "/" + filename);

				byte[] data = new byte[1024];
				while (fis.read(data) != -1) {
					fos.write(data);
				}
				fos.flush();
				ads.setImageurl(ServletActionContext.getRequest().getContextPath() + "/upload/ads/images/" + filename);
			}

			if (StringUtils.isEmpty(ads.getId())) {
				String id = this.adsService.add(ads);
				ads.setId(id);
			} else {
				this.adsService.update(ads);
				if (pathStatus) {
					FileUtil.deleteFile(ServletActionContext.getRequest().getRealPath("/") + oldPath);
				}
			}

			pathStatus = false;
			uploadStatus = "success";
			return Constants.ACTION_TO_EDIT;
		} catch (Exception e) {
			log.error(e);
			pathStatus = false;
			uploadStatus = "error";
			return Constants.ACTION_TO_EDIT;
		} finally {
			try {
				if (null != fis) {
					fis.close();
				}
				if (null != fos) {
					fos.close();
				}
			} catch (Exception e) {
				log.error(e);
			}
		}
	}

	@SuppressWarnings("deprecation")
	public void doDelete() {
		String oldPath = ads.getImageurl();
		this.adsService.delete(ads);
		if (StringUtils.isNotBlank(oldPath)) {
			oldPath = oldPath.substring(oldPath.indexOf("xiaopan") + 7, oldPath.length());
			FileUtil.deleteFile(ServletActionContext.getRequest().getRealPath("/") + oldPath);
		}
		this.ajax(true);
	}

	/**
	 * @return the adss
	 */
	public List<Ads> getAdss() {
		return adss;
	}

	/**
	 * @param adss
	 *            the adss to set
	 */
	public void setAdss(List<Ads> adss) {
		this.adss = adss;
	}

	/**
	 * @return the ads
	 */
	public Ads getAds() {
		return ads;
	}

	/**
	 * @param ads
	 *            the ads to set
	 */
	public void setAds(Ads ads) {
		this.ads = ads;
	}

	public File getImgFile() {
		return imgFile;
	}

	public void setImgFile(File imgFile) {
		this.imgFile = imgFile;
	}

	public String getImgFileFileName() {
		return imgFileFileName;
	}

	public void setImgFileFileName(String imgFileFileName) {
		this.imgFileFileName = imgFileFileName;
	}

	public String getImgFileContentType() {
		return imgFileContentType;
	}

	public void setImgFileContentType(String imgFileContentType) {
		this.imgFileContentType = imgFileContentType;
	}

	public boolean isPathStatus() {
		return pathStatus;
	}

	public void setPathStatus(boolean pathStatus) {
		this.pathStatus = pathStatus;
	}

	public String getUploadStatus() {
		return uploadStatus;
	}

	public void setUploadStatus(String uploadStatus) {
		this.uploadStatus = uploadStatus;
	}
}
