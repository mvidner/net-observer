require 'rake'		# emacs: -*- ruby -*-
require 'rdoc/task'
require 'rake/testtask'


task :default => "test"

namespace :test do
  desc "Test all classes"
  Rake::TestTask.new(:all) do |t|
    t.libs << "test"
    t.pattern = 'test/*_test.rb'
    t.verbose = true
  end 
end

desc "Run all the unit tests"
task :test do
  Rake::Task["test:all"].invoke
end

desc 'Generate documentation.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'net-observer'
  rdoc.options << '--line-numbers' << "--main" << "README.rdoc"
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = %q{net_observer}
    gem.summary     = %q{Gem allow easy observation of network communication in ruby via ruby network library}
    gem.description = %q{Gem allow easy observation of network communication in ruby via ruby network library. It is useful to log low level information for abstract layers like ActiveResource. It contain predefined observers for logging and to remember last request.}

    gem.files        = FileList['[A-Z]*', 'lib/**/*.rb', 'test/**/*.rb']
    gem.require_path = 'lib'
    gem.test_files   = Dir[*['test/**/*_test.rb']]

    gem.has_rdoc         = true
    gem.extra_rdoc_files = ["README.md"]
    gem.rdoc_options = ['--line-numbers', "--main", "README.md"]
    gem.license = "MIT"

    gem.authors = ["Flavio Castelli", "Josef Reidinger", "Martin Vidner"]
    gem.email   = %w(flavio@castelli.name jreidinger@suse.cz mvidner@suse.cz)
    gem.homepage = "http://github.com/mvidner/net-observer"
    
    gem.add_development_dependency "fakeweb"
    gem.add_development_dependency "yard"

    gem.platform = Gem::Platform::RUBY
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

desc "Clean files generated by rake tasks"
task :clobber => [:clobber_rdoc]

begin
	require "yard"
	YARD::Rake::YardocTask.new do |t|
  	t.files   = ['lib/**/*.rb']   # optional
  	t.options = [] # optional
	end
rescue LoadError
  puts "YARD not available. Install it with: gem install yard"
end
