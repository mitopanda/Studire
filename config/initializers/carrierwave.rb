require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'studire-bucket'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key],
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