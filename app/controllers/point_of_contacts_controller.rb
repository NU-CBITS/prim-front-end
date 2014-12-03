# Manage Points of Contact.
class PointOfContactsController < ApplicationController
  before_action :authenticate_user!

  # PATCH/PUT /point_of_contacts/1
  def update
    @point_of_contact = PointOfContact.find(params[:id])
    authorize! :update, @point_of_contact

    respond_to do |format|
      if @point_of_contact.update_attributes(point_of_contact_params)
        format.html do
          redirect_to(@point_of_contact,
                      notice: 'Point of contact was successfully updated.')
        end
        format.json { respond_with_bip @point_of_contact }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip @point_of_contact }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def point_of_contact_params
    params.require(:point_of_contact).permit(:title, :name, :site_id,
                                             :street_address, :city, :zip,
                                             :phone, :email)
  end
end
