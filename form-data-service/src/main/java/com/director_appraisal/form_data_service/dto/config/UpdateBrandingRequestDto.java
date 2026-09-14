package com.director_appraisal.form_data_service.dto.config;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UpdateBrandingRequestDto {
    private String universityName;
    private String domain;
    private String address;
    private String act;
    private String logoUrl;
    private String iqacLogoUrl;
}