# frozen_string_literal: true

# TODO: when finished, run `rake generate_cops_documentation` to update the docs
module RuboCop
  module Cop
    module DryRbMigration
      # Replaces old-style `include Dry::Types.module` with `include Dry.Types`
      #
      # @example
      #   # bad
      #   include Dry::Types.module
      #
      #   # good
      #   include Dry.Types
      #   # good
      #   include Dry::Types()
      class IncludeDryTypes < Base
        extend AutoCorrector
        # TODO: Implement the cop in here.
        #
        # In many cases, you can use a node matcher for matching node pattern.
        # See https://github.com/rubocop-hq/rubocop-ast/blob/master/lib/rubocop/ast/node_pattern.rb
        #
        # For example
        MSG = 'Replace with include Dry.Types'

        def_node_matcher :includes_dry_types_old_style?, <<~PATTERN
          (send _ :include
            $(send
              (const
                (const nil? :Dry) :Types) :module))
        PATTERN

        def on_send(node)
          includes_dry_types_old_style?(node) do |included_method|
            add_offense(node) do |corrector|
              corrector.replace(included_method, "Dry.Types")
            end
          end
        end
      end
    end
  end
end
