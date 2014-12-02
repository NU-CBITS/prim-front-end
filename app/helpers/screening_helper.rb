# Methods for screening views.
module ScreeningHelper
  def retrieve_screenings(user_id)
    user = User.find(user_id)
    participants = Participant.find(:all,
                                    params: { external_id: user.external_id })
    participant = participants[0]
    if participant
      @screenings = Screening.find(:all,
                                   params: { participant_id: participant.id })
      @screenings.elements.sort_by do |screening|
        if screening.position
          screening.position
        else
          0
        end
      end
    else
      nil
    end
  end

  def render_screening_view(user_id)
    screening = retrieve_screenings(user_id)
    if current_user &&
       current_user.at_least_a_admin? &&
       screening &&
       screening.size > 0
      link_to 'screening',
              screening_path(user_id: user_id),
              remote: true,
              'data-toggle' => 'modal',
              'data-controls-modal' => 'modal-window',
              'data-target' => '#screening-modal-window',
              'data-backdrop' => true,
              'data-keyboard' => true,
              class: 'user-admin-link'
    else
      '---'
    end
  end
end
