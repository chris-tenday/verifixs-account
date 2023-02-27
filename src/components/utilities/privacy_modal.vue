<template>
  <div class="modal fade modal-fullscreen" id="privacyModal" tabindex="-1" role="dialog" aria-hidden="true"
    data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-6 text-center text-danger">
            <i class="fas fa-info"></i> Veuillez lire et accepter nos termes et conditions
            ci-bas !
          </h1>
          <button type="button" class="btn-close d-none" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <pdf :src="pdfSrc" @num-pages="pageCount = $event" style="display: none;" />
        <div class="modal-body">
          <pdf :src="pdfSrc" v-for="i in pageCount" :key="i" :page="i" @page-loaded="currentPage = $event"></pdf>
          <div class="container">
            <p class="text-danger fs-8">
              Est-ce que vous nous autoriser à vérifier vos informations avec d'autres
              institution?
            </p>
            <input type="radio" class="form-check-input" name="crossCheck" v-model="crossCheck" value="Oui" />
            Oui
            <input type="radio" class="form-check-input" v-model="crossCheck" name="crossCheck" value="Non" />
            Non
            <hr />
            <p class="text-danger fs-8">
              Confirmez-vous la véracité de toutes vos informations ?
            </p>
            <input type="radio" class="form-check-input" name="veracite" v-model="veracite" value="Oui" />
            Oui
            <input type="radio" class="form-check-input" name="veracite" v-model="veracite" value="Non" />
            Non
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" v-if="crossCheck === 'Oui' && veracite === 'Oui'" class="btn btn-success me-2"
            @click="onAccepted">
            J'ai lu et j'accepte.
          </button>
          <button class="btn btn-danger" @click="onRefused">Refuser</button>
        </div>
        <!-- end /.modal-body -->
      </div>
    </div>
  </div>
</template>

<script>
import pdf from "vue-pdf";
import $ from "jquery";
export default {
  props: ["pdfSrc", "modalId"],

  components: { pdf },
  data() {
    return {
      crossCheck: "",
      veracite: "",
      pageCount: 0,
      currentPage: 0,
      numPages: [],
    };
  },
  mounted() {
    this.currentPage = 0;
  },
  methods: {
    onAccepted() {
      this.$emit("onAccepted", true);

      $(".btn-close").click();
    },
    onRefused() {
      this.$emit("onRefused", false);
      this.crossCheck = "";
      this.veracite = "";
      $(".btn-close").click();
    },
  },
};

/**
 * How to use it
 *
 * data(){
 *   return {
 *      checked: "",
 *   }
 * }
 *
 *
 * HTML
 *
 * <a
    href="#privacyModal"
    data-target="#privacyModal"
    data-toggle="modal"
    class="link"
    >open modal here</a
  >
 *
 * <privacy-modal
        pdfSrc="assets/privacy-policy.pdf"
        @onAccepted="checked = $event"
        @onRefused="checked = $event"
    ></privacy-modal>
 *
**/
</script>
