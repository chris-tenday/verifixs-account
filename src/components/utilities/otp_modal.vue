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
          <p class="text-center" style="font-size: 14px;">Entrez le code réçu par e-mail
            <strong>xxxxx{{ user.email.slice(-13)
            }}</strong> ou au numero de
            téléphone
            <strong>+243xxxxxxxx{{ user.telephone.slice(-2) }} </strong> <strong v-if="time !== 0"> avant {{ time
            }}</strong>!!
          </p>
          <otp-input ref="otpInput1" :num-inputs="6" :should-auto-focus="true" separator="-" input-type="number"
            @on-change="handleOnChange" @on-complete="handleOnComplete" />

          <div class="d-flex mt-2 align-center justify-content-center align-items-center">
            <p>Vous n'avez reussi le code ? <a href="javascript:void(0)" class="link-dark-info"
                @click="resendOtp">Renvoyez le code </a></p>
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
      time: 60
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
      console.log(user);
      this.user = JSON.parse(user);
    },

    async resendOtp() {
      let formData = new FormData();
      formData.append('telephone', this.user.telephone);
      this.$store.dispatch('resendOtp', formData).then((res) => {
        this.time = 60;
        console.log(JSON.stringify(res));
      });
    },


    /* Cette methode permet d'effectuer une action après
    * l'insertion complete de données reçues par email par ex.
    **/
    handleOnComplete(value) {
      this.$emit("onSubmitted", value);
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
