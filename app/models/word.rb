class Word < ApplicationRecord
  Statuses = %w[unclaimed claimed in-progress draft completed hidden]
  StatusList = Statuses.map {|x| [x, x] }
  validates :status, inclusion: Statuses
end
