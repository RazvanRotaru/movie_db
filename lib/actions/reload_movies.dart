import 'dart:math';

class ReloadMovies {
  static final Random random = Random();

  int get randomPage {
    return random.nextInt(100) + 1;
  }
}
