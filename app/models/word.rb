class Word < ApplicationRecord
  Statuses = %w[unclaimed claimed in-progress draft completed hidden]
  StatusList = Statuses.map {|x| [x, x] }
  validates :status, inclusion: Statuses
  has_many :users
  
  def printed_name
    return "" if users.empty?
    user = users.first
    user.first_name + " " + user.last_name
  end
end
