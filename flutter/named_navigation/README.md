# named_navigation

A Movie and TV Series based App to help you find movie and TV Series of different genre. Also the user will be able to see the reviews and votes, get movies/ TV Series suggestion based on the movie they selected. Apart from this, a signed up user will have following feature.

1. Display the movie and TV series suggestions based on their interest.
2. Ability to add review and add Collections 
3. Notify user upon new arrival of episode.
4. Streaming source for video(Tentative)
5. Chat room for discussing and sharing Trivia and info about movie/TV series or the Artist by creating Hashtag . E.g:- #ReleaseSnyderCut.

In implementation perspective, the below are implemented.

1. The cached_network_image is used for caching the images and a transparent placeholder is used until the image is loaded. An fading animation is used when the image is loaded first time.
2. The named navigation is used to manage the navigation to different screen. The parameter for widget is passed through the argument in named navigation.
3. The carousel_slider is used for the carousel of images.
4. The TMDB API is used for the movie info.
5. Hero animation is used for page navigation of cast list -> Artist Info page.
6. The async feature of dart is used to asynchronously load the data for widget.


# In Progress

1. Social signup and signup  with email.
2. Suggestion based on the interest of user.
3. Favorite list
3. Push notification with firebase.


# Known Issue

1. The Movie thumbnails in 'You might like this section' need to be fixed.
2. The detail page of few TV series will give exception due to the data issue.
3. The Hero navigation has a glitch when navigating back to screen1.



+<img src="/flutter/named_navigation/MyMDB.gif?raw=true" width="200px">
