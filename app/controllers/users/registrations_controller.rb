class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :html, :turbo_stream

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_to do |format|
          format.html { redirect_to after_sign_up_path_for(resource) }
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update("nav", partial: "shared/nav", locals: { user: current_user }),
              turbo_stream.update("flash-messages", partial: "shared/flash", locals: { flash: flash }),
              turbo_stream.update("content", template: "welcome/index")
            ]
          end
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_to do |format|
          format.html { redirect_to after_inactive_sign_up_path_for(resource) }
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update("flash", partial: "shared/flash", locals: { flash: flash }),
              turbo_stream.update("content", template: "welcome/index")
            ]
          end
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length

      Rails.logger.error "User registration failed: #{resource.errors.full_messages}"


      respond_to do |format|
        format.html { render :new }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("content",
            render_to_string(template: "devise/registrations/new", locals: { resource: resource, resource_name: :user })
          )
        end
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :avatar)
  end
end
