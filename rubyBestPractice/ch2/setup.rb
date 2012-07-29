class Foo
  def initialize(bar="bar",baz="baz")
    @bar,@baz = bar, baz
  end

  def add_bar(str="some sentence")
    put_all do |s|
      p @bar += str
    end
  end

  def add_baz(str="some sentence")
    put_all do |s|
      p @baz += str
    end
  end

  def put_all
    yield
  ensure
    puts @bar,@baz,"======================"
  end
end
foo = Foo.new
foo.add_bar
foo.add_baz("hello")
