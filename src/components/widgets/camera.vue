<template>
  <div style="display: flex; align-items: center; justify-content: center;">
    <div id="outer">
      <div v-if="video === null || img === null" class="btn-clear" data-aos="zoom-in" @click.prevent="$emit('onDelete')">
        <i class="bi bi-x"></i>
      </div>
      <video v-if="img === null" ref="video" class="img-fluid video" @canplay="initCapture()">
        Stream unvailable
      </video>
      <img v-else :src="img" class="img-fluid video">

      <div class="video-btns">
        <button class="btn btn-light-success me-2" @click.prevent="takePicture()">
          <i class="bi-camera-fill"></i> Capturer photo
        </button>
        <label for="uploader" class="btn btn-light-primary">
          <i class="bi bi-upload"></i> charger photo
        </label>
        <input type="file" class="d-none" id="uploader" @change="uploadImage">
      </div>
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
      img: null,
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

    console.log("captured value", this.captured);
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

    uploadImage(event) {
      let file = event.target.files[0];
      try {
        if (file.size > 1048576) {
          alert("Desolé! cette image est invalide");
          return
        }
        else {
          let reader = new FileReader();
          reader.onload = event => {
            this.img = event.target.result;
            this.$emit("onCapture", file);

          };
          reader.readAsDataURL(file);
        }
      } catch (error) {
        console.log("uploading error", error);
      }
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
#outer {
  max-width: 400px;
  max-height: 400px;
  border-radius: 5px;
  overflow: hidden;
  position: relative;
}

.video {
  position: relative;
  left: 0;
  top: 0;
  bottom: 0;
  top: 0;
}

.video-btns {
  position: absolute;
  bottom: 15px;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.btn-clear {
  height: 40px;
  width: 40px;
  border-radius: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  position: absolute;
  z-index: 999;
  top: 20px;
  right: 20px;
  background-color: #ffffffa0;
  border: none;
  box-shadow: rgba(0, 0, 0, 0.18) 0px 2px 4px;
  transition: all .3s;
  cursor: pointer;
}

.btn-clear:hover {
  background-color: rgba(247, 146, 146, 0.765);
}
</style>
