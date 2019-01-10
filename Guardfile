# frozen_string_literal: true

spec_dir = 'test/unit'

group :ruby, halt_on_fail: true do
  guard :rspec, cmd: 'bundle exec rspec --format progress', spec_paths: [spec_dir] do
    # RSpec files
    watch('test/spec_helper.rb') { spec_dir }
    watch(%r{^#{spec_dir}/.+_spec\.rb$})

    # Ruby files
    watch(%r{^lib/(.+)\.rb$}) { |m| "#{spec_dir}/#{m[1]}_spec.rb" }
  end

  guard :rubocop do
    watch(/\.rb$/)
    watch(/\.gemspec$/)
    watch('Gemfile')
    watch('Rakefile')
    watch(%r{/Vagrantfile$})
    watch('.rubocop.yml') { '.' }
  end
end
