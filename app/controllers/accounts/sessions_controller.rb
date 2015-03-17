class Accounts::SessionsController < Devise::SessionsController
  # before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    respond_to do |f|
      f.html {super}
      f.json {render json: {result: "fail"}, status: 400}
    end
  end

  def create
    respond_to do |f|
      f.html {super}
      f.json {
        auth_options = { scope: resource_name, recall: "#{controller_path}#new" }
        self.resource = warden.authenticate!(auth_options)
        set_flash_message(:notice, :signed_in) if is_flashing_format?
        sign_in(resource_name, resource)
        render json: {token: resource.authentication_token}
      }
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
