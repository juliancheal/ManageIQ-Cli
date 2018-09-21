require_relative 'commands/provider'
require_relative 'commands/setup'

module Miq
  module Cli
    desc 'create, list, update, delete'
    command :provider do |provider|

      provider.arg_name 'args', :multiple
      provider.desc 'Create a new provider'
      provider.command :create do |c|
        c.action do |global_options,options,args|
          provider = Provider.new
          provider.create(args)
        end
      end

      provider.desc 'List existing providers'
      provider.command :list do |l|
        l.action do |global_options,options,args|
          provider = Provider.new
          provider.list
        end
      end

      provider.desc 'Update an existing provider'
      provider.command :update do |u|
        u.action do |global_options,options,args|
          provider = Provider.new
          u.update(args)
        end
      end

      provider.desc 'Delete an existing provider'
      provider.command :delete do |d|
        d.action do |global_options,options,args|
          provider = Provider.new
          provider.delete(args)
        end
      end
    end
    desc 'setup'
    command :setup do |setup|
      setup.arg_name 'args', :multiple
      setup.desc 'Creates configuration file'
      setup.command :create do |c|
        c.action do |global_options,options,args|
          setup = Setup.new
          setup.create(args)
        end
      end
    end
  end
end
