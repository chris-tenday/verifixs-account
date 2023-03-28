<template>
  <div class="modal fade" id="actifDetails" tabindex="-1" role="dialog" data-bs-backdrop="false" aria-hidden="true"
    style="background-color: rgba(0, 0, 0, 0.5)">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">
            Actif : {{ data.titre }}
          </h3>
          <button type="button" class="btn-close text-white" @click="clearFields" data-bs-dismiss="modal"
            aria-label="Close" id="btnExitModal"></button>
          <button id="inputsShowBtn" class="d-none" data-bs-target="#actifDetails" data-bs-toggle="modal"></button>
        </div>
        <!-- end /.modal-header -->

        <div class="modal-body">
          <div class="row">
            <div class="col-12">
              <p class="text-danger fs-5">Veuillez renseigner tous ces champs ci-bas !</p>
            </div>
            <form name="formval2" ref="form" @submit.prevent="submitData" class="form-horizontal loan-eligibility-form">
              <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" v-for="(field, index) in data.details"
                :key="index">
                <!--Field is file-->
                <div class="mb-2" v-if="field.reponse_type.includes('file')">
                  <label :for="`field${index}`" class="form-label text-dark fw-bold">{{ field.detail | capitalize }} <sup
                      class="text-danger">*</sup></label>
                  <div class="input-group">
                    <input class="form-control border-light" :id="`field${index}`" :type="field.reponse_type"
                      v-model="field.data" required aria-required="veuillez renseigner ce champs !" />
                  </div>
                </div>
                <!--End Field file-->

                <!--Field is adress location-->
                <div class="mb-2" v-else-if="field.adresse_split !== undefined">
                  <label :for="`field${index}`" class="form-label text-dark fw-bold">{{ field.detail | capitalize }} <sup
                      class="text-danger">*</sup></label>
                  <div class="row">
                    <!-- Select Province -->
                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-6 col-6">
                      <div class="form-group mb-2">
                        <label class="form-label mb-1" for="address_province">Province <sup class="text-danger">*</sup>
                        </label>
                        <select name="address_province" v-model="field.adresse_split.province" id="address_province"
                          @change="handleSplit(field)" class="form-select border-light" required>
                          <option value="" selected>Sélectionner province...</option>
                          <option v-for="(prov, index) in provinces" :key="index" :value="prov">{{ prov.title }}</option>
                        </select>
                      </div>
                    </div>

                    <!-- Select City -->
                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-6 col-6">
                      <div class="form-group mb-2">
                        <label class="form-label mb-1" for="address_city">Ville <sup class="text-danger">*</sup> </label>
                        <select name="address_city" id="address_city" v-model="field.adresse_split.ville"
                          class="form-select border-light" @change="handleSplit(field)" required>
                          <option selected value="">Sélectionner ville...</option>
                          <option v-for="v in field.adresse_split.province.villes" :key="v" :value="v">{{ v }}</option>
                        </select>
                      </div>
                    </div>

                    <!-- Text input Address Commune -->
                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-6 col-6">
                      <div class="form-group mb-2">
                        <label class="form-label mb-1" for="address_street">Commune <sup class="text-danger">*</sup>
                        </label>
                        <input id="address_c" name="address_c" type="text" v-model="field.adresse_split.commune"
                          placeholder="Commune..." class="form-control border-light" @change="handleSplit(field)"
                          required>
                      </div>
                    </div>

                    <!-- Text input Address Quartier -->
                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-6 col-6">
                      <div class="form-group mb-2">
                        <label class="form-label mb-1" for="address_street">Quartier <sup class="text-danger">*</sup>
                        </label>
                        <input id="address_q" name="address_q" type="text" v-model="field.adresse_split.quartier"
                          placeholder="Quartier..." class="form-control border-light" @change="handleSplit(field)"
                          required>
                      </div>
                    </div>

                    <!-- Text input Address Street -->
                    <div class="col-xl-2 col-lg-2 col-md-6 col-sm-6 col-6">
                      <div class="form-group mb-2">
                        <label class="form-label mb-1" for="address_street">Avenue <sup class="text-danger">*</sup>
                        </label>
                        <input id="address_street" name="address_street" v-model="field.adresse_split.avenue" type="text"
                          placeholder="Avenue..." class="form-control border-light" @change="handleSplit(field)" required>
                      </div>
                    </div>

                    <!-- Text input Address number -->
                    <div class="col-xl-2 col-lg-2 col-md-6 col-sm-6 col-6">
                      <div class="form-group mb-2">
                        <label class="form-label mb-1" for="address_num">Numéro <sup class="text-danger">*</sup> </label>
                        <input id="address_num" name="address_num" v-model="field.adresse_split.numero" type="text"
                          placeholder="N°..." class="form-control border-light" @change="handleSplit(field)" required>
                      </div>
                    </div>

                    <!-- Text input Address Réf -->
                    <div class="col-xl-8 col-lg-8 col-md-6 col-sm-6 col-6">
                      <div class="form-group mb-2">
                        <label class="form-label mb-1" for="address_ref">Réference <sup class="text-danger">*</sup>
                        </label>
                        <input id="address_ref" name="address_ref" v-model="field.adresse_split.reference" type="text"
                          placeholder="Réference..." class="form-control border-light" @change="handleSplit(field)"
                          required>
                      </div>
                    </div>
                  </div>
                </div>
                <!--end field adress location -->

                <!--Field is select-->
                <div class="mb-2" v-else-if="field.reponse_type.includes('select')">
                  <label :for="`field${index}`" class="form-label text-dark fw-bold">{{
                    field.detail | capitalize
                  }} <sup class="text-danger">*</sup></label>
                  <select v-if="!field.autre_data.includes('autre')" class="form-select border-light"
                    :id="`field${index}`" v-model="field.data" @change="onselectionchange(field)"
                    aria-label="Select value" required aria-required="veuillez renseigner ce champs !">
                    <option value="" selected>-------------</option>
                    <option :value="option" v-for="option in field.options" :key="option">
                      {{ option }}
                    </option>
                    <option value="autre" class="text-primary">Autre...</option>
                  </select>
                  <div v-else class="input-group">
                    <input v-model="field.data" :id="`field${index}`" type="text" class="form-control mt-2 border-light"
                      placeholder="Veuillez saisir autre choix..." required
                      aria-required="veuillez renseigner ce champs !" />
                    <button class="btn btn-light-danger btn-sm mt-2" type="button" @click="field.autre_data = ''"><i
                        class="bi-arrows-collapse"></i>
                    </button>
                  </div>
                </div>

                <!-- Field is text !-->
                <div class="mb-2" v-else>
                  <label :for="`field${index}`" class="form-label text-dark fw-bold">{{ field.detail | capitalize }} <sup
                      class="text-danger">*</sup>
                  </label>
                  <!-- if reponses multiple !-->
                  <div v-if="field.reponse_type.includes('multiple')">
                    <div class="input-group mt-2" v-for="(reponse, i) in field.reponses" :key="reponse">
                      <input :id="`field${index}`" type="text" v-model="reponse.reponse" class="form-control border-light"
                        placeholder="Veuillez saisir.." required aria-required="veuillez renseigner ce champs !" />

                      <button v-if="i === field.reponses.length - 1" type="button" class="btn btn-light-primary"
                        @click.prevent="addAnswer(field)">
                        <i class="fa fa-plus fs-7"></i>
                      </button>
                      <button v-else type="button" class="btn btn-light-danger"
                        @click.prevent="field.reponses.splice(i, 1)">
                        <i class="fa fa-times fs-7"></i>
                      </button>
                    </div>
                  </div>
                  <div style="margin-bottom: 5px; padding-bottom: 5px;" class="input-group"
                    v-else-if="!field.reponse_type.includes('multiple')">
                    <input :id="`field${index}`" :type="field.reponse_type" v-model="field.data"
                      class="form-control border-light input-sm" placeholder="Veuillez saisir.."
                      style="margin-bottom: 5px;" required aria-required="veuillez renseigner ce champs !" />
                  </div>
                </div>
                <!--end field select -->
              </div>

              <div class="mt-4">
                <button type="submit" class="btn btn-success me-2" :class="isLoading ? 'disabled' : ''">
                  <span class="spinner-border spinner-border-sm" v-if="isLoading"></span>
                  Sauvegarder
                </button>
                <button type="reset" @click="clearFields" data-bs-dismiss="modal" class="btn btn-secondary">
                  Fermer
                </button>
              </div>
            </form>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapState } from "vuex";
import $ from "jquery";
export default {
  name: "DetailModal",
  props: {
    data: {
      type: Object,
      default: () => { },
    },
    diligence: {
      type: Object,
      default: () => { },
    },
    diligenceId: {
      type: String,
      default: "",
    },
  },
  data() {
    return {
      isLoading: false,
      other: {
        index: '',
        data: '',
        selected: false
      },

    };
  },
  computed: {
    ...mapGetters({
      client: "getClient",
    }),

    ...mapState({
      provinces: "provinces"
    })
  },

  mounted() {
    this.clearFields();
  },

  methods: {
    onselectionchange(field) {
      if (field.data.includes('autre')) {
        field.autre_data = field.data;
        field.data = "";
      }
    },
    /** Method pour ajouter une réponse */
    addAnswer(field) {
      var reponse = { reponse: "" };
      field.reponses.push(reponse);
    },
    handleSplit(field) {
      let split = `PROVINCE :  ${field.adresse_split.province.title} | VILLE :  ${field.adresse_split.ville} |  COMMUNE :  ${field.adresse_split.commune} | QUARTIER :  ${field.adresse_split.quartier} | AVENUE :  ${field.adresse_split.avenue} | NUMERO :  ${field.adresse_split.numero} | REFERENCE :  ${field.adresse_split.reference}`;
      field.data = split.toString();
    },
    changeFile(event) {
      let file = event.target.files[0];
      console.log(file);
    },
    toggleInputOther(field) {
      console.log(JSON.stringify(field));
      if (field.select) {
        field.select = "non";
      } else {
        field.select = "oui";
      }
    },

    clearFields() {
      this.$refs.form.reset();
      for (let i = 0; i < this.data.details.length; i++) {
        let detail = this.data.details[i];
        if (detail.data !== "") {
          detail.data = "";
        }
        if (detail.adresse_split !== undefined) {
          detail.adresse_split.province = "";
          detail.adresse_split.avenue = "";
          detail.adresse_split.numero = "";
          detail.adresse_split.quartier = "";
          detail.adresse_split.reference = "";
          detail.adresse_split.commune = "";
        }
      }
    },

    submitData(event) {
      /**
       * check detail input data if isn't empty
       **/
      for (let i = 0; i < this.data.details.length; i++) {
        let detail = this.data.details[i];
        if (detail.data === "" && detail.obligatoire === "oui") {
          this.$swal.fire({
            text: "Vous devez renseigner tous les champs obligatoires!",
            icon: "warning",
          });
          return;
        }

        /* Verification de la date entrée */
        if (detail.reponse_type.includes('date')) {
          const date = new Date(detail.data).getTime();
          const now = new Date(Date.now()).getTime();
          if (date >= now) {
            this.$swal.fire({
              text: "Les dates entrées sont invalides !",
              icon: 'warning',
              toast: true,
              timer: 3000,
              showConfirmButton: false,
            });
            return;
          }
        }
      }


      /**
       * actifs save details formData
       **/
      let formData = new FormData();
      formData.append("client_id", this.client.client_id);
      formData.append("actif_id", this.data.actif_id);
      formData.append("diligence_id", this.diligenceId);

      this.isLoading = true;

      /**
       * ajouter actif
       **/
      this.$axios
        .post("/clients/diligences/actifs/add", formData)
        .then(async (result) => {
          //console.log(JSON.stringify(result.data));
          var data = result.data;
          if (data.reponse !== undefined && data.reponse.status === "success") {
            for (let i = 0; i < this.data.details.length; i++) {
              let detail = this.data.details[i];
              let diligenceActifId = data.reponse.diligence_actif_id;
              this.saveDetail(detail, diligenceActifId);
            }

            /**
             * Throw event pour permettre au parent component de recharger tout le contenu de la page.
             */

            this.$swal.fire({
              icon: "success",
              text: "Effectué avec succès !",
              showConfirmButton: false,
              timer: 1500,
            });
            let s = {
              client_id: this.client.client_id,
              diligence_id: this.diligence.diligence_id,
            };
            this.isLoading = false;
            this.clearFields();
            await this.$store.dispatch("viewDiligenceDetails", s);
            $("#btnExitModal").click();
            this.$emit("allowNext");
          } else if (data.error !== undefined) {
            this.$swal.fire({
              text:
                "Un problème est survenu lors de l'envoie de données\nVeuillez réessayer ultérieurement !",
              icon: "error",
              // all of other options may go here
            });
          }
        })
        .catch((err) => {
          this.isLoading = false;
          console.log(err);
        });
    },
    saveDetail(detail, id) {
      let formData = new FormData();
      formData.append("client_id", this.client.client_id);
      formData.append("diligence_actif_id", id);
      formData.append("actif_detail_id", detail.actif_detail_id);
      if (detail.reponse_type.includes("multiple")) /** if reponse multiple */ {
        var d = "";
        for (var i = 0; i < detail.reponses.length; i++) {
          d += detail.reponses[i].reponse;
          if (i < detail.reponses.length - 1) {
            d += " , ";
          }
        }
        formData.append("detail", d);
      }
      else {
        formData.append("detail", detail.data);
      }
      this.$axios
        .post("/clients/diligences/actifs/savedetail", formData)
        .then((result) => {
          let res = JSON.stringify(result.data);
          console.log(res);
        })
        .catch((err) => {
          this.isLoading = false;
          console.log(err);
        });
    },
  },
};
</script>
