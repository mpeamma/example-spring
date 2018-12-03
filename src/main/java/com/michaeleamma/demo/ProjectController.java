package com.michaeleamma.demo;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.*;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.hateoas.Resource;


@RestController
public class ProjectController {

    private static final String TEMPLATE = "Hello, %s!";

    @RequestMapping("/project")
    public HttpEntity<Project> project(@RequestParam(value = "name", required = false, defaultValue = "World") String name) {

        Project project = new Project(String.format(TEMPLATE, name));
        Resource<Project> projectResource = new Resource<Project>(project);
        //projectResource.add(linkTo(methodOn(ProjectController.class).project(name)).withSelfRel());

        return new ResponseEntity<>(project, HttpStatus.OK);
    }
}
