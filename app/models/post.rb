class Post < ApplicationRecord
  has_one_attached :qrcode, dependent: :destroy

  before_create :generate_qrcode
  before_update :regenerate_qrcode, if: :title_changed?

  private

  def generate_qrcode
    generate_and_attach_qrcode if title.present?
  end

  def regenerate_qrcode
    qrcode.purge if qrcode.attached?
    generate_and_attach_qrcode
  end

  def generate_and_attach_qrcode
    require 'rqrcode'

    qrcode_data = RQRCode::QRCode.new(title)

    png = qrcode_data.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )

    qrcode.attach(
      io: StringIO.new(png.to_s),
      filename: 'qrcode.png',
      content_type: 'image/png'
    )
  end
end
