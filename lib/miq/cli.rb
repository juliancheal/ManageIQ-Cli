module Miq
  module Cli
    include GLI::App
    extend self

    program_desc 'cli: Manage all the things'

    version Miq::VERSION

    subcommand_option_handling :normal
    arguments :strict

    desc 'Describe some switch here'
    switch [:s,:switch]

    desc 'Describe some flag here'
    default_value 'the default'
    arg_name 'The name of the argument'
    flag [:f,:flagname]

    pre do |global,command,options,args|
      # Pre logic here
      # Return true to proceed; false to abort and not call the
      # chosen command
      # Use skips_pre before a command to skip this block
      # on that command only
      true
    end

    post do |global,command,options,args|
      # Post logic here
      # Use skips_post before a command to skip this
      # block on that command only
    end

    on_error do |exception|
      # Error logic here
      # return false to skip default error handling
      true
    end

    require_relative 'commands'

    exit run(ARGV)
  end
end
