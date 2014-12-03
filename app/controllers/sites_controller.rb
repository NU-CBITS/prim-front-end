# Handles CRUD functionality for sites management.
class SitesController < ApplicationController
  before_action :authenticate_user!

  # POST /sites
  def create
    authorize! :create, Site
    @site = Site.new(site_params)

    if @site.save
      redirect_to @site, notice: 'Site was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /sites/1
  def update
    @site = Site.find(params[:id])
    authorize! :update, @site

    respond_to do |format|
      if @site.update_attributes(site_params)
        format.html do
          redirect_to(@site, notice: 'site page was successfully updated.')
        end
        format.json { respond_with_bip @site }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip @site }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def site_params
    params.require(:site).permit(:name, :content, :about_id,
                                 :home_id, :contact_us_id, :eligibility_id,
                                 :funding_id, :resource_id, :project_id)
  end
end
