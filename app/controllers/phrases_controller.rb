require 'base64'

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

  def record
    @phrase = Phrase.new(phrase_params)
    @phrase.source = "audio"
    @phrase.text ||= "audio_#{Time.now.to_s}"
    
    #save_path = Rails.root.join("tmp")
    
    # unless File.exists?(save_path)
    #   Dir::mkdir(Rails.root.join("tmp"))
    # end
    
    #data       = phrase_params[:blob]
    #audio_data = Base64.decode64(data['data:audio/ogg;base64,'.length .. -1])
    #tempfile = Tempfile.new(@phrase.text)
    ##tempfile.write audio_data
    #tempfile.rewind
    #tempfile.close
    # file = File.open(save_path + "_audio", 'wb') do |f| 
    #   f.write audio_data 
    #   f.close
    # end
    #UploadToS3.new(file: file)
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
