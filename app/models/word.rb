class Word < ApplicationRecord
  Statuses = %w[unclaimed claimed in-progress draft completed hidden]
  StatusList = Statuses.map {|x| [x, x] }
  validates :status, inclusion: Statuses

  belongs_to :user, optional: true

  def printed_name
    return "" unless user.present?
    "#{user.first_name} #{user.last_name}"
  end
end
