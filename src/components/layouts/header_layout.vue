<template>
  <div>
    <div class="bg-dual-gradient py-1" id="header-layout">
      <!-- top-bar -->
      <div class="container px-md-0">
        <div class="d-flex justify-content-between align-items-center">
          <div class="fs-6 text-white">
            <a class="btn-link text-white" href="mailto:contact@verifixs.com"><i
                class="fa fa-envelope me-2"></i>contact@verifixs.com</a>
          </div>
          <div class="fs-6 text-white">
            <a href="javascript:void(0)" @click.prevent="$emit('onLoggedOut')" class="text-white btn-link fw-semi-bold"><i
                class="fas fa-lock"></i>
              Déconnexion
            </a>
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
};
</script>
