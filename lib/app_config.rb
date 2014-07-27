require 'ostruct'

module Configuration
  class Settings < OpenStruct

    def initialize(hash=nil)
      @table = {}
      @hash_table = {}

      if hash
        hash.each do |k,v|
          @table[k.to_sym] = (v.is_a?(Hash) ? self.class.new(v) : v)
          @hash_table[k.to_sym] = v

          new_ostruct_member(k)
        end
      end
    end

    def to_h
      @hash_table
    end
  end
end

config = YAML.load(ERB.new(File.read("#{Rails.root}/config/config.yml")).result)[Rails.env]
AppConfig = Kernel.const_set('AppConfig', Configuration::Settings.new(config))
