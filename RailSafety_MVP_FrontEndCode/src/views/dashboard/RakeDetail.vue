<template>
  <v-container fluid tag="section">
    <v-row>
      <v-col cols="10">
        <base-material-card color="success" inline :title="page_title" class="px-5 py-3">
          <v-form class="pt-1" data-vv-scope="form-1" @submit.prevent="validateForm('form-1')">
            <v-row>
              <v-col>
                <v-text-field
                  v-model="train_no"
                  label="Train Number"
                  outlined
                  class="ml-4"
                  disabled
                />
              </v-col>
              <v-col>
                <v-text-field
                  v-model="rake_no"
                  label="Rake Number"
                  outlined
                  class="ml-4"
                  :disabled="trainrake_no !== '0'"
                  v-validate="'required'"
                  :error-messages="errors.collect('form-1.rake_no')"
                  data-vv-name="rake_no"
                  data-vv-as="Rake no"
                />
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-textarea
                  outlined
                  name="desc"
                  label="Description"
                  v-model="desc"
                  class="ml-4"
                  v-validate="'required'"
                  :error-messages="errors.collect('form-1.desc')"
                  data-vv-name="desc"
                  data-vv-as="Description"
                />
              </v-col>
              <v-col>
                <v-text-field v-model="status" label="Status" outlined class="ml-4" disabled />
              </v-col>
            </v-row>

            <div class="my-6" />
            <div align="right">
              <v-btn type="submit" large class="ma-1 pa-0" color="blue">SAVE</v-btn>
              <v-btn v-on:click="loadRakeList()" large class="ma-1" color="secondary">BACK</v-btn>
            </div>
            <div class="my-6" />
          </v-form>
        </base-material-card>
      </v-col>
    </v-row>
    <v-dialog v-model="dialog" max-width="500">
      <v-card class="text-center">
        <v-card-title>
          {{popup_title}}
          <v-spacer />

          <v-icon aria-label="Close" @click="dialog = false">mdi-close</v-icon>
        </v-card-title>
        <v-btn :color="btn_color" class="px-1 ml-1" fab small>
          <v-icon v-text="icon" />
        </v-btn>

        <v-card-text style="font-size:medium">{{popup_text}}</v-card-text>

        <v-card-actions>
          <v-spacer />

          <v-btn color="error" text @click="dialog = false">Close</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import router from "../../router";
import axios from "axios";

export default {
  name: "RakeDetail",
  mounted() {
    this.checkLoggedIn();
  },
  methods: {
    checkLoggedIn() {
      this.$session.start();
      this.train_no = this.$route.query.train_no;
      this.trainrake_no = this.$route.query.rake_no;

      if (this.$session.has("token")) {
        if (this.trainrake_no !== "0") {
          this.page_title = "Edit Rake Details";
          let get_api_url = "http://localhost:8000/api/getRakeDetails/";
          axios
            .get(get_api_url + this.trainrake_no + "/", {
              headers: {
                Authorization: "JWT " + this.$session.get("token"),
              },
            })
            .then((res) => {
              this.rake_obj = res.data;

              this.rake_no = this.rake_obj.rake_no;
              this.desc = this.rake_obj.description;
              this.status = this.rake_obj.status;
            })
            .catch((e) => {
              console.log(e);
              this.loading = false;
            });
        } else {
          this.page_title = "Add Rake";
          this.status = "Active";
        }
      } else {
        router.push("/pages/Login");
      }
    },
    loadRakeList() {
      router.push("/rakeList?train_no=" + this.train_no);
    },

    validateForm(scope) {
      this.$validator.validateAll(scope).then((result) => {
        if (result) {
          const config = {
            headers: {
              Authorization: "JWT " + this.$session.get("token"),
            },
          };
          let body = {
            train: this.train_no,
            rake_no: this.rake_no,
            status: this.status,
            description: this.desc,
            trainrake_no: this.trainrake_no,
          };
          if (this.trainrake_no !== "0") {
            let put_api_url = "http://localhost:8000/api/updateRakeDetails/";
            axios
              .put(put_api_url + this.trainrake_no + "/", body, config)
              .then((res) => {
                this.popup_title = "Rake No. " + this.rake_no;
                this.popup_text = "Rake Details updated Successfully !";
                this.btn_color = "success";
                this.icon = "mdi-check";
                this.dialog = true;
              })
              .catch((e) => {
                this.popup_title = "Rake No. " + this.rake_no;
                this.popup_text = e;
                this.btn_color = "error";
                this.icon = "mdi-close";
                this.dialog = true;
              });
          } else {
            body["trainrake_no"] = this.train_no + "_" + this.rake_no;
            let post_api_url = "http://localhost:8000/api/addRakeDetails/";
            axios
              .post(post_api_url, body, config)
              .then((res) => {
                this.popup_title = "Rake No. " + this.rake_no;
                this.popup_text = "Rake added Successfully !";
                this.btn_color = "success";
                this.icon = "mdi-check";
                this.dialog = true;
              })
              .catch((e) => {
                this.popup_title = "Rake No. " + this.rake_no;
                this.popup_text = e.message;
                if (e.response.data.trainrake_no && e.response.data.trainrake_no[0]) {
                  this.popup_text = e.response.data.trainrake_no[0];
                }
                this.btn_color = "error";
                this.icon = "mdi-close";
                this.dialog = true;
              });
          }
        }
      });
    },
  },
  data: () => ({
    train_no: null,
    rake_no: "",
    trainrake_no: "",
    rake_obj: {},
    desc: "",
    status: "",
    dialog: false,
    popup_title: "",
    popup_text: "",
    btn_color: "",
    icon: "",
    page_title: "",
  }),
};
</script>

