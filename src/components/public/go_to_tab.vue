<template>
  <div class="row mb-lg-0">
    <div class="col-md-12 mb-2 col-12 d-flex align-items-center justify-content-end">
      <button v-if="previoustab" type="button"
        class="btn me-2 flex-fill flex-lg-grow-0 fs-6 p-2 p-lg-3 text-white border-0"
        :class="previoustab ? 'bg-app' : 'disabled bg-secondary'" @click="goToTab(false)" style="background-color: red">
        Etape précédente
      </button>
      <button v-if="nexttab === true && allownexttab === true" type="button"
        class="btn fs-6 flex-fill flex-lg-grow-0 p-2 p-lg-3 text-white border-0" :class="
          nexttab === true && allownexttab === true ? 'bg-app' : 'disabled bg-secondary'
        " @click="goToTab(true)">
        Etape suivante
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "go_to_tab",
  props: {
    permission: {
      type: Boolean,
      default: false,
    },
    nexttab: {
      type: Boolean,
      default: true,
    },
    previoustab: {
      type: Boolean,
      default: true,
    },
    askpermission: {
      type: Boolean,
      default: false,
    },
    permissiontext: {
      type: String,
      default: "Est-ce que vous nous autoriser à vérifier cette information?",
    },
    allownexttab: {
      type: Boolean,
      default: false,
    },
  },
  methods: {
    async goToTab(nextTab = true) {
      /**
       * Empecher le user de passer au next tab s'il n'a pas accordé la permission de vérification de ces informations.
       * */
      if (this.askpermission && nextTab) {
        var confirmed = false;

        await this.$swal({
          text: this.permissiontext,
          icon: "warning",
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

        /**
         * Go to next tab.
         * */
        this.$emit("gototab", nextTab);
      } else {
        console.log("tab go");
        /**
         * Throw event pour passer au next Tab .
         */
        this.$emit("gototab", nextTab);
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
  },
};
</script>

<style scoped></style>
