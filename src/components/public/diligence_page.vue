<template>
  <div class="mt-10 mb-10">
    <loader :data-loaded="dataLoaded" height="300">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 col-md-12 col-sm-12 col-12">
            <div class="card mb-2" data-aos="fade-down">
              <div class="card-body p-3 d-flex align-items-start justify-content-between">
                <div>
                  <h1 class="fw-bold text-dark-primary">
                    <img src="assets/images/icon/icon-2.svg" alt="Icon" class="icon-sm me-2" />{{ diligence.diligence_type
                    }}
                  </h1>
                  <h2 class="fw-semi-bold fs-4">Motif : {{ diligence.objet }}</h2>
                  <p class="fs-6">
                    <span class="badge bg-danger mx-1 p-2">status : {{ diligence.diligence_status }}</span>
                    <span class="mx-1 fw-semi-bold"><i class="fas fa-calendar text-success mx-1"></i>
                      {{ diligence.date_enregistrement.split("|")[0] }}
                      <i class="fas fa-clock text-success mx-1"></i>{{ diligence.date_enregistrement.split("|")[1]
                      }}</span>
                  </p>
                </div>

                <button class="btn btn-info btn-sm text-white">Voir mes reponses</button>
              </div>
            </div>
            <!-- /.section title start-->
          </div>
        </div>
        <div>
          <div>
            <!--Nav tab header-->
            <ul
              class="nav nav-pills nav-justified bg-white rounded border-top mb-2 flex-nowrap overflow-scroll overflow-md-hidden"
              id="myTab" role="tablist">
              <li class="nav-item" data-aos="zoom-in">
                <button class="nav-link active rounded-0 d-grid py-3" id="questionsTab" data-bs-toggle="pill"
                  href="#questionsTabView" role="tab" aria-controls="questionsTabView" aria-selected="true">
                  <i class="bi bi-question-circle-fill fs-3"></i>
                  <p class="mb-0 mt-1 fs-5">Questions</p>
                </button>
              </li>
              <li class="nav-item" v-if="canAccessTab('actifs') === true" data-aos="zoom-in">
                <button class="nav-link rounded-0 d-grid py-3 border-start" style="pointer-events: none" id="actifTab"
                  data-bs-toggle="pill" href="#actifTabView" role="tab" aria-controls="actifTabView"
                  aria-selected="false">
                  <i class="bi bi-house-fill fs-3"></i>
                  <p class="mb-0 mt-1 fs-5">Actifs</p>
                </button>
              </li>
              <li class="nav-item" v-if="canAccessTab('credits') === true" data-aos="zoom-in">
                <button class="nav-link rounded-0 d-grid py-3 border-start" style="pointer-events: none" id="creditsTab"
                  data-bs-toggle="pill" href="#creditsTabView" role="tab" aria-controls="creditsTabView"
                  aria-selected="false">
                  <i class="bi bi-cash-stack fs-3"></i>
                  <p class="mb-0 mt-1 fs-5">Credits</p>
                </button>
              </li>
              <li class="nav-item" data-aos="zoom-in">
                <button class="nav-link rounded-0 d-grid py-3 border-start" style="pointer-events: none" id="docTab"
                  data-bs-toggle="pill" href="#docTabView" role="tab" aria-controls="docTabView" aria-selected="false">
                  <i class="bi bi-files-alt fs-3"></i>
                  <p class="mb-0 mt-1 fs-5">Documents</p>
                </button>
              </li>
              <li class="nav-item" data-aos="zoom-in">
                <button class="nav-link rounded-0 d-grid py-3 border-start" id="certificatTab" data-bs-toggle="pill"
                  href="#certificatTabView" role="tab" aria-controls="certificatTabView" aria-selected="false">
                  <i class="bi bi-file-earmark-check-fill fs-3"></i>
                  <p class="mb-0 mt-1 fs-5">Certificats</p>
                </button>
              </li>
            </ul>
            <!-- End Nav tab header -->
            <!-- Nav tab content -->
            <div class="tab-content bg-white p-3 p-lg-5 p-sm-2 rounded smooth-shadow-sm">
              <div role="tabpanel" class="tab-pane fade show active" id="questionsTabView">
                <question-tab @gotonexttab="goToTab('questions')" @gotoprevioustab="goToTab('questions', false)"
                  @updatecontent="updateContent"></question-tab>
              </div>

              <div role="tabpanel" class="tab-pane fade" id="actifTabView">
                <actif-tab :diligence="diligence" @gotonexttab="goToTab('actifs')"
                  @onSelectedActif="onSelectedActif($event)" @showDetails="onShowDetails($event)"
                  @gotoprevioustab="goToTab('actifs', false)"></actif-tab>
              </div>
              <div role="tabpanel" class="tab-pane fade" id="creditsTabView">
                <credits-tab @alert="displayMsg" @updatecontent="updateContent" @gotonexttab="goToTab('credits')"
                  @gotoprevioustab="goToTab('credits', false)"></credits-tab>
              </div>
              <div role="tabpanel" class="tab-pane fade" id="docTabView">
                <doc-tab @loading="displayLoader" @updatecontent="updateContent" @gotonexttab="goToTab('documents')"
                  @gotoprevioustab="goToTab('documents', false)"></doc-tab>
              </div>

              <div role="tabpanel" class="tab-pane fade" id="certificatTabView">
                <pay-tab :diligence="diligence" @loading="displayLoader" @updatecontent="updateContent"
                  @gotonexttab="goToTab('certificat')" @gotoprevioustab="goToTab('certificat', false)"></pay-tab>
              </div>
            </div>
          </div>
        </div>
      </div>
    </loader>

    <!-- modal pour ajouter un nouvel actif !-->
    <!-- <portal to='body'>
      <detail-modal :data="actif_details" :diligence="diligence" :diligenceId="diligenceId"></detail-modal>
    </portal> -->

    <!-- modal pour voir actif enregistré !-->
    <portal to='body'>
      <actif-modal :data="selected_actif"></actif-modal>
    </portal>


    <portal-target name="modal">
      <!--
  This component can be located anywhere in your App.
  The slot content of the above portal component will be rendered here.
  -->
    </portal-target>

  </div>
</template>

<script>
import docTab from "@/components/public/tabs/doc_tab";
import payTab from "@/components/public/tabs/pay_tab";
import questionTab from "@/components/public/tabs/question_tab";
import actifTab from "@/components/public/tabs/actif_tab";
import creditsTab from "@/components/public/tabs/credits_tab";
import loader from "../loader";
import $ from "jquery";
export default {
  components: {
    questionTab,
    actifTab,
    docTab,
    payTab,
    creditsTab,
    loader,
  },

  data() {
    return {
      diligenceId: 0,
      dataLoaded: false,
      isLoading: false,
      tabs: { actifs: true, credits: true, documents: true, certificat: true },
      canGoToNextTab: false,
      selected_actif: {},
      actif_details: {},
    };
  },
  methods: {
    onSelectedActif(actif) {
      this.selected_actif = actif;
      console.log(JSON.stringify(actif));
      $("#actifDetailBtn").click();
    },
    onShowDetails(inputs) {
      this.actif_details = inputs;
      $("#detailShowBtn").click();
    },
    displayMsg(msg, type = "error" /** pour afficher un message en toast */) {
      this.$swal({
        title: msg,
        icon: type,
        timer: 3000,
        toast: true,
        showConfirmButton: false,
      });
    },
    goToTab(fromTab, next = true) /** method pour gerer le passage d'une tab à une uatre */ {
      var tabs = [
        { name: "questions", buttonId: "questionsTab" },
        { name: "actifs", buttonId: "actifTab" },
        { name: "credits", buttonId: "creditsTab" },
        { name: "documents", buttonId: "docTab" },
        { name: "certificat", buttonId: "certificatTab" },
      ];

      var currentTabIndex = null;

      if (next) {
        /**
         * S'il faut aller au prochain tab.
         * */
        for (var i = 0; i < tabs.length; i++) {
          if (fromTab === tabs[i].name) {
            currentTabIndex = i;
          }

          if (currentTabIndex !== null && i > currentTabIndex) {
            if (this.canAccessTab(tabs[i].name)) {
              /**
               * Aller à ce tab.
               */
              let tabId = tabs[i].buttonId;

              $("#" + tabId).click();

              break;
            }
          }
        }
      } else {
        /**
         * S'il faut aller au précédent tab.
         */
        for (i = tabs.length - 1; i >= 0; i--) {
          if (fromTab === tabs[i].name) {
            currentTabIndex = i;
          }

          if (currentTabIndex !== null && i < currentTabIndex) {
            if (this.canAccessTab(tabs[i].name)) {
              /**
               * Aller à ce tab.
               */
              document.getElementById(tabs[i].buttonId).click();
              break;
            }
          }
        }
      }
    },
    displayLoader(
      value /** method pour afficher/cacher le loader à la démande d'un child component */
    ) {
      if (value) {
        this.isLoading = true;
      } else {
        this.isLoading = false;
      }
    },
    /** method pour mettre à jour le contenu affiché */
    updateContent() {
      var formData = new FormData();
      formData.append("diligence_id", this.diligenceId);
      formData.append("client_id", this.client.client_id);
      this.$store.dispatch("viewDiligenceDetails", formData).then((res) => {
        this.dataLoaded = true;
      });
    },
    blockTabChange(
      tab /** method pour bloquer la passation à un autre tab tant que les Tabs précédents ne sont pas totalement remplies */
    ) {
      /**
       * Checker si toutes les questions du questionnaire ont été complètement répondues.
       */
      var total_questions = this.questionnaireCompletion.total_questions;
      var total_reponses = this.questionnaireCompletion.total_reponses;
      if (total_questions - total_reponses > 0) {
        return true;
      }

      return false;
    },
    canAccessTab(
      tab /** method pour checker si l'on peut acceder à ce tab par rapport au type de diligence */
    ) {
      /**
       * Type de diligence.
       * */
      var diligenceType = this.diligence.diligence_type;

      if (tab === "actifs") {
        /**
         * Exclure ces types des diligence pour ne pas accéder au tab actif,
         * */
        if (diligenceType.includes("juridique") || diligenceType.includes("fournisseur")) {
          return false;
        }
      } else if (tab === "credits") {
        /**
         * Exclure ces types de diligence pour ne pas accéder au tab credits.
         * */
        if (
          diligenceType.includes("juridique") ||
          diligenceType.includes("basique") ||
          diligenceType.includes("actif")
        ) {
          return false;
        }
      }

      return true;
    },
  },
  computed: {
    client() {
      return this.$store.getters.getClient;
    },
    diligence() {
      var diligences = this.$store.getters.getDiligences;
      //console.clear(); console.log("2getters..");
      //console.log(diligences);
      var diligence = {};
      for (var i = 0; i < diligences.length; i++) {
        if (diligences[i].diligence_id === this.diligenceId) {
          diligence = diligences[i];
        }
      }
      return diligence;
    },
    questionnaireCompletion() {
      return this.$store.getters.getQuestionsCompletion;
    },
  },
  mounted() {
    this.diligenceId = this.$route.params.id;

    /**
     * Si client a été redirigé sur cette page après avoir effectué un paiement bancaire.
     */
    if (location.href.includes("paiement")) {
      this.isLoading = true;
      setTimeout(() => {
        /**
         * Generer un click au bouton censé affiché le tab pay_tab.
         */
        document.getElementById("certificatTab").click();
        document.getElementById("paiementEnCour").click();
        this.isLoading = false;
      }, 3000);
    }

    this.updateContent();
  },
  created() {
    this.diligenceId = this.$route.params.id;
  },
};
</script>
