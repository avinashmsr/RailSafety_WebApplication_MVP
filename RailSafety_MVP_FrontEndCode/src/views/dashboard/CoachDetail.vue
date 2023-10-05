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
                <v-text-field v-model="rake_no" label="Rake Number" outlined class="ml-4" disabled />
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-select
                  v-model="prefix"
                  :items="prefixes"
                  label="Prefix"
                  outlined
                  class="ml-4"
                  v-validate="'required'"
                  :error-messages="errors.collect('form-1.prefix')"
                  data-vv-name="prefix"
                  data-vv-as="Prefix"
                />
              </v-col>
              <v-col>
                <v-text-field
                  v-model="coach_no"
                  label="Coach Number"
                  outlined
                  class="ml-4"
                  :disabled="trainrakecoach_no !== '0'"
                  v-validate="'required'"
                  :error-messages="errors.collect('form-1.coach_no')"
                  data-vv-name="coach_no"
                  data-vv-as="Coach Number"
                />
              </v-col>
            </v-row>

            <v-row>
              <v-col cols="12" sm="6">
                <v-text-field
                  v-model="coach_name"
                  label="Coach Position"
                  outlined
                  class="ml-4"
                  v-validate="'required'"
                  :error-messages="errors.collect('form-1.coach_name')"
                  data-vv-name="coach_name"
                  data-vv-as="Coach Position"
                />
              </v-col>
              <v-col cols="12" sm="6">
                <v-select
                  v-model="coach_type"
                  :items="coach_types"
                  label="Coach Type"
                  outlined
                  class="ml-4"
                  v-validate="'required'"
                  :error-messages="errors.collect('form-1.coach_type')"
                  data-vv-name="coach_type"
                  data-vv-as="Coach Type"
                />
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" sm="6">
                <v-select
                  v-model="coach_class"
                  :items="coach_classes"
                  label="Coach Class"
                  outlined
                  class="ml-4"
                  v-validate="'required'"
                  :error-messages="errors.collect('form-1.coach_class')"
                  data-vv-name="coach_class"
                  data-vv-as="Coach Class"
                />
              </v-col>
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
            </v-row>
            <div class="my-6" />
            <div align="right">
              <v-btn type="submit" large class="ma-1 pa-0" color="blue">SAVE</v-btn>
              <v-btn v-on:click="loadCoachList()" large class="ma-1" color="secondary">BACK</v-btn>
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
  name: "CoachDetail",
  mounted() {
    this.checkLoggedIn();
  },
  methods: {
    checkLoggedIn() {
      this.$session.start();
      this.trainrake_no = this.$route.query.rake_no;
      this.trainrakecoach_no = this.$route.query.coach_no;
      this.train_no = this.trainrake_no.split("_")[0];
      this.rake_no = this.trainrake_no.split("_")[1];

      if (this.$session.has("token")) {
        if (this.trainrakecoach_no !== "0") {
          this.page_title = "Edit Coach Details";
          let get_api_url = "http://localhost:8000/api/getCoachDetails/";
          axios
            .get(get_api_url + this.trainrakecoach_no + "/", {
              headers: {
                Authorization: "JWT " + this.$session.get("token"),
              },
            })
            .then((res) => {
              this.coach_obj = res.data;
              this.coach_no = this.coach_obj.coach_no;
              this.coach_name = this.coach_obj.coach_name;
              this.coach_type = this.coach_obj.coach_type;
              this.coach_class = this.coach_obj.coach_class;
              this.desc = this.coach_obj.description;
              this.prefix = this.coach_obj.prefix;
              this.position = this.coach_obj.position;
            })
            .catch((e) => {
              console.log(e);
              this.loading = false;
            });
        } else {
          this.page_title = "Add Coach";
        }
      } else {
        router.push("/pages/Login");
      }
    },
    loadCoachList() {
      router.push("/coachList?rake_no=" + this.trainrake_no);
    },
    // saveCoachDetail() {

    // },
    validateForm(scope) {
      this.$validator.validateAll(scope).then((result) => {
        if (result) {
          const config = {
            headers: {
              Authorization: "JWT " + this.$session.get("token"),
            },
          };
          let body = {
            rake: this.trainrake_no,
            coach_no: this.coach_no,
            coach_name: this.coach_name,
            coach_type: this.coach_type,
            description: this.desc,
            coach_class: this.coach_class,
            prefix: this.prefix,
            trainrakecoach_no: this.trainrakecoach_no,
            position: this.position,
          };
          if (this.trainrakecoach_no !== "0") {
            let put_api_url = "http://localhost:8000/api/updateCoachDetails/";
            axios
              .put(put_api_url + this.trainrakecoach_no + "/", body, config)
              .then((res) => {
                this.popup_title = "Coach No. " + this.coach_no;
                this.popup_text = "Coach Details updated Successfully !";
                this.btn_color = "success";
                this.icon = "mdi-check";
                this.dialog = true;
              })
              .catch((e) => {
                this.popup_title = "Coach No. " + this.coach_no;
                this.popup_text = e;
                this.btn_color = "error";
                this.icon = "mdi-close";
                this.dialog = true;
              });
          } else {
            body["trainrakecoach_no"] = this.trainrake_no + "_" + this.coach_no;
            let post_api_url = "http://localhost:8000/api/addCoachDetails/";
            axios
              .post(post_api_url, body, config)
              .then((res) => {
                this.popup_title = "Coach No. " + this.coach_no;
                this.popup_text = "Coach added Successfully !";
                this.btn_color = "success";
                this.icon = "mdi-check";
                this.dialog = true;
              })
              .catch((e) => {
                this.popup_title = "Coach No. " + this.coach_no;
                this.popup_text = e.message;
                if (e.response.data.trainrakecoach_no && e.response.data.trainrakecoach_no[0]) {
                  this.popup_text = e.response.data.trainrakecoach_no[0];
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
    coach_no: null,
    rake_no: null,
    trainrake_no: "",
    trainrakecoach_no: "",
    coach_obj: {},
    coach_name: "",
    coach_type: "",
    desc: "",
    coach_class: "",
    prefix: "",
    position: 0,
    coach_types: ["LMACCN", "ABCDE", "FGHIJ", "KLMNO", "PQRST"],
    coach_classes: [
      "AC-I Class",
      "AC-II Class",
      "AC-III Class",
      "SL-I",
      "SL-II",
    ],
    dialog: false,
    popup_title: "",
    popup_text: "",
    btn_color: "",
    icon: "",
    page_title: "",
    prefixes: ["NE", "NW", "SE", "SW", "C", "N", "E", "W", "S"],
  }),
};
</script>

