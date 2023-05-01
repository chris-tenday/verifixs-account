<!--
 Props:
  dataLoaded => true | false (pour afficher ou cacher le loader).
  height => int (optionnel, pour configurer la taille du widget ).
 slot:
  Le slot pour contenir le contenu à afficher une fois que le loader est caché .
-->
<template>
  <div>
    <!-- loader !-->
    <div id="loader" v-if="!dataLoaded" :style="`min-height:${height}px; display:flex; justify-content:center;`">
      <img src="assets/images/loader.gif" class="mfp-img-mobile"
        style="width: 70px; height: 70px; display: block; margin: auto" />
    </div>
    <!-- End- loader !-->
    <slot v-else></slot>
    <!-- slot pour contenir le contenu à afficher une fois chargée !-->
  </div>
</template>

<script>
export default {
  name: "loader",
  props: ["dataLoaded", "height"],
  mounted() { },
};
</script>
