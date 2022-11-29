<template>
  <div style="text-align: center; margin: 0 auto">
    <div class="position-relative">
      <video
        ref="video"
        class="video-size rounded img-fluid shadow-lg"
        @canplay="initCapture()"
      >
        Stream unvailable
      </video>
    </div>
    <div
      class="d-flex align-items-center mt-2 mb-2 justify-content-between position-relative"
    >
      <button
        class="btn btn-success btn-sm me-1 fs-7 flex-fill"
        @click.prevent="takePicture()"
      >
        <i class="fa fa-camera"></i> Capturer
      </button>
      <button
        class="btn btn-secondary btn-sm fs-7 flex-fill"
        @click.prevent="$emit('onDelete')"
      >
        <i class="fa fa-times"></i> Annuler
      </button>
    </div>
    <canvas ref="canvas" class="rounded img-fluid" style="display: none"></canvas>
  </div>
</template>

<script>
function dataURLtoFile(dataurl, filename) {
  var arr = dataurl.split(","),
    mime = arr[0].match(/:(.*?);/)[1],
    bstr = atob(arr[1]),
    n = bstr.length,
    u8arr = new Uint8Array(n);

  while (n--) {
    u8arr[n] = bstr.charCodeAt(n);
  }

  return new File([u8arr], filename, { type: mime });
}
export default {
  name: "camera",
  data() {
    return {
      video: null,
      canvas: null,
    };
  },
  props: {
    captured: {},
  },
  mounted() {
    this.video = this.$refs.video;
    this.canvas = this.$refs.canvas;
    this.startCapture();
  },
  methods: {
    startCapture() {
      navigator.mediaDevices
        .getUserMedia({ video: true, audio: false })
        .then((stream) => {
          this.video.srcObject = stream;
          this.video.play();
        })
        .catch((err) => console.log(err));
    },

    initCapture() {
      this.canvas.setAttribute("width", this.video.videoWidth);
      this.canvas.setAttribute("height", this.video.videoHeight);
    },

    takePicture() {
      let context = this.canvas.getContext("2d");
      context.drawImage(this.video, 0, 0, this.video.videoWidth, this.video.videoHeight);
      let imgPath = dataURLtoFile(this.canvas.toDataURL("image/png"), "cap-image.png");
      this.$emit("onCapture", imgPath);

      this.video.pause();
    },
  },
  watch: {
    captured() {
      if (this.captured === null) {
        this.startCapture();
      }
    },
  },
};
</script>

<style>
.video-size {
  height: 200px;
  width: 200px;
  margin: 0 auto;
}
</style>
