package com.worldfriends.bacha.model;

import lombok.Data;

@Data
public class Options {
    private String keyOption;
    private String keyword;
    
    public Options(String keyOption, String keyword) {
       this.keyOption = keyOption;
       this.keyword = keyword;
    }
}
