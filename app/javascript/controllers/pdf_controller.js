import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    document.addEventListener("DOMContentLoaded", () => {
      const url = this.data.get("url");
      const filename = this.data.get("filename");

      const adobeDCView = new AdobeDC.View({ clientId: "9bc183d0c24c4a3ba83c92aa05fa7433", divId: "pdf" });
      adobeDCView.previewFile({
        content: { location: { url: url } },
        metaData: { fileName: filename }
      });
    });
  }
}
