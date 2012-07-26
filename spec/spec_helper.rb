require 'minitest/autorun'
require 'minitest/pride'

begin; require 'turn/autorun'; rescue LoadError; end

require File.expand_path('../../lib/clockblock.rb', __FILE__)

Turn.config.format = :pretty