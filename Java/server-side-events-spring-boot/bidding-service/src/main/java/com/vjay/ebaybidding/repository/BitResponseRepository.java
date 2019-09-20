package com.vjay.ebaybidding.repository;

import com.vjay.ebaybidding.model.BiddingResponse;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.data.mongodb.repository.Tailable;
import reactor.core.publisher.Flux;

public interface BitResponseRepository extends ReactiveMongoRepository<BiddingResponse, String> {

    @Tailable
    Flux<BiddingResponse> findWithTailableCursorByBitRequestId(String bitRequestId);
}
