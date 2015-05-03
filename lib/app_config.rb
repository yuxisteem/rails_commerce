require 'ostruct'

module Ecomm
  module Configuration
    extend self

    CONFIG_PATH = Rails.root.join('config', 'config.yml')

    def load
      processed = YAML.load(ERB.new(File.read(CONFIG_PATH)).result)

      Hashie::Mash.new(processed['all'].merge(processed[Rails.env]))
    end
  end
end

AppConfig = Ecomm::Configuration.load
