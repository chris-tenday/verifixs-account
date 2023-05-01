import LoginScreen from "@/components/auth/login_page.vue";
import RegisterScreen from "@/components/auth/register_page.vue";
import MainScreen from "@/components/layouts/main_layout.vue";

//pubic page
import HomePage from "@/components/public/home_page.vue";
import NewLoanPage from "@/components/public/new_loan_page.vue";
import DiligenceView from "@/components/public/diligence_page.vue";
import cacheStore from "../store/cacheStore";

function auth(to, from, next) {
  var client = cacheStore.get("client");
  //console.log(JSON.stringify(client));
  if (
    client !== null &&
    client !== undefined &&
    Object.keys(client).length > 0
  ) {
    next();
  } else {
    next({ name: "login" });
  }
}

const routes = [
  {
    path: "/",
    component: LoginScreen,
    name: "login",
  },

  {
    path: "/creation/compte",
    component: RegisterScreen,
    name: "register",
  },
  {
    path: "/motdepasse+reset",
    component: () => import("@/components/auth/reset_page"),
    name: "reset",
  },

  {
    path: "/home",
    component: MainScreen,
    name: "main",
    beforeEnter: auth,
    children: [
      {
        path: "",
        component: HomePage,
        name: "home",
      },
      {
        path: "/creation/diligence",
        component: NewLoanPage,
        name: "new-loan",
      },
      {
        path: "/diligences/view/:id",
        component: DiligenceView,
        name: "loan-view",
      },
    ],
  },
];
export default routes;
