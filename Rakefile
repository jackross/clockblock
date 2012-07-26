#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/clockblock'
  t.test_files = FileList['spec/lib/clockblock/*_spec.rb']
  t.verbose = true
end

task :default => :test