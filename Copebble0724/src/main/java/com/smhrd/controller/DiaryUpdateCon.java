package com.smhrd.controller;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.smhrd.command.Command;
import com.smhrd.model.DiaryDAO;
import com.smhrd.model.DiaryDTO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DiaryUpdateCon")
public class DiaryUpdateCon extends HttpServlet implements Command {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("[DiaryUpdateCon]");
		
		
		
		//MultipartRequest변수 설정
		// 1. request 객체
		// 2. savePath(저장경로)
		String savePath = request.getServletContext().getRealPath("img");
		System.out.println(savePath);
		
		// 3. maxSize
		int maxSize = 10*1024*1024;
		
		// 4. encoding
		String encoding = "UTF-8";
		
		// 5. 중복제거
		DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
		
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, savePath, maxSize, encoding, rename);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 데이터 받아오기

		String TITLE = multi.getParameter("TITLE");
		String DIARY = multi.getParameter("DIARY");
		String FILENAME = multi.getFilesystemName("FILENAME");
		String FAMILY_KEY = multi.getParameter("FAMILY_KEY");		
		String NUM2 = multi.getParameter("num");		
		
		int NUM = Integer.parseInt(NUM2);
		System.out.println("FAMILY_KEY :"+FAMILY_KEY);
		System.out.println("TITLE :"+TITLE);
		System.out.println("DIARY :"+DIARY);
		System.out.println("FILENAME :"+FILENAME);
		System.out.println("NUM :"+NUM);
		//update메소드 호출
		int row = new DiaryDAO().updateDiary(new DiaryDTO(TITLE, DIARY, FILENAME,NUM));
		
	    // 성공실패
	      if(row>0) {
	    	  System.out.println("수정 성공");
	      }else {
	    	  System.out.println("수정 실패");	    	  
	      }
		return "DiaryMain.jsp";
	}

}
