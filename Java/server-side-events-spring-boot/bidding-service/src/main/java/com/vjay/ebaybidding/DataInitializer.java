package com.vjay.ebaybidding;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.ApplicationContext;
import org.springframework.data.mongodb.core.CollectionOptions;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private ApplicationContext application;


    @Override
    public void run(String... args) throws Exception {
        System.out.println("Running Data initializer");
        MongoOperations mongoOperations = application.getBean(MongoOperations.class);
        if (mongoOperations.collectionExists("bitresponse")) {
            mongoOperations.dropCollection("bitresponse");
        }
        mongoOperations.createCollection("bitresponse", CollectionOptions.empty().capped().size(9999999L).maxDocuments(100L));
    }
}
