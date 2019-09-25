package ru.itis.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserVk {
    private String first_name;
    private String screen_name;
    private String id;
    private String photo_max_orig;
}
