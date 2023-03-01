<template>
  <div class="actif-tab">
    <go_to_tab :allownexttab="allowNextTab" :askpermission="askCheckingPermission"
      permissiontext="Est-ce que vous nous autoriser à vérifier cette information auprès des institutions bancaires?"
      @gototab="goToTab"></go_to_tab>
    <div v-if="credits.length < 1">
      <div v-if="newCredit === false">
        <div>
          <div class="mb-2 mt-2">
            <p class="fs-4 text-dark">Avez-vous des crédits bancaire ?</p>
            <div>
              <div class="form-check form-check-inline" style="cursor: pointer">
                <input class="form-check-input" type="radio" value="oui" @change="checkedChanged($event)"
                  name="flexRadioDefault" id="yes" />
                <label class="form-check-label text-success" for="yes"> Oui </label>
              </div>
              <div class="form-check form-check-inline" style="cursor: pointer">
                <input class="form-check-input" type="radio" name="flexRadioDefault" @change="checkedChanged($event)"
                  id="no" value="non" />
                <label class="form-check-label" for="no"> Non </label>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- affichage des credits !-->
    <div class="mb-4 mt-4" v-if="credits.length > 0">
      <div class="single-title" data-aos="fade-up">
        <h2><i class="fa fa-money"></i> <span>Vos Crédits</span></h2>
      </div>
      <div class="row">
        <div class="col-md-12 col-lg-12">
          <table class="table table-striped">
            <thead>
              <th>Banque</th>
              <th>Motif</th>
              <th>Montant</th>
              <th>Date crédit</th>
              <th>Durée</th>
              <th>Echéance</th>
              <th>Dernier paiement</th>
              <th>Solde</th>
              <th>Action</th>
            </thead>
            <tbody>
              <tr v-for="credit in credits" :key="credit">
                <td>{{ credit.banque }}</td>
                <td>{{ credit.motif }}</td>
                <td>{{ credit.montant }}</td>
                <td>{{ credit.date_credit }}</td>
                <td>-</td>
                <td>{{ credit.echeance_remboursement }}</td>
                <td>{{ credit.dernier_paiement_date }}</td>
                <td>{{ credit.solde }}</td>
                <td>
                  <button @click="deleteOneCredit(credit.credit_id)" class="btn btn-danger p-2">
                    <span class="fa fa-trash fs-7"></span>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <button @click.prevent="toggleNewCredit(true)" class="btn btn-sm btn-success">
            <span class="fa fa-plus-circle"></span> Ajouter
          </button>
        </div>
      </div>
      <hr />
    </div>

    <!-- enregistrement credit !-->
    <fieldset data-aos="zoom-in" class="mt-4" v-if="newCredit === true">
      <p class="text-danger fs-5">
        <span class="fa fa-info"></span> Veuillez renseigner votre crédit s'il vous plait
      </p>
      <form id="creditForm" @submit.prevent="enregistrerCredit">
        <div class="row">
          <div class="col-md-6 col-lg-6">
            <div class="form-group">
              <label class="mb-2 mt-2 form-label">Banque <sup class="text-danger">*</sup></label>
              <input style="display: none" type="text" class="text_field form-control" placeholder="Banque.."
                v-model="credit.banque" required />
              <select v-if="selectBanque" name="" id="" v-model="credit.banque" class="form-control" required>
                <option value="">--------</option>
                <option value="EquityBCDC">EquityBCDC</option>
                <option value="Rawbank">Rawbank</option>
                <option value="UBA">UBA</option>
                <option value="FBNBank">FBNBank</option>
                <option value="SofiBank">SofiBank</option>
                <option value="AccessBank">AccessBank</option>
                <option value="EcoBank">EcoBank</option>
                <option value="Afriland First Bank">Afriland First Bank</option>
                <option value="BGFI Bank">BGFI Bank</option>
                <option value="BOA Bank">BOA Bank</option>
                <option @click.prevent="toggleSelectBanque">Autre banque..</option>
              </select>
              <input v-else type="text" class="text_field form-control" placeholder="Saisissez la banque.."
                v-model="credit.banque" aria-label="Text input with dropdown button" required />
            </div>
          </div>
          <div class="col-md-6 col-lg-6">
            <div class="form-group">
              <label class="mb-2 mt-2">Motif du crédit <sup class="text-danger">*</sup></label>

              <select v-if="selectMofif" name="" id="" class="form-control" v-model="credit.motif" required>
                <option value="">-----------</option>
                <option value="Scolaire">Scolaire</option>
                <option value="Business">Business</option>
                <option value="Achat parcelle">Achat parcelle</option>
                <option @click.prevent="toggleSelectMotif">Autre motif..</option>
              </select>
              <input v-else type="text" class="text_field form-control" placeholder="Saisissez le motif.."
                v-model="credit.motif" aria-label="Text input with dropdown button" required />
            </div>
          </div>
          <div class="col-md-6 col-lg-6">
            <div>
              <label class="mb-2 mt-2">Montant <span v-if="devise === 'USD'">(USD)</span><span
                  v-else-if="devise === 'CDF'">(CDF)</span> <sup class="text-danger">*</sup></label>
            </div>
            <div class="input-group form-group">
              <input type="text" class="text_field form-control" placeholder="Montant.." v-model="credit.montant"
                aria-label="Text input with dropdown button" required />

              <div class="input-group-append">
                <select v-model="devise" class="form-control btn btn-primary" required>
                  <option value="USD">USD</option>
                  <OPtion value="CDF">CDF</OPtion>
                </select>
              </div>
            </div>
          </div>

          <div class="col-md-6 col-lg-6">
            <div class="form-group">
              <label class="mb-2 mt-2">Date de souscription <sup class="text-danger">*</sup></label>
              <input type="date" class="text_field form-control" v-model="credit.date_credit" required />
            </div>
          </div>
          <div class="col-md-6 col-lg-6">
            <div>
              <label class="mb-2 mt-2">Durée <sup class="text-danger">*</sup></label>
            </div>
            <div class="input-group form-group">
              <input type="number" class="text_field form-control" placeholder="Durée" v-model="credit.duree_credit"
                aria-label="Text input with dropdown button" required />

              <div class="input-group-append">
                <select v-model="credit.duree_mois_annee" class="form-control btn btn-primary" required>
                  <option value="Mois">Mois</option>
                  <option value="Annee">Année</option>
                </select>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-6">
            <div class="form-group">
              <label class="mb-2 mt-2">Echéance du remboursement <sup class="text-danger">*</sup></label>
              <input type="text" class="text_field form-control" placeholder="Echéance.."
                v-model="credit.echeance_remboursement" required />
            </div>
          </div>
          <div class="col-md-6 col-lg-6">
            <div class="form-group">
              <label class="mb-2 mt-2">Date du dernier paiement <sup class="text-danger">*</sup></label>
              <input type="date" class="text_field form-control" v-model="credit.date_dernier_paiement" required />
            </div>
          </div>
          <div class="col-md-6 col-lg-6">
            <div class="form-group">
              <label class="mb-2 mt-2">Solde <span v-if="devise === 'USD'">(USD)</span><span
                  v-else-if="devise === 'CDF'">(CDF)</span> <sup class="text-danger">*</sup></label>
              <input type="text" class="text_field form-control" placeholder="Solde.." v-model="credit.solde" required />
            </div>
          </div>
        </div>
        <div class="mt-3">
          <button class="btn me-2 btn-sm btn-danger pull-left" @click.prevent="toggleNewCredit(false)">
            <i class="mr-2 fa fa-close"></i>Annuler
          </button>
          <button class="btn btn-sm btn-success pull-right" :class="isLoading ? 'disabled' : ''" type="submit">
            <span class="spinner spinner-border spinner-border-sm mr-2" v-if="isLoading"></span>
            <i class="fa fa-plus" v-else></i> Enregistrer
          </button>
        </div>
      </form>
    </fieldset>
  </div>
</template>

<script>
import go_to_tab from "../go_to_tab";
export default {
  name: "credits",
  components: { go_to_tab },
  data() {
    var credit = {
      banque: "",
      motif: "",
      montant: "",
      devise: "USD",
      date_credit: "",
      duree_credit: "",
      duree_mois_annee: "Mois",
      echeance_remboursement: "",
      date_dernier_paiement: "",
      solde: "",
    };
    return {
      devise: "USD",
      isLoading: false,
      credit: credit,
      diligenceId: 0,
      newCredit: false,
      askCheckingPermission: true,
      checkingPermission: false,
      allowNextTab: false,
      selectMofif: true,
      selectBanque: true,
    };
  },
  computed: {
    client() {
      return this.$store.getters.getClient;
    },
    credits() {
      return this.$store.getters.getCredits;
    },
  },
  methods: {
    deleteOneCredit(creditId) {
      let data = {
        credit_id: creditId,
        client_id: this.client.client_id,
      }
      this.$store.dispatch('deleteCredit', data).then((res) => {
        console.log(JSON.stringify(res));
        this.$emit("updatecontent");
      })
    },
    toggleSelectMotif() {
      this.credit.motif = "";
      if (this.selectMofif) {
        this.selectMofif = false;
      } else {
        this.selectMofif = true;
      }
    },
    toggleSelectBanque() {
      this.credit.banque = "";
      if (this.selectBanque) {
        this.selectBanque = false;
      } else {
        this.selectBanque = true;
      }
    },
    goToTab(next) {
      if (next) {
        this.$emit("gotonexttab");
      } else {
        this.$emit("gotoprevioustab");
      }
    },
    enregistrerCredit(event) {
      /**
       * Vérifier le remplissage des champs.
       * */
      //TODO: Remplissage des champs réquis.

      /**
       * Form data à envoyer au serveur.
       * @type {FormData}
       */

      var formData = new FormData();
      formData.append("diligence_id", this.diligenceId);
      formData.append("client_id", this.client.client_id);
      formData.append("banque", this.credit.banque);
      formData.append("motif", this.credit.motif);
      formData.append("montant", this.credit.montant);
      formData.append(
        "duree_credit",
        this.credit.duree_credit + " " + this.credit.duree_mois_annee
      );
      formData.append("devise", this.devise);
      formData.append("date_credit", this.credit.date_credit);
      formData.append("solde", this.credit.solde);
      formData.append("dernier_paiement_date", this.credit.date_dernier_paiement);

      this.isLoading = true;
      this.$store.dispatch("enregistrerCredit", formData).then((res) => {
        if (res.error !== undefined) {
          /** erreur retournée du  backend */
          /**
           * Demander au parent component d'afficher une alerte.
           */
          this.$emit("alert", res.error);
        }
        this.$emit("updatecontent");
        this.newCredit = false;
        this.isLoading = false;
      });
    },
    toggleNewCredit(newCredit) {
      this.newCredit = newCredit;
      if (this.newCredit) {
        this.allowNextTab = false;
      } else {
        this.allowNextTab = true;
      }
    },
    checkedChanged(value) {
      if (value.target.id === "yes" && value.target.checked) {
        this.toggleNewCredit(true);
      }
      if (value.target.id === "no" && value.target.checked) {
        this.toggleNewCredit(false);
      }
    },
    toggleCheckingPermission(permission) {
      //this.checkingPermission=(permission.includes('oui'))? true :false;
      this.checkingPermission = permission;

      if (!this.checkingPermission) {
        this.$emit("alert", "Désolé !! vous ne pouvez pas continuer.");
      } else {
        this.askCheckingPermission = false;
      }
    },
  },
  mounted() {
    this.diligenceId = this.$route.params.id;

    if (this.credits.length > 0) {
      this.allowNextTab = true;
      this.askCheckingPermission = false;
    }
  },
  watch: {
    credits(newData, oldData) {
      if (newData.length > 0) {
        this.allowNextTab = true;
        this.askCheckingPermission = false;
      }
    },
  },
};
</script>

<style scoped></style>
