# IrbAcceptanceImagesController handles requests to update or create new
# viewable images.
class IrbAcceptanceImagesController < ApplicationController
  before_action :set_site

  protect_from_forgery except: :create

  def show
  end

  def new
  end

  def create
    respond_to do |format|
      irb_acceptance_image = IrbAcceptanceImage.new(irb_acceptance_image_params)
      irb_acceptance_image.image_file_name =
        Time.now.strftime('%Y_%m_%d_%H%M%S') +
        irb_acceptance_image.image_file_name
      irb_acceptance_image.save
      SiteConsentFormVersion.create(site: irb_acceptance_image.site)

      format.html { redirect_to :back }
      format.js
      format.json { head :no_content }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      consent_id = params[:irb_acceptance_image][:consent_id]
      irb_acceptance_image = IrbAcceptanceImage
                             .where(consent_id: consent_id)
                             .first
      irb_acceptance_image.image = params[:irb_acceptance_image][:image]
      irb_acceptance_image.image_file_name =
        Time.now.strftime('%Y_%m_%d_%H%M%S') +
        irb_acceptance_image.image_file_name
      irb_acceptance_image.save
      format.html { redirect_to :back }
      format.js
      format.json { head :no_content }
    end
  end

  private

  def irb_acceptance_image_params
    params.require(:irb_acceptance_image)
      .permit(:image, :position, :site_id, :consent_id)
  end
end
