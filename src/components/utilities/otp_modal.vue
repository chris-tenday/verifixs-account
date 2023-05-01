<template>
  <div class="modal fade" id="otpModal" tabindex="-1" role="dialog" data-bs-backdrop="static" data-bs-keyboard="false"
    aria-hidden="true">
    <button href="#" data-bs-toggle="modal" data-bs-target="#otpModal" class="trigger" style="display: none"></button>

    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <button type="button" class="exit d-none" data-bs-dismiss="modal" aria-label="Close"></button>
        <!-- end /.modal-header -->
        <div class="modal-body">
          <h3 class="text-center">
            <span class="fa fa-lock text-info"></span> Activation de compte
          </h3>
          <p class="text-center" style="font-size: 14px;">Entrez le code réçu par e-mail/ boite spam
            <strong>{{ user.email.substring(0, 1)
            }}<small>xxxxx</small>{{ user.email.slice(-13) }}</strong> ou au numero de
            téléphone
            <strong>{{ user.telephone.substring(0, 6) }}<small>xxxxxxxx</small>{{ user.telephone.slice(-2) }} </strong>
            <strong v-if="time !== 0"> avant {{ time
            }}<sup>s</sup></strong>!!
          </p>
          <otp-input ref="otpInput1" :num-inputs="6" :should-auto-focus="true" separator="-" input-type="number"
            @on-change="handleOnChange" @on-complete="handleOnComplete" />

          <div class="d-flex mt-2 align-center justify-content-center align-items-center">
            <p>Vous n'avez reussi le code ? <a href="javascript:void(0)" :disabled="otpSendLoading" class="link-dark-info"
                @click="resendOtp">Renvoyez le code <i v-if="otpSendLoading" class="mx-2 fa fa-spinner fa-spin"></i> </a>
            </p>
          </div>
        </div>
        <!-- end /.modal-body -->
      </div>
    </div>
  </div>
</template>

<script>
import $ from "jquery";
export default {
  name: "OTP",


  data() {
    return {
      user: {},
      time: 60,
      otpSendLoading: false,
    }
  },
  created() {
    this.refreshUserData();
  },

  mounted() {
    setInterval(() => {
      if (this.time == 0) {
        return;
      }
      this.time--;

    }, 1200);
  },

  methods: {


    /** 
    Renvoi de données de l'utilisateur en attente d'activation du code 
    */
    refreshUserData() {
      let user = localStorage.getItem("client");
      this.user = JSON.parse(user);
    },

    async resendOtp() {
      let formData = new FormData();
      console.log(this.user.telephone);
      formData.append('telephone', this.user.telephone);
      this.otpSendLoading = true;
      this.$store.dispatch('resendOtp', formData).then((res) => {
        this.otpSendLoading = false;
        this.time = 60;
        console.log(JSON.stringify(res));
      });
    },


    /* Cette methode permet d'effectuer une action après
    * l'insertion complete de données reçues par email par ex.
    **/
    async handleOnComplete(value) {
      this.otpSendLoading = true;

      await this.$emit("onSubmitted", value);
      this.otpSendLoading = false
      //$(".exit").click();
    },
    /**
     * Cette methode permet de recuperer
     * une valeur après chaque modification.
     *
     **/
    handleOnChange(value) {
      this.$emit("onChanged", value);
    },

    onOpen() {
      this.$emit("onOpened");
    },
  },
};
</script>

