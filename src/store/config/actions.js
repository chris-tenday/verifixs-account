import axios from "axios";
import checkConnection from "../../utils/data-connection"
//import { scroller } from "vue-scrollto/src/scrollTo";

const actions = {
  login({ state }, data) /** method pour le login */ {
    return new Promise(function(resolve, reject) {

      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/utilisateurs/connexion/login", data)
        .then(function(result) {
          var data = result.data;
          resolve(data);
        });
    });
  },
  logUserIn(
    { commit },
    data
  ) /** method pour sauvegarder les données d'un user connecté */ {
    //console.log("Before commit:"); console.log(data);
    commit("setUser", data);
  },
  logUserOut() /** method pour deconnecter un user */ {
    localStorage.removeItem("user");
  },
  viewDiligences({ state, commit }, data) {
    return new Promise(function(resolve) {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.!");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/clients/dashboard", data)
        .then(function(result) {
          var data = result.data;
          resolve(data);
          commit("setDiligences", data.data);
        });
    });
  },
  newDiligence({ state, commit }, data) {
    if (!checkConnection()) {
      alert("Vous êtes actuellement hors ligne.");
      resolve(false);
      return;
    }
    return new Promise(function(resolve) {
      axios
        .post(state.baseURL + "/clients/diligences/postuler", data)
        .then(function(result) {
          console.clear();

          resolve(result.data);
        });
    });
  },
  viewDiligenceDetails({ state, commit }, data_sent) {
    return new Promise(function(resolve) {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/clients/diligences/view", data_sent)
        .then(function(result) {
          var data = result.data;
          localStorage.removeItem("last-response");
          resolve(data);
          var diligences = state.diligences;
          for (var i = 0; i < diligences; i++) {
            if (diligences[i].diligence_id === data_sent.diligence_id) {
              diligences[i].details = data.details;
            }
          }
          //console.clear(); console.log(diligences);
          //commit("setDiligences",diligences);
          //**Copie des reponses precedentes  */
          localStorage.setItem(
            "last-response",
            JSON.stringify(data.details.questionnaire)
          );
          /*End copie*/
          commit("setDiligenceDetails", data.details);
        });
    });
  },
  uploadDocument({ state }, data) {
    return new Promise(function(resolve) {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/clients/diligences/uploader", data)
        .then(function(result) {
          var data = result.data;

          resolve(data);
        });
    });
  },
  async registerAccount({ state, commit }, data) {
    return new Promise(function(resolve, reject) {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/connexion/clients/registeraccount", data)
        .then(function(result) {
          var data = result.data;
          if (data.error !== undefined) {
            axios
              .post(state.baseURL + "/connexion/clients/registeraccount", data)
              .then((res) => {
                resolve(result.data);
                if (
                  res.data.reponse !== undefined &&
                  res.data.status === "success"
                ) {
                  commit("setClient", res.data.reponse.data);
                }
              });
          } else {
            resolve(data);
            if (
              data.reponse !== undefined &&
              data.reponse.status === "success"
            ) {
              commit("setClient", data.reponse.data);
            }
          }
        })
        .then((e) => {
          reject(e);
        });
    });
  },

  resendOtp({ commit, state }, data) {
    return new Promise((resolve, reject) => {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/connexion/clients/otp", data)
        .then((res) => {
          resolve(res.data);
        })
        .catch((err) => reject(err));
    });
  },

  deleteCredit({ commit, state }, data) {
    return new Promise((resolve, reject) => {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/clients/diligences/credits/supprimer", {
          client_id: data.client_id,
          credit_id: data.credit_id,
        })
        .then((res) => {
          resolve(res.data);
        })
        .catch((err) => reject(err));
    });
  },
  loginAccount({ state, commit }, data) {
    return new Promise(function(resolve, reject) {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/connexion/clients/login", data)
        .then(function(result) {
          var data = result.data;

          resolve(data);
          if (data.reponse !== undefined && data.reponse.status === "success") {
            commit("setClient", data.reponse.data);
          }
        })
        .catch((e) => {
          reject(e);
        });
    });
  },
  logOut({ commit }) {
    commit("setClient", {});
  },
  postulerDiligence({ state }, data) {
    if (!checkConnection()) {
      alert("Vous êtes actuellement hors ligne.");
      resolve(false);
      return;
    }
    return new Promise(function(resolve) {
      axios
        .post(state.baseURL + "/clients/diligences/postuler", data)
        .then(function(result) {
          var data = result.data;

          resolve(data);
        });
    });
  },
  getDiligenceTypes({ state, commit }) {
    if (!checkConnection()) {
      alert("Vous êtes actuellement hors ligne.");
      resolve(false);
      return;
    }
    return new Promise(function(resolve) {
      axios.get(state.baseURL + "/config/clients").then(function(result) {
        var data = result.data;

        resolve(data);

        commit("setDiligenceTypes", data.diligence_types);
      });
    });
  },
  repondreQuestion(
    { state },
    data
  ) /** method pour envoyer la réponse d'une question au serveur */ {
    return new Promise(function(resolve, reject) {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }

      axios
        .post(state.baseURL + "/clients/diligences/repondrequestion", data)
        .then(function(result) {
          var data = result.data;
          console.log(data);
          resolve(data);
        })
        .catch((e) => {
          reject(e);
        });
    });
  },
  payer({ state }, data) /** method pour payer le frais d'une diligence */ {
    return new Promise(function(resolve) {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/clients/diligences/paiements/payer", data)
        .then(function(result) {
          console.log(JSON.stringify(result));
          var data = result.data;
          resolve(data);
        });
    });
  },

  /*/
                                                                                                   requete pour afficher les actifs
                                                                                                   /*/
  viewActifs({ state, commit }) {
    if (!checkConnection()) {
      alert("Vous êtes actuellement hors ligne.");
      resolve(false);
      return;
    }
    axios.get(`${state.baseURL}/config/actifs`).then((result) => {
      var data = result.data.actifs;

      /**
       * Pour bien gerer les reponses multiples
       */
      for (var i = 0; i < data.length; i++) {
        var details = data[i].details;
        for (var k = 0; k < details.length; k++) {
          if (details[k].reponse_type.includes("multiple")) {
            data[i].details[k].reponses = [{ reponse: "" }];
          }
        }
      }
      commit("setActifs", data);
    });
  },
  enregistrerCredit({ state }, data) /** method pour enregistrer un crédit */ {
    return new Promise(function(resolve) {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/clients/diligences/credits", data)
        .then(function(result) {
          var data = result.data;

          resolve(data);
        });
    });
  },
  activateAccount(
    { state, commit },
    data
  ) /** method pour activier un compte */ {
    return new Promise(function(resolve) {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      axios
        .post(state.baseURL + "/clients/account", data)
        .then(function(result) {
          var data = result.data;
          console.log(JSON.stringify(data));
          if (data.reponse.status === "success") {
            /**
             * Update client dans le store.
             */
            commit("setClient", data.reponse.data);
          }
          resolve(data);
        });
    });
  },

  supprimerReponse(
    { state, getters },
    payload
  ) /** method pour activier un compte */ {
    console.log(payload);
    let client = getters.getClient;

    console.log(JSON.stringify(client));
    return new Promise(function(resolve, reject) {
      if (!checkConnection()) {
        alert("Vous êtes actuellement hors ligne.");
        resolve(false);
        return;
      }
      let formData = new FormData();
      formData.append("client_id", client.client_id);
      formData.append("diligence_questionnaire_id", payload);
      axios
        .post(
          state.baseURL + "/clients/diligences/supprimerquestionnairediligence",
          formData
        )
        .then(function({ data }) {
          resolve(data);
        })
        .catch((e) => {
          console.log(e);
          reject(false);
        });
    });
  },
};

export default actions;
