require_relative 'commands/provider'

module Miq
  module Cli
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
