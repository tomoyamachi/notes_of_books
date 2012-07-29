# -*- coding: utf-8 -*-
# C 1.1 配列引数
def my_method(*args)
  args.map { |arg| art.reverse }
end

# C 1.2 アラウンドエイリアス
class String
  alias :old_reverse :reverse
  def reverse
    "X#{old_reverse}X"
  end
end

# C 1.3 ブランックスレート
class C
  def method_missing(name,*args)
    puts "missing!"
  end
  instance_methods.each do |m|
    undef_method m unless m.to_s =~ /object_id|method_missing|respond_to?|instance_eval|^__/
  end
end
#puts C.new.to_s

# C 1.4 クラス拡張 モジュールをクラスメソッドとして定義
module M
  def hello
    "hello"
  end
end
class << C
  include M
end
puts C.hello

# C 1.5 クラス拡張ミックスイン フックメソッドをつかってモジュールをクラスメソッドとして定義
module Mo
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def bye
      "bye"
    end
  end
end

class C
  include Mo
end
puts C.bye


# 6 クラスインスタンス変数
class C
  @my_class_instance = "Value"

  def self.class_attribute
    @my_class_instance
  end
end

puts C.class_attribute

# 7 クラスマクロ
class << C
  def my_macro(arg)
    puts "#{arg} called"
  end
end

class C
  my_macro :x
end

# 8 クリーンルーム
class CleanRoom
  def useful_method(x); x * 2;end
end

puts CleanRoom.new.instance_eval{ useful_method(5) }

# 9 コードプロセッサ 外部ファイルのコード文字列を処理
Dir.glob("*reference.txt").each do |file|
  File.readlines(file).each do |line|
    puts "#{line.chomp} #=> #{eval(line)}"
  end
end

# 10 コンテキスト探査機
class C
  def initialize
    @x = "capsulized value"
  end
end

obj = C.new
puts obj.instance_eval { @x }

# 11 遅延評価
class C
  def store(&block)
    @capsule = block
  end
  def execute
    @capsule.call
  end
end
obj = C.new
obj.store { $X = 1}
$X = 0

obj.execute
puts $X #=> 1

# 12 動的ディスパッチ
dynamic_reverse = :reverse
"abc".send(dynamic_reverse)

# 13 動的メソッド
C.class_eval do
  define_method :dynamic_my_method do
    "hello dynamic world"
  end
end
p C.new.dynamic_my_method

# 14 動的プロキシ 他のオブジェクトに転送
class MyDynamicProxy
  def initialize(target)
    @target = target
  end

  def method_missing(name,*args,&block)
    "result: #{@target.send(name,*args,&block)}"
  end
end
obj = MyDynamicProxy.new("my dynamic proxy")
p obj.reverse

# 15 フラットスコープ
class C
  def an_attribute
    @attr
  end
end
obj = C.new
flat_value = 10

obj.instance_eval do
  @attr = flat_value
end

puts obj.an_attribute

# 16 ゴーストメソッド
class Ghost
  def method_missing(name,*args)
    name.to_s.reverse
  end
end
puts Ghost.new.dont_exist_method

#17 フックメソッド 特定のイベントが発生したときに、指定したコードを実行
class C
  def self.inherited(subclass)
    puts subclass
  end
end

class InheritedClass < C;end

# 18 カーネルメソッドにメソッドを定義して、すべてのオブジェクトでつか
# えるようにする
module Kernel
  def a_method
    puts "This is Kernel#a_method"
  end
end
a_method

#19 遅延インスタンス変数
class C
  def attribute
    @attribute = @attribute || "value"
  end
end
C.new.attribute

# 20 ミミックメソッド
def BaseClass(name)
  name == "string" ? String : Object
end

class A < BaseClass "string" # クラスにみえるメソッド
  attr_accessor :an_attribute # キーワードにみえるメソッド
end
obj = A.new
obj.an_attribute = 1 # 属性にみえるメソッド

# 21 モンキーパッチ 既存クラスの振舞いを変更
class String
  def reverse
    "override"
  end
end
"abc".reverse

# 22 名前付き引数
def named_parameter(args)
  args[:arg2]
end
named_parameter(:arg1 =>"A", :arg2 => "B")

#23 ネームスペース 定数をモジュール内に定義
module MyNamespace
  class Array
    def to_s
      "#23 name space"
    end
  end
end
p Array.new.to_s
p MyNamespace::Array.new.to_s

#24 nilガード
x = nil
y = x || "nil guard"

# 25 オブジェクト拡張 特異クラスにモジュールをインクルードして、特異メ
# ソッドを定義

obj = Object.new
module M
  def m_method
    "#25 singleton"
  end
end
class << obj
  include M
end
obj.m_method

#26 オープンクラス 既存のクラスを拡張
class String
  def my_string_method
    "#26 open class"
  end
end
p "abc".my_string_method

#27 パターンディスパッチ 名前をもとにメソッドを呼び出す
$x = "# 27"
class P
  def my_first
    $x += " pattern"
  end

  def my_second
    $x += " dispatch"
  end
end

obj = P.new
obj.methods.each { |m| obj.send(m) if m.to_s =~ /^my_/ }
puts $x

#28 サンドボックス 安全な場所をつくる $SAFEで管理
def sandbox(&code)
  proc {
    $SAFE = 2
    yield
  }.call
end

sandbox { puts "#28 sandbox"}

# 29 スケープゴート class,module.defで、スコープが切り替わる
a = 1
defined? a
module MyModule
  b = 1
  defined? a
end
defined? a

# 30 自己yield ブロックにself を渡す
class Person
  attr_accessor :name, :surname

  def initialize
    yield self
  end
end

joe = Person.new do |p|
  p.name = "#30"
  p.surname = " self yield"
end

# 31 共有スコープ フラットスコープにし、変数を共有
lambda{
  shared = 10
  self.class.class_eval do
    define_method :counter do
      shared
    end

    define_method :down do
      shared -= 1
    end
  end
}.call

p counter
3.times { down }
p counter

# 32 特異メソッド 特定のオブジェクトにメソッドを定義
obj = "abc"

class << obj
  def my_singleton_method
    "# 32 singleton method"
  end
end

puts obj.my_singleton_method

# 33 コード文字列
string = "puts '#33 code string'"
eval string

# 34 Symbol の Proc変換 シンボルを1つのメソッドを呼び出すブロックに変
# 換
p [1,2,3,4].map(&:to_s)
