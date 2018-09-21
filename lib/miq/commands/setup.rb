require 'manageiq-api-client'

class Setup

  def initialize
    @conf = load_configuration
    @conf
  end

  def create(file)
    save_configuration(file)
  end

  private

  def load_configuration(file = "config/manageiq-cli-config.tmpl.yml")
    return unless config_file = YAML.load_file(file)
    config_file
  end

  def save_configuration(file)
    file = file.first
    File.open(file, "w") do |f|
      f.write(@conf.to_yaml)
    end
  end
end
