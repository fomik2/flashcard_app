require 'yaml'
module SecretKeyManager

  def self.config(path)
    @_config ||= YAML.load(ERB.new(File.read(File.join(Rails.root, "config/#{ path }"))).result)[Rails.env]
  end

end
