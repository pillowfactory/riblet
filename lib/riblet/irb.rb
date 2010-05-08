module Riblet
  module IRB
    def add_on(require_name, required=true, &config)
      Riblet::Addon.load(require_name, required, &config) 
    end
  end
end
