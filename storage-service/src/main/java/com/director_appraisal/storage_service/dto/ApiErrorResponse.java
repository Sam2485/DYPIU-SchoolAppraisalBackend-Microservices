package com.director_appraisal.storage_service.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ApiErrorResponse {
    private String timestamp;
    private int status;
    private String error;
    private String code;
    private String message;
    private String service;
    private String path;
    private String correlationId;
    private Object details;
}
