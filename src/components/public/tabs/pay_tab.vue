<template>
  <div>
    <go_to_tab :permission="true" @gototab="goToTab" :nexttab="false"></go_to_tab>

    <div class="row mt-3">
      <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
        <div class="accordion" id="Faqaccordionsone">
          <div class="card mb-2">
            <div class="p-3" id="faqOne">
              <h4 class="mb-0">
                <a
                  href="#!"
                  data-bs-toggle="collapse"
                  data-bs-target="#collapseOne"
                  aria-expanded="false"
                  aria-controls="collapseOne"
                  class="collapsed"
                >
                  <i class="fa fa-plus-circle me-1"></i>
                  Paiement
                </a>
              </h4>
            </div>
            <div
              id="collapseOne"
              class="collapse"
              aria-labelledby="faqOne"
              data-bs-parent="#Faqaccordionsone"
              style=""
            >
              <div class="card-body border-top">
                <div class="row">
                  <div class="col-md-12">
                    <div class="payment_info modules__content">
                      <div v-if="wantToPay">
                        <p class="subtitle text-danger" style="font-weight: bold">
                          <span class="fa fa-money"></span> Choisissez votre moyen de
                          paiement
                        </p>
                        <h2 class="text-primary font-weight-bold">
                          <span style="font-weight: normal">Montant:</span>
                          {{ payment.montant }}
                          {{ payment.devise }}
                        </h2>

                        <div class="row">
                          <div class="col-lg-4 col-md-4 mb-2 mb-lg-0">
                            <a
                              href="#!"
                              class="card text-center smooth-shadow-sm"
                              :class="
                                payment.payWithMobile ? 'border-primary border-2' : ''
                              "
                              @click.prevent="togglePaymentMethod"
                            >
                              <div
                                class="card-body p-4 px-4 d-flex align-content-center align-items-center"
                              >
                                <div
                                  class="icon-shape bg-light-pink rounded-circle icon-xl"
                                >
                                  <img
                                    src="assets/images/icon/icon-4.svg"
                                    alt="document title"
                                  />
                                </div>
                                <h4 class="mb-0">Paiement mobile</h4>
                              </div>
                            </a>
                          </div>
                          <div class="col-lg-4 col-md-4 mb-2 mb-lg-0">
                            <a
                              href="#!"
                              class="card text-center smooth-shadow-sm"
                              :class="
                                !payment.payWithMobile ? 'border-primary border-2' : ''
                              "
                              @click.prevent="togglePaymentMethod"
                            >
                              <div
                                class="card-body p-4 px-4 d-flex align-content-center align-items-center"
                              >
                                <div
                                  class="icon-shape bg-light-pink rounded-circle icon-xl"
                                >
                                  <img
                                    src="assets/images/svg/credit-card.svg"
                                    alt="document title"
                                  />
                                </div>
                                <h4 class="mb-0">Paiement par carte</h4>
                              </div>
                            </a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div v-if="wantToPay" class="row mt-3 p-2">
                  <div class="col-md-8">
                    <div v-if="payment.payWithMobile">
                      <div>
                        <label for="card_number" class="form-label"
                          >* Numéro de téléphone (Mpesa, Orange Money, Airtel Money,
                          Afrimoney)</label
                        >
                        <input
                          id="card_number"
                          type="text"
                          class="form-control"
                          placeholder="Numéro de téléphone"
                          v-model="payment.telephone"
                        />
                      </div>
                      <button
                        @click.prevent="pay"
                        type="submit"
                        class="btn btn-success btn-lg w-100 mt-3"
                        :class="payLoading ? 'disabled' : ''"
                      >
                        <span
                          v-if="payLoading"
                          class="spinner-border spinner-border-sm"
                        ></span>
                        <i v-else class="fa fa-lock"></i> Payer
                      </button>
                    </div>
                    <div v-else>
                      <form
                        action="https://beta-cardpayment.flexpay.cd/v1/pay"
                        method="post"
                        id="card_form"
                      >
                        <div class="mb-2 d-none">
                          <input
                            type="text"
                            name="authorization"
                            class="form-control"
                            :value="cardTransaction.authorization"
                          />
                        </div>
                        <div class="mb-2 d-none">
                          <input
                            type="text"
                            name="merchant"
                            class="form-control"
                            :value="cardTransaction.merchant"
                          />
                        </div>
                        <div class="mb-2 d-none">
                          <input
                            type="text"
                            name="reference"
                            class="form-control"
                            :value="cardTransaction.reference"
                          />
                        </div>
                        <div class="mb-2 d-none">
                          <input
                            type="text"
                            name="amount"
                            class="form-control"
                            :value="cardTransaction.amount"
                          />
                        </div>
                        <div class="mb-2 d-none">
                          <input
                            class="form-control"
                            type="text"
                            name="currency"
                            :value="cardTransaction.currency"
                          />
                        </div>
                        <div class="mb-2 d-none">
                          <input
                            class="form-control"
                            type="text"
                            name="description"
                            :value="cardTransaction.description"
                          />
                        </div>
                        <div class="mb-2 d-none">
                          <input
                            class="form-control"
                            type="text"
                            name="callback_url"
                            :value="cardTransaction.callback_url"
                          />
                        </div>
                        <div class="mb-2 d-none">
                          <input
                            class="form-control"
                            type="text"
                            name="approve_url"
                            :value="cardTransaction.approve_url"
                          />
                        </div>
                        <div class="mb-2 d-none">
                          <input
                            class="form-control"
                            type="text"
                            name="cancel_url"
                            :value="cardTransaction.cancel_url"
                          />
                        </div>
                        <div class="mb-2 d-none">
                          <input
                            class="form-control"
                            type="text"
                            name="decline_url"
                            :value="cardTransaction.decline_url"
                          />
                        </div>

                        <button
                          @click.prevent="pay"
                          type="submit"
                          class="btn btn-success btn-lg w-100 mt-3"
                          :class="payLoading ? 'disabled' : ''"
                        >
                          <span
                            v-if="payLoading"
                            class="spinner-border spinner-border-sm"
                          ></span>
                          <i v-else class="fa fa-lock"></i> Payer
                        </button>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="card mb-2">
            <div class="p-3" id="faqTwo">
              <h4 class="mb-0">
                <a
                  href="#!"
                  class="collapsed"
                  data-bs-toggle="collapse"
                  data-bs-target="#collapseTwo"
                  aria-expanded="false"
                  aria-controls="collapseTwo"
                >
                  <i class="fa fa-plus-circle me-1"></i>
                  Paiement en cours de traitement.
                </a>
              </h4>
            </div>
            <div
              id="collapseTwo"
              class="collapse"
              aria-labelledby="faqTwo"
              data-bs-parent="#Faqaccordionsone"
            >
              <div class="card-body border-top">
                <div class="row">
                  <div
                    v-if="paiement !== undefined && paiement !== null"
                    class="offset-xl-3 col-xl-6 offset-md-2 col-md-8 offset-md-2 col-md-8 col-sm-12 col-12"
                  >
                    <div>
                      <h1 class="mb-2">Dernier paiement</h1>
                      <p class="text-center">
                        {{ paiement.method }} | {{ paiement.montant
                        }}{{ paiement.devise }}
                        <span class="badge bg-app text-white" style="padding: 5px">{{
                          paiement.transaction_status
                        }}</span>
                        | <span class="fa fa-calendar-alt"></span>
                        {{ paiement.date_enregistrement }}
                      </p>
                    </div>
                  </div>

                  <div
                    v-else
                    class="offset-xl-3 col-xl-6 offset-md-2 col-md-8 offset-md-2 col-md-8 col-sm-12 col-12"
                  >
                    <div class="mb-8 text-center">
                      <!-- section title-->
                      <h1 class="mb-2">Aucun paiement répertorié !</h1>
                      <p class="lead fs-5 text-danger">
                        Cher client vous n'avez effectué aucun paiement !
                      </p>
                    </div>
                    <!-- /.section title-->
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="card mb-2">
            <div class="p-3" id="faqThree">
              <h4 class="mb-0">
                <a
                  href="#!"
                  class="collapsed"
                  data-bs-toggle="collapse"
                  data-bs-target="#collapseThree"
                  aria-expanded="false"
                  aria-controls="collapseThree"
                >
                  <i class="fa fa-plus-circle me-1"></i>
                  Mon certificat
                </a>
              </h4>
            </div>
            <div
              id="collapseThree"
              class="collapse"
              aria-labelledby="faqThree"
              data-bs-parent="#Faqaccordionsone"
            >
              <div class="card-body border-top">
                <div class="row">
                  <div class="row" v-if="certificat !== null">
                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
                      <div class="card bg-light mb-4">
                        <div class="card-body">
                          <h3>Mon certificat</h3>
                          <p>
                            Cher client ceci est votre certificat, veuillez cliquer sur le
                            bouton en bas pour le télécharger !
                          </p>

                          <a
                            :href="certificat.certificat_path"
                            class="btn btn-primary btn-sm mt-3"
                            >Télécharger mon certificat</a
                          >
                        </div>
                      </div>
                    </div>
                  </div>

                  <div
                    v-else
                    class="offset-xl-3 col-xl-6 offset-md-2 col-md-8 offset-md-2 col-md-8 col-sm-12 col-12"
                  >
                    <div class="mb-8 text-center">
                      <!-- section title-->
                      <h1 class="mb-2">Aucun certificat !</h1>
                      <p class="lead fs-5 text-danger">
                        Cher client vous ne disposez d'aucun certificat !
                      </p>
                    </div>
                    <!-- /.section title-->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import go_to_tab from "../go_to_tab";
export default {
  components: { go_to_tab },
  props: {
    diligence: Object,
  },
  data() {
    return {
      wantToPay: true,
      diligenceId: 0,
      payment: { payWithMobile: true, telephone: "", montant: 10, devise: "USD" },
      cardTransaction: {},
      payLoading: false,
    };
  },
  methods: {
    goToTab(nextTab) {
      if (nextTab) {
        this.$emit("gotonexttab");
      } else {
        this.$emit("gotoprevioustab");
      }
    },
    toggleWantToPay() {
      if (this.wantToPay) {
        this.wantToPay = false;
      } else {
        this.wantToPay = true;
      }
    },
    togglePaymentMethod() {
      if (this.payment.payWithMobile) {
        this.payment.payWithMobile = false;
      } else {
        this.payment.payWithMobile = true;
      }
    },
    /** method pour éxécuter le paiement */
    pay() {
      var formData = new FormData();
      if (this.payment.payWithMobile) {
        if (this.payment.telephone.length < 10) {
          this.displayMsg("Numéro de téléphone incorrect.");
          return false;
        }
        formData.append("telephone", this.payment.telephone);
      }
      this.payLoading = true;

      formData.append("client_id", this.client.client_id);
      formData.append("diligence_id", this.diligenceId);
      var method = this.payment.payWithMobile ? "mobile" : "card";
      formData.append("method", method);
      formData.append("montant", this.payment.montant);
      formData.append("devise", this.payment.devise);

      /**
       * Envoyer la requete vers le serveur.
       */
      this.$store.dispatch("payer", formData).then((res) => {
        this.payLoading = false;
        if (res.error !== undefined) {
          this.displayMsg(res.error);
        } else if (res.reponse !== undefined) {
          if (res.reponse.status === "success") {
            if (this.payment.payWithMobile) {
              /**
                   * Paiement par mobile money.
                  /**
                   *
                   * Paiement transmis
                   * */
              this.$swal({
                title: "Maintenan confirmez la transaction sur votre téléphone.",
                toast: true,
                showConfirmButton: true,
                showCancelButton: true,
                confirmButtonText: "Oui j'ai confirmé",
                icon: "info",
                cancelButtonText: "Non annuler",
              }).then((value) => {
                if (value.isConfirmed) {
                  /**
                   * Vérifier la transaction.
                   */
                  this.$emit("loading", true);
                  this.$emit("updatecontent", this.diligenceId);

                  setTimeout(() => {
                    this.$emit("loading", false);
                  }, 3000);
                }
              });
            } else {
              /**
               * Paiement par carte.
               */
              this.cardTransaction = res.reponse.transaction_data;
              setTimeout(() => {
                document.getElementById("card_form").submit();
                //this.$emit("loading", false);
              }, 2000);
            }
          } else {
            this.displayMsg("Paiement non effectué.");
          }
        } else {
          this.displayMsg("Erreur! Réessayez plus tard.");
        }
      });
    },
    displayMsg(msg) {
      this.$swal({
        title: msg,
        toast: true,
        timer: 3000,
        icon: "error",
        showConfirmButton: false,
      });
    },
  },
  computed: {
    certificat() {
      return this.$store.state.diligenceDetails.certificat;
    },
    client() {
      return this.$store.getters.getClient;
    },
    paiement() {
      return this.$store.state.diligenceDetails.paiement;
    },
  },
  mounted() {
    this.diligenceId = this.$route.params.id;
  },
};
</script>
