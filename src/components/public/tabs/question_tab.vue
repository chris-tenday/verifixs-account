<template>
  <div data-aos="fade-up">
    <go_to_tab :allownexttab="allowNextTab" @gototab="goToTab" :previoustab="false"></go_to_tab>
    <form>
      <div class="row g-2">
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
          <label class="form-label text-dark fw-bold"> {{ question.question | capitalize }} <sup
              class="text-danger">*</sup>
          </label>
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
                  placeholder="Entrez votre réponse !" v-model="reponse.reponse"
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
                <h3 class="fw-400 mb-3 text-dark fs-4" v-if="reponse.reponse !== ''">
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
          <camera :dataImg="question.reponses[0].media" @onCapture="cameraCapture" :captured="documentUploaded"
            @onDelete="deleteCapture"></camera>
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
import QuestionTabMixin from "../mixins/question-tab.mixin";
export default {
  components: { camera, go_to_tab },
 mixins:[QuestionTabMixin]
};
</script>
<style>
#inputPhone {
  margin-bottom: 10px;
}
</style>
