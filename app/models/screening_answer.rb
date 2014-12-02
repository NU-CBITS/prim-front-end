# A response from a Participant to a Screening Question.
class ScreeningAnswer < ActiveRecord::Base
  belongs_to :screening_question
end
