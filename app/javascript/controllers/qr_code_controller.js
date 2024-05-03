import { Controller } from "@hotwired/stimulus";

import ZXing from "@zxing/library";

export default class extends Controller {
  connect() {
    const codeReader = new ZXing.BrowserQRCodeReader();
    codeReader
      .getVideoInputDevices()
      .then((videoInputDevices) => {
        if (videoInputDevices && videoInputDevices.length) {
          codeReader
            .decodeFromInputVideoDevice(videoInputDevices[0].deviceId, "video")
            .then((result) => {
              console.log("Found QR code:", result);
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
}
