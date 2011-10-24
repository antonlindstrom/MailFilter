module MailFilter
  class Config

    def initialize
      load_config
    end

    # Shift to get the conf.
    $:.unshift File.join(File.dirname(__FILE__), *%w[../../])
    FILE = "config/userdata.json"

    attr_accessor :value

    # Bootstrap
    #
    # Returns nothing
    def bootstrap
      FileUtils.touch(file) unless File.exist?(file)
    end

    # Set config (config.value[x])
    def value=(values)
      @value = values
    end

    # Load config from file
    #
    # Returns config hash
    def load_config
      @value = MultiJson.decode(File.new(file, 'r').read)
    end

    # Configuration file
    #
    # Returns string path to config file
    def file
      FILE
    end

  end
end
