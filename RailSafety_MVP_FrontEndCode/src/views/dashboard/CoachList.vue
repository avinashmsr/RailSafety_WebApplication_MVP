<template>
  <base-material-card
    color="orange"
    icon="mdi-clipboard-text"
    inline
    title="Coach List page"
    class="px-5 py-3 mb-5"
  >
    <div class="my-6" />
    <div align="right">
      <v-btn v-on:click="loadCoachDetails('0')" large class="ma-1" color="blue">ADD COACH</v-btn>
      <v-btn v-on:click="loadRakeList()" large class="ma-1" color="secondary">BACK</v-btn>
    </div>
    <div class="my-6" />
    <v-simple-table>
      <thead>
        <tr>
          <th>Rake No.</th>
          <th>Prefix</th>
          <th>Coach No.</th>
          <th>Coach Type</th>
          <th>Coach position</th>
          <th>Current WSP status</th>
          <th>Updated time</th>
          <th class="text-right">Actions</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="coach in coachList" :key="coach.coach_no">
          <td>{{ coach.rake.split("_")[1] }}</td>
          <td>{{ coach.prefix }}</td>
          <td>{{ coach.coach_no }}</td>
          <td>{{ coach.coach_type }}</td>
          <td>{{ coach.coach_name }}</td>
          <td>{{ (coach.faults !== null && coach.faults.length>0) ? coach.faults[0].wsp_status_code : "" }}</td>
          <td>{{ (coach.faults !== null && coach.faults.length>0) ? coach.faults[0].fault_datetime : "" }}</td>
          <td class="text-right">
            <v-btn
              v-on:click="loadCoachDetails(coach.trainrakecoach_no)"
              color="blue"
              class="px-1 ml-1"
              fab
              x-small
            >
              <v-icon>mdi-pencil</v-icon>
            </v-btn>
            <v-btn
              v-on:click="loadCoachFaultHistory(coach.trainrakecoach_no)"
              color="orange"
              class="px-1 ml-1"
              fab
              x-small
            >
              <v-icon>mdi-history</v-icon>
            </v-btn>
            <v-btn
              v-on:click="deleteCoachConfirmation(coach.trainrakecoach_no)"
              color="red"
              class="px-1 ml-1"
              fab
              x-small
            >
              <v-icon>mdi-delete</v-icon>
            </v-btn>
          </td>
        </tr>
      </tbody>
    </v-simple-table>
    <v-dialog v-model="dialog3" max-width="500">
      <v-card>
        <v-card-title>
          Are you sure to delete coach ?
          <v-spacer />

          <v-icon aria-label="Close" @click="dialog3 = false">mdi-close</v-icon>
        </v-card-title>

        <v-card-text class="pb-6 pt-12 text-center">
          <v-btn class="mr-3" text @click="dialog3 = false">No</v-btn>

          <v-btn color="success" text @click="deleteCoachDetails()">Yes</v-btn>
        </v-card-text>
      </v-card>
    </v-dialog>
  </base-material-card>
</template>

<script>
import router from "../../router";
import axios from "axios";

export default {
  name: "CoachList",
  mounted() {
    this.checkLoggedIn();
  },
  methods: {
    checkLoggedIn() {
      this.$session.start();
      this.trainrake_no = this.$route.query.rake_no;
      this.train_no = this.trainrake_no.split("_")[0];
      if (this.$session.has("token")) {
        this.getCoachList();
      } else {
        router.push("/pages/Login");
      }
    },
    getCoachList() {
      axios
        .get(
          "http://localhost:8000/api/getCoachList/?trainrake_no=" + this.trainrake_no,
          {
            headers: {
              Authorization: "JWT " + this.$session.get("token"),
            },
          }
        )
        .then((res) => {
          this.coachList = res.data;
          this.coachList.forEach((coach) => {
            coach.faults.sort(function (a, b) {
              return new Date(b.fault_datetime) - new Date(a.fault_datetime);
            });
          });
        })
        .catch((e) => {
          console.log(e);
          this.loading = false;
        });
    },
    loadRakeList() {
      router.push("/rakeList?train_no=" + this.train_no);
    },
    loadCoachFaultHistory(coach_no) {
      router.push("/coachFaultHistory?coach_no=" + coach_no);
    },
    loadCoachDetails(trainrakecoach_no) {
      router.push(
        "/coachDetail?rake_no=" + this.trainrake_no + "&coach_no=" + trainrakecoach_no
      );
    },
    deleteCoachConfirmation(coach_no) {
      this.dialog3 = true;
      this.current_coach_no = coach_no;
    },
    deleteCoachDetails() {
      const config = {
        headers: {
          Authorization: "JWT " + this.$session.get("token"),
        },
      };
      let del_api_url = "http://localhost:8000/api/deleteCoachDetails/";

      axios
        .delete(del_api_url + this.current_coach_no + "/", config)
        .then((res) => {
          this.getCoachList();
          this.dialog3 = false;
          this.popup_title = "Coach No. " + this.current_coach_no.split("_")[2];
          this.popup_text = "Coach deleted Successfully !";
          this.btn_color = "success";
          this.icon = "mdi-check";
          this.dialog = true;
        })
        .catch((e) => {
          this.popup_title = "Coach No. " + this.current_coach_no.split("_")[2];
          this.popup_text = e;
          this.btn_color = "error";
          this.icon = "mdi-close";
          this.dialog = true;
        });
    },
  },
  data: () => ({
    trainrake_no: "",
    coachList: [],
    delete_conf_text: "",
    dialog3: false,
    current_coach_no: "",
  }),
};
</script>
