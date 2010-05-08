require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riblet::Addon do
  context ".load" do
    it "should accept the name of a library to load" do
      Riblet::Addon.load('rubygems')
    end

    it "should accept an optional configuration block" do
      Riblet::Addon.load('rubygems') { }
    end

    it "should accept an optional 'library required' boolean" do
      Riblet::Addon.load('rubygems', false)
    end

    context "when library is prerequisite to loading IRB" do

      context "and the library is loadable" do
        it "should load the specifed library" do
          lambda{ Set }.should raise_error(NameError)
          Riblet::Addon.load('set')
          Set.new
        end

        it "should run any optional initialization" do
          success = false
          Riblet::Addon.load('bigdecimal') do
            init { success = true }
          end
          success.should == true
        end
      end

      context "and library isn't loadable" do
        it "should exit IRB" do
          lambda{ Riblet::Addon.load('invalid lib') }.should raise_error(SystemExit)
        end
      end
    end
  end
end
