var uploaders = document.getElementsByClassName("yaDiskUploader");

var Dropzones = [];
if (uploaders.length > 0) {
  for (var i = 0; i < uploaders.length; i++) {
    uploaders[i].classList.add("dropzone_" + (i + 1));
    Dropzones[i] = new Dropzone(".dropzone_" + (i + 1), {
      url: document.location.href,
      paramName: uploaders[i].dataset.name,
      params: { action: "yandexdiskuploader_upload" },
      maxFilesize: 15,
      clickable: [".yaDiskUploader", ".dropzoneInput"],
      acceptedFiles:
        "image/jpeg,image/jpg,image/png,application/pdf,.dwg,.xlsx,.doc,.docx,.xls",
    });
    Dropzones[i].on("success", function (e, response) {
      response = JSON.parse(response);
      let link =
        "Сайт: " + window.location.hostname + " <br> Ссылка: <a href='" + response.url +"'>" + response.url +"</a>";
      document.getElementById(response.inputId).setAttribute("value", link);
    });
    Dropzones[i].on("addedfile", (file) => {
      document.getElementsByClassName("yaDiskUploader")[0].style.display =
        "block";
      document.getElementsByClassName("dropzoneInput")[0].style.display =
        "none";
    });
  }
}

if (/iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream) {
  document.getElementsByClassName("yaDiskUploader")[0].style.display = "none";
} else {
  document.getElementsByClassName("dropzoneInput")[0].style.display = "none";
}
