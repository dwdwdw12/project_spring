package com.airline.mapper;

import org.springframework.stereotype.Component;

@Component
public interface JoinMapper {

	public String checkEmail(String email);
}