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
                  :disabled="mode === 'edit'"
                  v-validate="'required'"
                  :error-messages="errors.collect('form-1.train_no')"
                  data-vv-name="train_no"
                  data-vv-as="Train no"
                />
              </v-col>
              <v-col>
                <v-text-field
                  v-model="train_name"
                  label="Train Name"
                  outlined
                  class="ml-4"
                  v-validate="'required'"
                  :error-messages="errors.collect('form-1.train_name')"
                  data-vv-name="train_name"
                  data-vv-as="Train name"
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
              <v-col></v-col>
            </v-row>

            <div class="my-6" />
            <div align="right">
              <v-btn type="submit" large class="ma-1 pa-0" color="blue">SAVE</v-btn>
              <v-btn v-on:click="loadTrainList()" large class="ma-1" color="secondary">BACK</v-btn>
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
  name: "TrainDetail",
  mounted() {
    this.checkLoggedIn();
  },
  methods: {
    checkLoggedIn() {
      this.$session.start();

      this.mode = this.$route.query.train_no !== "0" ? "edit" : "add";
      if (this.$session.has("token")) {
        if (this.mode === "edit") {
          this.train_no = this.$route.query.train_no;
          this.page_title = "Edit Train Details";
          let get_api_url = "http://localhost:8000/api/getTrainDetails/";
          axios
            .get(get_api_url + this.train_no + "/", {
              headers: {
                Authorization: "JWT " + this.$session.get("token"),
              },
            })
            .then((res) => {
              this.train_obj = res.data;
              this.train_name = this.train_obj.train_name;
              this.desc = this.train_obj.description;
            })
            .catch((e) => {
              console.log(e);
              this.loading = false;
            });
        } else {
          this.page_title = "Add Train";
          this.status = "Active";
        }
      } else {
        router.push("/pages/Login");
      }
    },
    loadTrainList() {
      router.push("/trainList");
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
            train_no: this.train_no,
            train_name: this.train_name,
            description: this.desc,
          };
          if (this.mode === "edit") {
            let put_api_url = "http://localhost:8000/api/updateTrainDetails/";
            axios
              .put(put_api_url + this.train_no + "/", body, config)
              .then((res) => {
                this.popup_title = "Train No. " + this.train_no;
                this.popup_text = "Train Details updated Successfully !";
                this.btn_color = "success";
                this.icon = "mdi-check";
                this.dialog = true;
              })
              .catch((e) => {
                this.popup_title = "Train No. " + this.train_no;
                this.popup_text = e;
                this.btn_color = "error";
                this.icon = "mdi-close";
                this.dialog = true;
              });
          } else {
            let post_api_url = "http://localhost:8000/api/addTrainDetails/";
            axios
              .post(post_api_url, body, config)
              .then((res) => {
                this.popup_title = "Train No. " + this.train_no;
                this.popup_text = "Train added Successfully !";
                this.btn_color = "success";
                this.icon = "mdi-check";
                this.dialog = true;
              })
              .catch((e) => {
                this.popup_title = "Train No. " + this.train_no;
                this.popup_text = e.message;
                if (e.response.data.train_no && e.response.data.train_no[0]) {
                  this.popup_text = e.response.data.train_no[0];
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
    train_name: "",
    desc: "",
    mode: "",
    dialog: false,
    popup_title: "",
    popup_text: "",
    btn_color: "",
    icon: "",
    page_title: "",
  }),
};
</script>

