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
    claim_edit = { icon_path: :claim_word_path, icon_method: :post,
                   link_path: :edit_word_path,  link_method: :get }
    edit_edit  = { icon_path: :edit_word_path,  icon_method: :get,
                   link_path: :edit_word_path,  link_method: :get }
    edit_show  = { icon_path: :edit_word_path,  icon_method: :get,
                   link_path: :word_path,       link_method: :get }
    no_owner   = { icon_path: nil,              icon_method: :get,
                   link_path: :word_path,       link_method: :get },
    claim_show = { icon_path: :claim_word_path, icon_method: :post,
                   link_path: :word_path,       link_method: :get }
    show_show  = { icon_path: :word_path,       icon_method: :get,
                   link_path: :word_path,       link_method: :get }

    @icon_action_path_lookup = if user.admin?
      {
        Word::STATUS_UNCLAIMED   => claim_edit,
        Word::STATUS_CLAIMED     => edit_edit,
        Word::STATUS_IN_PROGRESS => edit_edit,
        Word::STATUS_DRAFT       => edit_edit,
        Word::STATUS_COMPLETED   => edit_edit
      }
    elsif word.owner?(user)
      {
        Word::STATUS_UNCLAIMED   => no_owner,
        Word::STATUS_CLAIMED     => edit_edit,
        Word::STATUS_IN_PROGRESS => edit_edit,
        Word::STATUS_DRAFT       => edit_show,
        Word::STATUS_COMPLETED   => show_show
      }
    else # Random User
      {
        Word::STATUS_UNCLAIMED   => claim_show,
        Word::STATUS_CLAIMED     => show_show,
        Word::STATUS_IN_PROGRESS => show_show,
        Word::STATUS_DRAFT       => show_show,
        Word::STATUS_COMPLETED   => show_show
      }
    end
  end

  def edit_action_data(word, user)
    lookup = edit_action_data_lookup(word, user)
    lookup[word.status]
  end

  def edit_action_data_lookup(word, user)
    admin_usual = [:update, :cancel, :destroy, :hide]
    @icon_action_path_lookup = if user.admin?
      {
        Word::STATUS_UNCLAIMED   => [:claim]   + admin_usual,
        Word::STATUS_CLAIMED     => [:unclaim] + admin_usual,
        Word::STATUS_IN_PROGRESS => [:unclaim] + admin_usual,
        Word::STATUS_DRAFT       => [:save]    + admin_usual,     # rename save??
        Word::STATUS_COMPLETED   => admin_usual
      }
    elsif word.owner?(user)
      {
        Word::STATUS_UNCLAIMED   => [],
        Word::STATUS_CLAIMED     => [:update, :cancel, :unclaim],
        Word::STATUS_IN_PROGRESS => [:update, :cancel, :unclaim, :save],  # rename save??
        Word::STATUS_DRAFT       => [],
        Word::STATUS_COMPLETED   => []
      }
    else # Random User
      {
        Word::STATUS_UNCLAIMED   => [],
        Word::STATUS_CLAIMED     => [],
        Word::STATUS_IN_PROGRESS => [],
        Word::STATUS_DRAFT       => [],
        Word::STATUS_COMPLETED   => []
      }
    end
  end

end
