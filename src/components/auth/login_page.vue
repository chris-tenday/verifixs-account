<template>
  <div class="d-flex align-items-center justify-content-center auth-box" data-aos="zoom-in"
    style="overflow: hidden; height: 100vh; width: 100%">
    <div class="container">
      <div class="row d-flex align-items-center justify-content-center">
        <div class="col-xl-5 col-lg-5 col-md-6 col-sm-12 col-12">
          <div class="card auth-box-shadow">
            <div class="card-body">
              <img src="assets/images/logos/logo_color.svg" class="mb-3" style="width: 180px" title="logo" />
              <p>Veuillez vous connecter à votre compte !</p>
              <form method="post" id="form-login" @submit.prevent="loginAccount" novalidate>
                <!-- Text input-->
                <div class="mb-3">
                  <label class="form-label sr-only" for="identifiant">Email ou Téléphone</label>
                  <input id="identifiant" name="identifiant" v-model="login.identifiant" type="text"
                    placeholder="Email ou téléphone..." class="form-control" required />
                  <div class="invalid-feedback">Email ou téléphone requis !</div>
                </div>
                <!-- Text input-->
                <div class="mb-3">
                  <label class="form-label sr-only" for="pass">Mot de passe</label>
                  <input id="pass" name="pass" type="password" v-model="login.pass" placeholder="Mot de passe ..."
                    class="form-control " required />
                  <div class="invalid-feedback">
                    <!-- {{ error }} -->
                    Mot de passe requis !
                  </div>
                </div>

                <div class="mb-3 mb-0 d-grid">
                  <button type="submit" :disabled="isLoading" class="btn text-white border-0 bg-app">
                    <span class="spinner-border spinner-border-sm me-1" v-if="isLoading"></span>
                    <i class="fas fa-unlock me-1" v-else></i> Connecter
                  </button>
                </div>
                <p class="text-center p-0">
                  Vous n'avez pas un compte ?
                  <a class="link-primary fw-bold" href="javascript:void(0)"
                    @click.prevent="$router.replace({ name: 'register' })">créez un compte !</a>
                </p>
                <p class="text-center p-0">
                  <a class="link-primary fw-bold" href="javascript:void(0)"
                    @click.prevent="$router.push({ name: 'reset' })">Mot
                    de passe oublié !</a>
                </p>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  destroyed() {
    if (this.loggedIn) {
      this.$router.go();

    }
  },
  data() {
    var login = {
      identifiant: "",
      pass: "",

    };

    return {
      login: login,
      isLoading: false,
      date: "",
      loggedIn: false
    };
  },
  methods: {

    loginAccount(event) {


      const forms = document.querySelectorAll("#form-login");
      // Loop over them and prevent submission
      Array.from(forms).forEach((form) => {
        // console.log(this.login.pass);
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
          form.classList.add("was-validated");
        }

        if (form.checkValidity()) {
          // console.log(this.login.pass + '  2');

          this.isLoading = true;
          var formData = new FormData();
          formData.append("identifiant", this.login.identifiant);
          formData.append("pass", this.login.pass);

          this.$store.dispatch("loginAccount", formData).then((res) => {
            this.isLoading = false;
            console.log(res);
            if (res === false) {
              return
            }
            if (res.reponse !== undefined && res.reponse.status === "success") {
              this.loggedIn = true;
              this.$router.push({ name: "home" })
              this.isLoading = true;
            } else {
              this.$swal({
                title: res.error,
                icon: "error",
                timer: 3000,
                toast: true,
                showConfirmButton: false,
              });
            }
          }).catch((_) => {
            this.isLoading = false
          });
        }
      });
    },

    getDate(date) {
      this.date = date;
      console.log("new date" + this.date);
    },
  },
};
</script>
