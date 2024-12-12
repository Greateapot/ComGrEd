import 'package:vector_math/vector_math_64.dart';

extension DoubleExtension on double {
  double toDegrees() => this * radians2Degrees;
  double toRadians() => this * degrees2Radians;
}
