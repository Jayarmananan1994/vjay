package com.vjay.moviecatalogue.model

class MovieCatalogue {
    String userId
    List<MovieRating> moviesWatched = []

    static class MovieRating{
        String movieId
        String movieTitle
        double rating
    }
}
