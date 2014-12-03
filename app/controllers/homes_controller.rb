# Handles CRUD functionality for the home page of a site.
class HomesController < ApplicationController
  before_action :authenticate_user!, except: :reload_header

  def reload_header
    render partial: 'pages/' + @site.template_name + '/shared/header'
  end

  # PATCH/PUT /homes/1
  def update
    @home = Home.find(params[:id])
    authorize! :update, @home

    respond_to do |format|
      if @home.update_attributes(homes_params)
        format.html do
          redirect_to(@home, notice: 'home page was successfully updated.')
        end
        format.json { respond_with_bip @home }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip @home }
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def homes_params
    params.require(:home).permit(:title, :content)
  end
end
