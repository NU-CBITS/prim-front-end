# Handles CRUD functionality for the eligibility page of a site.
class EligibilitiesController < ApplicationController
  # PATCH/PUT /eligibilities/1
  def update
    @eligibility = Eligibility.find(params[:id])

    respond_to do |format|
      if @eligibility.update_attributes(eligibility_params)
        format.html do
          redirect_to(@eligibility,
                      notice: 'About page was successfully updated.')
        end
        format.json { respond_with_bip @eligibility }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip @eligibility }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def eligibility_params
    params.require(:eligibility).permit(:title, :content)
  end
end
