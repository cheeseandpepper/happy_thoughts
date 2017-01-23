AWS.config(
  :access_key_id => ENV['AWS_KEY_ID'],
  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])

S3 = AWS::S3.new
BUCKET = S3.buckets["happy-thoughts-audio"]