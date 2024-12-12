import 'package:equatable/equatable.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Point extends Equatable {
  final String id;

  final double x;
  final double y;
  final double z;

  const Point({
    required this.id,
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  List<Object?> get props => [x, y, z];

  Vector3 get vector => Vector3(x, y, z);
}
