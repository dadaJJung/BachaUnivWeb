package com.worldfriends.bacha.model;

import lombok.Data;

@Data
public class SortOption {
    private int start;
    private int end;
    private String option;
    private String keyOption;
    private String keyword;
    
    public SortOption(Pagination pagination, String option, String keyOption, String keyword) {
       start = pagination.getStart();
       end = pagination.getEnd();
       this.option = option;
       this.keyOption = keyOption;
       this.keyword = keyword;
    }
}