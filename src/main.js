import Vue from "vue";
import Vuex from "vuex";
import App from "./App.vue";
import router from "./router/index";
import storeData from "./store/store.js";
import axios from "axios";
import VuePhoneNumberInput from "vue-phone-number-input";
import "vue-phone-number-input/dist/vue-phone-number-input.css";

Vue.config.productionTip = false;

Vue.filter("sortlength", function(text, length, suffix) {
  var sorted = text.length > length ? text.substring(0, length) + suffix : text;
  return sorted;
});
Vue.use(Vuex);

//axios instance
import states from "./store/config/states";
var instance = axios.create({
  baseURL: states.baseURL,
  headers: {
    "Content-Type": "application/x-www-form-urlencoded",
  },
});
Vue.prototype.$axios = instance;
import $ from "jquery";
var modal = function(key) {
  if (key === "show") {
    $(".trigger").click();
  }
  if (key === "hide") {
    $(".exit").click();
  }
};
Vue.prototype.$otpModal = modal;

Vue.component("XLoading", require("@/components/utilities/loading").default);
Vue.component(
  "privacyModal",
  require("@/components/utilities/privacy_modal").default
);
Vue.component(
  "actifModal",
  require("@/components/widgets/modals/actif_detail_modal").default
);
Vue.component(
  "detailModal",
  require("@/components/widgets/modals/actif_selected_details_modal.vue")
    .default
);

/*OTP modal */
Vue.component("otpModal", require("@/components/utilities/otp_modal").default);

/*OTP Global component */
Vue.component("otpInput", require("@/components/widgets/otp").default);
Vue.component(
  "customDateInput",
  require("@/components/widgets/custom_date_input").default
);

/* Phone number input with country code */
Vue.component("phoneInput", VuePhoneNumberInput);

//support vueSweetalert
import VueSweetalert2 from "vue-sweetalert2";
import "sweetalert2/dist/sweetalert2.min.css";
Vue.use(VueSweetalert2);

//support vueToast
import VueToast from "vue-toast-notification";
import "vue-toast-notification/dist/theme-sugar.css";
Vue.use(VueToast);
// Dismiss all opened toast immediately
Vue.$toast.clear();

const store = new Vuex.Store(storeData);

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
