# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update] # rubocop:disable Rails/LexicallyScopedActionFilter

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      if Rails.env.production? && !verify_recaptcha(action: 'registration', minimum_score: 0.5)
        self.resource = resource_class.new sign_up_params
        flash.now[:recaptcha_error] = 'reCAPTCHAの検証に失敗しました。もう一度お試しください。'
        respond_with_navigational(resource) { render :new }
        return
      end
      super
    end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    def destroy
      redirect_to edit_user_registration_path, alert: 'アカウントの削除は許可されていません'
    end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end

    def after_update_path_for(_resource)
      groups_path
    end
  end
end
