<template>
  <div data-aos="fade-up">
    <go_to_tab :allownexttab="allowNextTab" @gototab="goToTab" :previoustab="false"></go_to_tab>
    <form @submit.prevent="nextQuestion">
      <div class="row g-2">
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
          <label class="form-label text-dark fw-bold"> {{ question.question | capitalize }} <sup
              v-if="question.obligatoire === 'oui'" class="text-danger">*</sup>
          </label>
        </div>
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"
          v-if="question.reponse_type === 'text' || question.reponse_type === 'telephone' || question.reponse_type === 'date'">
          <div v-if="question.split === undefined">
            <div v-if="question.total_reponse !== 'multiple'">
              <!-- reponse type date !-->
              <div class="mb-3" v-if="question.reponse_type === 'date'">
                <custom-date-input :required="question.obligatoire === 'oui'" v-for="reponse in question.reponses"
                  :key="reponse.diligence_questionnaire_id" :selected-value="reponse.reponse"
                  @input="reponse.reponse = $event" />
              </div>
              <!-- reponse type text !-->
              <div class="mb-3" v-else>
                <input v-for="reponse in question.reponses" :type="question.reponse_type" id="subj" class="form-control"
                  placeholder="Entrez votre réponse !" v-model="reponse.reponse" :key="reponse.diligence_questionnaire_id"
                  :required="question.obligatoire === 'oui'" />
              </div>
            </div>

            <div v-if="question.total_reponse === 'multiple'">
              <!-- reponse type phone !-->
              <div v-if="question.reponse_type.includes('telephone')">
                <phone-input id="inputPhone" v-for="reponse in question.reponses"
                  :key="reponse.diligence_questionnaire_id" v-model="reponse.reponse" size="lg"
                  :translations="translations" default-country-code="CD" :no-example="true" color="#FF0000"
                  @update="updateCountryCode" :required="question.obligatoire === 'oui'" />
              </div>
              <!-- reponse type text !-->
              <div v-else>
                <input v-for="reponse in question.reponses" :type="question.reponse_type" id="subj" class="form-control"
                  placeholder="Entrez votre reponse !" v-model="reponse.reponse" :key="reponse.diligence_questionnaire_id"
                  :required="question.obligatoire === 'oui'" />
              </div>

            </div>
            <button style="margin-top: 5px;" v-if="question.total_reponse === 'multiple'" @click.prevent="addAnswer"
              class="btn btn-outline-primary btn-sm mb-3">
              <i class="bi bi-plus me-2"></i>Ajouter
            </button>
          </div>
          <div v-else>
            <button class="btn btn-outline-primary btn-sm mb-2" @click.prevent="addAnswer"><i
                class="bi bi-plus me-1"></i>Ajouter adresse</button>
            <div v-for="(reponse, i) in question.reponses" :key="i" class="mb-2 border-1 border-bottom">
              <div class="d-flex align-items-center mb-2 justify-content-between">
                <p class="fw-300 mb-2" v-if="reponse.reponse !== ''">
                  <i class="bi-signpost-2-fill me-2 text-primary"></i> {{ reponse.reponse }}
                </p>
              </div>
              <div class="col-md-12">
                <div v-if="reponse.reponse === ''" class="d-flex justify-content-between align-content-center">
                  <div>
                    <div class="form-check form-check-inline mb-2">
                      <input class="form-check-input" value="" type="radio" id="adresse_type" name="adresse_type" checked
                        :required="question.obligatoire === 'oui'" />
                      <label class="form-check-label" style="cursor: pointer" id="adresse_type" name="adresse_type">
                        Domiciliaire
                      </label>
                    </div>
                    <div class="form-check form-check-inline mb-2">
                      <input class="form-check-input" value="" type="radio" id="adresse_type" name="adresse_type"
                        :required="question.obligatoire === 'oui'" />
                      <label class="form-check-label" style="cursor: pointer" id="adresse_type">
                        Professionnelle
                      </label>
                    </div>
                  </div>
                  <button v-if="question.reponses.length > 1" class="btn btn-outline-danger btn-sm"
                    @click.prevent="question.reponses.splice(i, 1)"><i class="bi bi-x me-1"></i> Réduire</button>
                </div>
              </div>
              <address-field v-if="reponse.reponse === ''" :model="reponse"></address-field>
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
            <form ref="formFile">
              <input type="file" ref="documentUploaded" id="documentUploaded" @change="uploadDocument"
                class="form-control-file" :required="question.obligatoire === 'oui'" />
            </form>
          </div>
        </div>

        <!-- reponse type camera capture !-->
        <div v-if="question.reponse_type === 'capture'" class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
          <camera :dataImg="question.reponses[0].media" @onCapture="cameraCapture" :captured="documentUploaded"
            @onDelete="deleteCapture"></camera>
        </div>

        <!-- next & previos button section !-->
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
          <!--st-pagination-->
          <nav>
            <ul class="pagination">
              <li class="page-item" :class="index == 0 ? 'disabled' : ''">
                <button @click.prevent="previousQuestion" class="page-link">Précédent</button>
              </li>
              <li class="page-item disabled">
                <span class="fw-bold p-2 p-lg-2 bg-app page-link text-white">{{ index + 1 }} / {{ questionnaire.length
                }}</span>
              </li>
              <li :class="
                index > questionnaire.length - 1 || isQuesttionLoading ? 'disabled' : ''
              " class="page-item">
                <button class="page-link" type="submit">
                  <span class="spinner-border spinner-border-sm" v-if="isQuesttionLoading"></span>
                  Suivant</button>
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
import QuestionTabMixin from "../mixins/question-tab.mixin";
export default {
  components: { camera, go_to_tab },
  mixins: [QuestionTabMixin]
};
</script>
<style>
#inputPhone {
  margin-bottom: 10px;
}

.btn-increment {
  width: 100%;
  height: auto;
  border: none;
  align-items: center;
  text-align: center;
  color: #fff;
  border-radius: 3px;
  margin: 1px;

}
</style>
