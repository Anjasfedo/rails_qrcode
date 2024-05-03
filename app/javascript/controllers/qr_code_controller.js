import { Controller } from "@hotwired/stimulus";
import Rails from "@rails/ujs";
import { BrowserQRCodeReader } from "@zxing/library";

export default class extends Controller {
  connect() {
    this.codeReader = new BrowserQRCodeReader();
    this.startVideo();
  }

  startVideo() {
    this.codeReader
      .getVideoInputDevices(undefined, "video")
      .then((result) => {
        if (result && result.length) {
          this.codeReader
            .decodeFromInputVideoDevice(result[0].deviceId, "video")
            .then((result) => {
              let qrDataFromReader = result.text;

              // Prepare a post request so it can be sent to the Rails controller
              let formData = new FormData();

              let qrCodeParams = {
                qr_data: qrDataFromReader,
              };
              console.log(qrCodeParams);
              formData.append(
                "qr_code_json_data",
                JSON.stringify(qrCodeParams)
              );

              // Send QR code data as JSON to the
              // qr_codes#create action using Rails ujs
              Rails.ajax({
                url: "/qr_codes",
                type: "post",
                data: formData,
                success: (data) => {
                  // Redirect to another page after receiving the response
                  // window.location.href = "/posts/10";
                  console.log(data);
                },
                error: (err) => {
                  console.error("Error:", err);
                },
              });
            })
            .catch((err) => {
              console.error("Error reading QR code:", err);
            });
        } else {
          console.error("No video input devices found.");
        }
      })
      .catch((err) => {
        console.error("Error accessing video input devices:", err);
      });
  }

  restartVideo() {
    // Stop the video stream
    this.codeReader.reset();
    // Restart the video stream
    this.startVideo();
  }
}
