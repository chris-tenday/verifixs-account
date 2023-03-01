<template>
  <div class="modal fade" id="actifDetails" tabindex="-1" role="dialog" data-bs-backdrop="false" aria-hidden="true"
    style="background-color: rgba(0, 0, 0, 0.5)">
    <div class="modal-dialog modal-lg rounded-0" role="document">
      <div class="modal-content">
        <div class="modal-header bg-dual-gradient rounded-0">
          <h3 class="modal-title fs-5 text-white">
            Actif : {{ data.titre }}
          </h3>
          <button type="button" class="btn-close text-white" data-bs-dismiss="modal" aria-label="Close"
            id="btnExitModal"></button>
          <button id="detailShowBtn" class="d-none" data-bs-target="#actifDetails" data-bs-toggle="modal"></button>
        </div>
        <!-- end /.modal-header -->

        <div class="modal-body">
          <div class="row">
            <div class="col-12">
              <p class="text-danger fs-5">Veuillez renseigner tous ces champs ci-bas !</p>
            </div>
            <form name="formval2" class="form-horizontal loan-eligibility-form">
              <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" v-for="(field, index) in data.details"
                :key="index">
                <!--Field is file-->
                <div class="mb-2" v-if="field.reponse_type.includes('file')">
                  <label :for="`field${index}`" class="form-label text-dark-primary">{{ field.detail }} :</label>
                  <div class="input-group">
                    <input class="form-control border-dark-primary" :id="`field${index}`" :type="field.reponse_type"
                      v-model="field.data" />
                  </div>
                </div>

                <!--End Field file-->

                <!--Field is adress location-->
                <div class="mb-2" v-else-if="field.adresse_split !== undefined">
                  <label :for="`field${index}`" class="form-label text-dark-primary">{{ field.detail }} :</label>
                  <div class="input-group">
                    <input v-model="field.adresse_split.avenue" style="width: 120px" type="text"
                      class="form-control border-dark-primary m-1 rounded" placeholder="avenue" />
                    <input v-model="field.adresse_split.numero" style="width: 60px" type="text"
                      class="form-control border-dark-primary rounded m-1" placeholder="no." />
                    <input v-model="field.adresse_split.quartier" style="width: 110px" type="text"
                      class="form-control border-dark-primary rounded m-1" placeholder="quartier" />
                    <input v-model="field.adresse_split.reference" style="width: 110px" type="text"
                      class="form-control border-dark-primary rounded m-1" placeholder="référence" />
                    <input v-model="field.adresse_split.commune" style="width: 110px" type="text"
                      class="form-control border-dark-primary m-1 rounded" placeholder="commune" @change="
                        handleSplit(
                          field,
                          'Avenue ' + field.adresse_split.avenue,
                          ' Numéro ' + field.adresse_split.numero,
                          'Quartier ' + field.adresse_split.quartier,
                          ' Référence ' + field.adresse_split.reference,
                          ' Commune ' + field.adresse_split.commune
                        )
                      " />
                  </div>
                </div>
                <!--end field adress location -->

                <!--Field is select-->
                <div class="mb-2" v-else-if="field.reponse_type.includes('select')">
                  <label :for="`field${index}`" class="form-label text-dark-primary">{{
                    field.detail
                  }}</label>
                  <select v-if="field.select === 'oui'" class="form-select border-dark-primary" :id="`field${index}`"
                    v-model="field.data" @change="field.select = field.data" aria-label="Select value">
                    <option value="" selected>-------------</option>
                    <option :value="option" v-for="option in field.options" :key="option">
                      {{ option }}
                    </option>
                    <option value="autre" class="text-primary">Autre...</option>
                  </select>
                  <input v-if="field.select === 'autre'" v-model="field.data" :id="`field${index}`" type="text"
                    class="form-control mt-2 border-dark-primary" placeholder="Veuillez saisir.." />
                </div>

                <!-- Field is text !-->
                <div class="mb-2" v-else>
                  <label :for="`field${index}`" class="form-label text-dark-primary">{{ field.detail }} :
                  </label>
                  <!-- if reponses multiple !-->
                  <div v-if="field.reponse_type.includes('multiple')">

                    <div class="input-group mt-2" v-for="(reponse, i) in field.reponses" :key="reponse">
                      <input :id="`field${index}`" type="text" v-model="reponse.reponse"
                        class="form-control border-dark-primary" placeholder="Veuillez saisir.." />

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
                      class="form-control border-dark-primary input-sm" placeholder="Veuillez saisir.."
                      style="margin-bottom: 5px;" />
                  </div>


                </div>

                <!--end field select -->
              </div>
            </form>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-success btn-sm me-2" :class="isLoading ? 'disabled' : ''"
            @click="submitData">
            <span class="spinner-border spinner-border-sm" v-if="isLoading"></span>
            Enregistrer & valider
          </button>
          <button type="reset" @click="clearFields" data-bs-dismiss="modal" class="btn btn-sm btn-secondary">
            Fermer
          </button>
        </div>
        <!-- end /.modal-body -->
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
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
    };
  },
  computed: {
    ...mapGetters({
      client: "getClient",
    }),
  },
  methods: {
    addAnswer(field) /** Method pour ajouter une réponse */ {
      var reponse = { reponse: "" };

      field.reponses.push(reponse);
    }
    ,
    handleSplit(field, ...data) {
      field.data = data.toString();
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
      for (let i = 0; i < this.data.details.length; i++) {
        let detail = this.data.details[i];
        if (detail.data !== "") {
          detail.data = "";
        }
        if (detail.adresse_split !== undefined) {
          detail.adresse_split.avenue = "";
          detail.adresse_split.numero = "";
          detail.adresse_split.quartier = "";
          detail.adresse_split.reference = "";
          detail.adresse_split.commune = "";
        }
      }
    },

    submitData() {
      /**
       * check detail input data if isn't empty
       **/
      for (let i = 0; i < this.data.details.length; i++) {
        let detail = this.data.details[i];
        console.log(JSON.stringify(detail));
        if (detail.data === "" && detail.obligatoire === "oui") {
          this.$swal.fire({
            text: "Vous devez renseigner tous les champs obligatoires!",
            icon: "warning",
          });
          return;
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
