# frozen_string_literal: true

RSpec.describe RuboCop::Cop::DryRbMigration::MigrateIntToInteger do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it 'registers and refactors to Integer' do
    expect_offense(<<~RUBY)
      Types::Strict::Int
      ^^^^^^^^^^^^^^^^^^ Replace Int with Integer
    RUBY
    expect_correction(<<~RUBY)
      Types::Strict::Integer
    RUBY
  end

  it 'registers and refactors to Integer' do
    expect_offense(<<~RUBY)
      attribute :foo, type: Types::Strict::Int
                            ^^^^^^^^^^^^^^^^^^ Replace Int with Integer
    RUBY
    expect_correction(<<~RUBY)
      attribute :foo, type: Types::Strict::Integer
    RUBY
  end

  it 'registers and refactors to Integer' do
    expect_offense(<<~RUBY)
      Types::Coercible::Int
      ^^^^^^^^^^^^^^^^^^^^^ Replace Int with Integer
    RUBY
    expect_correction(<<~RUBY)
      Types::Coercible::Integer
    RUBY
  end

  it 'registers and refactors to Integer' do
    expect_offense(<<~RUBY)
      Types::Int
      ^^^^^^^^^^ Replace Int with Integer
    RUBY
    expect_correction(<<~RUBY)
      Types::Integer
    RUBY
  end

  it 'registers and refactors to Integer' do
    expect_offense(<<~RUBY)
      module Types
        include Dry.Types

        Something = Strict::Int.constructor(&:to_i)
                    ^^^^^^^^^^^ Replace Int with Integer
      end
    RUBY
    expect_correction(<<~RUBY)
      module Types
        include Dry.Types

        Something = Strict::Integer.constructor(&:to_i)
      end
    RUBY
  end

  it 'registers and refactors to Integer' do
    expect_offense(<<~RUBY)
      module Types
        include Dry.Types

        Foo = Strict::Array.of(Int)
                               ^^^ Replace Int with Integer
        Something = Int.constructor(&:to_i)
                    ^^^ Replace Int with Integer
      end
    RUBY
    expect_correction(<<~RUBY)
      module Types
        include Dry.Types

        Foo = Strict::Array.of(Integer)
        Something = Integer.constructor(&:to_i)
      end
    RUBY
  end

  it 'registers and refactors to Integer' do
    expect_offense(<<~RUBY)
      module Types
        Something = Int.constructor(&:to_i)
                    ^^^ Replace Int with Integer
      end
    RUBY
    expect_correction(<<~RUBY)
      module Types
        Something = Integer.constructor(&:to_i)
      end
    RUBY
  end

  it 'ignores modules if it is not called Types' do
    expect_no_offenses(<<~RUBY)
      module Foo
        Something = Int.constructor(&:to_i)
      end
    RUBY
  end
end
