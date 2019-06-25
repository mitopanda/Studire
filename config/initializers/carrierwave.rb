CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'studire-bucket'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:api_key],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_key],
      region: Rails.application.credentials.aws[:region],
      path_style: true
    }
    config.asset_host = 'https://cdn.studire.com'
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/