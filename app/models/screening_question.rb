# A question within a Screening asked of a Participant.
class ScreeningQuestion < ActiveRecord::Base
  belongs_to :site
  has_many :screening_answers

  def question_type_enum
    [
      ['Text Field',    'TEXT_FIELD'],
      ['Text Area',     'TEXT_AREA'],
      ['Radio Button',  'RADIO_BUTTON'],
      ['Check Box',     'CHECK_BOX']
    ]
  end
end
