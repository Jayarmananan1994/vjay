package com.vjay.movieinfoapp.resources

import com.vjay.movieinfoapp.model.Movie
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RequestMapping('/api')
@RestController
class MovieinfoApi {

    @RequestMapping('/pingme/{name}')
    String pingMyName(@PathVariable('name') String name){
        'Welcome '+ name
    }

    @RequestMapping('/{movieId}')
    Movie getMovieDetawil(@PathVariable('movieId')String id){
        Movie movie = new Movie( movieId: id,title:'Home Alone',description:'Comedy Movie')
        movie
    }


}
