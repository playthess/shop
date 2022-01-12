package vo;

public class Notice {
	public int noticeNo;
	public String noticeTitle;
	public String noticeContent;
	public int memberNo;
	public String createDate;
	public String updateDate;
	
	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", memberNo=" + memberNo + ", createDate=" + createDate + ", updateDate=" + updateDate + "]";
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
}
