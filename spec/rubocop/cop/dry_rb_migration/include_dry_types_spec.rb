# frozen_string_literal: true

RSpec.describe RuboCop::Cop::DryRbMigration::IncludeDryTypes do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using old-style include' do
    expect_offense(<<~RUBY)
      include Dry::Types.module
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Replace with include Dry.Types
    RUBY
    expect_correction(<<~RUBY)
      include Dry.Types
    RUBY
  end

  it 'registers an offense when using old-style include on an explicit module' do
    expect_offense(<<~RUBY)
      Foo.include Dry::Types.module
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Replace with include Dry.Types
    RUBY
    expect_correction(<<~RUBY)
      Foo.include Dry.Types
    RUBY
  end

  it 'does not trigger on weird style' do
    expect_no_offenses(<<~RUBY)
      include Dry::Types()
    RUBY
  end

  it 'does not trigger on new style' do
    expect_no_offenses(<<~RUBY)
      include Dry.Types(default: :nominal)
    RUBY
  end
end
