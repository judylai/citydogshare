class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :stub_request_ip
  cattr_accessor :stubbed_request_ip

  def current_user
    @current_user ||= User.find_by_uid(session[:user_id]) if session[:user_id]
  end

  private

  def stub_request_ip
    if stubbed_ip = self.class.stubbed_request_ip
      request.instance_eval <<-EOS
        def ip
          '#{stubbed_ip}'
        end
      EOS
    end
  end
end
