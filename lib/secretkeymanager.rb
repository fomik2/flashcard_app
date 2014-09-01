require 'yaml'
module SecretKeyManager
  CONFIG_PATH = File.join(Rails.root, 'config/aws.yml')
  SOCNET_PATH = File.join(Rails.root, 'config/socnet.yml')

  def self.config(path)
    @_config ||= YAML.load(ERB.new(File.read(File.join(Rails.root, path))).result)[Rails.env]
  end

end
