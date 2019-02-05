class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :medium do
    process :crop
    resize_to_fill(500, 300)
  end

  version :default do
    resize_to_fill(500, 300)
  end

  def crop
    if model.crop_x.present?
      manipulate! do |img|
        x = (model.crop_x.to_f * model.coef_w.to_f).to_i
        y = (model.crop_y.to_f * model.coef_h.to_f).to_i
        w = (model.crop_w.to_i * model.coef_w.to_f).to_i
        h = (model.crop_h.to_i * model.coef_h.to_f).to_i
        img.crop!(x,y,w,h)
      end
    end
  end
end
