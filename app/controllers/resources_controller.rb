# Handles CRUD functionality for the resources pages.
class ResourcesController < ApplicationController
  before_action :authenticate_user!

  # PATCH/PUT /resources/1
  def update
    @resource = Resource.find(params[:id])
    authorize! :update, @resource

    respond_to do |format|
      if @resource.update_attributes(resource_params)
        format.html do
          redirect_to(@resource,
                      notice: 'Resource page was successfully updated.')
        end
        format.json { respond_with_bip @resource }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip @resource }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def resource_params
    params.require(:resource).permit(:title, :content)
  end
end
