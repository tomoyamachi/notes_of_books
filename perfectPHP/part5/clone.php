<?php
class Foo {
  public $bar;
  public function __clone() {
    $this->bar = clone $this->bar;
  }

}
class Bar {
  public $value;
}

$foo = new Foo();
$foo->bar = new Bar();
$foo->bar->value = 'bar';

$foo2 = clone $foo;
$foo2->bar->value = 'bar2';

var_dump($foo->bar->value);
var_dump($foo2->bar->value);

?>