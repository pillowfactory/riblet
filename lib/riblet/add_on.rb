module Riblet
  class Addon
    
    def initialize(require_name, required=true)
      @require_name = require_name
      @required = required
    end

    def name(name); @name = name; end
    def desc(desc); @desc = desc; end
    def install(install); @install = install; end
    def source(source); @source = source; end
    def usage(usage); @usage = usage; end
    def init(&init_block); @init_block = init_block; end

    def perform_init
      @init_block.call if @init_block
    end

    def install_str
      "Install with: '#{@install}'" if @install
    end

    def to_s
      if @name
        "#{@name} (#{@require_name})"
      else
        @require_name
      end
    end

    def self.load(require_name, required=true, &config)
      definition = self.new(require_name, required)
      definition.instance_eval(&config) if block_given?
      
      if required && (require require_name)
        ($irb_add_ons ||= []) << definition
        definition.perform_init
        puts "#{Color::BOLD}Loaded #{Color::CYAN}#{definition.to_s}#{Color::RESET}"
      end
    rescue LoadError
      puts "#{Color::RED}Unable to load: #{Color::YELLOW}#{definition.to_s}#{Color::RED}. #{definition.install_str}#{Color::RESET}"
      exit if required
    end

    module Color 
      RESET     = "\e[0m"
      BOLD      = "\e[1m"
      UNDERLINE = "\e[4m"
      LGRAY     = "\e[0;37m"
      GRAY      = "\e[1;30m"
      RED       = "\e[31m"
      GREEN     = "\e[32m"
      YELLOW    = "\e[33m"
      BLUE      = "\e[34m"
      MAGENTA   = "\e[35m"
      CYAN      = "\e[36m"
      WHITE     = "\e[37m"
    end
  end
end
