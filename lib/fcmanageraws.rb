require 'yaml'
module FCManagerAWS
  CONFIG_PATH = File.join(Rails.root, 'config/aws.yml')
  SOCNET_PATH = File.join(Rails.root, 'config/socnet.yml')

  def self.config
    @_config ||= YAML.load(ERB.new(File.read(CONFIG_PATH)).result)[Rails.env]
  end

  def self.socnet
    @_config ||= YAML.load(ERB.new(File.read(SOCNET_PATH)).result)[Rails.env]
  end

end