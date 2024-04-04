import 'package:flutter/material.dart' show Color;

const double kAppBarHeight = 56.0;

const double kIconLargeSize = 160;

const String kDBName = 'movies';

const int kTapBarLength = 3;


const String kBaseUrl = 'https://api.themoviedb.org/3/';
const String kBaseUrlImage = 'https://image.tmdb.org/t/p/w500';
const String kApiKey = 'd17b357a03e3b9f405c7d9927b192106';

const String kAccessToken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMTdiMzU3YTAzZTNiOWY0MDVjN2Q5OTI3YjE5MjEwNiIsInN1YiI6IjY2MGMyYmVmNmRjNTA3MDE3ZTU1OTFlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-JN1KwSLl9fT0cJwMyqABmJi7AWj11nb0pcQ72-IvyA';

const Color kMainColor = Color(0xFFF2F2F2);
const Color kSecondaryColor = Color(0xFFDBE3FF);

const Color kTextPrimaryColor = Color(0xFF110E47);
const Color kTextSecondaryColor = Color(0xFF9C9C9C);
const Color kTextSubColor = Color(0xFF88A4E8);

// Search By name
// https://api.themoviedb.org/3/search/movie?query=man&include_adult=false&language=en-US&page=1&api_key=d17b357a03e3b9f405c7d9927b192106

// Now Playing
// https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1&api_key=d17b357a03e3b9f405c7d9927b192106

// Top Rated
// https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=d17b357a03e3b9f405c7d9927b192106

// details Movie by Id
// https://api.themoviedb.org/3/movie/1055446?language=en-US&api_key=d17b357a03e3b9f405c7d9927b192106