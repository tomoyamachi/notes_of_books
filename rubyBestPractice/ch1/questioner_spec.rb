require "rspec"
require "./questioner.rb"
describe Questioner do
  before do
    @q = Questioner.new
  end

  %w[y Y Yes yEs yes].each do |yes|
    it "#yes_or_no return true when #{yes}" do
      @q.yes_or_no(yes).should be_true
    end
  end

  %w[n No NO no].each do |no|
    it "#yes_or_no return false when #{no}" do
      @q.yes_or_no(no).should be_false
    end
  end


  %w[yesod none test ye].each do |str|
    it "#yes_or_no return nil when #{str}" do
      @q.yes_or_no(str).should be_nil
    end
  end

  it "#inquire_about_happiness return Good when true" do
    def @q.ask(question);true;end
    @q.inquire_about_happiness.should == "Good"
  end

  it "#inquire_about_happiness return Bad when false" do
    def @q.ask(question);false;end
    @q.inquire_about_happiness.should == "Bad"
  end
end
