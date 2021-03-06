# frozen_string_literal: true

# TODO: when finished, run `rake generate_cops_documentation` to update the docs
module RuboCop
  module Cop
    module DryRbMigration
      # This cop helps migrate from obsolete Types::Int style to newer Types::Intger
      #
      # @example
      #
      #   # bad
      #   Types::Int
      #
      #   # bad
      #   module Types
      #     include Dry.Types
      #
      #     Age = Int.constrained(gt: 0)
      #   end
      #
      #   # good
      #   Types::Integer
      #
      #   # good
      #   module Types
      #     include Dry.Types
      #
      #     Age = Integer.constrained(gt: 0)
      #   end
      class MigrateIntToInteger < Base
        extend AutoCorrector
        MSG = 'Replace Int with Integer'

        def_node_search :nominal_int, <<~PATTERN
          (const {nil? (const _ {:Strict :Coercible :JSON :Params})} :Int)
        PATTERN

        def_node_matcher :nominal_int?, <<~PATTERN
          $(const
            `(const _ :Types) :Int)
        PATTERN

        def_node_matcher :module_with_type_definition?, <<~PATTERN
          (module
            (const _ :Types) ...)
        PATTERN

        def on_const(node)
          nominal_int?(node) do |const|
            match_offense(node, const)
          end
        end

        def on_module(node)
          return unless module_with_type_definition?(node)

          nominal_int(node).each do |const|
            add_offense(const) do |corrector|
              corrector.replace(const.loc.name, "Integer")
            end
          end
        end

        private

        def match_offense(node, const)
          add_offense(node) do |corrector|
            corrector.replace(const.loc.name, "Integer")
          end
        end
      end
    end
  end
end
