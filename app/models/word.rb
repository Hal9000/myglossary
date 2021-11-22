class Word < ApplicationRecord

  STATUSES= [
    STATUS_UNCLAIMED = "unclaimed",
    STATUS_CLAIMED = "claimed",
    STATUS_IN_PROGRESS = "in-progress",
    STATUS_DRAFT = "draft",
    STATUS_COMPLETED = "completed",
    STATUS_HIDDEN = "hidden",
  ]
  validates :status, inclusion: STATUSES

  belongs_to :user, optional: true

  def can_edit_draft?(user)
    user.admin?
  end

  def can_edit?(user)
    user.admin? || owner?(user)
  end

  def owner?(user)
    user.id == user_id
  end

  def printed_name
    return "" unless user.present?
    "#{user.first_name} #{user.last_name}"
  end

  def self.group_by_character
    grouping = {"0-9" => []}
    all.sort_by {|x| x.word.upcase }.each do |word|
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
