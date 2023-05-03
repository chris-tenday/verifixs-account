<template>
    <div class="d-flex align-items-center justify-content-center auth-box" data-aos="zoom-in"
        style="overflow: hidden; height: 100vh; width: 100%">
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="col-xl-5 col-lg-5 col-md-6 col-sm-12 col-12">
                    <div class="card auth-box-shadow">
                        <div class="card-body">
                            <img src="assets/images/logos/logo_color.svg" class="mb-3" style="width: 180px" title="logo" />

                            <div v-if="reset">
                                <p class="text-center">Veuillez réinitialiser votre mot de passe !</p>
                                <form id="form-reset" data-aos="fade-right" @submit.prevent="resetPass" novalidate>
                                    <!-- Text input-->
                                    <div class="mb-3">
                                        <label class="form-label" for="identifiant">Nouveau mot de passe</label>
                                        <input id="newPass" v-model="form.newPass" type="password"
                                            placeholder="Saisir votre nouveau mot de passe..." class="form-control"
                                            required />
                                        <span class="invalid-feedback text-start">Entrer votre nouveau mot de passe !
                                        </span>
                                        <div class="text-danger small" v-if="pwdError">
                                            <!-- <ul :v-if='invalid'> -->
                                            {{ pwdError }}
                                            <!-- </ul> -->
                                            <!-- Mot de passe requis ! -->
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" for="identifiant">Confirmation mot de
                                            passe</label>
                                        <input id="confirmPass" v-model="form.confirm" type="password"
                                            placeholder="Retaper votre nouveau mot de passe..." class="form-control"
                                            required />
                                        <span class="invalid-feedback text-start">confirmer nouveau mot de passe !
                                        </span>
                                        <div class="text-danger small" v-if="isDifferent">
                                            Le mot de passe saisi ne correspond pas !
                                        </div>
                                    </div>
                                    <div class="mb-3 mb-0 d-grid">
                                        <button type="submit" :disabled="isLoading"
                                            class="btn text-white border-0 btn-success">
                                            <span class="spinner-border spinner-border-sm me-1" v-if="isLoading"></span>
                                            <i class="bi bi-check-circle me-1" v-else></i> Réinitialiser maintenant
                                        </button>
                                    </div>
                                </form>
                            </div>
                            <div v-else>
                                <div v-if="isOtp" data-aos="fade-up">
                                    <p class="text-center">Entrer le code reussi à votre numéro de
                                        téléphone <strong class="text-primary">{{ form.phone.substring(0, 6)
                                        }}<small>°°°°°°°°°</small>{{
    form.phone.slice(-2) }}</strong> !</p>
                                    <otp-input ref="otpInput1" :num-inputs="6" :should-auto-focus="true" separator="-"
                                        input-type="number" @on-change="emptyField" @on-complete="checkOtp" />

                                    <div class="d-flex mt-2 align-center justify-content-center align-items-center">
                                        <p>Vous n'avez reussi le code ? <a href="javascript:void(0)" :disabled="isLoading"
                                                class="link-dark-info fw-semi-bold" @click="sendOtp">Renvoyez le code <i
                                                    v-if="isLoading" class="mx-2 fa fa-spinner fa-spin"></i></a>
                                        </p>
                                    </div>
                                </div>

                                <form data-aos="fade-left" v-else id="form-reset" @submit.prevent="resetPwdSendOtp"
                                    novalidate>
                                    <!-- Text input-->
                                    <div class="mb-3 form-group">
                                        <label class="form-label" for="phone">Entrer le numéro de téléphone lié à
                                            votre compte</label>
                                        <phone-input v-model="phone" id="phone" class="form-control p-0" size="lg"
                                            :translations="translations" default-country-code="CD" :no-example="true"
                                            @update="updatePhone" :required="true" color="#FF0000" />
                                        <span class="invalid-feedback">Entrer votre numéro pour recevoir un code
                                            de réinitialisation !
                                        </span>

                                    </div>

                                    <div class="mb-3 mb-0 d-grid">
                                        <button type="submit" :disabled="isLoading"
                                            class="btn text-white border-0 btn-info">
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
    </div>
</template>

<script>
export default {
    name: 'Reset-Pass',

    data() {
        return {
            isLoading: false,
            isOtp: false,
            reset: false,
            pwdError: '',
            isPwValid: false,
            isDifferent: false,
            phone: '',
            translations: {
                countrySelectorLabel: "Code pays",
                countrySelectorpwdError: "Choisir un pays",
                phoneNumberLabel: "Ex. 810000000",
                example: "Ex. 810000000",
            },
            form: {
                phone: '',
                newPass: '',
                confirm: '',
                clientId: ''
            }
        }
    },

    methods: {
        resetPwdSendOtp(event) {
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
                    this.sendOtp();
                }
            });
        },

        sendOtp() {
            this.isLoading = true;
            this.emptyField();
            this.$store.dispatch('resetPassSendOtp', this.form.phone).then((res) => {
                console.log(JSON.stringify(res));
                this.isLoading = false;
                let result = res.reponse;
                if (result.status === 'success') {
                    this.isOtp = true;
                }

            }).catch((err) => this.isLoading = false);
        },

        checkOtp(otp) {
            let payload = {
                phone: this.form.phone,
                otp: otp
            }
            this.isLoading = true;
            this.$store.dispatch('resetPassCheckOtp', payload).then((res) => {
                this.isLoading = false;
                if (res.error !== undefined) {
                    this.$swal({
                        icon: 'warning',
                        title: 'Echec !',
                        text: 'Utilisateur ou code invalide !',
                        timer: 3000,
                        showConfirmButton: false,

                    });
                    this.isOtp = false;
                    return;
                }
                let client = res.client;
                if (client !== undefined) {
                    this.reset = true;
                    this.form.clientId = client.client_id
                }
            }).catch((err) => this.isLoading = false)
        },

        resetPass(event) {
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
                    if (!this.isPwValid) {
                        return;
                    }
                    this.isLoading = true;
                    let data = {
                        client_id: this.form.clientId,
                        pass: this.form.newPass
                    }
                    this.$store.dispatch('resetPass', data).then((res) => {
                        this.isLoading = false;
                        let result = res.reponse;
                        if (result.status === 'success') {
                            this.$swal({
                                title: "Réinitialisation effectuée",
                                text: `Le mot de passe du compte de ${result.client.nom} a été mis à jour  !\nveuillez utiliser votre nouveau mot de passe pour vous connecter à votre compte!`,
                                timer: 4000,
                                showConfirmButton: false,
                            }).then((_) => {
                                this.$router.go(-1);
                            })
                        }
                        else {
                            this.$swal({
                                title: "Echec de Réinitialisation",
                                text: 'Vos tentatives de réinitialisation du mot de passe ont échouées',
                                timer: 4000,
                                showConfirmButton: false,
                            }).then((_) => {
                                this.reset = false;
                                this.isOtp = false;
                            })
                        }
                    }).catch((err) => this.isLoading = false);
                }
            });
        },

        updatePhone(value) {
            this.form.phone = value.e164;
        },

        emptyField(val) {
            this.$emit('onChanged', val);
        },


        validatePassword() {
            var nmb = 0;
            var maj = 0;
            var min = 0;
            var spec = 0;
            var specialChar = /[`!@#$%^&*()_+\-=\\|,.`<>?~]/;

            if (this.form.newPass.length >= 8) {

                for (var i of this.form.newPass) {
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
                        this.pwdError = "Votre mot de passe doit contenir au moins 1 chiffre";
                        return false;
                    }
                    if (maj == 0) {
                        this.pwdError = 'Votre mot de passe doit contenir au moins 1 lettre en majuscule';
                        return false;
                    }
                    if (min == 0) {
                        this.pwdError = "Votre mot de passe doit contenir au moins 1 lettre en minuscule";
                        return false;
                    }
                    if (spec == 0) {
                        this.pwdError = 'Votre mot de passe doit contenir au moins 1 caractère spécial';
                        return false;
                    }
                    this.pwdError = "";
                    return true;
                }
            }
            else {
                this.pwdError = 'Votre mot de passe doit contenir minimum 8 caractères';
                return false;
            }
        },

    },

    watch: {
        phone(val) {
            if (val !== null) {
                let f = `${val}`[0];
                if (f === "0") {
                    this.phone = "";
                    return;
                }
                else if (val.length > 9) {
                    this.phone = "";
                    return;
                }

            }
        },

        'form.confirm'(val) {
            if (this.form.newPass !== val) {
                this.isDifferent = true;
            }
            else {
                this.isDifferent = false;
            }
        },

        'form.newPass'(val) {
            if (val) {
                this.isPwValid = this.validatePassword();
            }
        }
    }
}
</script>