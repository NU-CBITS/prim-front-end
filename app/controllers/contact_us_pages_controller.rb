# Handles CRUD functionality for the 'contact us' page of a site.
class ContactUsPagesController < ApplicationController
  before_action :set_contact_us_page, only: [:show, :edit, :update, :destroy]

  # GET /contact_us_pages
  def index
    @contact_us_pages = ContactUsPage.all
  end

  # GET /contact_us_pages/1
  def show
  end

  # GET /contact_us_pages/new
  def new
    @contact_us_page = ContactUsPage.new
  end

  # GET /contact_us_pages/1/edit
  def edit
  end

  # POST /contact_us_pages
  def create
    @contact_us_page = ContactUsPage.new(contact_us_page_params)

    if @contact_us_page.save
      redirect_to @contact_us_page,
                  notice: 'Contact us was successfully created.'
    else
      render action: 'new'
    end
  end

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

  # Use callbacks to share common setup or constraints between actions.
  def set_contact_us_page
    @contact_us_page = ContactUsPage.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def contact_us_page_params
    params.require(:contact_us_page).permit(:title, :content)
  end
end
