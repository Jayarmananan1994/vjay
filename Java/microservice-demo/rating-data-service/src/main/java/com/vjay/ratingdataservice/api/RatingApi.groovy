package com.vjay.ratingdataservice.api

import com.vjay.ratingdataservice.model.Rating
import com.vjay.ratingdataservice.model.UserRating
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping('/api')
class RatingApi {

    @RequestMapping('/watchlist/{userId}')
    UserRating getMoviesList(@PathVariable('userId') String id){
        UserRating ratings = new UserRating()
        ratings.userId = id
        ratings.ratings = []
        ratings.ratings << new Rating(movieId: 'MV01', rating: 4.5)
        ratings.ratings << new Rating(movieId: 'MV02', rating: 4.4)
        ratings.ratings << new Rating(movieId: 'MV03', rating: 3.5)
        ratings
    }

}
