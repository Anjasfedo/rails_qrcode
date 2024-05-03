class QrCodesController < ApplicationController
  def create
    qr_code_params = JSON.parse(params[:qr_code_json_data])

    # Process the QR code data as needed
    qr_data = qr_code_params['qr_data']

    puts qr_data

    respond_to do |format|
      format.json { render json: { message: 'QR code data received successfully', qr_data: qr_data }, status: :created }
    end
  end

  def show

  end

  private

  # Only allow a list of trusted parameters through.
  def qr_code_params
    params.permit(:qr_code_json_data)
  end
end
