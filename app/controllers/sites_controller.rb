# Handles CRUD functionality for sites management.
# @author Eric Schlange <eric.schlange@northwestern.edu>
class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  def index
    @sites = Site.all
  end

  # GET /sites/1
  def show
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  def create
    @site = Site.new(site_params)

    if @site.save
      redirect_to @site, notice: 'Site was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /sites/1
  def update
    if @site.update(site_params)
      redirect_to @site, notice: 'Site was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /sites/1
  def destroy
    @site.destroy
    redirect_to sites_url, notice: 'Site was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_site
    @site = Site.find(params[:id])
    if @site.nil?
      @site = Site.find(params[:site_id])
    end
  end

  # Only allow a trusted parameter "white list" through.
  def site_params
    params.require(:site).permit(:name, :description, :about_id,
                                 :home_id, :contact_us_id, :eligibility_id,
                                 :funding_id, :resource_id)
  end
end