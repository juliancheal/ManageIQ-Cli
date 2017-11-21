class Settings

  def configuration(file = "#{Dir.home}/.manageiq-cli-config.yml")
    config_file = YAML.load_file(file)
    config = {}
    return unless config_file
    symbolise(config_file)
  end

  private

  # code from https://gist.github.com/Integralist/9503099
  def symbolise(obj)
    if obj.is_a? Hash
      return obj.inject({}) do |hash, (k, v)|
        hash.tap { |h| h[k.to_sym] = symbolise(v) }
      end
    elsif obj.is_a? Array
      return obj.map { |hash| symbolise(hash) }
    end
    obj
  end
end
