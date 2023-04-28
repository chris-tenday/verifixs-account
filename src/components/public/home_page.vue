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
              <div class="portfolioFilter" style="overflow-x: auto; overflow-y: hidden;"
                v-show="diligences.length > 0 || filterWord !== ''">
                <ul class="nav justify-content-center nav-pills-gray mb-4" data-aos="fade-up">
                  <li class="nav-item" v-for="(filter, index) in filters" :key="index">
                    <a class="mb-1 nav-link rounded-2" @click.prevent="toggleShowFiltered(filter)"
                      href="javascript:void(0)" :class="`${selectedFilterId === filter.id ? 'active' : ''}`">
                      {{ filter.label }}
                    </a>
                  </li>

                </ul>

              </div>

              <div class="row" v-if="diligences.length > 0">
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 col-12" v-for="diligence in diligences"
                  :key="diligence.diligence_id">
                  <div class="card mb-6 text-center border-0 smooth-shadow-sm" data-aos="zoom-in">
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
                      <span>{{ diligence.objet | sortlength(30, "...") }}</span><br />
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
              <div class="row" v-show="filterWord === '' && diligences.length === 0" v-else>
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
              <div class="row" v-if="(filterWord !== '') && (diligences.length === 0)">
                <div class="col-md-12 text-center" data-aos="fade-up">
                  <svg style="width: 150px; height: 150px;" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <path
                      d="M9 22H7C3 22 2 21 2 17V7C2 3 3 2 7 2H8.5C10 2 10.33 2.44001 10.9 3.20001L12.4 5.20001C12.78 5.70001 13 6 14 6H17C21 6 22 7 22 11V13"
                      stroke="#33cc7c" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"
                      stroke-linejoin="round" />
                    <path opacity="0.4"
                      d="M13.7605 18.3199C11.4105 18.4899 11.4105 21.8899 13.7605 22.0599H19.3205C19.9905 22.0599 20.6506 21.8099 21.1406 21.3599C22.7906 19.9199 21.9105 17.0399 19.7405 16.7699C18.9605 12.0799 12.1806 13.8599 13.7806 18.3299"
                      stroke="#FF0000" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"
                      stroke-linejoin="round" />
                  </svg>
                  <h3 style="color:#FF0000" class="mt-2">Aucune diligence trouvé !</h3>
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
export default {
  components: { loader },
  data() {
    return {
      loader: false,
      filters: [
        { id: 1, label: 'Tous' },
        { id: 2, label: 'Actif' },
        { id: 3, label: 'En cours' },
        { id: 4, label: 'Cloturée' },
      ],
      filterWord: '',
      selectedFilterId: 1,
    };
  },
  computed: {
    diligences() {
      if (this.filterWord === '') {
        return this.$store.state.diligences;
      }
      else {
        let arr = this.$store.state.diligences;
        return arr.filter((item) => item.diligence_status.toLowerCase().includes(this.filterWord.toLowerCase()));
      }
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
    viewConditions() {
      /**
       * Afficher et faire accepter les termes & conditions.
       */

      //TODO: Sauter l'affichage des termes & conditions , jusqu'à ce que le document original des conditions soit pret auprès du client.
      $("#btn-privacy").click();
      //this.conditionAccepted(true);
    },

    toggleShowFiltered(filter) {
      this.selectedFilterId = filter.id;
      if (filter.label === 'Tous') {
        this.filterWord = "";
      }
      else {
        this.filterWord = filter.label
      }
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
