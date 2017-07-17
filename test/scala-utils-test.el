(defun run-wrap ()
  (re-search-backward "|")
  (delete-char 1)
  (scala-utils:wrap-in-braces)
  (insert "|")
  (buffer-string))

(ert-deftest su-scala-utils:wrap-1 ()
  (should
   (equal
    (with-current-buffer (find-file-noselect "test-wrap-1.scala")
       (progn
         (insert "package foo.bar

object Test {
  def abs() =
    1 |+ 1

  def efg() = 123
}
")
         (run-wrap)))
    "package foo.bar

object Test {
  def abs() = {
    |
    1 + 1
  }

  def efg() = 123
}
")))

(ert-deftest su-scala-utils:wrap-2 ()
  (should
   (equal
    (with-current-buffer (find-file-noselect "test-wrap-2.scala")
       (progn
         (insert "package foo.bar

object Test {
  def abs() = 1 + 1

  def efg() =
    12|3
}
")
         (run-wrap)))
    "package foo.bar

object Test {
  def abs() = 1 + 1

  def efg() = {
    |
    123
  }
}
")))

(ert-deftest su-scala-utils:wrap-3 ()
  (should
   (equal
    (with-current-buffer (find-file-noselect "test-wrap-3.scala")
       (progn
         (insert "package foo.bar

object Test {
  def calcA(): Int       = 1 + 2
  def calcB(i: Int): Int = 1 + 2 + i

  def delete[T](i: Int = calcB {
    def res = calcA()
    res
  }, party: Party, findBankAccounts: Party ⇒ PossibleValue[List[BankAccount]])
    : Failure ∨ Unit =
    upda|te()
}
")
         (run-wrap)))
    "package foo.bar

object Test {
  def calcA(): Int       = 1 + 2
  def calcB(i: Int): Int = 1 + 2 + i

  def delete[T](i: Int = calcB {
    def res = calcA()
    res
  }, party: Party, findBankAccounts: Party ⇒ PossibleValue[List[BankAccount]])
    : Failure ∨ Unit = {
    |
    update()
  }
}
")))

(ert-deftest su-scala-utils:wrap-4 ()
  (should
   (equal
    (with-current-buffer (find-file-noselect "test-wrap-4.scala")
       (progn
         (insert "package foo.bar

object Test {
  def calcA(): Int   |    = 1 + 2
  def calcB(i: Int): Int = 1 + 2 + i
}
")
         (run-wrap)))
    "package foo.bar

object Test {
  def calcA(): Int       = {
    |
    1 + 2
  }
  def calcB(i: Int): Int = 1 + 2 + i
}
")))

(ert-deftest su-scala-utils:wrap-5 ()
  (should
   (equal
    (with-current-buffer (find-file-noselect "test-wrap-5.scala")
       (progn
         (insert "package foo.bar

object Test {
  def calcA(): Int       = 1 + 2
  def c|alcB(i: Int): Int = 1 + 2 + i
}
")
         (run-wrap)))
    "package foo.bar

object Test {
  def calcA(): Int       = 1 + 2
  def calcB(i: Int): Int = {
    |
    1 + 2 + i
  }
}
")))
