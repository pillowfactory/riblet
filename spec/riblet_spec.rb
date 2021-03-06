require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Riblet" do
  describe ".add_on" do
    it "should accept the name of a library to load" do
      add_on('rubygems')
    end

    it "should accept an optional configuration block" do
      add_on('rubygems') { }
    end

    it "should accept an optional 'library required' boolean" do
      add_on('rubygems', false)
    end

    context "when library is prerequisite to loading IRB" do

      context "and the library is loadable" do
        it "should load the specifed library" do
          lambda{ Base64 }.should raise_error(NameError)
          add_on('base64')
          Base64
        end

        it "should run any optional initialization" do
          success = false
          add_on('drb') do
            init { success = true }
          end
          success.should == true
        end
      end

      context "and library isn't loadable" do
        it "should exit IRB" do
          lambda{ add_on('invalid lib') }.should raise_error(SystemExit)
        end
      end
    end
  end
end

