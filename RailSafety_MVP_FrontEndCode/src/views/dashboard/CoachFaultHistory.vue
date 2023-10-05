<template>
  <base-material-card color="orange" icon="mdi-train" inline title class="px-5 py-3 mb-5">
    <div class="my-6" />
    <div align="right">
      <v-btn v-on:click="loadCoachList()" large class="ma-1" color="secondary">BACK</v-btn>
    </div>
    <div class="my-6" />
    <v-container fluid tag="section">
      <v-row>
        <v-col cols="12" md="6">
          <base-material-card color="green" class="px-5 py-3">
            <template v-slot:heading>
              <v-row>
                <v-col>
                  <div class="display-2 font-weight-medium">Coach No. : {{ coach_no.split("_")[2] }}</div>
                </v-col>
                <v-col></v-col>
              </v-row>
            </template>

            <v-row>
              <v-col>Rake No. :</v-col>
              <v-col>
                <span>
                  <b>{{ rake_no.split("_")[1] }}</b>
                </span>
              </v-col>
            </v-row>
            <v-row>
              <v-col>Coach Type :</v-col>
              <v-col>
                <span>
                  <b>{{ coach_obj.coach_type }}</b>
                </span>
              </v-col>
            </v-row>
            <v-row>
              <v-col>Coach Position :</v-col>
              <v-col>
                <span>
                  <b>{{ coach_obj.coach_name }}</b>
                </span>
              </v-col>
            </v-row>
          </base-material-card>
        </v-col>
        <v-col cols="12" md="6">
          <base-material-card color="orange" inline class="px-5 py-3">
            <template v-slot:heading>
              <div class="display-2 font-weight-medium">Fault History</div>
            </template>
            <v-card-text>
              <v-data-table :headers="headers" :items="faultList" />
            </v-card-text>
          </base-material-card>
        </v-col>
      </v-row>
      <v-row></v-row>
    </v-container>
  </base-material-card>
</template>

<script>
import router from "../../router";
import axios from "axios";

export default {
  name: "CoachFaultHistory",
  mounted() {
    this.checkLoggedIn();
  },
  methods: {
    checkLoggedIn() {
      this.$session.start();
      this.coach_no = this.$route.query.coach_no;

      if (this.$session.has("token")) {
        axios
          .get(
            "http://localhost:8000/api/getCoachFaults/" + this.coach_no + "/",
            {
              headers: {
                Authorization: "JWT " + this.$session.get("token"),
              },
            }
          )
          .then((res) => {
            this.coach_obj = res.data;

            this.faultList = this.coach_obj.faults;
            this.rake_no = this.coach_obj.rake;
          })
          .catch((e) => {
            console.log(e);
            this.loading = false;
          });
      } else {
        router.push("/pages/Login");
      }
    },
    loadCoachList() {
      router.push("/coachList?rake_no=" + this.rake_no);
    },
  },
  data: () => ({
    rake_no: "",
    coach_no: "",
    coach_obj: {},
    faultList: [],
    headers: [
      {
        sortable: true,
        text: "WSP code",
        value: "wsp_status_code",
      },
      {
        sortable: true,
        text: "Logged time",
        value: "fault_datetime",
      },
    ],
  }),
};
</script>
