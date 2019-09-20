package com.vjay.ebaybidding.repository;

import com.vjay.ebaybidding.model.BiddingRequest;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;

public interface BiddingRepository extends ReactiveMongoRepository<BiddingRequest, String> {
}
