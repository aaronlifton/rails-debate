#require 'test_helper'
require File.dirname(__FILE__) + '/../test_helper'

class SideTest < ActiveSupport::TestCase
  test "should prevent destruction if debate will have too few sides" do
    debate =  Debate.new(:name => "Are you awesome?")
    side_one = debate.sides.build(:name => "yes")
    side_two = debate.sides.build(:name => "no")
    debate.save
    assert !side_one.destroy, "Destroyed the side, leaving its debate with less than two sides"
    assert !side_two.destroy, "Destroyed the side, leaving its debate with less than two sides"
    assert debate.sides.size == 2, "A side was destroyed, leaving its debate with less than two sides"
  end
end
