class Phrase < ApplicationRecord

  before_save :generate_audio
  before_save :update_phrase_path
  before_destroy :remove_from_s3
  
  default_scope { order(created_at: :desc) }

  def generate_audio
    TextToSpeech.new(self.text)
  end

  def update_phrase_path
    self.url = "https://happy-thoughts-audio.s3.amazonaws.com/#{file_name}.mp3"
  end

  def file_name
    self.text.gsub(" ", "_")
  end

  def remove_from_s3
    BUCKET.objects[file_name].delete
  end
end
