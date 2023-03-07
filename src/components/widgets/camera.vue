<template>
  <div style="display: flex; align-items: center; justify-content: center;">
    <div id="outer">
      <video ref="video" class="img-fluid video" @canplay="initCapture()">
        Stream unvailable
      </video>

      <div class="video-btns">
        <button class="btn btn-light-success me-2" @click.prevent="takePicture()">
          <i class="bi-camera-fill"></i> Capturer photo
        </button>
        <button class="btn btn-light-primary" @click.prevent="$emit('onDelete')">
          <i class="bi bi-upload"></i> charger photo
        </button>
      </div>
    </div>

    <canvas ref="canvas" class="rounded img-fluid" style="display: none"></canvas>
  </div>
</template>

<script>

function Sound(source, volume, loop) {
  this.source = source;
  this.volume = volume;
  this.loop = loop;
  var son;
  this.son = son;
  this.finish = false;
  this.stop = function () {
    document.body.removeChild(this.son);
  }
  this.start = function () {
    if (this.finish) return false;
    this.son = document.createElement("embed");
    this.son.setAttribute("src", this.source);
    this.son.setAttribute("hidden", "true");
    this.son.setAttribute("volume", this.volume);
    this.son.setAttribute("autostart", "true");
    this.son.setAttribute("loop", this.loop);
    document.body.appendChild(this.son);
  }
  this.remove = function () {
    document.body.removeChild(this.son);
    this.finish = true;
  }
  this.init = function (volume, loop) {
    this.finish = false;
    this.volume = volume;
    this.loop = loop;
  }
}
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
      var s = new Sound("assets/audios/sound.mp3", 100, false);
      s.start();
      context.drawImage(this.video, 0, 0, this.video.videoWidth, this.video.videoHeight);
      let imgPath = dataURLtoFile(this.canvas.toDataURL("image/png"), "cap-image.png");
      this.$emit("onCapture", imgPath);
      this.video.pause();
      s.stop();
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
  width: 400px;
  height: 400px;
  border-radius: 10px;
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
  bottom: 80px;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
