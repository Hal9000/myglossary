module WordsHelper

  def owner?
    current_user == @word.user_id
  end

  def claimed?
    @word.status == "claimed"
  end

  def unclaimed?
    @word.status == "unclaimed"
  end

end
