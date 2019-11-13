class ProfileimageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick


  storage :file

  process :resize_to_limit => [200, 200]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
