package com.newp.xiaopan.action.system;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Archive;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.common.FileUtil;
import com.newp.xiaopan.service.system.IArchiveService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class ArchiveAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(getClass());

	@Autowired
	private IArchiveService archiveService;

	private Archive archive;
	private List<Archive> archives;

	private File imgFile;
	private String imgFileFileName;
	private String imgFileContentType;

	public String toList() {
		archives = this.archiveService.queryList(archive);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		if (null != archive && StringUtils.isNotEmpty(archive.getId())) {
			archive = this.archiveService.query(archive);
		}
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings({ "unchecked", "deprecation" })
	public void uploadKindEditorImg() {
		InputStream fis = null;
		FileOutputStream fos = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd/");
			String base = "/upload/archive/contents/" + sdf.format(new Date());
			String path = ServletActionContext.getRequest().getRealPath(base);
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
			msg.put("error", 0);
			msg.put("url", ServletActionContext.getRequest().getContextPath() + base + filename);
			makeSuccessRespForKE(ServletActionContext.getResponse());
		} catch (Exception e) {
			log.error(e);
			getError("上传失败");
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

	@SuppressWarnings("unchecked")
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();
		if (StringUtils.isEmpty(archive.getId())) {
			String id = this.archiveService.add(archive);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			this.archiveService.update(archive);
			jsonObject.put("result", "success");
			jsonObject.put("id", archive.getId());
		}
		this.ajax(jsonObject.toJSONString());
	}

	public void doDelete() {
		this.archiveService.delete(archive);
		this.ajax(true);
	}

	/**
	 * @return the archives
	 */
	public List<Archive> getArchives() {
		return archives;
	}

	/**
	 * @param archives
	 *            the archives to set
	 */
	public void setArchives(List<Archive> archives) {
		this.archives = archives;
	}

	/**
	 * @return the archive
	 */
	public Archive getArchive() {
		return archive;
	}

	/**
	 * @param archive
	 *            the archive to set
	 */
	public void setArchive(Archive archive) {
		this.archive = archive;
	}

	/**
	 * @return the imgFile
	 */
	public File getImgFile() {
		return imgFile;
	}

	/**
	 * @param imgFile
	 *            the imgFile to set
	 */
	public void setImgFile(File imgFile) {
		this.imgFile = imgFile;
	}

	/**
	 * @return the imgFileFileName
	 */
	public String getImgFileFileName() {
		return imgFileFileName;
	}

	/**
	 * @param imgFileFileName
	 *            the imgFileFileName to set
	 */
	public void setImgFileFileName(String imgFileFileName) {
		this.imgFileFileName = imgFileFileName;
	}

	/**
	 * @return the imgFileContentType
	 */
	public String getImgFileContentType() {
		return imgFileContentType;
	}

	/**
	 * @param imgFileContentType
	 *            the imgFileContentType to set
	 */
	public void setImgFileContentType(String imgFileContentType) {
		this.imgFileContentType = imgFileContentType;
	}
}
