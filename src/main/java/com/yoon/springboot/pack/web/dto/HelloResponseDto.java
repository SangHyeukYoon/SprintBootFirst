package com.yoon.springboot.pack.web.dto;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.NonNull;

@Getter
@RequiredArgsConstructor
public class HelloResponseDto {

    private final String name;
    private final int amount;

}
