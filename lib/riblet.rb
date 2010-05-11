module Riblet
  @@addons = []
  def self.addons
    @@addons
  end

  def self.addons=(riblet)
    @@addons << riblet
  end
end

require 'riblet/add_on'
require 'riblet/irb'

include Riblet::IRB
