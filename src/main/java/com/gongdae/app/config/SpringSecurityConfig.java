package com.gongdae.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.ExceptionTranslationFilter;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;

import com.gongdae.app.security.AjaxSessionTimeoutFilter;
import com.gongdae.app.security.CustomAccessDeniedHandler;
import com.gongdae.app.security.LoginFailureHandler;
import com.gongdae.app.security.LoginSuccessHandler;

@Configuration
@EnableWebSecurity
public class SpringSecurityConfig {

    private final CustomAccessDeniedHandler customAccessDeniedHandler;

    SpringSecurityConfig(CustomAccessDeniedHandler customAccessDeniedHandler) {
        this.customAccessDeniedHandler = customAccessDeniedHandler;
    }
	@Bean
	SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

		HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
		requestCache.setMatchingRequestParameterName(null);

		String[] excludeUri = { "/", "/index.jsp", "/member/login", "/guest/signup", "/member/logout",
	            "/member/userIdCheck", "/guest/nicknameCheck", "/complete", "/guest/findId", "/guest/findPwd", "/guest/pwd", "/expired", "/dist/**",
	            "/js/**", "/vendor/**","/favicon.ico","/guest/main", "/guest/list", "/uploads/photo/**", "/favicon.ico", "/WEB-INF/views/**",
	            "/oauth/kakao/callback", "/host/main/prelogin", "/host/member/login", "/admin/login", 
	            "/wish/*", "/notice/**","/faq/**","/event/**", "/review/*", "/terms",
	            "/dist/docs/*" };
				

		http.cors(Customizer.withDefaults()) 
			.csrf(AbstractHttpConfigurer::disable) 
			.requestCache(request -> request.requestCache(requestCache)); 

		http.authorizeHttpRequests(authorize -> authorize
				.requestMatchers(excludeUri).permitAll()
		        .requestMatchers("/space/*", "/space/list", "/space/detail/**").hasAnyRole("ANONYMOUS", "GUEST", "ADMIN")
		        .requestMatchers("/host/**").hasAnyRole("HOST", "ADMIN")
		        .requestMatchers("/admin/**").hasRole("ADMIN")	      
		        .requestMatchers("/booking/**", "/mypage/**", "/cart/**", "/community/write").hasAnyRole("GUEST", "ADMIN")
		        .anyRequest().authenticated()
		)
		.formLogin(login -> login
			.loginPage("/member/login")
			.loginProcessingUrl("/member/login")
			.usernameParameter("login_id")
			.passwordParameter("password")
			.successHandler(loginSuccessHandler())
			.failureHandler(loginFailureHandler())
			.permitAll()
		)
		.logout(logout -> logout
			.logoutUrl("/member/logout")
			.invalidateHttpSession(true)
			.deleteCookies("JSESSIONID")
			 .logoutSuccessHandler((request, response, authentication) -> {

				 if (authentication != null) {

				        boolean isAdmin = authentication.getAuthorities().stream()
				                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

				        boolean isHost = authentication.getAuthorities().stream()
				                .anyMatch(a -> a.getAuthority().equals("ROLE_HOST"));

				        if (isAdmin) {
				            response.sendRedirect("/admin/login");
				            return;
				        }

				        if (isHost) {
				            response.sendRedirect("/host/main/prelogin");
				            return;
				        }
				    }

				    // 일반 유저 or 비로그인 상태
				    response.sendRedirect("/");

			    })
		)
		.addFilterAfter(ajaxSessionTimeoutFilter(), ExceptionTranslationFilter.class)
		.sessionManagement(management -> management
			.maximumSessions(1)
			.expiredUrl("/expired"));

		http.exceptionHandling(e -> e.accessDeniedHandler(customAccessDeniedHandler));

		return http.build();
	}

	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	LoginSuccessHandler loginSuccessHandler() {
		LoginSuccessHandler handler = new LoginSuccessHandler();
		handler.setDefaultUrl("/");
		handler.setDefaultAdminUrl("/admin/main");
	    handler.setDefaultHostUrl("/host/main/home");
		return handler;
	}

	@Bean
	LoginFailureHandler loginFailureHandler() {
		LoginFailureHandler handler = new LoginFailureHandler();
		handler.setDefaultFailureUrl("/member/login?error");
		return handler;
	}

	@Bean
	AjaxSessionTimeoutFilter ajaxSessionTimeoutFilter() {
		AjaxSessionTimeoutFilter filter = new AjaxSessionTimeoutFilter();
		filter.setAjaxHeader("AJAX");
		return filter;
	}
	
}
