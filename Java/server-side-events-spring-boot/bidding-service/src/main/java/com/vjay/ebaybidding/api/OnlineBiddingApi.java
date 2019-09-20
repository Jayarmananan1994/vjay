package com.vjay.ebaybidding.api;

import com.vjay.ebaybidding.model.BiddingRequest;
import com.vjay.ebaybidding.model.BiddingResponse;
import com.vjay.ebaybidding.repository.BiddingRepository;
import com.vjay.ebaybidding.repository.BitResponseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping(path = "/bid")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class OnlineBiddingApi {

    @Autowired
    BiddingRepository biddingRepository;

    @Autowired
    BitResponseRepository bitResponseRepository;

    @GetMapping("/health")
    public String checkHealth(){
        return  "The Service is up";
    }

    @PostMapping("/newbid")
    public Mono<BiddingRequest> postNewBid(@RequestBody BiddingRequest request){
        Mono<BiddingRequest> mono = biddingRepository.save(request);
        return mono;
    }

    @PostMapping("/postbidresponse")
    public Mono<BiddingResponse> postNewBidResponse(@RequestBody BiddingResponse request){
        Mono<BiddingResponse> mono = bitResponseRepository.insert(request);
        return mono;
    }

    @GetMapping(value = "/allbidsbyid", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<BiddingResponse> getBidResponsebyd(@RequestParam String requestId){
        Flux<BiddingResponse> flux = bitResponseRepository.findWithTailableCursorByBitRequestId(requestId);
        return flux;
    }

    @GetMapping(value = "/allbidreq")
    public Flux<BiddingRequest> getAllBitRequest(){
        Flux<BiddingRequest> flux = biddingRepository.findAll();
        return flux;
    }


}
