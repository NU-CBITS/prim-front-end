# Handles toggling of user screening status.
class UserScreeningFlagsController < ApplicationController
  before_action :authenticate_user!

  # GET /sites/:sites_id/user/:user_id/toggle_screening
  def update
    @user_screening_flag = UserScreeningFlag.find_or_create_by(
      user_id: params[:user_id],
      site_id: params[:sites_id]
    )
    authorize! :update, @user_screening_flag
    @user_screening_flag.active = !@user_screening_flag.active
    @user_screening_flag.save

    if @user_screening_flag
      ScreeningEnabledMailer.screening_enabled_email(
        User.find(params[:user_id]),
        Site.find(params[:sites_id]), request
      ).deliver
    end

    render nothing: true
  end
end
