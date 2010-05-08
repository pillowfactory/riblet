require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riblet::IRB do
  describe '.add_on' do
    it "should delegate to Riblet::Adon" do
      Riblet::Addon.should_receive(:load)
      Riblet::IRB.add_on(:foo)
    end
  end
end
