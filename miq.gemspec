# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','miq','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'miq'
  s.version = Miq::VERSION
  s.author = 'Julian Cheal'
  s.email = 'julian.cheal@gmail.com'
  s.homepage = 'http://juliancheal.co.uk'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
  s.files = `git ls-files`.split("")

  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'miq'
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~>3')

  s.add_runtime_dependency('gli','2.17.0')
  s.add_runtime_dependency('manageiq-api-client', '~> 0.2.0')
end
