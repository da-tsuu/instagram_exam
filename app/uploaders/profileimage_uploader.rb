class ProfileimageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_limit => [640, 480]
  process :convert => 'jpg'
  version :thumb do
    process :resize_to_limit => [300, 300]
  end
  version :thumb100 do
    process :resize_to_limit => [100, 100]
  end
  version :thumb30 do
    process :resize_to_limit => [30, 30]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
