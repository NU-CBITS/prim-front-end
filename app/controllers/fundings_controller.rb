# Handles CRUD functionality for the funding page of a site.
class FundingsController < ApplicationController
  before_action :authenticate_user!

  # PATCH/PUT /fundings/1
  def update
    @funding = Funding.find(params[:id])
    authorize! :update, @funding

    respond_to do |format|
      if @funding.update_attributes(funding_params)
        format.html do
          redirect_to(@funding,
                      notice: 'funding page was successfully updated.')
        end
        format.json { respond_with_bip @funding }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip @funding }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def funding_params
    params.require(:funding).permit(:title, :content)
  end
end
