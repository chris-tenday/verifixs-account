<template>
  <div class="mt-15">
    <!-- content start -->
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="mt-n6 mb-10">
            <div class="d-flex justify-content-center mb-4">
              <a v-for="(state, i) in status" :key="i" href="#" class="btn btn-primary m-1" @click="tri(state)">
                {{ state }}
              </a>
            </div>
            <loader :data-loaded="loader" height="200">
              <div class="row" v-if=" diligences.length > 0 && sort.length > 0">
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 col-12" v-for="diligence in sort"
                  :key="diligence.diligence_id">
                  <div class="card mb-6 text-center border-0 smooth-shadow-sm">
                    <span style="top: 5px; right: 5px;"
                      class="badge bg-danger p-2 position-absolute text-center fs-5 fw-semi-bold">
                      {{ diligence.diligence_status }}
                    </span>
                    <div class="card-body p-5">
                      <div class="mb-6 mt-3">
                        <img src="assets/images/icon/icon-2.svg" alt="Icon" class="icon-xxl" />
                      </div>
                      <h3>
                        <a href="javascript:void(0)" class="text-inherit">{{
                          diligence.diligence_type
                        }}</a>
                      </h3>
                      <span>{{ diligence.objet | sortlength(35, "...") }}</span><br />
                      <span style="font-size: 10px; font-weight: 600">
                        <span class="me-2">
                          <i class="fas fa-calendar text-success me-1"></i>{{ diligence.date_enregistrement.split("|")[0]
                          }}</span>
                        <span class="me-2"><i class="fas fa-clock text-success me-1"></i>{{
                          diligence.date_enregistrement.split("|")[1] }}</span></span><br />
                      <button @click.prevent="
                        $router.push({
                          name: 'loan-view',
                          params: { id: diligence.diligence_id },
                        })
                      " class="btn btn-sm btn-info mt-3 text-white fw-medium fs-6">
                        <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                          xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="13px" height="7px"
                          viewBox="0 0 13 7" enable-background="new 0 0 13 7" xml:space="preserve">
                          <polygon id="arrow_poly_1" class="arrow_poly" fill="#FFFFFF"
                            points="13,3.5 9,0 9,3 0,3 0,4 9,4 9,7 " />
                        </svg> Voir détails diligence
                      </button>
                    </div>
                  </div>
                </div>
              </div>
              <div v-else-if=" diligences.length > 0 && sort.length == 0">
                <div class="col-md-12 text-center">
                  <img src="assets/images/folder_1.png" style="width: 100px; height: 100px" />
                  <div class="not_found">
                    <a href="#" class="btn btn-danger btn-lg p-3 btn-shadow">
                      <i class="lnr lnr-plus-circle mr-2"></i> Aucune diligence </a>
                  </div>
                </div>
              </div>
              <div class="row" v-else>
                <div class="col-md-12 text-center" data-aos="fade-down">
                  <img src="assets/images/folder_1.png" style="width: 100px; height: 100px" />
                  <div class="not_found">
                    <h3>Bienvenu(e) chez Verifixs !</h3>
                    <a href="#/creation/diligence" class="btn btn-danger btn-lg p-3 btn-shadow"
                      @click.prevent="viewConditions">
                      <i class="lnr lnr-plus-circle mr-2"></i> Postuler maintenant à une
                      diligence</a>
                  </div>
                </div>
              </div>
              <div style="display: none" class="row">
                <div class="col-md-12">
                  <div class="text-center">
                    <!-- section title start-->
                    <h1 class="mb-2">
                      <span class="fa fa-warning"></span> Bienvenu(e) chez Verifixs !
                    </h1>
                    <p class="fs-6 text-danger">
                      Veuillez souscrire à une ou plusieurs diligences !
                    </p>
                    <div class="btn btn-danger btn-lg" @click.prevent="viewConditions">
                      Postuler à une diligence
                    </div>
                  </div>
                </div>
              </div>
            </loader>
          </div>
        </div>
      </div>
    </div>

  </div>
  <!-- /.content end -->
</template>

<script>
import loader from "../loader";
import $ from "jquery";
import { type } from "os";
import { log } from "console";
export default {
  components: { loader },
  data() {
    return {
      loader: false,
      status: ['all', 'actif', 'clos', 'en cours',],
      sort: [],
      // alias: localStorage.getItem('diligences') 
    };
  },
  computed: {
    diligences() {
      return this.$store.state.diligences;
    },
    client() {
      return this.$store.getters.getClient;
    },
    // trie(){
    //   console.log(state);
    //   return tri(state)
    // },
  },
  mounted() {
    var formData = new FormData();
    formData.append("client_id", this.client.client_id);
    this.$store.dispatch("viewDiligences", formData).then(() => {
      this.loader = true;
    });
  },
  methods: {
    tri(state) {
      console.log(state);
      // const aliase = this.$store.state.diligences
      this.sort = this.$store.state.diligences;
      for (let e = 0; e <= this.$store.state.diligences.length; e++) {
        if (this.$store.state.diligences[e].diligence_status === state) {
          this.sort.push(this.$store.state.diligences[e])
        }
      }
      if (this.sort.length > 0) {
        return this.sort;
      }
      else if (this.sort.length == 0) {
        if (state == 'en cours' || state == 'clos') {
          console.log(this.sort, 'all');
          return this.sort;
        }
        console.log(this.sort, 'all');
        this.sort = this.$store.state.diligences
        return this.sort;
      }
      else {
        this.sort = this.$store.state.diligences
        return this.sort
      }
    },
    viewConditions() {
      /**
       * Afficher et faire accepter les termes & conditions.
       */

      //TODO: Sauter l'affichage des termes & conditions , jusqu'à ce que le document original des conditions soit pret auprès du client.
      $("#btn-privacy").click();
      //this.conditionAccepted(true);
    },
    conditionAccepted(accepted = false) {
      if (!accepted) {
        this.$swal({
          title: "Désolé! Vous ne pouvez pas continuer",
          toast: true,
          showConfirmButton: false,
          timer: 3000,
          icon: "warning",
        });
      } else {
        this.$router.push({ name: "new-loan" });
      }
    },
  },
};
</script>
