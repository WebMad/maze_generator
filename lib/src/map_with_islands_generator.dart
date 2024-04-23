import 'dart:math';

class MapWithIslandsGenerator {
  static final _random = Random();

  static List<List<int>> generateV2({
    required int width,
    required int height,
  }) {
    return List.generate(
      height,
      (y) => List.generate(
        width,
        (x) {
          if ((x == 0 && y == 0) || (x == width - 1 && y == height - 1)) {
            return 0;
          }

          return _random.nextInt(10) > 2 ? 0 : 1;
        },
      ),
    );
  }

  static List<List<int>> generate({
    required int width,
    required int height,
    required int maxCountIslands,
    required int maxIslandSize,
  }) {
    final map = List.generate(height, (_) => List.generate(width, (_) => 0));

    for (int i = 0; i < maxCountIslands; i++) {
      _generateIsland(
        map: map,
        x: _random.nextInt(width - 1) + 1,
        y: _random.nextInt(height - 1) + 1,
        maxSize: _random.nextInt(maxIslandSize),
        myBlocks: {},
      );
    }

    return map;
  }

  static void _generateIsland({
    required List<List<int>> map,
    required int x,
    required int y,
    required int maxSize,
    required Set<String> myBlocks,
  }) {
    final height = map.length;
    final width = map[0].length;

    if (maxSize == 0 || x == width || y == height || y == -1 || x == -1) {
      return;
    }

    final neighbors = {
      [x + 1, y],
      [x, y + 1],
      [x + 1, y + 1],
      [x - 1, y - 1],
      [x - 1, y + 1],
      [x + 1, y - 1],
      [x - 1, y],
      [x, y - 1],
    };

    for (final neighbor in neighbors) {
      if (neighbor[0] >= 0 &&
          neighbor[1] >= 0 &&
          neighbor[0] < width &&
          neighbor[1] < height) {
        if (map[neighbor[1]][neighbor[0]] == 1 &&
            !myBlocks.contains("${neighbor[0]}|${neighbor[1]}")) {
          return;
        }
      }
    }

    final size = maxSize - 1;

    int totalSize = size;
    List<int> sizePerDest = List.filled(4, 0);

    while (totalSize > 0) {
      int destIndex = _random.nextInt(4);
      sizePerDest[destIndex]++;
      totalSize--;
    }

    map[y][x] = 1;
    myBlocks.add("$x|$y");

    _generateIsland(
      map: map,
      x: x + 1,
      y: y,
      maxSize: sizePerDest[0],
      myBlocks: myBlocks,
    );

    _generateIsland(
      map: map,
      x: x,
      y: y + 1,
      maxSize: sizePerDest[1],
      myBlocks: myBlocks,
    );

    _generateIsland(
      map: map,
      x: x,
      y: y - 1,
      maxSize: sizePerDest[2],
      myBlocks: myBlocks,
    );

    _generateIsland(
      map: map,
      x: x - 1,
      y: y,
      maxSize: sizePerDest[3],
      myBlocks: myBlocks,
    );
  }

  static display(List<List<int>> map) {
    for (var row in map) {
      print(row.map((e) => e == 1 ? '██' : '  ').join());
    }
  }
}
