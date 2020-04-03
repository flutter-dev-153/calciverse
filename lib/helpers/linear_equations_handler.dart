import 'package:flutter/foundation.dart';

import 'package:linalg/linalg.dart';

class LinearEquationsHandler {
  static List<double> solveEquationsInTwoVariables({
    @required double x1,
    @required double y1,
    @required double res1,
    @required double x2,
    @required double y2,
    @required double res2,
  }) {
    // AX = B
    // X = inv(A) * B

    var A = Matrix([
      [x1, y1],
      [x2, y2]
    ]);
    var B = Matrix([
      [res1],
      [res2]
    ]);

    try {
      var result = A.inverse() * B;
      return [result[0][0], result[1][0], 1];
    } catch (error) {
      return [null, null, 0];
    }
  }

  static List<double> solveEquationsInThreeVariables({
    @required double x1,
    @required double y1,
    @required double z1,
    @required double res1,
    @required double x2,
    @required double y2,
    @required double z2,
    @required double res2,
    @required double x3,
    @required double y3,
    @required double z3,
    @required double res3,
  }) {
    // AX = B
    // X = inv(A) * B

    var A = Matrix([
      [x1, y1, z1],
      [x2, y2, z2],
      [x3, y3, z3],
    ]);
    var B = Matrix([
      [res1],
      [res2],
      [res3],
    ]);

    try {
      var result = A.inverse() * B;
      return [result[0][0], result[1][0], result[2][0], 1];
    } catch (error) {
      return [null, null, null, 0];
    }
  }
}
