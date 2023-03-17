class Reservation < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :room, foreign_key: 'room_id'
  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :number_of_people, presence: true
  validate :check_in_not_be_before_check_out

  def check_in_not_be_before_check_out
    unless check_in.nil? == true || check_out.nil? == true
      if check_in >= check_out
        errors.add(:check_out, "がチェックイン日と同日または前日となっています。")
      end
    end
  end
end
