RSpec.configure do |config|
  config.before(:each, type: :system) do
    Recaptcha.configuration.skip_verify_env.push('test')
  end
end
