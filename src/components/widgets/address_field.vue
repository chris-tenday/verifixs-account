<template>
    <div class="row">
        <!-- Select Province -->
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-6 col-6">
            <div class="form-group mb-2">
                <label class="form-label mb-1" for="address_province">Province <sup class="text-danger">*</sup> </label>
                <select name="address_province" :class="border" v-model="model.split.province" id="address_province"
                    @change="handleSplit" class="form-select" required>
                    <option value="" selected>Sélectionner province...</option>
                    <option v-for="(prov, index) in provinces" :key="index" :value="prov">{{ prov.title }}</option>
                </select>
            </div>
        </div>

        <!-- Select City -->
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-6 col-6">
            <div class="form-group mb-2">
                <label class="form-label mb-1" for="address_city">Ville <sup class="text-danger">*</sup> </label>
                <select name="address_city" :class="border" id="address_city" v-model="model.split.ville"
                    class="form-select" @change="handleSplit" required>
                    <option selected value="">Sélectionner ville...</option>
                    <option v-for="v in model.split.province.villes" :key="v" :value="v">{{ v }}</option>
                </select>
            </div>
        </div>

        <!-- Text input Address Commune -->
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-6 col-6">
            <div class="form-group mb-2">
                <label class="form-label mb-1" for="address_street">Commune <sup class="text-danger">*</sup> </label>
                <input id="address_c" :class="border" name="address_c" type="text" v-model="model.split.commune"
                    placeholder="Commune..." class="form-control " @change="handleSplit" required>
            </div>
        </div>

        <!-- Text input Address Quartier -->
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-6 col-6">
            <div class="form-group mb-2">
                <label class="form-label mb-1" for="address_street">Quartier <sup class="text-danger">*</sup> </label>
                <input id="address_q" :class="border" name="address_q" type="text" v-model="model.split.quartier"
                    placeholder="Quartier..." class="form-control " @change="handleSplit" required>
            </div>
        </div>

        <!-- Text input Address Street -->
        <div class="col-xl-2 col-lg-2 col-md-6 col-sm-6 col-6">
            <div class="form-group mb-2">
                <label class="form-label mb-1" for="address_street">Avenue <sup class="text-danger">*</sup> </label>
                <input id="address_street" :class="border" name="address_street" v-model="model.split.avenue" type="text"
                    placeholder="Avenue..." class="form-control " @change="handleSplit" required>
            </div>
        </div>

        <!-- Text input Address number -->
        <div class="col-xl-2 col-lg-2 col-md-6 col-sm-6 col-6">
            <div class="form-group mb-2">
                <label class="form-label mb-1" for="address_num">Numéro <sup class="text-danger">*</sup> </label>
                <input id="address_num" :class="border" name="address_num" v-model="model.split.numero" type="text"
                    placeholder="N°..." class="form-control " @change="handleSplit" required>
            </div>
        </div>

        <!-- Text input Address Réf -->
        <div class="col-xl-8 col-lg-8 col-md-6 col-sm-6 col-6">
            <div class="form-group mb-2">
                <label class="form-label mb-1" for="address_ref">Réference <sup class="text-danger">*</sup> </label>
                <input id="address_ref" :class="border" name="address_ref" v-model="model.split.reference" type="text"
                    placeholder="Réference..." class="form-control " @change="handleSplit" required>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "Address-field",

    props: {
        model: {
            type: Object,
            default: () => { }
        },
        border: {
            type: String,
            default: ''
        }
    },

    computed: {
        provinces() {
            return this.$store.state.provinces;
        },
    },

    methods: {
        handleSplit(event) {
            let res = this.model;
            let split = `PROVINCE :  ${res.split.province.title} | VILLE :  ${res.split.ville} |  COMMUNE :  ${res.split.commune} | QUARTIER :  ${res.split.quartier} | AVENUE :  ${res.split.avenue} | NUMERO :  ${res.split.numero} | REFERENCE :  ${res.split.reference}`;
            if (res.reponse !== undefined) {
                if (res.split.province.title !== '' && res.split.ville !== '' && res.split.commune !== '' && res.split.quartier && res.split.quartier !== '' && res.split.avenue !== '' && res.split.numero !== '' && (res.split.reference !== '')) {
                    res.reponse = split.toString();
                }
            }

        },
    }
}
</script>