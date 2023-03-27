export default {
  name: "Question-tab-mixin",
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
    provinces() {
      return this.$store.state.provinces;
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
            text: "Numéro de téléphone ne doit pas commencer par 0 !",
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
            text: "Numéro de téléphone invalide",
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
    isQuestionnaireCompleted: function() {
      var questions = this.questionnaireCompletion.total_questions;
      var reponses = this.questionnaireCompletion.total_reponses;
      if (questions === reponses) {
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
      this.question.reponses[0].reponse = data;
    },
    /** method pour supprimer une capture */
    deleteCapture() {
      this.documentUploaded = null;
    },
    /** method pour passer à la question suivante */
    async nextQuestion() {
      /* Checker les adresses vides */

      console.log(JSON.stringify(this.question));

      if (this.question.split) {
        let obj = this.question.reponses[this.question.reponses.length - 1];
        for (let i in obj) {
          let address = `${obj[i]}`.trim();
          if (address === "") {
            this.displayMsg(
              "Vous devez entrer une adresse complet !",
              "warning"
            );
            return;
          }
        }
      }
      if (
        this.question.question.includes("condamné en justice") &&
        this.question.reponses[0].reponse.includes("Non")
      ) {
        /**
         * Exiger la permission de vérification sur l'authentification de cette reponse.
         * */
        var confirmed = false;

        await this.$swal({
          title:
            "Est-ce que vous autoriser à vérifier cette information auprès des instances judiciaires?",
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
        if (
          this.documentUploaded === null &&
          this.mustUploadDocument === true
        ) {
          if (this.question.reponse_type === "attachment") {
            this.displayMsg("Veuillez attacher un document.");
            return false;
          } else {
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

        if (
          this.question.obligatoire === "oui" &&
          this.question.reponses[0].reponse.length < 1
        ) {
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
            this.question.reponses[i].diligence_questionnaire_id !==
              undefined &&
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

          await this.$store
            .dispatch("repondreQuestion", formData)
            .then((res) => {
              if (
                res.reponse === undefined ||
                res.reponse.status !== "success"
              ) {
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
          await this.$store
            .dispatch("repondreQuestion", formData)
            .then((res) => {
              console.log("Res:" + res);

              if (
                res.reponse === undefined ||
                res.reponse.status !== "success"
              ) {
                this.displayMsg(
                  "Votre document précédent n'a pas été téléchargé"
                );
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
      this.$store.dispatch("viewDiligenceDetails", formData).then((_) => {
        if (this.question.reponse_type === "attachment") {
          this.$refs.formFile.reset();
        }
      });
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
          province: "",
          avenue: "",
          numero: "",
          quartier: "",
          thiserence: "",
          commune: "",
        };
      }
      this.question.reponses.push(reponse);
    },

    uploadDocument(event) {
      let file = event.target.files[0];
      //console.log(file);
      this.documentUploaded = file;
      console.clear();
      console.log(JSON.stringify(this.question));
      console.log(this.documentUploaded);
      /* document.getElementById("documentUploadedPreview").src = URL.createObjectURL(file); */
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
