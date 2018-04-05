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

(ert-deftest su-scala-utils:wrap-6 ()
  (should
   (equal
    (with-current-buffer (find-file-noselect "test-wrap-6.scala")
       (progn
         (insert "package foo.bar

object Test {
  val locations =
    am.applic|ationId match {
      case Some(oppId) ⇒ 1
      case None        ⇒ 2
    }
}
")
         (run-wrap)))
    "package foo.bar

object Test {
  val locations = {
    |
    am.applicationId match {
      case Some(oppId) ⇒ 1
      case None        ⇒ 2
    }
  }
}
")))

(ert-deftest su-scala-utils:wrap-7 ()
  (should
   (equal
    (with-current-buffer (find-file-noselect "test-wrap-7.scala")
       (progn
         (insert "package foo.bar

object Test {
  val key =
    K|ey(keyStr)

  (global, optional) match {
    case (1, 2) ⇒
    case _ ⇒
  }
}
")
         (run-wrap)))
    "package foo.bar

object Test {
  val key = {
    |
    Key(keyStr)
  }

  (global, optional) match {
    case (1, 2) ⇒
    case _ ⇒
  }
}
")))

(ert-deftest su-scala-utils:wrap-8 ()
  (should
   (equal
    (with-current-buffer (find-file-noselect "test-wrap-8.scala")
       (progn
         (insert "package foo.bar

object Test {
  val intGen: Get[Int] = for {
    key <- keyGen
  } yield IntAn|swer(key)

  val noGen: Gen[No.type] = Gen.const(No)
}
")
         (run-wrap)))
    "package foo.bar

object Test {
  val intGen: Get[Int] = for {
    key <- keyGen
  } yield {
    |
    IntAnswer(key)
  }

  val noGen: Gen[No.type] = Gen.const(No)
}
")))

(ert-deftest su-scala-utils:wrap-9 ()
  (should
   (equal
    (with-current-buffer (find-file-noselect "test-wrap-9.scala")
       (progn
         (insert "package foo.bar

object Test {
  val riskText = (for {
    span <- submitterEmail.body
  } yield spa|n.text).mkString

  riskText should be(NonStandardRisk)
}
")
         (run-wrap)))
    "package foo.bar

object Test {
  val riskText = (for {
    span <- submitterEmail.body
  } yield {
    |
    span.text
  }).mkString

  riskText should be(NonStandardRisk)
}
")))
