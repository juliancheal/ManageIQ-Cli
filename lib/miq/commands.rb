require_relative 'commands/provider'

module Miq
  module Cli
    desc 'Describe create here'
    arg_name 'Describe arguments to create here'
    command :create do |create|
      create.arg_name 'provider_name', :multiple
      create.desc 'Describe a flag to create'

      create.command :provider do |provider|
        provider.action do |global_options,options,args|
          provider = Provider.new
          provider.create(args)
        end
      end
    end

    desc 'Describe list here'
    arg_name 'Describe arguments to list here'
    command :list do |list|
      list.arg_name 'provider_name', :multiple
      list.desc 'Describe a flag to create'

      list.command :provider do |provider|
        provider.action do |global_options,options,args|
          provider = Provider.new
          provider.list
        end
      end
    end

    desc 'Describe update here'
    arg_name 'Describe arguments to update here'
    command :update do |update|
      update.arg_name 'provider_name', :multiple
      update.desc 'Describe a flag to create'

      update.command :provider do |provider|
        provider.action do |global_options,options,args|
          provider = Provider.new
          provider.update(args)
        end
      end
    end

    desc 'Describe delete here'
    arg_name 'Describe arguments to delete here'
    command :delete do |delete|
      delete.arg_name 'provider_name', :multiple
      delete.desc 'Describe a flag to create'

      delete.command :provider do |provider|
        provider.action do |global_options,options,args|
          provider = Provider.new
          provider.delete(args)
        end
      end
    end
  end
end
