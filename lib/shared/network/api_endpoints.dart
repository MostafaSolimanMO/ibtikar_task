class EndPoints {
  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static const String imageBaseUrl = 'http://image.tmdb.org/t/p/w200/';

  static const String token = '8bb5123c4a792f06e0eb0ffa6c6323fb';

  static const String popularPerson = 'person/popular';

  static String getPersonImages({required int personId}) {
    return "person/$personId/images";
  }
}
