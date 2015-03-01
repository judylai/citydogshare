OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '516642671808581', '48478e348cb9dab288c675bc7a7f70a1', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
