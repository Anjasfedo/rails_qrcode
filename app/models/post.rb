class Post < ApplicationRecord
    # include Rails.application.routes.url_helpers

    has_one_attached :qrcode, dependent: :destroy

    private

    def generate_qrcode
        
    end
end
