package com.example.ci_cd_demo;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
public class UserController {
    

    @GetMapping("/users")
    public List<String> getUsers() {
        List<String> users = new ArrayList<>();
        users.add("maxy");
        return users;
    }
}
