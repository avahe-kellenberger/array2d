when compileOption("checks"):
  import strformat

type Array2D*[I: static int, T] = object
  data: array[I, T]
  width: int
  height: int

proc newArray2D*[T](width, height: static int): Array2D[width * height, T] =
  result = Array2D[width * height, T]()
  result.width = width
  result.height = height

template `width`*[I, T](this: Array2D[I, T]): int =
  this.width

template `height`*[I, T](this: Array2D[I, T]): int =
  this.height

template checkForBoundsException[I, T](this: Array2D[I, T], x, y: int) =
  when compileOption("checks"):
    if x >= this.width:
      raise newException(IndexDefect, fmt"x value of {x} outside bounds")
    if y >= this.height:
      raise newException(IndexDefect, fmt"y value of {y} outside bounds")

proc `[]`*[I, T](this: Array2D[I, T], x, y: int): T {.inline.} =
  this.checkForBoundsException(x, y)
  return this.data[x + this.width * y]

proc `[]`*[I, T](this: var Array2D[I, T], x, y: int): var T {.inline.} =
  this.checkForBoundsException(x, y)
  return this.data[x + this.width * y]

proc `[]=`*[I, T](this: var Array2D[I, T], x, y: int, t: T) {.inline.} =
  this.checkForBoundsException(x, y)
  this.data[x + this.width * y] = t

iterator items*[I, T](this: Array2D[I, T]): tuple[x: int, y: int, value: T] =
  for y in 0 ..< this.height:
    for x in 0 ..< this.width:
      yield (x, y, this[x, y])

iterator mitems*[I, T](this: var Array2D[I, T]): tuple[x: int, y: int, value: var T] =
  for y in 0 ..< this.height:
    for x in 0 ..< this.width:
      yield (x, y, this[x, y])

iterator values*[I, T](this: Array2D[I, T]): T =
  for item in this.data:
    yield item

