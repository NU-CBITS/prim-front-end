# Handles altered confirmation controller logic for devise users.
class ConfirmationsController < Devise::ConfirmationsController
  before_action :set_site

  def show
    @original_token = params[:confirmation_token]
    digested_token = Devise.token_generator.digest(self,
                                                   :confirmation_token,
                                                   params[:confirmation_token])
    if params[:confirmation_token].present?
      self.resource = resource_class.find_by_confirmation_token(digested_token)
    end

    set_flash_message(:notice, :password_create) if params[:err] == 'true'

    super if resource.nil? || resource.confirmed?
  end

  # rubocop:disable Metrics/AbcSize
  def confirm
    digested_token = Devise
                     .token_generator
                     .digest(self,
                             :confirmation_token,
                             params[resource_name][:confirmation_token])
    if params[resource_name][:confirmation_token].present?
      self.resource = resource_class
        .find_by_confirmation_token(digested_token)
    end
    if !resource.nil? &&
       resource.update_attributes(params[resource_name]
               .except(:confirmation_token)
               .permit(:email, :password, :password_confirmation)) &&
       resource.password_match?
      self.resource = resource_class
        .confirm_by_token(params[resource_name][:confirmation_token])
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
    else
      site_user = SitesUser.find_by(user_id: resource.id)
      redirect_to "/sites/#{ site_user.site_id }/users/confirmation?" \
                  'err=true&confirmation_token=' +
        params[resource_name][:confirmation_token]
    end
  end
  # rubocop:enable Metrics/AbcSize

  def create
    self.resource = send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      # rubocop:disable Metrics/LineLength
      respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
      # rubocop:enable Metrics/LineLength
    else
      respond_with(resource)
    end
  end

  def send_confirmation_instructions(attributes = {})
    if resource_class.reconfirmable
      confirmable = find_by_unconfirmed_email_with_errors(attributes)
    end
    unless confirmable.try(:persisted?)
      confirmable = resource_class.find_or_initialize_with_errors(
        resource_class.confirmation_keys,
        attributes,
        :not_found
      )
    end

    if !params[:site_id].nil? && !params[:site_id].blank?
      confirmable.site_id = params[:site_id]
    else
      confirmable.site_id = 1
    end

    confirmable.resend_confirmation_instructions if confirmable.persisted?
    confirmable
  end

  protected

  def sign_in_and_redirect(resource_or_scope, *args)
    options  = args.extract_options!
    scope    = Devise::Mapping.find_scope!(resource_or_scope)
    resource = args.last || resource_or_scope
    sign_in(scope, resource, options)
    site_user = SitesUser.find_by(user_id: resource.id)
    redirect_to '/sites/' + site_user.site_id.to_s + '/pages/home'
  end

  def after_confirmation_path_for(resource)
    site_user = SitesUser.find_by(user_id: resource.id)
    '/sites/' + site_user.site_id.to_s + '/pages/home'
  end

  def after_resending_confirmation_instructions_path_for(_resource)
    '/sites/' + params[:site_id] + '/pages/home'
  end
end
