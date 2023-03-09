<template>
  <div class="row">
    <div class="col-md-4 mx-auto">
      <div class="card">
        <div v-if="media === ''" class="btn-clear" data-aos="zoom-in" @click.prevent="onDelete">
          <i class="bi bi-trash"></i>
        </div>
        <!-- <div v-else class="btn-clear bg-info" data-aos="zoom-in" @click.prevent="onDelete">
          <i class="bi bi-pen text-white"></i>
        </div> -->
        <div class="card-body">
          <img data-aos="zoom-in" v-if="media !== ''" :src="media" class="img-fluid rounded">
          <video data-aos="zoom-in" v-else-if="img === null && media === ''" ref="video" class="img-fluid rounded"
            @canplay="initCapture()">
            Stream unvailable
          </video>
          <img data-aos="zoom-in" v-else :src="img" class="img-fluid rounded">
        </div>
        <div class="card-footer d-flex" v-if="media === ''">
          <button class="btn btn-success btn-lg me-2 flex-fill rounded" @click.prevent="takePicture()">
            <i class="bi-camera-fill"></i>
          </button>
          <label for="uploader" class="btn btn-lg btn-primary flex-fill rounded">
            <i class="bi bi-upload"></i>
          </label>
          <input type="file" class="d-none" id="uploader" @change="uploadImage">
        </div>
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
      media: this.dataImg
    };
  },
  props: {
    captured: {
      type: String,
      default: null
    },
    dataImg: {
      type: String,
      default: ''
    }
  },
  mounted() {
    this.startCamera()
    console.log("captured value", this.dataImg);
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
    onDelete() {
      this.$nextTick(() => {
        this.media = '';
        setTimeout(() => {
          this.$emit('onDelete');
        }, 100);
        this.startCamera();
      })
      console.log("image", this.dataImg);
    },

    startCamera() {
      this.img = null;
      setTimeout(() => {
        this.video = this.$refs.video;
        this.canvas = this.$refs.canvas;
        this.startCapture();
      }, 200)
      this.$forceUpdate();
    }
  },
  watch: {
    captured(val) {
      if (!val) {
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
  left: 10px;
  right: 10px;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.btn-clear {
  height: 40px;
  width: 40px;
  border-radius: 5px;
  display: flex;
  align-items: center;
  justify-content: center;
  position: absolute;
  z-index: 999;
  top: 15px;
  right: 15px;
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
