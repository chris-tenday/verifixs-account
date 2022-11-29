<template>
  <div
    class="modal fade"
    id="otpModal"
    tabindex="-1"
    role="dialog"
    data-bs-backdrop="static"
    data-bs-keyboard="false"
    aria-hidden="true"
  >
    <button
      href="#"
      data-bs-toggle="modal"
      data-bs-target="#otpModal"
      class="trigger"
      style="display: none"
    ></button>

    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <button
          type="button"
          class="exit d-none"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
        <!-- end /.modal-header -->
        <div class="modal-body">
          <h3 class="text-center">
            <span class="fa fa-lock"></span> Activation de compte
          </h3>
          <p class="text-center">Entrez le code réçu par e-mail !</p>
          <otp-input
            ref="otpInput1"
            :num-inputs="6"
            :should-auto-focus="true"
            separator="-"
            input-type="number"
            @on-change="handleOnChange"
            @on-complete="handleOnComplete"
          />
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

  methods: {
    /**
     * Cette methode permet d'effectuer une action après
     * l'insertion complete de données reçues par email par ex.
     * **/
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
