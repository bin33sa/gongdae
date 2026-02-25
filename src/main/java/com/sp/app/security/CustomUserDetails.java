package com.sp.app.security;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.sp.app.domain.dto.SessionInfo;

public class CustomUserDetails implements UserDetails {
	private static final long serialVersionUID = 1L;
	
	private final SessionInfo memebr;
	private final List<String> roles; 
	private final boolean disabled;
	
	private CustomUserDetails(Builder builder) {
		this.memebr = builder.memebr;
		this.roles = builder.roles;
		this.disabled = builder.disabled;
	}

	public static class Builder {
		private SessionInfo memebr;
		private List<String> roles;
		private boolean disabled = false;
        
		public Builder sessionInfo(SessionInfo memebr) {
			this.memebr = memebr;
			return this;
		}

		public Builder roles(List<String> roles) {
			this.roles = roles;
			return this;
		}
        
		public Builder disabled(boolean disabled) {
			this.disabled = disabled;
			return this;
		}        

		public CustomUserDetails build() {
			if (this.memebr == null) {
				throw new IllegalStateException("SessionInfo 객체는 필수입니다.");
			}
        	
			return new CustomUserDetails(this);
		 }
	}

	public static Builder builder() {
		return new Builder();
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return roles.stream()
			.map(role -> new SimpleGrantedAuthority(role.startsWith("ROLE_") ? role : "ROLE_" + role))
			.collect(Collectors.toList());
	}

	@Override
	public String getPassword() { return memebr.getPassword(); }

	@Override
	public String getUsername() { return memebr.getLogin_id(); }

	@Override 
	public boolean isEnabled() { return !disabled; }
    
	@Override public boolean isAccountNonExpired() { return true; }
	@Override public boolean isAccountNonLocked() { return true; }
	@Override public boolean isCredentialsNonExpired() { return true; }

	public SessionInfo getMember() { return memebr; }
}
