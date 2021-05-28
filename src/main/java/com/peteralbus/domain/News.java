package com.peteralbus.domain;

public class News
{
    String pubDate;
    String title;
    String summary;
    String infoSource;
    String sourceUrl;
    String province;
    String provindId;

    @Override
    public String toString() {
        return "news{" +
                "pubDate='" + pubDate + '\'' +
                ",\n title='" + title + '\'' +
                ",\n summary='" + summary + '\'' +
                ",\n infoSource='" + infoSource + '\'' +
                ",\n sourceUrl='" + sourceUrl + '\'' +
                ",\n province='" + province + '\'' +
                ",\n provindId='" + provindId + '\'' +
                '}';
    }

    public String getPubDate() {
        return pubDate;
    }

    public void setPubDate(String pubDate) {
        this.pubDate = pubDate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getInfoSource() {
        return infoSource;
    }

    public void setInfoSource(String infoSource) {
        this.infoSource = infoSource;
    }

    public String getSourceUrl() {
        return sourceUrl;
    }

    public void setSourceUrl(String sourceUrl) {
        this.sourceUrl = sourceUrl;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getProvindId() {
        return provindId;
    }

    public void setProvindId(String provindId) {
        this.provindId = provindId;
    }
}
