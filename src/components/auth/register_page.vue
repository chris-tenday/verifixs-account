<template>
  <div class="d-flex align-items-center justify-content-center auth-box"
    style="overflow: auto; height: 100%; width: 100%">
    <div class="container">
      <div class="row d-flex align-items-center justify-content-center">
        <div class="col-xl-8 col-lg-10 col-md-10 col-sm-12 col-12">
          <div class="card mt-lg-6 mt-sm-10 border-0 auth-box-shadow mb-lg-3 mb-ms-10">
            <div class="card-body">
              <img src="assets/images/logos/logo_color.svg" class="mb-3" style="width: 180px" title="logo" />
              <p>
                Veuillez renseigner toutes les informations requises pour créer un compte
                !
              </p>
              <form class="row g-3 mt-3" id="form-register" @submit.prevent="registerAccount" novalidate>
                <!-- Text input-->
                <div class="col-md-12">
                  <label class="form-label" for="name">Nom complet <span class="text-danger">*</span></label>
                  <input id="name" name="name" type="text" placeholder="Nom complet... ex:Lumba Jean" class="form-control"
                    v-model="register.nom" required />
                  <div class="invalid-feedback">Votre nom est requis !</div>
                </div>
                <!-- Text input-->
                <div class="col-md-6">
                  <label class="form-label" for="email">Adresse email <span class="text-danger">*</span></label>
                  <input id="email" name="email" type="email" placeholder="adresse e-mail... ex:gaston@domain"
                    class="form-control" v-model="register.email" required />
                  <div class="invalid-feedback">Votre adresse e-mail est requise !</div>
                </div>
                <!-- Text input-->
                <div class="col-md-6">
                  <label class="form-label" for="phone">Téléphone <span class="text-danger">*</span></label>
                  <phone-input v-model="phone" size="lg" :translations="translations" default-country-code="CD"
                    :no-example="true" @update="updatePhone" :required="true" />
                  <div class="invalid-feedback">Votre numéro de tél. requis !</div>
                </div>
                <!-- Select Basic -->

                <div class="col-md-6">
                  <label class="form-label" for="pass">Mot de passe <span class="text-danger">*</span></label>
                  <input id="pass" name="pass" type="password" placeholder="Mot de passe... " class="form-control "
                    v-model="register.pass" required />
                  <div class="text-danger" v-if="error">
                    <!-- <ul :v-if='invalid'> -->
                    {{ error }}
                    <!-- </ul> -->
                    <!-- Mot de passe requis ! -->
                  </div>
                  <!-- <div class="invalid-feedback">Mot de passe requis !</div> -->
                </div>

                <div class="col-md-6">
                  <label class="form-label" for="pass">Confirmation mot de passe <span
                      class="text-danger">*</span></label>
                  <input id="confirmpass" name="confirmpass" type="password" placeholder="Confirmation mot de passe... "
                    v-model="register.confirmPass" class="form-control" required />
                  <div class="text-danger" v-if="isDifferent">
                    Le mot de passe saisi ne correspond pas
                    <!-- Veuillez rétaper votre mot de passe ! -->
                  </div>
                </div>
                <div class="col-md-12">
                  <input class="form-check-input" type="checkbox" v-model="checked" id="invalidCheck" required />
                  <label class="form-check-label" for="invalidCheck">
                    <span class="ml-3">J'accepte les termes & politiques de confidentialité !</span>
                  </label>
                </div>

                <div class="mb-1 col-md-12 mt-4">
                  <div class="d-grid mb-2">
                    <button type="submit" :disabled="isLoading" class="btn bg-dual-gradient border-0 text-white">
                      <span class="me-1 spinner-border spinner-border-sm" v-if="isLoading"></span>
                      Créer un compte
                    </button>
                  </div>
                  <p class="text-center">
                    Vous avez déjà un compte ?
                    <a class="link-success" href="javascript:void(0)"
                      @click.prevent="$router.replace({ name: 'login' })">connectez-vous !</a>
                  </p>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <button id="btn-privacy" data-bs-toggle="modal" data-bs-target="#privacyModal" class="d-none"></button>

    <privacy-modal pdf-src="assets/privacy-policy.pdf" @onAccepted="checked = $event"
      @onRefused="checked = $event"></privacy-modal>
  </div>
</template>
<script>
import $ from "jquery";
export default {
  data() {
    var register = {
      personalite: "physique",
      nom: "",
      email: "",
      telephone: "",
      pass: "",
      confirmPass: "",
    };
    return {
      register: register,
      isLoading: false,
      checked: "",
      translations: {
        countrySelectorLabel: "Code pays",
        countrySelectorError: "Choisir un pays",
        phoneNumberLabel: "Ex. 81xxxxxxx",
        example: "Ex. :810000000",
      },
      phone: "",
      invalid: true,
      error: '',
      isDifferent: false,
    };
  },
  watch: {
    checked(val) {
      let modalShow = $("#btn-privacy");
      if (val) {
        console.log(val);
        modalShow.click();
      }
    },

    'register.pass'(val) {
      if (val) {
        this.invalid = this.validatePassword();
      }
    }
  },
  methods: {
    validatePassword() {
      var nmb = 0;
      var maj = 0;
      var min = 0;
      var spec = 0;
      var specialChar = /[`!@#$%^&*()_+\-=\\|,.`<>?~]/;

      if (this.register.pass.length >= 8) {

        for (var i of this.register.pass) {
          if (!isNaN(i * 1)) {
            nmb += 1;
          }
          else if (specialChar.test(i)) {
            spec++;
          }
          else if (i !== i.toLowerCase()) {
            maj++;
          }
          else if (i !== i.toUpperCase()) {
            min = min + 1;
          }
        }
        if (nmb || maj || min || spec) {
          if (nmb == 0) {
            this.error = "Votre mot de passe doit contenir au moins 1 chiffre";
            return true;
          }
          if (maj == 0) {
            this.error = 'Votre mot de passe doit contenir au moins 1 lettre en majuscule';
            return true;
          }
          if (min == 0) {
            this.error = "Votre mot de passe doit contenir au moins 1 lettre en minuscule";
            return true;
          }
          if (spec == 0) {
            this.error = 'Votre mot de passe doit contenir au moins 1 caractère spécial';
            return true;
          }
          this.error = "";
          return false;
        }
      }
      else {
        this.error = 'Votre mot de passe doit contenir minimum 8 caractères';
        return true;
      }
    },
    registerAccount(event) {
      console.log(this.register.telephone);
      // Fetch all the forms we want to apply custom Bootstrap validation styles to
      const forms = document.querySelectorAll("#form-register");
      // Loop over them and prevent submission
      Array.from(forms).forEach((form) => {
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
          console.log("form not validated!");
          form.classList.add("was-validated");
          return;
        }
        //form.classList.add("was-validated");
        if (form.checkValidity()) {

          // this.validatePassword();
          // console.log('Hello');

          this.isLoading = true;
          var formData = new FormData();
          formData.append("personnalite", this.register.personalite);
          formData.append("nom", this.register.nom);
          formData.append("email", this.register.email);
          formData.append("telephone", this.register.telephone);
          formData.append("pass", this.register.pass);
          this.$store.dispatch("registerAccount", formData).then((res) => {
            this.isLoading = false;
            console.log(res);
            if (res.reponse !== undefined && res.reponse.status === "success") {
              this.$router.go(this.$router.replace({ name: "home" }));
            } else {
              this.$swal({
                title: res.error,
                icon: "error",
                timer: 3000,
                toast: true,
                showConfirmButton: false,
              });
            }
          });
        }
      });
    },

    updatePhone(value) {
      this.register.telephone = value.e164;
    },
  },
};
</script>

<style>
.wrong .fa-check {
  display: none;
}

.good .fa-times {
  display: none;
}

.valid-feedback,
.invalid-feedback {
  margin-left: calc(2em + 0.25rem + 1.5rem);
}
</style>
