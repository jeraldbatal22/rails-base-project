class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    if current_user.status.zero? && current_user.role == 1
      redirect_to new_user_session_path, notice: 'We send you an email once the admin approved your account. Thankyou for your patience.'
      sign_out resource
    elsif current_user.role == 1
      respond_with resource, location: stock_market_path
    else
      respond_with resource, location: user_list_path
    end
  end
end
