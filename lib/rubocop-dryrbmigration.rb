# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/dryrbmigration'
require_relative 'rubocop/dryrbmigration/version'
require_relative 'rubocop/dryrbmigration/inject'

RuboCop::Dryrbmigration::Inject.defaults!

require_relative 'rubocop/cop/dryrbmigration_cops'
