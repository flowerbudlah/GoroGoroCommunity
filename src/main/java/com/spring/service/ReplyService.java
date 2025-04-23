package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.dao.ReplyDAO;
import com.spring.dto.ReplyDTO;

@Service
public class ReplyService {

	@Autowired
	private ReplyDAO replyDAO;

	// 1. 댓글 작성 Create
	public ReplyDTO writeReplyProcess(ReplyDTO writeReplyDTO) {

		ReplyDTO replyDTO = new ReplyDTO();

		int writingCount = replyDAO.writeReplyProcess(writeReplyDTO);

		//댓글 작성 성공
		if (writingCount > 0) {
			replyDTO.setResult("success");
		
		//댓글 작성 실패 
		} else {
			replyDTO.setResult("fail");
		}

		return replyDTO;
	}

	// 2. 댓글리스트 출력
	public List<ReplyDTO> replyList(int postNo) {
		return replyDAO.replyList(postNo);
	}

	// 3. 댓글삭제 delete
	public ReplyDTO removeReply(int replyNo) {

		ReplyDTO replyDTO = new ReplyDTO();

		int removeCount = replyDAO.removeReply(replyNo);

		// 댓글삭제 성공
		if (removeCount > 0) {
			replyDTO.setResult("success");

		// 댓글삭제 미성공
		} else {
			replyDTO.setResult("fail");
		}

		return replyDTO;
	}

}