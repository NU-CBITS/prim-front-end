# UserAdminController handles requests to update users, should only be
# accessible to super user or admins.
class UserAdminController < ApplicationController
  before_action :authenticate_user!, :set_site

  # GET /sites
  def index
    authorize! :manage, User
    @users = User.joins(:sites_users)
             .order(column_sort)
             .paginate(page: params[:page], per_page: 25)
    @users.each do |user|
      next unless user.external_id
      begin
        user.participant = Participant.find(
          :all, params: { external_id: user.external_id }
        ).first
        user.status = Status.find(
          :all, params: { participant_id: user.participant.id }
        ).first
      rescue
        logger.info 'No status or participant could be associated with user ' \
                    "id: #{ user.id }"
      end
    end

    UserAdminAudit.create(user: current_user,
                          site: @site,
                          action: 'view user admin page')

    respond_to do |format|
      format.html
      format.csv do
        if user_admin_params[:export_data] == 'phi'
          send_phi_csv
        elsif user_admin_params[:export_data] == 'screening'
          send_screening_csv
        end
      end
    end
  end

  private

  def column_sort
    @sort_column = params['sort']
    @sort_order = ''
    if sort_param_found
      @sort_order = params['order']
    else
      @sort_order = 'ASC'
    end

    case params['sort']
    when 'id'
      ordering = 'external_id ' + @sort_order
    when 'first_name'
      ordering = 'first_name ' + @sort_order
    when 'phone'
      ordering = 'phone ' + @sort_order
    when 'email'
      ordering = 'email ' + @sort_order
    when 'last_name'
      ordering = 'last_name ' + @sort_order
    when 'role'
      ordering = 'role_identifier ' + @sort_order
    else
      @sort_column = 'created_at'
      if sort_param_found
        ordering = 'created_at ' + @sort_order
      else
        @sort_order = 'DESC'
        ordering = 'created_at DESC'
      end
    end
    @sort_order = reverse_sort_order @sort_order
    @sort_icon = icon_classes @sort_order
    ordering
  end

  def icon_classes(order)
    if order == 'ASC'
      'fa fa-arrow-down'
    else
      'fa fa-arrow-up'
    end
  end

  def reverse_sort_order(sort_order)
    if sort_order == 'ASC'
      'DESC'
    else
      'ASC'
    end
  end

  def sort_param_found
    'ASC' == params['order'] || 'DESC' == params['order']
  end

  def send_phi_csv
    UserAdminAudit.create(user: current_user,
                          site: @site,
                          action: 'PHI CSV export')

    send_data(
      @users.to_csv(only: [:first_name, :last_name, :email, :phone, :created_at,
                           :future_contact, :role_identifier]),
      type: 'text/csv; charset=utf-8; header=present',
      filename: "participants-#{Time.now.strftime('%Y%m%d%H%M%S')}.csv")
  end

  def send_screening_csv
    UserAdminAudit.create(user: current_user,
                          site: @site,
                          action: 'screening data CSV export')

    screenings = Screening.all
    column_names = %w(site_id question answer external_id)

    send_data(CSV.generate do |csv|
      csv << column_names
      screenings.each do |screening|
        next unless screening.participant_id && !screening.participant_id.blank?

        participant = Participant.find(
          :all, params: { participant_id: screening.participant_id }
        )
        screening_answer_map = screening.attributes.values_at(*column_names)
        screening_answer_map[3] = participant[0].external_id
        csv << screening_answer_map
      end
    end)
  end

  def user_admin_params
    params.permit(:export_data, :page, :order, :sort)
  end
end
