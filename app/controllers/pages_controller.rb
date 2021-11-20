class PagesController < ApplicationController
  def home
    redirect_to words_path
  end
end
