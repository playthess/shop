package vo;

public class QnaMemberComment {
	private Qna qna;
	private Member member;
	private QnaComment comment;
	
	@Override
	public String toString() {
		return "QnaMemberComment [qna=" + qna + ", member=" + member + ", comment=" + comment + "]";
	}
	public Qna getQna() {
		return qna;
	}
	public void setQna(Qna qna) {
		this.qna = qna;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public QnaComment getComment() {
		return comment;
	}
	public void setComment(QnaComment comment) {
		this.comment = comment;
	}
	
}
