package com.vjay.ebaybidding.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "bitresponse")
public class BiddingResponse {
    @Id
    String id;
    String proposedBy;
    double amount;
        String bitRequestId;

    public BiddingResponse() {
    }

    public BiddingResponse(String id, String proposedBy, double amount, String bitRequestId) {
        this.id = id;
        this.proposedBy = proposedBy;
        this.amount = amount;
        this.bitRequestId = bitRequestId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProposedBy() {
        return proposedBy;
    }

    public void setProposedBy(String proposedBy) {
        this.proposedBy = proposedBy;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getBitRequestId() {
        return bitRequestId;
    }

    public void setBitRequestId(String bitRequestId) {
        this.bitRequestId = bitRequestId;
    }
}
