<template>
  <div
    class="container-fluid h-100 overflow-auto d-flex justify-content-center"
  >
    <div class="text-center w-75 p-3 m-3">
      <h1 class="text-center">Settings</h1>
      <section class="content">
        <div class="row">
          <div class="box box-info w-100 p-3 m-3">
            <div class="box-header with-border">
              <h3 class="box-title">Inputs</h3>
            </div>

            <div class="box-body">
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-fw fa-calendar"></i>
                  </span>
                </div>
                <datepicker
                  :readonly="true"
                  class="form-control"
                  format="MMM/D/YYYY"
                  id="dateInput"
                  width="100%"
                ></datepicker>
              </div>

              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-fw fa-at" aria-hidden="true"></i>
                  </span>
                </div>
                <input
                  class="form-control"
                  placeholder="Username"
                  type="text"
                />
              </div>

              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-fw fa-usd" aria-hidden="true"></i>
                  </span>
                </div>
                <input class="form-control" type="text" />
                <div class="input-group-append">
                  <span class="input-group-text">.00</span>
                </div>
              </div>

              <h4>With icons</h4>
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-fw fa-envelope"></i>
                  </span>
                </div>
                <input class="form-control" placeholder="Email" type="email" />
              </div>

              <div class="input-group">
                <input class="form-control" type="text" />
                <div class="input-group-append">
                  <span class="input-group-text">
                    <i class="fa fa-fw fa-check"></i>
                  </span>
                </div>
              </div>
              <br />

              <h4>With border indicator</h4>
              <div class="form-group has-success mb-3">
                <label class="control-label" for="inputSuccess"
                  ><i class="fa fa-fw fa-check"></i> Input with success</label
                >
                <input
                  class="form-control"
                  id="inputSuccess"
                  placeholder="Enter ..."
                  type="text"
                />
                <span class="help-block">Help block with success</span>
              </div>

              <div class="form-group has-error mb-3">
                <label class="control-label" for="inputError"
                  ><i class="fa fa-fw fa-times-circle-o"></i> Input with
                  error</label
                >
                <input
                  class="form-control"
                  id="inputError"
                  placeholder="Enter ..."
                  type="text"
                />
                <span class="help-block">Help block with error</span>
              </div>

              <h4>Select Options</h4>
              <div class="form-group mb-3">
                <label>Select</label>
                <select class="form-control">
                  <option>option 1</option>
                  <option>option 2</option>
                  <option>option 3</option>
                  <option>option 4</option>
                  <option>option 5</option>
                </select>
              </div>

              <div class="form-group mb-3">
                <label>Select Multiple</label>
                <select multiple="" class="form-control">
                  <option>option 1</option>
                  <option>option 2</option>
                  <option>option 3</option>
                  <option>option 4</option>
                  <option>option 5</option>
                </select>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script>
require('moment')
import datepicker from 'vue-date-picker'

export default {
  name: 'Settings',
  components: { datepicker },
  computed: {
    datetime() {
      return new Date()
    }
  }
}
</script>
