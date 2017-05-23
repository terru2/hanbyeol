package com.hongik.project.vo;

public class PagingVO {
	private int pageSize;  // 한 페이지에 보여줄 게시글 수
    private int pageBlock; //페이징 네비[블록] 사이즈
    private int pageNo;  // 페이지 번호
    private int startRowNo; //조회 시작 row 번호
    private int endRowNo; //조회 마지막 now 번호
    private int firsthtmlPageNo; // 첫 번째 페이지 번호
    private int finalPageNo; // 마지막 페이지 번호
    private int prevhtmlhtmlPageNo; // 이전 페이지 번호
    private int lasthtmlhtmlhtmlPageNo; // 다음 페이지 번호
    private int startPageNo; // 시작 페이지 (페이징 네비 기준)
    private int endPageNo; // 끝 페이지 (페이징 네비 기준)
    private int totalCount; // 게시 글 전체 수
    private String category;
    
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageBlock() {
		return pageBlock;
	}
	public void setPageBlock(int pageBlock) {
		this.pageBlock = pageBlock;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getStartRowNo() {
		return startRowNo;
	}
	public void setStartRowNo(int startRowNo) {
		this.startRowNo = startRowNo;
	}
	public int getEndRowNo() {
		return endRowNo;
	}
	public void setEndRowNo(int endRowNo) {
		this.endRowNo = endRowNo;
	}
	public int getfirsthtmlPageNo() {
		return firsthtmlPageNo;
	}
	public void setfirsthtmlPageNo(int firsthtmlPageNo) {
		this.firsthtmlPageNo = firsthtmlPageNo;
	}
	public int getFinalPageNo() {
		return finalPageNo;
	}
	public void setFinalPageNo(int finalPageNo) {
		this.finalPageNo = finalPageNo;
	}
	public int getprevhtmlhtmlPageNo() {
		return prevhtmlhtmlPageNo;
	}
	public void setprevhtmlhtmlPageNo(int prevhtmlhtmlPageNo) {
		this.prevhtmlhtmlPageNo = prevhtmlhtmlPageNo;
	}
	public int getlasthtmlhtmlhtmlPageNo() {
		return lasthtmlhtmlhtmlPageNo;
	}
	public void setlasthtmlhtmlhtmlPageNo(int lasthtmlhtmlhtmlPageNo) {
		this.lasthtmlhtmlhtmlPageNo = lasthtmlhtmlhtmlPageNo;
	}
	public int getStartPageNo() {
		return startPageNo;
	}
	public void setStartPageNo(int startPageNo) {
		this.startPageNo = startPageNo;
	}
	public int getEndPageNo() {
		return endPageNo;
	}
	public void setEndPageNo(int endPageNo) {
		this.endPageNo = endPageNo;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		this.makePaging();
	}
	
	private void makePaging() {
        // 기본 값 설정
        if (this.totalCount == 0) return; 
        if (this.pageNo == 0) this.setPageNo(1);   //기본 페이지 번호
        if (this.pageSize == 0) this.setPageSize(20); //기본 페이지 리스트 사이즈
        if (this.pageBlock == 0 ) this.setPageBlock(5); //기본 페이지 네비[블록] 사이즈
        
        //--[첫 페이지], [마지막 페이지] 계산
        int finalPage = (totalCount + (pageSize - 1)) / pageSize; // 마지막 페이지
        this.setfirsthtmlPageNo(1);   // 첫 번째 페이지 번호
        this.setFinalPageNo(finalPage); // 마지막 페이지 번호
        
        //-- [이전] , [다음] 페이지 계산
        boolean isNowfirsthtml = pageNo == 1 ? true : false;    // 시작 페이지 (전체)
        boolean isNowFinal = pageNo == finalPage ? true : false;  // 마지막 페이지 (전체)
        if (isNowfirsthtml) {
            this.setprevhtmlhtmlPageNo(1); // 이전 페이지 번호
        } else {
            this.setprevhtmlhtmlPageNo(((pageNo - 1) < 1 ? 1 : (pageNo - 1))); // 이전 페이지 번호
        }
        if (isNowFinal) {
            this.setlasthtmlhtmlhtmlPageNo(finalPage); // 다음 페이지 번호
        } else {
            this.setlasthtmlhtmlhtmlPageNo(((pageNo + 1) > finalPage ? finalPage : (pageNo + 1))); // 다음 페이지 번호
        }
                
        //-- 페이징 네비[블록]을 계산
        int startPage = ((pageNo - 1) / pageBlock) * pageBlock + 1; // 시작 페이지 (페이징 네비 기준)
        int endPage = startPage + pageBlock - 1;      // 끝 페이지 (페이징 네비 기준)
        // 페이징 네비가 만약 [20-30] 인데 마지막 페이지가 28 인 경우 
        // [29, 30] 페이지는 페이징 네비에 미노출 해야 한다.
        if (endPage > finalPage) { // [마지막 페이지 (페이징 네비 기준) > 마지막 페이지] 보다 큰 경우 
            endPage = finalPage;  
        }
        this.setStartPageNo(startPage); // 시작 페이지 (페이징 네비 기준)
        this.setEndPageNo(endPage);  // 끝 페이지 (페이징 네비 기준)

        //--조회 시작 row, 조회 마지막 row 계산
        int startRowNo = ( (pageNo-1) * pageSize ) + 1;
        int endRowNo = pageNo * pageSize; 
        setStartRowNo( startRowNo );
        setEndRowNo( endRowNo );
    }
	@Override
	public String toString() {
		return "PagingVO [pageSize=" + pageSize + ", pageBlock=" + pageBlock + ", pageNo=" + pageNo + ", startRowNo="
				+ startRowNo + ", endRowNo=" + endRowNo + ", firsthtmlPageNo=" + firsthtmlPageNo + ", finalPageNo="
				+ finalPageNo + ", prevhtmlhtmlPageNo=" + prevhtmlhtmlPageNo + ", lasthtmlhtmlhtmlPageNo=" + lasthtmlhtmlhtmlPageNo + ", startPageNo="
				+ startPageNo + ", endPageNo=" + endPageNo + ", totalCount=" + totalCount + "]";
	}

}
