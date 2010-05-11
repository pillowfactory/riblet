module Riblet
  module IRB
    def add_on(require_name, required=true, &config)
      riblet = Riblet::Addon.load(require_name, required, &config) 
      
      puts "** Loaded: #{riblet.to_s(:usage)}" if riblet && riblet.loaded
    end

    def riblets(type=nil)
      puts "Using #{Riblet.addons.size} riblet(s)...\n\n"

      Riblet.addons.each do |addon|
        puts addon.to_s(type)
      end
      nil
    end
  end
end
