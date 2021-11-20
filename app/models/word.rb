class Word < ApplicationRecord
  Statuses = %w[unclaimed claimed in-progress draft completed hidden]
  StatusList = Statuses.map {|x| [x, x] }
  validates :status, inclusion: Statuses

  belongs_to :user, optional: true

  def printed_name
    return "" unless user.present?
    "#{user.first_name} #{user.last_name}"
  end

  def self.group_by_character
    grouping = {"0-9" => []}
    all.sort_by {|x| x.word[0].upcase }.each do |word|
      ch = word.word[0].upcase
      case ch
      when '(';        (grouping["0-9"] ||= []) << word
      when '0'..'9';   (grouping["0-9"] ||= []) << word
      when 'A'..'Z';   (grouping[ch] ||= [])    << word
      else
        # Hmm...?
      end
    end

    grouping
  end
end
