package com.c206.backend.global.jwt;

import com.c206.backend.domain.member.entity.Member;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

public class CustomUserDetails implements UserDetails {

    private final Member member;

    public CustomUserDetails(Member member) {
        this.member = member;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {

        return new ArrayList<>();
//        Collection<GrantedAuthority> collection = new ArrayList<>();
//
//        collection.add(new GrantedAuthority() {
//
//            @Override
//            public String getAuthority() {
//
////                return member.getRole();
//                return "true";
//            }
//        });
//
//        return collection;
    }


    public Long getId(){ return member.getId(); }

    @Override
    public String getUsername() {
        return "UserName hello";
    }
    @Override
    public String getPassword() {
        return member.getPassword();
    }

    public String getEmail() {
        return member.getEmail();
    }

    public String getNickname() { return member.getNickname(); }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
