class PhrasesController < ApplicationController

  def index
    @phrase = Phrase.new
    @phrases = Phrase.all
  end

  def create
   
  end

  def destroy
    @phrase = Phrase.find(phrase_params[:id])
    if @phrase.destroy!
      redirect_to :root
    else
      render text: "oops"
    end
  end

  def record
    @phrase = Phrase.new(phrase_params)
    @phrase.source = "audio"
    
    @phrase.save!
    respond_to do |format|
      format.js
    end
  end


  private

  def phrase_params
    params.require(:phrase).permit(:id, :text, :category, :url, :source, :blob)
  end
end
