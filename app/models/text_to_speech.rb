class TextToSpeech

  def initialize(text, voice="Samantha")
    @text = text.gsub(" ", "_")
    @voice = voice
    generate!
    convert!
  end

  def generate!
    `say -v #{@voice} #{@text} -o tmp/#{@text}.aiff `
  end

  def convert!
    `ffmpeg -i tmp/#{@text}.aiff -f mp3 -acodec libmp3lame -ab 192000 -ar 44100 tmp/#{@text}.mp3`
    upload!
  end

  def upload!    
    key = File.basename("tmp/#{@text}.mp3")
    BUCKET.objects[key].write(file: "tmp/#{@text}.mp3", acl: :public_read)
    cleanup!
  end

  def cleanup!
    `rm tmp/#{@text}.aiff`
    `rm tmp/#{@text}.mp3`
  end
end