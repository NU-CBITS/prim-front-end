require 'rubygems'
require 'active_resource'

# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# Registrations controller overwrites default Devise registration methods.
class RegistrationsController < Devise::RegistrationsController
  before_action :set_site

  def create
    build_resource(sign_up_params)
    resource.site_id = @site.id
    if resource.save
      site_id = create_consent_record(resource)
      associate_site_with_user(resource, site_id)
      predefined_user_creation(resource)
      save_prim_participant(sign_up_params, resource, site_id)
      UserScreeningFlag
        .create(site_id: site_id, user_id: resource.id, active: false)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def after_inactive_sign_up_path_for(_resource)
    "/sites/#{ params[:site_id] }/pages/home"
  end

  private

  def associate_site_with_user(resource, site_id)
    SitesUser.create(user_id: resource.id, site_id: site_id)
  end

  def create_consent_record(resource)
    consent = Consent.where(site_id: params[:site_id]).first
    img_url = consent.irb_acceptance_images.try(:first).try(:image).try(:url)
    version_id = SiteConsentFormVersion
                 .where(site_id: consent.site.id)
                 .order('created_at desc')
                 .first.id
    consent_record = UserConsent.new(
      user_id: resource.id,
      site_id: consent.site.id,
      consent_header: consent.header,
      consent_body: consent.body,
      consent_footer: consent.footer,
      irb_acceptance_image_url: img_url || 'no IRB image exists for this site.',
      site_consent_form_version_id: version_id
    )
    consent_record.save
    consent.site.id
  end

  def predefined_user_creation(resource)
    yield resource if block_given?
    if resource.active_for_authentication?
      set_flash_message :notice, :signed_up if is_flashing_format?
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      if is_flashing_format?
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}"
      end
      expire_data_after_sign_in!
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
  end

  # Helper for use in before_filters where no authentication is required.
  #
  # Example:
  #   before_filter :require_no_authentication, only: :new
  def require_no_authentication
    assert_is_devise_resource!
    return unless is_navigational_format?
    no_input = devise_mapping.no_input_strategies

    authenticated = if no_input.present?
                      args = no_input.dup.push scope: resource_name
                      warden.authenticate?(*args)
                    else
                      warden.authenticated?(resource_name)
                    end

    redirect_if_already_signed_in_and_not_content_manager(authenticated)
  end

  def redirect_if_already_signed_in_and_not_content_manager(authenticated)
    return unless authenticated && (current_user.nil? ||
                                    !current_user.at_least_a_content_manager?)

    render file: "#{Rails.root}/public/403.html", status: 403, layout: true
  end

  def save_prim_participant(sign_up_params, resource, site_id)
    @participant = Participant.create
    Email.create(email: sign_up_params[:email],
                 primary: true,
                 participant_id: @participant.id)
    Phone.create(name: '',
                 number: sign_up_params[:phone],
                 primary: true,
                 participant_id: @participant.id)
    resource.external_id = @participant.external_id
    resource.save
    Status.create(name: 'Screening in Progress',
                  description: '',
                  participant_id: @participant.id,
                  final: false,
                  site_id: site_id)
    save_prim_participant_phi(sign_up_params, @participant.id)
  end

  def save_prim_participant_phi(_sign_up_params, participant_id)
    Address.create(
      street_1: params[:address][:street_1],
      city: params[:address][:city],
      state: params[:address][:state],
      zip: params[:address][:zip],
      primary: true,
      participant_id: participant_id)
  end
end
