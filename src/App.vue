<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: "App",
  mounted() {
    this.refreshData();
  },

  methods: {
    refreshData() {
      this.$store.dispatch("viewActifs");
    },
  },
};
</script>
