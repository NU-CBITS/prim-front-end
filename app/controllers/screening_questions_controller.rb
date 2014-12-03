# ScreeningQuestionsController is a CRUD for screening questions.
class ScreeningQuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_site

  # GET /sites/1/participant_screenings
  def index
    authorize! :manage, ScreeningQuestion

    @questions = ScreeningQuestion
                 .where(site_id: @site.id)
                 .order(position: :asc)
    @questions.each do |question|
      question.screening_answers = ScreeningAnswer
        .where(screening_question_id: question.id)
        .order(position: :asc)
    end

    respond_to do |format|
      format.html
    end
  end
end
