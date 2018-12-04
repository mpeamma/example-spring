package com.michaeleamma.demo;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.web.bind.annotation.*;
import org.springframework.hateoas.Resource;

import java.util.ArrayList;
import java.util.List;


@RestController
public class ProjectController {

    private static final String TEMPLATE = "Hello, %s!";

    @Autowired
    private ProjectRepository repo;


    @GetMapping("/project")
    public HttpEntity<ArrayList<Resource<Project>>> project(@RequestParam(value = "name", required = false, defaultValue = "World") String name) {

        ArrayList<Project> projects = new ArrayList<>();
        //repo.findAll().forEach(projects::add);
        ArrayList<Resource<Project>> projectResources = new ArrayList<>();
        repo.findAll().forEach(p -> projectResources.add(new Resource<>(p)));
        //projectResource.add(linkTo(methodOn(ProjectController.class).project(name)).withSelfRel());

        return new ResponseEntity<>(projectResources, HttpStatus.OK);
    }

    @PostMapping("/project")
    public HttpEntity<Project> postProject() {
        Project project = new Project("This is a test project");
        Project saved = repo.save(project);
        return new ResponseEntity<>(saved, HttpStatus.OK);
    }
}
