package com.vjay.moviecatalogue.api

import com.vjay.moviecatalogue.model.Movie
import com.vjay.moviecatalogue.model.MovieCatalogue
import com.vjay.moviecatalogue.model.UserRating
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.client.RestTemplate

@RestController
@RequestMapping('/api')
class MovieCatalogueAPI {

    @Autowired
    RestTemplate restTemplate

    @RequestMapping('/watchlist/{userId}')
    MovieCatalogue getMoviesList(@PathVariable('userId') String id){

        UserRating userRating = restTemplate.getForObject('http://movie-rating-service/api/watchlist/'+id,UserRating.class)

        MovieCatalogue movieCatalogue = new MovieCatalogue()
        movieCatalogue.userId = id
        userRating.ratings.each { rating ->
            Movie movie = restTemplate.getForObject('http://movie-info-service/api/'+rating.movieId,Movie.class)
            movieCatalogue.moviesWatched << new MovieCatalogue.MovieRating(movieId: movie.movieId, movieTitle: movie.title,rating: rating.rating)
        }
        movieCatalogue
    }
}
