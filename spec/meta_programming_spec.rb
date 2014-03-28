require_relative 'spec_helper'
describe "test" do

  it "works" do
    Talker.new.say("really").must_equal "reallya" 
  end

  it "wraps" do
    Changer.wrap Talker, :say 
    puts Changer.new.methods.grep /say/
    Talker.new.say("Cool").must_equal "Coola"
  end
end
