# Manage Consents.
class ConsentController < ApplicationController
  # PATCH/PUT /consent/1
  def update
    @consent = Consent.find params[:id]

    respond_to do |format|
      if @consent.update_attributes(consent_params)
        SiteConsentFormVersion.create(site: @consent.site)
        format.html do
          redirect_to(@consent, notice: 'Consent was successfully updated.')
        end
        format.json { respond_with_bip @consent }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip @consent }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def consent_params
    params.require(:consent).permit(:header, :body, :footer)
  end
end
