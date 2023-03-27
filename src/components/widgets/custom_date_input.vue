<template>
  <div>
    <label for="loan" v-if="label" class="form-label">{{ label }}</label>
    <div class="row">
      <div class="col-lg-4 col-xl-4 col-md-12 col-sm-12 col-12">
        <div class="input-group">
          <select @change="updated" v-model="day" class="form-select w-20" aria-label="Days">
            <option value="" selected>-- Jour --</option>
            <option v-for="d in days" :key="d" :value="d">{{ d }}</option>
          </select>
          <select @change="updated" v-model="month" class="form-select w-25" aria-label="Months">
            <option value="" selected>-- Mois --</option>
            <option v-for="m in months" :key="m.value" :value="m.value">{{ m.label }}</option>
          </select>
          <select @change="updated" v-model="year" class="form-select w-25" aria-label="Years">
            <option value="" selected>-- Année --</option>
            <option v-for="y in years" :key="y" :value="y">{{ y }}</option>
          </select>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "CustomDateInput",

  props: {
    selectedValue: {
      type: String,
      default: "",
    },
    label: {
      type: String,
      default: "",
    },
  },

  data() {
    return {
      day: "",
      month: "",
      year: "",
    };
  },

  mounted() {
    this.loadSelected();
  },

  computed: {
    /*list of days*/
    days() {
      let day = [];
      for (let i = 0; i <= 31; i++) {
        if (i == 31) {
          break;
        }
        let d = `${i + 1}`;
        day.push(d.padStart(2, "0"));
      }
      return day;
    },

    /*List of months*/
    months() {
      let months = [
        { value: "01", label: "Janv" },
        { value: "02", label: "Fev" },
        { value: "03", label: "Mars" },
        { value: "04", label: "Avr" },
        { value: "05", label: "Mai" },
        { value: "06", label: "Juin" },
        { value: "07", label: "Juil" },
        { value: "08", label: "Août" },
        { value: "09", label: "Sept" },
        { value: "10", label: "Oct" },
        { value: "11", label: "Nov" },
        { value: "12", label: "Dec" },
      ];
      return months;
    },

    /*List of years*/
    years() {
      var currentYear = new Date().getFullYear();
      let y = [];
      let startYear = 1950;
      while (startYear <= currentYear) {
        y.push(startYear++);
      }
      return y;
    },
  },
  methods: {
    updated(event) {
      console.log(event);
      let date = `${this.day}-${this.month}-${this.year}`;
      this.$emit("input", date);
    },

    loadSelected() {
      if (this.selectedValue) {
        let date = this.selectedValue.split("-");
        this.day = date[0];
        this.month = date[1];
        this.year = date[2];
      }
    },
  },
};
</script>

<style>
select {
  font-family: Inter, "sans-serif"
}
</style>
