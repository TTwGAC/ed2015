ENV['SKIP_RCOV'] = 'true'
ENV['COOKIE_SECRET_TOKEN'] = "A" * 32

group 'rspec' do
  guard 'rspec', :cli => '--format documentation' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^app/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { "spec/" }
  end
end
