# Handles CRUD functionality for the about page of a site.
class AboutController < ApplicationController
  before_action :authenticate_user!

  # PATCH/PUT /abouts/1
  def update
    @about = About.find(params[:id])
    authorize! :update, @about

    respond_to do |format|
      if @about.update_attributes(abouts_params)
        format.html do
          redirect_to(@about, notice: 'About page was successfully updated.')
        end
        format.json { respond_with_bip @about }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip @about }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def abouts_params
    params.require(:about).permit(:title, :content)
  end
end
