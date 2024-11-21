const String baseImagePath = 'assets/images';
const String baseIconPath = 'assets/icons';

final icItem = 'decor'.image;
final icItem2 = 'decor2'.image;

extension ImageExtension on String {
  String get image => '$baseImagePath/$this.png';
  String get icon => '$baseIconPath/$this.png';
}
