#require 'test_helper'
require File.dirname(__FILE__) + '/../test_helper'

class DebateTest < ActiveSupport::TestCase
  test "should not validate with no sides" do
    debate = Debate.new(:name => "Am I awesome?")
    assert !debate.save, "Saved the debate with no sides"
  end
  
  test "should not validate with only one side" do
    debate = Debate.new(:name => "Am I awesome?")
    debate.sides.build(:name => "Yes")
    assert !debate.save, "Saved the debate with only one side"
  end
  
  test "should prevent destruction of too many sides" do
    debate = Debate.new(:name => "Am I awesome?")
    debate.sides.build(:name => "Yes")
    debate.sides.build(:name => "No")
    debate.save
    debate.sides.last.destroy
    debate.save
    assert debate.sides.size == 2, "Debate has less than two sides after destroying one"
  end
end
