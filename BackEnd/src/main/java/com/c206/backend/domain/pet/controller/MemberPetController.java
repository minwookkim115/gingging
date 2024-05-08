package com.c206.backend.domain.pet.controller;

import com.c206.backend.domain.pet.dto.response.MemberPetDetailResponseDto;
import com.c206.backend.domain.pet.dto.response.MemberPetListResponseDto;
import com.c206.backend.domain.pet.dto.response.PetListResponseDto;
import com.c206.backend.domain.pet.service.MemberPetService;
import com.c206.backend.global.common.dto.Message;
import com.c206.backend.global.jwt.CustomUserDetails;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/pet")
public class MemberPetController {

    private final MemberPetService memberPetService;


    // AuthenticationPrincipal 변경
    @GetMapping("/list")
//    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Message<List<MemberPetListResponseDto>>> getMemberPetList(
            @Parameter(hidden = true) Authentication authentication) {
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();
        List<MemberPetListResponseDto> memberPetListResponseDtoList = memberPetService.getMemberPetList(memberId);
        return ResponseEntity.ok().body(Message.success(memberPetListResponseDtoList));
    }


    // todo: redis에서 latest memberPetId 가져오기
    // AuthenticationPrincipal 변경
    @GetMapping("/{memberPetId}")
//    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Message<MemberPetDetailResponseDto>> getMemberPetDetail(
            @PathVariable("memberPetId") Long memberPetId,
            @Parameter(hidden = true) Authentication authentication) {
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();
        System.out.println("여기는 MemberPetController "+ memberPetId);
        MemberPetDetailResponseDto memberPetDetailResponseDto = memberPetService.getMemberPetDetail(memberId, memberPetId);
        return ResponseEntity.ok().body(Message.success(memberPetDetailResponseDto));
    }

    // AuthenticationPrincipal 변경
    @PostMapping("/rescue")
//    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Message<Boolean>> rescuePet(
            @Parameter(hidden = true) Authentication authentication) {
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();
        Boolean isRescue = memberPetService.rescuePet(memberId);
        return ResponseEntity.ok().body(Message.success(isRescue));
    }

    @PostMapping("/updatenickname/{memberPetId}")
    @Operation(summary = "펫 닉네임을 업데이트 합니다")
    public ResponseEntity<Message<?>> updatePetNickname(
            @PathVariable("memberPetId") Long memberPetId,
            @Parameter(hidden = true) Authentication authentication,
            @RequestBody @Parameter String petNickname
    ){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();
        boolean isUpdated = memberPetService.updatePetNickname(memberId,memberPetId, petNickname);

        return ResponseEntity.ok().body(Message.success(isUpdated));
    }

    @PostMapping("/active/{memberPetId}")
    @Operation(summary = "펫을 활성화 시킵니다.")
    public ResponseEntity<Message<?>> activePet(
            @PathVariable("memberPetId") Long memberPetId,
            @Parameter(hidden = true) Authentication authentication
    ){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        boolean isActive = memberPetService.activePet(memberId, memberPetId);

        return ResponseEntity.ok().body(Message.success(isActive));
    }

    @GetMapping("/petlist")
    @Operation(summary = "서비스해주는 펫의 모든 종류를 반환합니다.")
    public ResponseEntity<Message<List<PetListResponseDto>>> petList(
            @Parameter(hidden = true) Authentication authentication
    ){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();
        List<PetListResponseDto> petList = memberPetService.getPetList(memberId);

        return ResponseEntity.ok().body(Message.success(petList));
    }

}
