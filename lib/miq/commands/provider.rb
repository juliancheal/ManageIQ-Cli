require 'manageiq-api-client'

class Provider

  def initialize
    @conf = configuration

    miq_host     = @conf.first[:miq_host]
    miq_user     = @conf.first[:miq_user]
    miq_password = @conf.first[:miq_password]

    @miq = ManageIQ::API::Client.new(
      :url      => miq_host,
      :user     => miq_user,
      :password => miq_password
    )
  end

  def create(provider)
    type, keys = parse(provider)

    conf = @conf.find {|c| c[:provider] == type}

    type     = types(type)
    region   = (keys[:region]   || conf[:region])
    name     = (keys[:name]     || conf[:name])
    userid   = (keys[:userid]   || conf[:credentials][:userid])
    password = (keys[:password] || conf[:credentials][:password])

    tenant_id    = (keys[:tenant_id]    || conf[:tenant_id])
    subscription = (keys[:subscription] || conf[:subscription])

    case type
    when "ManageIQ::Providers::Amazon::CloudManager"
      @miq.providers.create({
        :type => type,
        :provider_region => region,
        :name => name,
        :credentials => {
          :userid => userid,
          :password => password
         }
       })
     when "ManageIQ::Providers::Azure::CloudManager"
       @miq.providers.create({
         :type => type,
         :provider_region => region,
         :name => name,
         :tenant_id => tenant_id,
         :subscription => subscription,
         :credentials => {
           :userid => userid,
           :password => password
          }
        })
    end
  end

  def list
    @miq.providers.each do |provider|
      pp provider
    end
  end

  def update(provider)
  end

  def delete(provider)
    @miq.providers.delete({:id => provider.first})
  end

  private

  def parse(values)
    provider_type = values.shift
    keys          = values
    key_values    = {}

    keys.each do |key|
      k,v = key.split("=")
      key_values[k.to_sym] = v
    end

    [provider_type, key_values]
  end

  def types(type)
    provider_types = {:amazon => "ManageIQ::Providers::Amazon::CloudManager",
                      :azure => "ManageIQ::Providers::Azure::CloudManager",
                      :google => "ManageIQ::Providers::Google::CloudManager",
                      :hawkular => "ManageIQ::Providers::Hawkular::MiddlewareManager",
                      :kubernetes => "ManageIQ::Providers::Kubernetes::ContainerManager",
                      :microsoft => "ManageIQ::Providers::Microsoft::InfraManager",
                      :openshift => "ManageIQ::Providers::Openshift::ContainerManager",
                      :openstack_cloud => "ManageIQ::Providers::Openstack::CloudManager",
                      :openstack_infra => "ManageIQ::Providers::Openstack::InfraManager",
                      :redhat => "ManageIQ::Providers::Redhat::InfraManager",
                      :vmware_cloud => "ManageIQ::Providers::Vmware::CloudManager",
                      :vmware_infra => "ManageIQ::Providers::Vmware::InfraManager",}
    provider_types[type.to_sym]
  end

  def configuration(file = "#{Dir.home}/.manageiq-cli-config.yml")
    config_file = YAML.load_file(file)
    config = {}
    return unless config_file
    symbolise(config_file)
  end

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
