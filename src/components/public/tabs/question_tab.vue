<template>
  <div data-aos="fade-up">
    <go_to_tab :allownexttab="allowNextTab" @gototab="goToTab" :previoustab="false"></go_to_tab>
    <form>
      <div class="row g-2">
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
          <div class="row">
            <div class="col-md-12">
              <h2 class="fw-bold mb-3">{{ question.question }} <sup class="text-danger">*</sup></h2>
            </div>
          </div>
        </div>
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"
          v-if="question.reponse_type === 'text' || question.reponse_type === 'telephone' || question.reponse_type === 'date'">

          <div v-if="question.split === undefined">
            <div v-if="question.total_reponse !== 'multiple'">
              <!-- reponse type date !-->
              <div class="mb-3" v-if="question.reponse_type === 'date'">
                <custom-date-input v-for="reponse in question.reponses" :key="reponse.diligence_questionnaire_id"
                  :selected-value="reponse.reponse" @input="reponse.reponse = $event" />
              </div>
              <!-- reponse type text !-->
              <div class="mb-3" v-else>
                <input v-for="reponse in question.reponses" :type="question.reponse_type" id="subj" class="form-control"
                  placeholder="Entrez votre reponse !" v-model="reponse.reponse"
                  :key="reponse.diligence_questionnaire_id" />
              </div>
            </div>

            <div v-if="question.total_reponse === 'multiple'">
              <!-- reponse type phone !-->
              <div v-if="question.reponse_type.includes('telephone')">
                <phone-input id="inputPhone" v-for="reponse in question.reponses"
                  :key="reponse.diligence_questionnaire_id" v-model="reponse.reponse" size="lg"
                  :translations="translations" default-country-code="CD" :no-example="true" color="#FF0000"
                  @update="updateCountryCode" />
              </div>
              <!-- reponse type text !-->
              <div v-else>
                <input v-for="reponse in question.reponses" :type="question.reponse_type" id="subj" class="form-control"
                  placeholder="Entrez votre reponse !" v-model="reponse.reponse"
                  :key="reponse.diligence_questionnaire_id" />
              </div>

            </div>
            <button style="margin-top: 5px;" v-if="question.total_reponse === 'multiple'" @click.prevent="addAnswer"
              class="btn btn-primary btn-sm mb-3">
              <i class="fa fa-plus me-2"></i>Ajouter
            </button>
          </div>

          <div v-else>
            <div v-for="(reponse, i) in question.reponses" :key="i">
              <div class="d-flex align-items-center mb-2 justify-content-between">
                <h3 class="fw-semi-bold mb-3 text-dark fs-4" v-if="reponse.reponse !== ''">
                  <i class="fa fa-map-marker me-2 text-success"></i> {{ reponse.reponse }}
                </h3>
                <p v-else></p>
              </div>
              <div class="input-group mb-2" v-if="i === question.reponses.length - 1">
                <div class="col-md-12" v-if="reponse.reponse === ''">
                  <div class="form-check form-check-inline mb-2">
                    <input class="form-check-input" value="" type="radio" id="adresse_type" name="adresse_type" checked />
                    <label class="form-check-label" style="cursor: pointer" id="adresse_type" name="adresse_type">
                      Domiciliaire
                    </label>
                  </div>
                  <div class="form-check form-check-inline mb-2">
                    <input class="form-check-input" value="" type="radio" id="adresse_type" name="adresse_type" />
                    <label class="form-check-label" style="cursor: pointer" id="adresse_type">
                      Professionnelle
                    </label>
                  </div>
                </div>

                <!-- reponse type adresse !-->
                <input v-if="reponse.reponse === ''" type="text" id="subj" class="form-control rounded m-1"
                  style="width: 120px" placeholder="Avenue" v-model="reponse.split.avenue" />
                <input v-if="reponse.reponse === ''" type="text" style="width: 60px" id="subj"
                  class="form-control rounded m-1" placeholder="no." v-model="reponse.split.numero" />
                <input v-if="reponse.reponse === ''" type="text" id="subj" class="form-control rounded m-1"
                  style="width: 110px" placeholder="Quartier" v-model="reponse.split.quartier" />
                <input v-if="reponse.reponse === ''" type="text" id="subj" style="width: 110px"
                  class="form-control m-1 rounded" placeholder="Référence" v-model="reponse.split.reference" />
                <input v-if="reponse.reponse === ''" type="text" style="width: 110px" id="subj"
                  class="form-control rounded m-1" placeholder="Commune" @change="
                    handleSplit(
                      reponse,
                      'Avenue ' + reponse.split.avenue,
                      ' Numéro ' + reponse.split.numero,
                      'Quartier ' + reponse.split.quartier,
                      ' Référence ' + reponse.split.reference,
                      ' Commune ' + reponse.split.commune
                    )
                  " v-model="reponse.split.commune" />
                <button v-if="i === question.reponses.length - 1" type="button"
                  class="btn btn-dark-primary mt-1 rounded btn-sm" style="height: 48px" @click.prevent="addAnswer">
                  <span v-if="reponse.reponse !== ''">Ajouter adresse</span>
                  <i v-else class="fa fa-plus fs-7"></i>
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- reponses type fixe/radio buttons !-->
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" v-if="question.reponse_type === 'fixe'">
          <div class="form-check form-check-inline mb-2" v-for="reponse_fixe in question.reponse_fixes"
            :key="reponse_fixe.reponse_fixe_id">
            <input class="form-check-input" :value="reponse_fixe.reponse" v-model="question.reponses[0].reponse"
              type="radio" :id="'label' + reponse_fixe.reponse_fixe_id" />
            <label class="form-check-label" style="cursor: pointer" :for="'label' + reponse_fixe.reponse_fixe_id">
              {{ reponse_fixe.reponse }}
            </label>
          </div>
        </div>

        <!-- reponse type file !-->
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" v-if="question.reponse_type === 'attachment'">
          <a :href="question.reponses[0].media" target="_blank"><img v-if="!mustUploadDocument"
              :src="question.reponses[0].media" id="documentUploadedPreview"
              class="img-fluid w-lg-30 w-sm-100 mb-3 img-thumbnail rounded shadow-sm" alt="Show Document preview" /></a>
          <div class="mb-3">
            <input type="file" id="documentUploaded" @change="uploadDocument" class="form-control-file" />
          </div>
        </div>

        <!-- reponse type camera capture !-->
        <div v-if="question.reponse_type === 'capture'" class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
          <div class="d-flex align-content-center justify-content-center m-lg-5 m-sm-2">
            <div style="width: 300px; height: 300px" class="p-2">
              <camera v-if="mustUploadDocument === true" @onCapture="cameraCapture" @onDelete="deleteCapture"
                :captured="documentUploaded"></camera>
              <img v-else :src="question.reponses[0].media" alt="Photo preview"
                class="img-fluid w-100 rounded img-thumbnail" />
            </div>
          </div>
        </div>

        <!-- next & previos button section !-->
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
          <!--st-pagination-->
          <nav>
            <ul class="pagination">
              <li class="page-item" :class="index == 0 ? 'disabled' : ''">
                <a href="javascript:void(0)" @click.prevent="previousQuestion" class="page-link">Précédent</a>
              </li>
              <li class="page-item disabled">
                <span class="fw-bold p-2 p-lg-2 bg-app page-link text-white">{{ index + 1 }} / {{ questionnaire.length
                }}</span>
              </li>
              <li :class="
                index > questionnaire.length - 1 || isQuesttionLoading ? 'disabled' : ''
              " class="page-item">
                <a class="page-link" href="javascript:void(0)" @click.prevent="nextQuestion">
                  <span class="spinner-border spinner-border-sm" v-if="isQuesttionLoading"></span>
                  Suivant</a>
              </li>
            </ul>
          </nav>

          <!--/.st-pagination-->
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import go_to_tab from "../go_to_tab";
import camera from "@/components/widgets/camera";

export default {
  components: { camera, go_to_tab },
  data() {
    return {
      index: 0,
      question: {},
      sousQuestions: [],
      diligenceId: 0,
      isQuesttionLoading: false,
      documentUploaded: null,
      mustUploadDocument: true,
      allowNextTab: false,
      translations: {
        countrySelectorLabel: "Code pays",
        countrySelectorError: "Choisir un pays",
        phoneNumberLabel: "Ex. 810000000",
        example: "Ex. 810000000",
        data: "",
      },
    };
  },
  computed: {
    questionnaire() {
      return this.$store.getters.getQuestionnaire;
    },
    client() {
      return this.$store.getters.getClient;
    },
    questionnaireCompletion() {
      return this.$store.getters.getQuestionsCompletion;
    },
  },
  methods: {
    updateCountryCode(value) {
      if (value.formatNational !== undefined) {
        if (value.nationalNumber[0] === "0") {
          this.$swal({
            text: 'Numéro de téléphone ne doit pas commencer par 0 !',
            icon: "warning",
            timer: 3000,
            toast: true,
            showConfirmButton: false,
          });
          this.question.reponses[0].reponse = "";
          return;
        }
        if (value.nationalNumber.length > 9) {
          this.$swal({
            text: 'Numéro de téléphone invalide',
            icon: "warning",
            timer: 3000,
            toast: true,
            showConfirmButton: false,
          });
          this.question.reponses[0].reponse = "";
          return;
        }
        this.question.reponses[0].reponse = value.e164;
      }
    },
    /** method pour checker si le questionnaire est complètement bien rempli */
    isQuestionnaireCompleted() {
      var questions = this.questionnaireCompletion.total_questions;
      var reponses = this.questionnaireCompletion.total_reponses;

      if (questions == reponses) {
        this.allowNextTab = true;
        this.index = 0;
        return true;
      } else {
        this.allowNextTab = false;
        return false;
      }
    },
    goToTab(nextTab) {
      if (nextTab) {
        this.$emit("gotonexttab");
      } else {
        this.$emit("gotoprevioustab");
      }
    },
    goToNextTab() {
      /**
       * Throw event pour passer au Tab de actifs.
       */
      this.$emit("gotonexttab");
    },
    cameraCapture(data) {
      this.documentUploaded = data;
    },
    /** method pour supprimer une capture */
    deleteCapture() {
      this.documentUploaded = null;
    },
    /** method pour passer à la question suivante */
    async nextQuestion() {
      /* Checker les adresses vides */

      if (this.question.split) {
        let obj = this.question.reponses[this.question.reponses.length - 1]
        for (let i in obj) {
          let address = `${obj[i]}`.trim();
          if (address === "") {
            this.displayMsg("Vous devez entrer une adresse complet !", "warning");
            return;
          }
        }
      }
      if (this.question.question.includes('condamné en justice') && this.question.reponses[0].reponse.includes("Non")) {
        /**
         * Exiger la permission de vérification sur l'authentification de cette reponse.
         * */
        var confirmed = false;

        await this.$swal({
          title: "Est-ce que vous autoriser à vérifier cette information auprès des instances judiciaires?",
          icon: "warning",
          toast: true,
          showConfirmButton: true,
          confirmButtonText: "Oui",
          showCancelButton: true,
          cancelButtonText: "Non",
        }).then((value) => {
          confirmed = value.isConfirmed;
        });

        if (!confirmed) {
          this.displayMsg("Désolé!! vous ne pouvez pas continuer.");
          return false;
        }
      }

      /**
       * Envoyer la réponse de cette question au serveur.
       * */
      var next = await this.sendReponseToServer();
      if (!next) {
        /**
         * Si le serveur n'a pas pu traiter la question.
         * */
        return false;
      }

      if (this.index < this.questionnaire.length - 1) {
        /**
         * Passer à la question suivante.
         * */
        this.index = this.index + 1;
        this.question = this.questionnaire[this.index];

        if (
          this.question.reponse_type === "attachment" ||
          this.question.reponse_type === "capture"
        ) {
          /**
           * Si la question doit prendre pour réponse un attachment ou capture.
           * */

          //TODO: preview document déjà uploadé dans le serveur.
          this.documentUploaded = this.question.reponses[0].reponse;
          if (
            this.question.reponses[0].media === undefined ||
            this.question.reponses[0].media === null
          ) {
            /**
             * Aucun upload effectué jusque là .
             * Exiger un upload au user.
             * */
            this.mustUploadDocument = true;
          } else {
            /**
             * Il existe déjà un document uplaodé dans le serveur.
             * Afficher cela en preview.
             * */
            this.mustUploadDocument = false;
          }
        }
      } else {
        this.goToNextTab();
      }
    },

    /** method pour revenir à la question précédente */
    previousQuestion() {
      this.index = this.index - 1;
      this.question = this.questionnaire[this.index];
    },

    /** method pour envoyer la réponse d'une question au serveur */
    async sendReponseToServer() {
      var answerSent = false;

      if (
        this.question.reponse_type === "attachment" ||
        this.question.reponse_type === "capture"
      ) {
        /**
         * Si la réponse de lq question est soit un attachment ou camera capture.
         * */
        if (this.documentUploaded === null && this.mustUploadDocument === true) {
          if (this.question.reponse_type === "attachment") {
            this.displayMsg("Veuillez attacher un document.");
            return false;
          }
          else {
            this.displayMsg("Veuillez vous prendre en photo.");
            return false;
          }
        } else {
          //return true;
        }
      } else {
        /**
         * Si la réponse de la question en text.
         * */

        if (this.question.reponses[0].reponse.length < 1) {
          this.displayMsg("Répondez à cette question d'abord !");
          return false;
        }
      }

      /**
       * Envoyer chaque réponse une par une de la meme question au serveur.
       * */
      var formData = new FormData();
      formData.append("client_id", this.client.client_id);
      formData.append("diligence_id", this.diligenceId);
      if (this.question.question_id === undefined || this.question === null) {
        /**
         * S'agissant d'une sous question.(question additionelle)
         * */
        formData.append("sous_question_id", this.question.sous_question_id);
      } else {
        /**
         * S'agissant d'une question.
         * */
        formData.append("question_id", this.question.question_id);
      }
      /**
       * s'il s'agit d'une question simple n'exigant pas l'attachement d'un document.
       * */
      if (this.documentUploaded === null) {
        for (var i = 0; i < this.question.reponses.length; i++) {
          if (
            this.question.reponses[i].diligence_questionnaire_id !== undefined &&
            this.question.reponses[i].diligence_questionnaire_id !== null
          ) {
            formData.append(
              "diligence_questionnaire_id",
              this.question.reponses[i].diligence_questionnaire_id
            );
          } else {
            formData.delete("diligence_questionnaire_id");
          }
          formData.append("reponse", this.question.reponses[i].reponse);
          this.isQuesttionLoading = true;

          await this.$store.dispatch("repondreQuestion", formData).then((res) => {
            if (res.reponse === undefined || res.reponse.status !== "success") {
              this.displayMsg(
                "Impossible d'enregistrer votre réponse à la question précédente !"
              );
            }

            answerSent = true;
            this.question.reponses[i].diligence_questionnaire_id =
              res.reponse.diligence_questionnaire_id;
            this.isQuesttionLoading = false;
          });
        }
      } else {
        /**
         * s'il s'agit d'une question dont la réponse est un attachment ou camera capture.
         * */

        /**
         * Question exigeant un document uploadé comme reponse.
         * */
        formData.append("fichier", this.documentUploaded);
        formData.append("designation", this.question.question);

        /**
         * Server request.
         * */
        if (this.documentUploaded instanceof File) {
          /**
           * Si Fichier uploadé.
           * Envoyer au serveur.
           * */
          this.isQuesttionLoading = true;
          await this.$store.dispatch("repondreQuestion", formData).then((res) => {
            //console.log(res);
            if (res.reponse === undefined || res.reponse.status !== "success") {
              this.displayMsg("Votre document précédent n'a pas été téléchargé");
            } else {
              this.documentUploaded = null;
              answerSent = true;
              this.isQuesttionLoading = false;
            }
          });
        } else {
          answerSent = true;
        }
      }

      this.documentUploaded = null; /** reinitialisation */

      /**
       * Throw event pour recharger le contenu à partir du parent component.
       */
      //this.$emit("updatecontent");
      formData = new FormData();
      formData.append("diligence_id", this.diligenceId);
      formData.append("client_id", this.client.client_id);
      await this.$store.dispatch("viewDiligenceDetails", formData).then();

      if (answerSent) {
        return true;
      } else {
        return false;
      }
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
    /** Method pour ajouter une réponse */
    addAnswer() {
      var reponse = {};
      reponse.reponse = "";
      if (this.question.split !== undefined) {
        /**
         * Gerer le split d'address
         * */
        reponse.split = {
          avenue: "",
          numero: "",
          quartier: "",
          reference: "",
          commune: "",
        };
      }

      this.question.reponses.push(reponse);
    },
    uploadDocument() {
      var file = document.getElementById("documentUploaded").files[0];
      //console.log(file);
      this.documentUploaded = file;
      document.getElementById("documentUploadedPreview").src = URL.createObjectURL(file);
    },
    handleSplit(reponse, ...data) {
      reponse.reponse = data.toString();
    },
  },
  created() {
    this.diligenceId = this.$route.params.id;
  },
  mounted() {
    this.diligenceId = this.$route.params.id;
    this.question = this.questionnaire[0];
    this.isQuestionnaireCompleted();
  },
  watch: {
    question(oldQuestion, newQuestion) {
      /*console.clear();
        console.log("Old: "+oldQuestion.question);
        console.log("New:" +newQuestion.question);*/
      /**
       * Update sousQuestions quand la question change.
       */
    },
  },
};
</script>
<style>
#inputPhone {
  margin-bottom: 10px;
}
</style>
