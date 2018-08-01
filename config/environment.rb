# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
def asset_exist?(path)
  if Rails.configuration.assets.compile
    Rails.application.precompiled_assets.include? path
  else
    Rails.application.assets_manifest.assets[path].present?
  end
end
