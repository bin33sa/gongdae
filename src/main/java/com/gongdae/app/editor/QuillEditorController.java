package com.gongdae.app.editor;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.gongdae.app.common.RequestUtils;
import com.gongdae.app.common.StorageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/editor/*")
public class QuillEditorController {
	private final StorageService storageService;

	@Value("${file.upload-root}/editor")
	private String uploadPath;
	
	@PostMapping("upload")
	public Map<String, ?> handleImageUpload(@RequestParam(name = "imageFile") MultipartFile partFile) {
		Map<String, Object> model = new HashMap<>();

		String state = "true";
		try {
			String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(partFile, uploadPath));
			
			String cp = RequestUtils.getContextPath();
			String imageUrl = cp + "/uploads/editor/" + saveFilename;
			
			model.put("state", state);
			model.put("saveFilename", saveFilename);
			model.put("imageUrl", imageUrl);
			
		} catch (Exception e) {
			state = "false";
		}

		model.put("state", state);
		return model;
	}
}
