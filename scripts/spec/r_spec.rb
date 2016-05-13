$: << File.dirname(__FILE__)
require 'spec_helper'
require 'r'

describe R do
  describe "initialize" do
    it "should be initialyzed with exception devision by 0" do
      lambda{R.new(1, 0)}.should raise_error
    end
  end

  describe "*" do
    it "returns valid Rational after * to Number" do
      r = R.new(2, 3)
      res = r*10
      res.to_s.should eq("20/3")
    end

    it "returns valid Rational after * to Rational" do
      r = R.new(2, 3)
      res = r*R.new(5, 7)
      res.to_s.should eq("10/21")
    end

    it "returns valid Rational after * to Rational" do
      r = R.new(2, 3)
      res = r*R.new(5, 7)
      res.to_s.should eq("10/21")
    end
  end
end