# Handles CRUD functionality for the 'contact us' page of a site.
class ContactUsPagesController < ApplicationController
  # PATCH/PUT /contact_us_pages/1
  def update
    @contact_us_page = ContactUsPage.find(params[:id])

    respond_to do |format|
      if @contact_us_page.update_attributes(contact_us_page_params)
        format.html do
          redirect_to(@contact_us_page,
                      notice: 'Contact us page was successfully updated.')
        end
        format.json { respond_with_bip @contact_us_page }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip @contact_us_page }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def contact_us_page_params
    params.require(:contact_us_page).permit(:title, :content)
  end
end
