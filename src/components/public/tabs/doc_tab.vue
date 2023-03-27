<template>
  <div>
    <go_to_tab :allownexttab="true" @gototab="goToTab"></go_to_tab>
    <div>
      <p class="text-danger animated-bounce-h">
        <span class="fa fa-info"></span> cliquez pour attacher un ou plusieurs documents supplémentaires :
      </p>

      <div class="row">
        <div class="col-lg-4 col-md-4 mb-2 mb-lg-0" v-for="fixedFile in fixedFiles" :key="fixedFile">
          <a href="#!" class="card text-center smooth-shadow-sm" :class="
            uploadedDocument.designation === fixedFile ? 'border-primary border-2' : ''
          " @click.prevent="setDesignation('')">
            <div class="card-body p-4 px-4 d-flex align-content-center align-items-center">
              <div class="icon-shape bg-light-pink rounded-circle icon-xl">
                <img src="assets/images/icon/icon-3.svg" alt="document title" />
              </div>
              <h4 class="mb-0">{{ fixedFile }}</h4>
            </div>
          </a>
        </div>
      </div>
    </div>
    <hr />
    <p class="mt-2 text-success font-weight-bold">
      {{ documents.length }} document(s) attaché(s).
    </p>
    <div v-if="documents.length > 0" class="row">
      <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 col-12" v-for="document in documents"
        :key="document.document_upload_id">
        <div class="card mb-5 border-1 border-light-success">
          <div class="card-body">
            <!-- card listing -->
            <div class="card-img">
              <a href="#!"><img :src="document.media" alt="document" class="img-fluid w-100 rounded mb-4" /></a>
            </div>
            <div class="d-flex justify-content-between align-content-center">
              <h3 class="mb-2">
                <a href="#" class="text-inherit">{{
                  document.designation.includes("Carte")
                  ? "Pièce d'identité"
                  : document.designation
                }}</a>

              </h3>
              <button :disabled="isDeletedDocLoading === document.diligence_upload_id" class="btn btn-sm btn-light-danger"
                @click="deleteDoc(document)">
                <span v-if="isDeletedDocLoading === document.diligence_upload_id"
                  class="spinner-border spinner-border-sm">
                </span>
                <span v-else class="bi bi-trash"></span></button>
            </div>
          </div>
        </div>
        <!-- /.card listing -->
      </div>
    </div>
    <div v-else style="height: 200px; display: flex; justify-content: center">
      <h2>Aucun document</h2>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="uploadModal" tabindex="-1" aria-labelledby="uploadModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="uploadModalLabel">
              <span class="fa fa-file"></span> Joindre un document supplémentaire
            </h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            <button type="button" id="uploadModalBtn" class="btn btn-primary d-none" data-bs-toggle="modal"
              data-bs-target="#uploadModal"></button>
          </div>
          <div class="modal-body">
            <div class="mb-3">
              <input class="form-control" type="text" placeholder="Veuillez saisir le libellé du document"
                v-model="uploadedDocument.designation" id="designation" />
            </div>
            <div class="mb-3">
              <input class="form-control" type="file" @change="chooseFile" id="uploadedFile" />
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" id="uploadModalDismissBtn" class="btn btn-secondary" data-bs-dismiss="modal">
              Fermer
            </button>
            <button type="button" :class="uploadLoading ? 'disabled' : ''" class="btn btn-primary"
              @click.prevent="uploadDocument">
              <span v-if="uploadLoading" class="spinner-border spinner-border-sm"></span>
              Charger le document
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import go_to_tab from "../go_to_tab";
import $ from "jquery";
export default {
  components: { go_to_tab },
  data() {
    var fixedFiles = ["Attacher un document supplémentaire"];
    return {
      filePicked: false,
      uploadedDocument: { designation: "", file: {} },
      diligenceId: 0,
      noEdit: false,
      fixedFiles: fixedFiles,
      uploadLoading: false,
      isDeletedDocLoading: ''
    };
  },
  computed: {
    documents() {
      return this.$store.state.diligenceDetails.document_uploads;
    },
    client() {
      return this.$store.getters.getClient;
    },
  },
  methods: {

    goToTab(nextTab) {
      if (nextTab) {
        this.$emit("gotonexttab");
      } else {
        this.$emit("gotoprevioustab");
      }
    },

    deleteDoc(doc) {
      console.log(JSON.stringify(doc));
      this.$swal({
        text: "Etes-vous sûr de vouloir supprimer le document sélectionné ?",
        icon: "warning",
        showConfirmButton: true,
        confirmButtonText: "Oui",
        showCancelButton: true,
        cancelButtonText: "Non",
      }).then((value) => {
        let formData = new FormData();
        formData.append("client_id", this.client.client_id);
        formData.append("diligence_upload_id", doc.diligence_upload_id)
        this.isDeletedDocLoading = doc.diligence_upload_id;
        this.$axios.post("/clients/diligences/deletedoc", formData).then((res) => {
          console.log(JSON.stringify(res.data));
          this.$emit('updateContent');
          this.isDeletedDocLoading = '';
        })
      });
    },
    openUploadModal(noEdit = false) {
      this.noEdit = noEdit;
      if (!noEdit) {
        this.uploadedDocument.designation = "";
      }
      this.$modal.show("user-add-modal");
    },
    hideUploadModal() {
      this.$modal.hide("user-add-modal");
    },
    chooseFile() {
      this.filePicked = true;
      this.uploadedDocument.file = document.getElementById("uploadedFile").files[0];
      //var previewFile = document.getElementById("filePreview");

      //previewFile.src=URL.createObjectURL(this.uploadedDocument.file);
    },
    uploadDocument() {
      if (this.uploadedDocument.designation.length < 1) {
        this.$swal({
          title: "Veuillez saisir un libéllé .",
          icon: "error",
          timer: 3000,
          toast: true,
          showConfirmButton: false,
        });

        return false;
      }
      if (this.uploadedDocument.file.name === undefined) {
        this.$swal({
          title: "Veuillez choisir un fichier",
          icon: "error",
          timer: 3000,
          toast: true,
          showConfirmButton: false,
        });
        return false;
      }

      var formData = new FormData();
      formData.append("diligence_id", this.diligenceId);
      formData.append("designation", this.uploadedDocument.designation);
      formData.append("fichier", this.uploadedDocument.file);
      formData.append("client_id", this.client.client_id);

      /**
       * Throw event pour que le parent component affiche le loader
       * */

      this.uploadLoading = true;

      this.$store.dispatch("uploadDocument", formData).then((res) => {
        this.uploadLoading = false;

        /**
         * Throw event pour que le parent component cache le loader.
         * */

        if (res.reponse !== undefined && res.reponse.status === "success") {
          $("#uploadModalDismissBtn").click();
          /**
           * refresh
           */
          var f = new FormData();
          f.append("client_id", this.client.client_id);
          f.append("diligence_id", this.diligenceId);
          this.$store.dispatch("viewDiligenceDetails", f).then(() => {
            this.isLoading = false;
            this.$swal({
              title: "Document téléchargé.",
              icon: "success",
              timer: 3000,
              toast: true,
              showConfirmButton: false,
            });
            this.hideUploadModal();
          });
        } else {
          this.$swal({
            title: "Une erreur s'est produite, réessayez plus tard.",
            icon: "error",
            timer: 3000,
            toast: true,
            showConfirmButton: false,
          });
        }
      });
    },
    setDesignation(designation) {
      this.uploadedDocument.designation = designation;
      console.log(this.uploadedDocument.designation);
      this.noEdit = true;
      $("#uploadModalBtn").click();
      //this.openUploadModal(true);
    },
  },
  mounted() {
    this.diligenceId = this.$route.params.id;
  },
  watch: {},
};
</script>
