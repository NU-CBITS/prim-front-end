# Handles view functionality for the views of the participants and guests.
# These views are primarily for static, persisted content.
class StatusesController < ApplicationController
  before_action :authenticate_user!

  # PATCH/PUT /statuses/1
  def update
    statuses = Status.find(:all, params: { id: params[:id] })
    @status = statuses[0]
    authorize! :update, @status
    @status.name = status_params[:name]
    @status.description = status_params[:description]

    respond_to do |format|
      if @status.save
        format.json { respond_with_bip @status }
      else
        format.json { respond_with_bip @status }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def status_params
    params.require(:status)
      .permit(:id, :name, :description, :site_id, :participant_id)
  end
end
