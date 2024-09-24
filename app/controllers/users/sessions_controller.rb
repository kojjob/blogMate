class Users::SessionsController < Devise::SessionsController
  respond_to :html, :turbo_stream

  # Skip verification for signed out users
  skip_before_action :verify_signed_out_user, only: [ :destroy ]

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("nav", partial: "shared/nav"),
          turbo_stream.update("flash-messages", partial: "shared/flash", locals: { flash: flash }),
          turbo_stream.replace("content", template: "welcome/index")
        ]
      end
      format.html { redirect_to after_sign_in_path_for(resource) }
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("nav", partial: "shared/nav"),
          turbo_stream.update("flash-messages", partial: "shared/flash", locals: { flash: flash }),
          turbo_stream.replace("content", template: "welcome/index")
        ]
      end
      format.html { redirect_to after_sign_out_path_for(resource_name) }
      format.all { head :no_content }
    end
  end
end
