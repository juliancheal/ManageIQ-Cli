require_relative 'commands/provider'
require_relative 'commands/settings'

module Miq
  module Cli

    desc 'Describe settings here'
    arg_name 'Use this command to display detected settings'
    command :settings do |settings|
      settings.arg_name 'args', :multiple
      settings.desc 'Describe a flag to provider'

      settings.action do |global_options,options,args|
        settings = Settings.new
        pp settings.configuration
      end

      settings.command :create do |c|
        c.action do |global_options,options,args|
          puts "Creating settings"
        end
      end
    end

    desc 'Describe provider here'
    arg_name 'Describe arguments to provider here'
    command :provider do |provider|
      provider.arg_name 'args', :multiple
      provider.desc 'Describe a flag to provider'

      provider.command :create do |c|
        c.action do |global_options,options,args|
          provider = Provider.new
          provider.create(args)
        end
      end

      provider.command :list do |l|
        l.action do |global_options,options,args|
          provider = Provider.new
          provider.list
        end
      end

      provider.command :update do |u|
        u.action do |global_options,options,args|
          provider = Provider.new
          u.update(args)
        end
      end

      provider.command :delete do |d|
        d.action do |global_options,options,args|
          provider = Provider.new
          provider.delete(args)
        end
      end
    end
  end
end
