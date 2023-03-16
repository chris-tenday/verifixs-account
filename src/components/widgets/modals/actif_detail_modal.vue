<template>
  <div class="modal fade" id="detailModal" tabindex="-1" role="dialog" data-bs-backdrop="false" aria-hidden="true"
    style="background-color: rgba(0, 0, 0, 0.5)">
    <div class="modal-dialog modal-lg rounded-0" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">Actif {{ data.titre }}</h3>
          <button type="button" class="btn-close text-white" data-bs-dismiss="modal" aria-label="Close"></button>
          <button id="detailShowBtn" class="d-none" data-bs-target="#detailModal" data-bs-toggle="modal"></button>
        </div>
        <!-- end /.modal-header -->

        <div class="modal-body">
          <div class="row" v-if="data">
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
              <div class="mb-8">
                <ul class="list-group">
                  <li class="list-group-item rounded-0 border-top-0" v-for="(item, key) in data.details" :key="key">
                    <div class="d-md-flex mb-3" v-if="item.reponse_type.includes('file')">
                      <div class="w-50">
                        <span class="fw-semi-bold text-dark">{{ item.actif_detail }} :</span>
                      </div>
                      <div>
                        <span><a :href="item.detail"><img :src="item.detail" class="img-fluid rounded h-40"
                              alt="file" /></a></span>
                      </div>
                    </div>
                    <div class="d-md-flex" v-else>
                      <div class="w-50">
                        <span class="fw-semi-bold text-dark">{{ item.actif_detail }} :</span>
                      </div>
                      <div>
                        <span>{{ item.detail }}</span>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <!-- end /.modal-body -->

        <div class="modal-footer">
          <button type="reset" data-bs-dismiss="modal" class="btn btn-sm btn-secondary">
            Fermer
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "ActifModal",
  props: {
    data: {
      type: Object,
      default: () => { },
    },
  },
};
</script>
