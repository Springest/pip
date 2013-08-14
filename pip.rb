#!/usr/bin/env ruby
# encoding: utf-8

# Suppress net/https warnings about certificate checks
BEGIN { $VERBOSE = nil }

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require './bundle/bundler/setup'
require './lib/pip/config'
require './lib/pip/request'
require './lib/pip/alfred'

command = ARGV.shift

if command == 'filter'
  require 'alfred'
  require './lib/alfred/feedback/item'
  require './lib/alfred/feedback/file_item'

  require './lib/pip/alfred/filter'
else
# $stdout.reopen("log", "w")
# $stderr.reopen("log", "w")

  require './lib/pip/alfred/action'
end

Pip::Alfred.const_get(command.capitalize).execute(*ARGV)
