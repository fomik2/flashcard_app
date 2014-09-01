require 'yaml'
module SecretKeyManager

  def self.config(path)
    YAML.load(ERB.new(File.read(File.join(Rails.root, "config/#{ path }.yml"))).result)[Rails.env]
  end

end
