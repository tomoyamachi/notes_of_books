require "rspec"

class ParseLine
  def parse_inline_style(text)
    segments = text.split(/(<\/?.+?>)/).delete_if {|x| x.empty?}
    segments.size == 1 ? segments.first : segments
  end

  def parse_inline_style_ib(text)
    segments = text.split(/(<\/?[ib]>)/).delete_if {|x| x.empty?}
    segments.size == 1 ? segments.first : segments
  end
end

describe ParseLine do
  before do
    @parse = ParseLine.new
  end
  it "#parse_inline_style return plain text" do
    @parse.parse_inline_style("Hello World").should == "Hello World"
  end

  it "#parse_inline_style return <[bi]> text" do
    @parse.parse_inline_style("<i>Hello <b>Fine</b></i> World").should == ["<i>","Hello ","<b>","Fine","</b>","</i>"," World"]
  end

  it "#parse_inline_style return <[bi]> text with <Ichigo>" do
    @parse.parse_inline_style_ib("Hello <ichigo>such <b>Fine</b></ichigo> World").should == ["Hello <ichigo>such ","<b>","Fine","</b>","</ichigo> World"]
  end

end

