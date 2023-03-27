<template>
  <div class="py-10">
    <loader :data-loaded="dataLoaded" height="300">
      <div class="container" v-if="diligenceTypes.length > 0">
        <div class="row">
          <div class="offset-xl-2 col-xl-8 offset-lg-2 col-lg-8 col-md-12 col-sm-12 col-12">
            <div class="mb-10 text-center">
              <!-- section title start-->
              <h1 class="mb-2">Bienvenu(e) {{ client.nom }}, veuillez choisir une diligence !</h1>
              <p class="lead px-lg-8 fs-6 text-danger">
                Vous devrez suivre minutieusement toutes les étapes pour postuler!
              </p>
            </div>
            <!-- /.section title start-->
          </div>
        </div>
        <div>
          <div class="row">
            <div v-for="diligenceType in diligenceTypes" :key="diligenceType.diligence_type_id"
              class="col-xl-3 col-lg-3 col-md-6 col-sm-3 col-12 mb-lg-3">
              <div class="card text-center smooth-shadow-sm border-0 mb-4 mb-lg-0">
                <div class="card-body">
                  <div class="mb-4 mt-4">
                    <a href="javascript:void(0)">
                      <img src="assets/images/icon/icon-2.svg" alt="icon" class="icon icon-xxl" /></a>
                  </div>

                  <div class="lh-1 mb-2">
                    <h3 class="mb-2">
                      {{
                        diligenceType.type
                      }}
                    </h3>
                    <p style="font-family: Corbel; font-size: 15px;">{{diligenceType.description}}</p>
                  </div>
                  <!-- <a tabindex="0" class="btn btn-link btn-sm" role="button" data-bs-toggle="popover"
                    data-bs-trigger="focus" title=""
                    data-bs-content="And here's some amazing content. It's very engaging. Right?"
                    data-bs-original-title="Dismissible popover">read more...</a> -->
                  <div class="d-grid mt-5">
                    <button data-bs-target="#myModal1" data-bs-toggle="modal" class="btn btn-primary btn-sm"
                      @click="setChoosenType(diligenceType)">
                      Postuler
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="container" v-else>
        <div class="row">
          <div class="offset-xl-2 col-xl-8 offset-lg-2 col-lg-8 col-md-12 col-sm-12 col-12">
            <div class="mb-10 text-center">
              <!-- section title start-->
              <h1 class="mb-2">
                Cher client notre service est indisponible pour l'instant !
              </h1>
              <p class="lead px-lg-8 fs-6 text-danger">
                Veuillez réessayer ultérieurement !
              </p>
            </div>
            <!-- /.section title start-->
          </div>
        </div>
      </div>
    </loader>

    <!--Modal-->
    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" style="display: none" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title">
              <img src="assets/images/icon/icon-2.svg" alt="icon" class="icon icon-sm me-2" />
              {{ choosenType.type }}
            </h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="row">
              <p class='fw-bold'>{{choosenType.description}}</p>
              <form name="formval2" class="form-horizontal loan-eligibility-form" id="postulat-form">
                <div class="mb-3">
                  <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Motif : </span>
                      </div>
                      <input type="text" class="form-control input-sm" id="loan" name="pr_amt2" v-model="objet"
                        placeholder="Entrer le motif de votre demande..." />
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" :disabled="isLoading" @click.prevent="postuler" class="btn btn-success me-1">
              <span class="spinner-border spinner-border-sm me-2" v-if="isLoading"></span>
              Postuler maintenant
            </button>
            <!-- <button type="reset" data-bs-dismiss="modal" class="btn btn-outline-danger">
              Fermer
            </button> -->
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// import { truncate } from "fs";
import $ from "jquery";
import loader from "../loader";
export default {
  components: {
    loader,
  },

  data() {
    var types = [
      "Full Basic Due Diligence ",
      "Financial due Diligence report ",
      "Criminal Record Check ",
      "Asset Due Diligence ",
      "Full Enhanced Due Diligence ",
    ];
    return {
      types: types,
      choosenType: {},
      objet: "",
      isLoading: false,
      dataLoaded: false,
      privacyAccepted: false,
    };
  },
  computed: {
    client() {
      return this.$store.getters.getClient;
    },
    diligenceTypes() {
      return this.$store.getters.getDiligenceTypes;
    },
  },
  methods: {
    setChoosenType(diligenceType) {
      //console.log(JSON.stringify(diligenceType));
      this.choosenType = diligenceType;
      console.log(this.choosenType.description);
    },
    postuler() {
      console.log("submitted");
      if (this.objet.length < 3) {
        this.$swal({
          title: "Saisissez correctement le motif de votre demande",
          icon: "warning",
          timer: 3000,
          toast: true,
          showConfirmButton: false,
        });
        return false;
      }
      var formData = new FormData();
      formData.append("client_id", this.client.client_id);
      formData.append("diligence_type_id", this.choosenType.diligence_type_id);
      //formData.append("type",this.choosenType); //TODO: en attente de l'implementation de ceci dans le backend.
      formData.append("objet", this.objet);

      this.isLoading = true;
      this.$store.dispatch("postulerDiligence", formData).then((res) => {
        this.isLoading = false;

        if (res.reponse !== undefined && res.reponse.status === "success") {
          $(".btn-close").click();
          this.$router.replace({ name: "home" });
        } else {
          this.$swal({
            title: "Impossible de postuler pour le moment.",
            icon: "error",
            timer: 3000,
            toast: true,
            showConfirmButton: false,
          });
        }
      });
    },
  },
  mounted() {
    this.$store.dispatch("getDiligenceTypes").then(() => {
      this.dataLoaded = true;
    });

  },
};
</script>
