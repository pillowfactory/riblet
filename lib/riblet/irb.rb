module Riblet
  module IRB
    def add_on(require_name, required=true, &config)
      riblet = Riblet::Addon.load(require_name, required, &config) 
      
      puts "** Loaded: #{riblet.to_s(:usage)}" if riblet && riblet.loaded
    end
    end
  end
end
