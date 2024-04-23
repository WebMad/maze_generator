import 'package:flutter/material.dart';

class MapDisplayWidget extends StatelessWidget {
  final List<List<int>> map;
  final Set<String>? route;
  final List<int>? startingPoint;
  final List<int>? finishingPoint;
  final void Function(int x, int y)? onTap;

  const MapDisplayWidget({
    super.key,
    required this.map,
    required this.route,
    this.startingPoint,
    this.finishingPoint,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: map[0].length, // Number of columns
        childAspectRatio: 1.0, // Aspect ratio of each cell
      ),
      itemCount: map.length * map[0].length,
      itemBuilder: (BuildContext context, int index) {
        int row = index ~/ map[0].length;
        int col = index % map[0].length;
        return GestureDetector(
          onTap: () {
            onTap?.call(col, row);
          },
          child: Container(
            color: () {
              if (route?.contains('$col,$row') ?? false) {
                return Colors.lightGreenAccent;
              }

              final startingPoint = this.startingPoint;

              if (startingPoint != null &&
                  startingPoint[0] == col &&
                  startingPoint[1] == row) {
                return Colors.yellow;
              }

              final finishingPoint = this.finishingPoint;

              if (finishingPoint != null &&
                  finishingPoint[0] == col &&
                  finishingPoint[1] == row) {
                return Colors.red;
              }

              return map[row][col] != 1 ? Colors.lightBlue : Colors.black;
            }(),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  map[row][col].toString(),
                  style: TextStyle(
                    color: map[row][col] != 1 ? Colors.black : Colors.lightBlue,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
