enum Direction {
  up,
  down,
  left,
  right;
}

// Расширение для удобной работы с направлениями 
extension DirectionExtinsion on Direction {
  bool get isHorizontal => this == Direction.left || this == Direction.right;

  bool get isVertical => this == Direction.up || this == Direction.down;


// Проверка противоположного направления 
bool isOpposite(Direction other) {
  return (this == Direction.up && other == Direction.down) ||
         (this == Direction.down && other == Direction.up) ||
         (this == Direction.left && other == Direction.right) || 
         (this == Direction.right && other == Direction.left);  
 } 
}

