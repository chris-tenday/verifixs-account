<template>
    <div class="d-flex align-items-center justify-content-center auth-box"
        style="overflow: hidden; height: 100vh; width: 100%">
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="col-xl-5 col-lg-5 col-md-6 col-sm-12 col-12">
                    <div class="card auth-box-shadow">
                        <div class="card-body">
                            <img src="assets/images/logos/logo_color.svg" class="mb-3" style="width: 180px" title="logo" />
                            <p>Veuillez entrer votre email pour réinitialiser le mot de passe !</p>
                            <form id="form-reset" @submit.prevent="resetPwd" novalidate>
                                <!-- Text input-->
                                <div class="mb-3">
                                    <label class="form-label sr-only" for="identifiant">Email ou Téléphone</label>
                                    <input id="identifiant" name="identifiant" v-model="form.email" type="email"
                                        placeholder="Saisir adresse email..." class="form-control" required />
                                    <span class="invalid-feedback text-start">Entrer votre email pour réinitialise le mot de
                                        passe !
                                    </span>
                                </div>
                                <div class="mb-3 mb-0 d-grid">
                                    <button type="submit" :disabled="isLoading" class="btn text-white border-0 btn-info">
                                        <span class="spinner-border spinner-border-sm me-1" v-if="isLoading"></span>
                                        <i class="bi bi-lock-fill me-1" v-else></i> Réinitialiser
                                    </button>
                                </div>
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
    name: 'Reset-Pass',

    data() {
        return {
            isLoading: false,
            form: {
                email: ''
            }
        }
    },

    methods: {
        resetPwd(event) {
            const forms = document.querySelectorAll("#form-reset");
            // Loop over them and prevent submission
            Array.from(forms).forEach((form) => {
                // console.log(this.login.pass);
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                    form.classList.add("was-validated");
                }

                if (form.checkValidity()) {
                    console.log(this.form.email);
                }
            });
        }
    },
}
</script>