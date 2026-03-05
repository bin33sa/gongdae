package com.gongdae.app.security;

public class NumericRoleGranted {
	public final static int ANONYMOUS = 0; 
	public final static int GUEST = 1;		
	public final static int HOST = 51;	
	public final static int ADMIN = 99;
	
	public static int getUserLevel(String authority) {
		try {
			switch (authority) {
			case "GUEST" : return GUEST;
			case "ANONYMOUS" : return ANONYMOUS;
			case "HOST" : return HOST;
			case "ADMIN" : return ADMIN;
			}
		} catch (Exception e) {
		}
		
		return 0;
	}
}
