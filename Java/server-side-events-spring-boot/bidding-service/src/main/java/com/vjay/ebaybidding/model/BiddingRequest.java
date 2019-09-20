package com.vjay.ebaybidding.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "bitrequest")
public class BiddingRequest {


    @Id
    String id;
    String productName;
    double initialAmount;

    public BiddingRequest() {
    }

    public BiddingRequest(String id, String productName, double initialAmount) {
        this.id = id;
        this.productName = productName;
        this.initialAmount = initialAmount;
    }

    public double getInitialAmount() {
        return initialAmount;
    }

    public void setInitialAmount(double initialAmount) {
        this.initialAmount = initialAmount;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }


}
