enum ApiRoute {
  nowPlaying('movie/now_playing'),
  topRated('movie/top_rated'),
  searchMovie('search/movie'),
  movieDetails('movie/');

  final String route;

  const ApiRoute(this.route);
}

enum DeviceScreenType { mobile, tablet }

