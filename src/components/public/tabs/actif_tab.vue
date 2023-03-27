<template>
  <div data-aos="fade-up">
    <go_to_tab :allownexttab="allowNextTab" @gototab="goToTab" :askpermission="askCheckingPermission"
      permission-text="Est-ce que vous nous autoriser à cette information?"></go_to_tab>

    <div class="row">
      <div class="col-md-12">
        <div class="mb-2" v-if="diligenceActifs.length < 1">
          <p class="fs-4 text-dark">Avez-vous des actifs ?</p>
          <div>
            <div class="form-check form-check-inline" style="cursor: pointer">
              <input class="form-check-input" type="radio" value="oui" @change="checkedChanged($event)"
                name="flexRadioDefault" id="yes" />
              <label class="form-check-label text-success" for="yes"> Oui </label>
            </div>
            <div class="form-check form-check-inline" style="cursor: pointer">
              <input class="form-check-input" type="radio" name="flexRadioDefault" @change="checkedChanged($event)"
                id="no" value="non" />
              <label class="form-check-label" for="no"> Non </label>
            </div>
          </div>
        </div>
      </div>

    </div>

    <div class="row" v-if="diligenceActifs.length">
      <div class="col-lg-12 col-md-12 col-12 mb-3">
        <div class="d-flex justify-content-between">
          <h1 class="mb-0">Mes actifs</h1>
          <button @click="toggleScrollerBottom" class="btn btn-danger rounded border-0">
            <span v-if="!newActif" class="fs-7"><i class="fas fa-plus me-1"></i>Ajouter plus d'actifs</span>
            <span v-else class="fs-7"><i class="fas fa-minus me-1"></i>Fermer</span>
          </button>
        </div>
      </div>
      <div class="col-xl-3 col-lg-4 col-md-4 col-sm-4 col-12" v-for="(actif, index) in diligenceActifs" :key="index">
        <div class="card mb-6 text-center border-0 bg-light-success">
          <div class="card-body p-5">
            <div class="mb-3">
              <img src="assets/images/svg/mortgage.svg" alt="Borrow - Loan Company Website Template" class="icon-xxl" />
            </div>
            <h3 class="mb-2">
              {{ actif.titre }}
            </h3>

            <button @click.prevent="onShowDetails(actif)
            " class="btn btn-sm btn-info mt-3 text-white fw-medium fs-6">
              <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="13px" height="7px" viewBox="0 0 13 7"
                enable-background="new 0 0 13 7" xml:space="preserve">
                <polygon id="arrow_poly_1" class="arrow_poly" fill="#FFFFFF" points="13,3.5 9,0 9,3 0,3 0,4 9,4 9,7 " />
              </svg> Voir détails
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="row" data-aos="fade-up" id="target" v-if="newActif">
      <div class="col-12 col-md-12">
        <div class="mb-4">
          <!-- section title start-->
          <h2 class="mb-1 fw-medium">Cher client veuillez ajouter vos actifs !</h2>
        </div>
      </div>
      <div class="col-xl-3 col-lg-4 col-md-4 col-sm-4 col-12" v-for="(actif, index) in actifs" :key="index">
        <div class="card text-center text-white bg-dual-gradient mb-6">
          <div class="icon-shape icon-lg bg-primary-gradient rounded-circle mx-auto mt-n4 text-white">
            <span class="fs-3"><i class="fas fa-check"></i></span>
          </div>
          <div class="card-body p-6">
            <h3 class="mb-2 text-white">{{ actif.titre }}</h3>
            <button class="btn btn-sm btn-light mt-2 border-0" @click="getSelectedActif(actif)">
              <i class="fa fa-plus mx-1"></i>Ajouter
            </button>
          </div>
        </div>
      </div>
    </div>

    <portal to="modal"><detail-modal :data="inputs" @allowNext="allowNextTab = true" :diligence="diligence"
        :diligenceId="diligenceId"></detail-modal></portal>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import { scroller } from "vue-scrollto/src/scrollTo";
import go_to_tab from "../go_to_tab";
import $ from "jquery";
export default {
  name: "actifs",
  components: { go_to_tab },
  props: {
    diligence: {},
  },

  data() {
    return {
      selected_actif: {},
      inputs: {},
      isLoading: false,
      file: "",
      diligenceId: 0,
      newActif: false,
      askCheckingPermission: true,
      checkingPermission: false,
      allowNextTab: false,
    };
  },

  computed: {
    ...mapGetters({
      actifs: "getActifs",
      client: "getClient",
      diligenceActifs: "getDiligenceActifs",
    }),
  },

  methods: {
    goToTab(nextTab) {
      if (nextTab) {
        this.$emit("gotonexttab");
      } else {
        this.$emit("gotoprevioustab");
      }
    },
    checkedChanged(value) {
      if (value.target.id === "yes" && value.target.checked) {
        this.toggleNewActif(true);
        const scrollTo = scroller();
        setTimeout(() => {
          scrollTo("#target");
        }, 100);
      }
      if (value.target.id === "no" && value.target.checked) {
        this.toggleNewActif(false);
      }
    },
    toggleNewActif(newActif) {
      this.newActif = newActif;
      if (this.newActif) {
        if (this.diligenceActifs.length > 0) {
          this.allowNextTab = true;
        } else {
          this.allowNextTab = false;
        }
      } else {
        this.allowNextTab = true;
      }
    },
    getSelectedActifDetails(actif) {
      this.selected_actif = actif;

      const scrollTo = scroller();
      setTimeout(() => {
        scrollTo("#bottom");
      }, 100);
    },

    cancelSelectedDetail() {
      this.selected_actif = {};
    },

    changeFile(event) {
      let file = event.target.files[0];
      console.log(file);
    },

    getSelectedActif(actif) {
      this.inputs = actif;
      this.$emit("onSelectedActif", actif);
    },

    onShowDetails(actif) {
      this.$emit('showDetails', actif);
    },

    toggleScrollerBottom() {
      this.newActif = !this.newActif;
      const scrollTo = scroller();
      setTimeout(() => {
        scrollTo("#target");
      }, 100);
    },

    saveDetail(detail, id) {
      let formData = new FormData();
      formData.append("client_id", this.client.client_id);
      formData.append("diligence_actif_id", id);
      formData.append("actif_detail_id", detail.actif_detail_id);
      formData.append("detail", detail.data);
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
  mounted() {
    if (this.diligenceActifs.length > 0) {
      this.allowNextTab = true;
      this.askCheckingPermission = false;
    }
    this.diligenceId = this.$route.params.id;
  },
};
</script>
