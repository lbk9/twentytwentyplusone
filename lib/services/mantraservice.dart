import 'dart:math';

class MantraService {
  List<String> _mantras = [
    "Positivity wins. Always.",
    "Failure to prepare is the best way to prepare for failure",
    "What's for you won't go by you.",
    "Keep your head up.",
    "You need the rain to get to the rainbow.",
    "Every cloud has a silver lining.",
    "The best time to start was yesterday, the second best time is now."
  ];

  String getMantra() {
    Random random = new Random();
    return _mantras[random.nextInt(_mantras.length)];
  }
}
