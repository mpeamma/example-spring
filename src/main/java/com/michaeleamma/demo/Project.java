package com.michaeleamma.demo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import org.springframework.hateoas.ResourceSupport;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;


@Entity
public class Project {

    public Project() {}

    public Project(String name) {
        this.name = name;
    }
    
    @Id
    @GeneratedValue
    private Long Id;
    private String name;

    public Long getId() {
        return this.Id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }
}

