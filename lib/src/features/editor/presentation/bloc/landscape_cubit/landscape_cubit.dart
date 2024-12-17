import 'dart:math' hide Point;

import 'package:bloc/bloc.dart';
import 'package:comgred/src/features/editor/data/models/models.dart';
import 'package:equatable/equatable.dart';

part 'landscape_state.dart';

class LandscapeCubit extends Cubit<LandscapeState> {
  LandscapeCubit()
      : super(const LandscapeInitial(
          depth: 5,
          randomness: 0.75,
          squareSize: 10.0,
        ));

  void updateDepth(int depth) {
    assert(depth >= 1 && depth <= 6);

    emit(state.copyWith(depth: depth));
  }

  void updateRandomness(double randomness) {
    assert(randomness >= 0 && randomness <= 1);

    emit(state.copyWith(randomness: randomness));
  }

  void updateSquareSize(double squareSize) {
    assert(squareSize >= 5 && squareSize <= 20);

    emit(state.copyWith(squareSize: squareSize));
  }

  void resetChanges() {
    emit(const LandscapeInitial(
      depth: 5,
      randomness: 0.75,
      squareSize: 10.0,
    ));
  }

  void applyChanges(void Function(List<Line> lines) callback) {
    final heights = _diamondSquareAlgorithm(
      depth: state.depth,
      randomness: state.randomness,
      squareSize: state.squareSize,
    );
    final lines = _buildLines(
      heights: heights,
      squareSize: state.squareSize,
    );

    /// project add lines callback
    callback(lines);
  }

  List<List<double>> _diamondSquareAlgorithm({
    required int depth,
    required double randomness,
    required double squareSize,
  }) {
    final int pointsPerSide = pow(2, depth).toInt() + 1;
    final List<List<double>> heights = List.generate(
      pointsPerSide,
      (_) => List.generate(pointsPerSide, (_) => 0),
    );
    final Random random = Random.secure();

    /// Инициализация углов
    heights[0][0] = random.nextDouble();
    heights[0][pointsPerSide - 1] = random.nextDouble();
    heights[pointsPerSide - 1][0] = random.nextDouble();
    heights[pointsPerSide - 1][pointsPerSide - 1] = random.nextDouble();

    for (int step = pointsPerSide - 1; step > 1;) {
      /// Алгоритм "Diamond" шаг
      for (int x = 0; x < pointsPerSide - 1; x += step) {
        for (int y = 0; y < pointsPerSide - 1; y += step) {
          double avg = (heights[x][y] +
                  heights[x + step][y] +
                  heights[x][y + step] +
                  heights[x + step][y + step]) /
              4.0;

          heights[x + step ~/ 2][y + step ~/ 2] = avg +
              (random.nextDouble() * 2 - 1) * randomness * step / squareSize;
        }
      }

      /// Алгоритм "Square" шаг
      for (int x = 0; x < pointsPerSide; x += step ~/ 2) {
        for (int y = (x + step ~/ 2) % step; y < pointsPerSide; y += step) {
          double sum = 0;
          int count = 0;

          if (x >= step / 2) {
            sum += heights[x - step ~/ 2][y];
            count++;
          }
          if (x + step / 2 < pointsPerSide) {
            sum += heights[x + step ~/ 2][y];
            count++;
          }
          if (y >= step / 2) {
            sum += heights[x][y - step ~/ 2];
            count++;
          }
          if (y + step / 2 < pointsPerSide) {
            sum += heights[x][y + step ~/ 2];
            count++;
          }

          heights[x][y] = sum / count +
              (random.nextDouble() * 2 - 1) * randomness * step / squareSize;
        }
      }
      step ~/= 2;
      randomness /= 2;

      /// Уменьшение случайности
    }

    return heights;
  }

  List<Line> _buildLines({
    required List<List<double>> heights,
    required double squareSize,
  }) {
    final List<Line> lines = [];

    int pointsPerSide = heights.length;
    double step = squareSize / (pointsPerSide - 1);

    /// Построение вершин
    for (int x = 0; x < pointsPerSide - 1; x++) {
      for (int y = 0; y < pointsPerSide - 1; y++) {
        /// Определяем вершины треугольников
        final p1 = Point(
          x: x * step - squareSize / 2,
          z: y * step - squareSize / 2,
          y: heights[x][y],
        );
        final p2 = Point(
          x: (x + 1) * step - squareSize / 2,
          z: y * step - squareSize / 2,
          y: heights[x + 1][y],
        );
        final p3 = Point(
          x: x * step - squareSize / 2,
          z: (y + 1) * step - squareSize / 2,
          y: heights[x][y + 1],
        );
        final p4 = Point(
          x: (x + 1) * step - squareSize / 2,
          z: (y + 1) * step - squareSize / 2,
          y: heights[x + 1][y + 1],
        );

        /// Добавляем два треугольника
        lines.addAll({
          /// p1, p2, p3
          Line(firstPoint: p1, lastPoint: p2),
          Line(firstPoint: p2, lastPoint: p3),
          Line(firstPoint: p3, lastPoint: p1),

          /// p2, p4, p3
          Line(firstPoint: p2, lastPoint: p4),
          Line(firstPoint: p4, lastPoint: p3),
          Line(firstPoint: p3, lastPoint: p2),
        });
      }
    }

    return lines;
  }
}
