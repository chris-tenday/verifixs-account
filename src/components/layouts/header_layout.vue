<template>
  <div>
    <div class="bg-dark py-1" id="header-layout">
      <!-- top-bar -->
      <div class="container px-md-0">
        <div class="d-flex justify-content-between align-items-center">
          <div class="fs-6 text-white">
            <a class="btn-link text-white" href="mailto:contact@verifixs.com"><i
                class="fa fa-envelope me-2"></i>contact@verifixs.com</a>
          </div>
          <div class="fs-6 text-white">

            <a href="javascript:void(0)" role="button" data-bs-toggle="dropdown"
              class="btn-link fw-semi-bold p-2 text-white d-flex justify-content-center align-items-center">
              <svg class="border-1 rounded-pill" width="16px" height="16px" viewBox="0 0 16 16"
                xmlns="http://www.w3.org/2000/svg">
                <path
                  d="m 8 1 c -1.65625 0 -3 1.34375 -3 3 s 1.34375 3 3 3 s 3 -1.34375 3 -3 s -1.34375 -3 -3 -3 z m -1.5 7 c -2.492188 0 -4.5 2.007812 -4.5 4.5 v 0.5 c 0 1.109375 0.890625 2 2 2 h 8 c 1.109375 0 2 -0.890625 2 -2 v -0.5 c 0 -2.492188 -2.007812 -4.5 -4.5 -4.5 z m 0 0"
                  fill="#ffffff" />
              </svg>
              {{ client.nom | capitalize }} <i
                class="bi bi-arrow-down-right-circle-fill text-success mx-2 fs-7 text-primary"></i>
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarFeatures">
              <li class="d-flex flex-column p-3">
                <h6 class="dropdown-header mb-1 fw-bold text-primary bg-light-primary p-2"><i class="bi bi-person"></i>{{
                  client.nom |
                  capitalize }}
                </h6>
              </li>
              <li><a class="dropdown-item" href="javascript:void(0)" @click.prevent="$router.replace({ name: 'home' })"><i
                    class="bi bi-chevron-bar-right me-1"></i>Diligences</a>
              </li>
              <li> <a class="dropdown-item" href="javascript:void(0)" @click.prevent="$emit('onLoggedOut')"> <i
                    class="bi bi-chevron-bar-right me-1"></i> Déconnexion</a></li>

            </ul>
          </div>
        </div>
      </div>
    </div>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg py-3 navbar-default">
      <div class="container px-0">
        <a class="navbar-brand" href="javascript:void(0)" @click.prevent="$router.replace({ name: 'home' })">
          ><img src="assets/images/logos/favicon.png" style="width: 120px" alt="" />
        </a>
        <!-- Button -->
        <div class="ms-lg-3 d-grid mt-lg-0">
          <a href="javascript:void(0)" @click.prevent="$emit('onSubscribed')"
            class="btn fs-7 border-none rounded text-white bg-app btn-sm"><i class="fas fa-plus"
              style="margin-right: 3px"></i>Nouvelle diligence
          </a>
        </div>
      </div>
    </nav>
  </div>
</template>

<script>
export default {
  name: "headerLayout",
  computed: {
    client() {
      return this.$store.getters.getClient
    }
  }
};
</script>
