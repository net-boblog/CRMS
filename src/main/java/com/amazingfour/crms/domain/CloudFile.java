package com.amazingfour.crms.domain;

import java.util.Date;

/**
 * Created by Huy on 2016-01-07.
 */
public class CloudFile {
    private Long fileId;
    private String fileName;
    private String fileUrl;
    private Date fileDate;
    private String fileDescript;
    private Byte fileState;

    public Long getFileId() {
        return fileId;
    }

    public void setFileId(Long fileId) {
        this.fileId = fileId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public Date getFileDate() {
        return fileDate;
    }

    public void setFileDate(Date fileDate) {
        this.fileDate = fileDate;
    }

    public String getFileDescript() {
        return fileDescript;
    }

    public void setFileDescript(String fileDescript) {
        this.fileDescript = fileDescript;
    }

    public Byte getFileState() {
        return fileState;
    }

    public void setFileState(Byte fileState) {
        this.fileState = fileState;
    }
}
