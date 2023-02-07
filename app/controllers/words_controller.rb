class WordsController < ApplicationController
  before_action :set_word, only: %i[ update_status show edit update destroy finish claim unclaim ]

  # GET /words or /words.json
  def index
    @words = Word.all

    respond_to do |format|
      format.html
      format.text do
        @words = @words.all

        send_data @words.to_txt, filename: "words-#{Date.today}.txt"
      end
    end
  end

  # GET /words/1 or /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words or /words.json
  def create
    return redirect_with_error("You cannot do that", words_url) unless @word.can_create?(current_user)

    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: "Word was successfully created." }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1 or /words/1.json
  def update
    return redirect_with_error("You cannot do that", words_url) unless @word.can_update?(current_user)

    respond_to do |format|
      word_hash = word_params
      if params[:commit].downcase.include?("save")
        word_hash[:status] = Word::STATUS_DRAFT
      elsif params[:commit].downcase.include?("unclaim")
        word_hash[:status] = Word::STATUS_UNCLAIMED
      elsif params[:commit].downcase.include?("claim")
        word_hash[:status] = Word::STATUS_CLAIMED
      else
        word_hash[:status] = Word::STATUS_IN_PROGRESS if @word.status == Word::STATUS_CLAIMED
      end

      if @word.update(word_hash)
        format.html { redirect_to words_path, notice: "Word was successfully updated." }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1 or /words/1.json
  def destroy
    return redirect_with_error("You cannot do that", words_url) unless @word.can_destroy?(current_user)

    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: "Word was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def complete
    return redirect_with_error("You cannot do that", words_url) unless @word.can_complete?(current_user)

    @word.status = "completed"
    @word.save
    respond_to do |format|
        format.html { redirect_to words_url, notice: "Marked finished" }
        format.json { render :show, status: :ok, location: @word }
    end
  end

  def unclaim
    return redirect_with_error("You cannot do that", words_url) unless @word.can_unclaim?(current_user)
    @word.status = "unclaimed"
    @word.save
    respond_to do |format|
      format.html { redirect_to words_url, notice: "Marked unclaimed" }
      format.json { render :show, status: :ok, location: @word }
    end
  end

  def claim
    return redirect_with_error("You cannot do that", words_url) unless @word.can_claim?(current_user)
    fail

    @word.status = "claimed"
    @word.user_id = current_user.id
    @word.save
    respond_to do |format|
      format.html { redirect_to words_url }  # , notice: "Something didn't hit the fan" }
      format.json { render :show, status: :ok, location: @word }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    def permitted_params_non_admin
      [:definition, :status, :notes]
    end

    def permitted_params_admin
      [:word, :definition, :status, :user_id, :notes]
    end

    def permitted_params
      current_user.admin? ? permitted_params_admin : permitted_params_non_admin
    end

    # Only allow a list of trusted parameters through.
    def word_params
      params.require(:word).permit(permitted_params)
    end
end
