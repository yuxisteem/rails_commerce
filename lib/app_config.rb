require 'ostruct'

module Configuration
  CONFIG_PATH = "#{Rails.root}/config/config.yml"

  class Settings < OpenStruct
    def self.load
      config = YAML.load(ERB.new(File.read(CONFIG_PATH)).result)

      if config['all']
        config = config['all'].merge(config[Rails.env])
      else
        config = config[Rails.env]
      end

      new(config)
    end

    def initialize(hash = nil)
      @table = {}
      @hash_table = {}

      return unless hash

      hash.each do |k, v|
        @table[k.to_sym] = (v.is_a?(Hash) ? self.class.new(v) : v)
        @hash_table[k.to_sym] = v

        new_ostruct_member(k)
      end
    end

    def to_h
      @hash_table
    end
  end
end

AppConfig = Configuration::Settings.load
