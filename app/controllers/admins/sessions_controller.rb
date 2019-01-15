# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController
    include Accessible
    skip_before_action :check_user, only: :destroy
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   superCoverage report generated for RSpec to /home/juliette/Documents/THP_NEXT/mvc_exercise/coverage. 250 / 250 LOC (100.0%) covered.

    # end

    # DELETE /resource/sign_out
    def destroy
      super
    end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
