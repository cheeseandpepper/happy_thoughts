class PhrasesController < ApplicationController

  def index
    @phrase = Phrase.new
    @phrases = Phrase.all
  end

  def create
    @phrase = Phrase.find_or_initialize_by(phrase_params)
    if @phrase.save!
      redirect_to :root
    else
      flash[:notice] = @phrase.errors.full_messages
      render text: "oops"
    end
  end

  def destroy
    @phrase = Phrase.find(phrase_params[:id])
    if @phrase.destroy!
      redirect_to :root
    else
      render text: "oops"
    end
  end


  private

  def phrase_params
    params.require(:phrase).permit(:id, :text, :category, :url)
  end
end
