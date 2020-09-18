require_relative 'lib/rubocop/dryrbmigration/version'

Gem::Specification.new do |spec|
  spec.name          = "rubocop-dryrbmigration"
  spec.version       = RuboCop::Dryrbmigration::VERSION
  spec.authors       = ["Igor S. Morozov"]
  spec.email         = ["igor@morozov.is"]
  spec.homepage      = "https://github.com/bookmate/"

  spec.summary       = "A collection of cops to automate refactoring to dry-rb 1.x gems"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bookmate/rubocop-dry-rb-migration"
  spec.metadata["changelog_uri"] = "https://github.com/bookmate/rubocop-dry-rb-migration/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rubocop'
end

