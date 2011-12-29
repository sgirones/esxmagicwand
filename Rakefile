# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "esxmagicwand"
  gem.version = File.exist?('VERSION') ? File.read('VERSION') : "0.1.0"
  gem.homepage = "http://github.com/sgirones/esxmagicwand"
  gem.license = "MIT"
  gem.summary = "VM deploy on ESX using PXE"
  gem.description = "VM deploy on ESX using PXE as install method. Add dynamic leases to DHCP server through OMAPI"
  gem.email = "salvador.girones@abiquo.com"
  gem.authors = ["sgirones"]
  gem.files = ['lib/*.rb']
  gem.executables = ['deploy_vm', 'undeploy_vm']

end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : "0.1.0"

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "test #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end