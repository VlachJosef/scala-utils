# scala-utils

Support for wrapping simple Scala expression in curly braces.

By running `scala-utils:wrap-in-braces` with point anywhere on this line:
```scala
def calcA(): Int = 1 + 2
```
Results in expression wrapped in curly braces (where `|` denotes position of the point).
```scala
def calcA(): Int = {
  |
  1 + 2
}
```

For more examples see `scala-utils-test.el`.
