class WordsController < ApplicationController
  before_action :set_word, only: %i[ update_status show edit update destroy finish claim unclaim ]

  # GET /words or /words.json
  def index
    @words = Word.all
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
    respond_to do |format|
      word_hash = word_params
      if params[:commit] == "Save"
        word_hash[:status] = Word::STATUS_DRAFT
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
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: "Word was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def complete
    @word.status = "completed"
    @word.save
    respond_to do |format|
        format.html { redirect_to words_url, notice: "Marked finished" }
        format.json { render :show, status: :ok, location: @word }
    end
  end

  def unclaim
    @word.status = "unclaimed"
    @word.user_id = nil
    @word.save
    respond_to do |format|
        format.html { redirect_to words_url, notice: "Marked unclaimed" }
        format.json { render :show, status: :ok, location: @word }
    end
  end

  def claim
    @word.status = "claimed"
    @word.user_id = current_user.id
    @word.save
    respond_to do |format|
        format.html { redirect_to words_url, notice: "Something didn't hit the fan" }
        format.json { render :show, status: :ok, location: @word }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def word_params
      params.require(:word).permit(:word, :definition, :status, :user_id)
    end
end
