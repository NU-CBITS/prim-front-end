# Handles CRUD functionality for the about page of a site.
class AboutController < ApplicationController
  PAGE_NAME = 'about'

  def index
    current_page(PAGE_NAME)
  end

  def reload_header
    render partial: 'pages/' + @site.template_name + '/shared/header'
  end

  # GET /abouts/1
  def show
  end

  # GET /abouts/new
  def new
    @abouts = About.new
  end

  # GET /abouts/1/edit
  def edit
  end

  # POST /abouts
  def create
    @abouts = About.new(contact_u_params)

    if @aboutssave
      redirect_to @abouts, notice: 'Contact us was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /abouts/1
  def update
    @about = About.find params[:id]

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
