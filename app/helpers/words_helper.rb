module WordsHelper

  def owner?
    current_user == @word.user_id
  end

  def claimed?
    @word.status == "claimed"
  end

  def unclaimed?
    @word.status == Word::STATUS_UNCLAIMED
  end

  WORD_MAP = {

  }

  def index_action_path_data(word, user)
    lookup = index_action_path_lookup(word, user)

    lookup[word.status]
  end

  def index_action_path_lookup(word, user)
    @icon_action_path_lookup = if user.admin?
      {
        Word::STATUS_UNCLAIMED => { icon_path: :claim_word_path, icon_method: :post, link_path: :edit_word_path, link_method: :get },
        Word::STATUS_CLAIMED => { path: :edit_word_path, method: :get, link_path: :word_path, link_method: :get },
      }
    elsif word.owner?(user)
      {
        Word::STATUS_UNCLAIMED => { icon_path: nil, method: :get, link_path: :word_path, link_method: :get },
        Word::STATUS_CLAIMED => { icon_path: :edit_word_path, icon_method: :get, link_path: :word_path, link_method: :get },
      }
    else # Random User
      {
        Word::STATUS_UNCLAIMED => { icon_path: :claim_word_path, icon_method: :post, link_path: :word_path, link_method: :get },
        Word::STATUS_CLAIMED => { icon_path: :edit_word_path, icon_method: :get, link_path: :word_path, link_method: :get },
      }
    end
  end

end
