require 'yaml'

module Pip
  class Config
    def initialize
      @config = YAML.load_file "#{ENV['HOME']}/.pipconfig.yml"
    end

    def api_key
      @config['api_key']
    end
  end
end
