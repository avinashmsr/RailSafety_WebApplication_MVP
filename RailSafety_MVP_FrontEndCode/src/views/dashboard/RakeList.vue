<template>
  <base-material-card
    color="orange"
    icon="mdi-clipboard-text"
    inline
    title="Rake List Main Page"
    class="px-5 py-3 mb-5"
  >
    <div class="my-6" />
    <div align="right">
      <v-btn v-on:click="loadRakeDetail('0')" large class="ma-1" color="blue">ADD RAKE</v-btn>
      <v-btn v-on:click="loadTrainList()" large class="ma-1" color="secondary">BACK</v-btn>
    </div>
    <div class="my-6" />
    <v-simple-table>
      <thead>
        <tr>
          <th>Train No.</th>
          <th>Rake No.</th>
          <th>No. of coaches</th>
          <th>No. of coaches with WSP 99</th>
          <th>No. of coaches with fault</th>
          <th class="text-right">Actions</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="rake in rakeList" :key="rake.rake_no">
          <td>{{ rake.train }}</td>
          <td>{{ rake.rake_no }}</td>
          <td>{{ (rake.coaches !== null) ? rake.coaches.length : 0 }}</td>
          <td>{{ (rake.coaches !== null && rake.coaches.length > 0) ? checkForWSP99(rake.coaches) : 0 }}</td>
          <td>{{ (rake.coaches !== null && rake.coaches.length > 0) ? checkForWSP72(rake.coaches) : 0 }}</td>
          <td class="text-right">
            <v-btn
              color="orange"
              class="px-1 ml-1"
              fab
              x-small
              v-on:click="loadCoachList(rake.trainrake_no)"
            >
              <v-icon>mdi-train</v-icon>
            </v-btn>
            <v-btn
              color="blue"
              class="px-1 ml-1"
              fab
              x-small
              v-on:click="loadRakeDetail(rake.trainrake_no)"
            >
              <v-icon>mdi-pencil</v-icon>
            </v-btn>
            <v-btn
              v-on:click="deleteRakeConfirmation(rake.trainrake_no)"
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
          Are you sure to delete rake ?
          <v-spacer />

          <v-icon aria-label="Close" @click="dialog3 = false">mdi-close</v-icon>
        </v-card-title>

        <v-card-text class="pb-6 pt-12 text-center">
          <v-btn class="mr-3" text @click="dialog3 = false">No</v-btn>

          <v-btn color="success" text @click="deleteRakeDetails()">Yes</v-btn>
        </v-card-text>
      </v-card>
    </v-dialog>
    <!-- <v-container fluid tag="section">
      <v-row>
        <v-col cols="12" md="6" v-for="rake in rakeList" :key="rake.rake_no">
          <base-material-card class="px-5 py-3">
            <template v-slot:heading>
              <v-row>
                <v-col>
                  <v-btn
                    color="orange"
                    class="px-1 ml-1"
                    fab
                    small
                    @click="loadCoachList(rake.rake_no)"
                  >
                    <v-icon>mdi-train</v-icon>
                  </v-btn>
                </v-col>
                <v-col>
                  <div
                    class="display-2 font-weight-medium"
                  >Rake No. : {{ rake.rake_no }}</div>
                </v-col>
                <v-col>
                  <v-btn
                    color="blue"
                    class="px-1 ml-1"
                    fab
                    small
                    v-on:click="loadRakeDetail(rake.rake_no)"
                  >
                    <v-icon>mdi-pencil</v-icon>
                  </v-btn>
                </v-col>
              </v-row>
            </template>

            <v-row>
              <v-col>Train No. :</v-col>
              <v-col>
                <span>
                  <b>{{ rake.train }}</b>
                </span>
              </v-col>
            </v-row>
            <v-row>
              <v-col>No. of coaches :</v-col>
              <v-col>
                <span>
                  <b>{{ (rake.coaches !== null) ? rake.coaches.length : 0 }}</b>
                </span>
              </v-col>
            </v-row>
            <v-row>
              <v-col>No. of coaches with WSP 99:</v-col>
              <v-col>
                <span>
                  <b>{{ (rake.coaches !== null && rake.coaches.length >0) ? checkForWSP99(rake.coaches) : 0 }}</b>
                </span>
              </v-col>
            </v-row>
            <v-row>
              <v-col>No. of coaches with fault:</v-col>
              <v-col>
                <span>
                  <b>{{ (rake.coaches !== null && rake.coaches.length >0) ? checkForWSP72(rake.coaches) : 0 }}</b>
                </span>
              </v-col>
            </v-row>
          </base-material-card>
        </v-col>
      </v-row>
    </v-container>-->
  </base-material-card>
</template>

<script>
import router from "../../router";
import axios from "axios";

export default {
  name: "RakeList",
  mounted() {
    this.checkLoggedIn();
  },
  methods: {
    checkLoggedIn() {
      this.$session.start();
      this.train_no = this.$route.query.train_no;
      if (this.$session.has("token")) {
        this.getRakeList();
      } else {
        router.push("/pages/Login");
      }
    },
    checkForWSP99(coaches) {
      var wsp_99_count = 0;
      coaches.forEach((coach) => {
        if (
          coach.faults !== null &&
          coach.faults.length > 0 &&
          coach.faults[0].wsp_status_code === 99
        ) {
          wsp_99_count++;
        }
      });
      return wsp_99_count;
    },
    checkForWSP72(coaches) {
      var wsp_72_count = 0;
      coaches.forEach((coach) => {
        if (
          coach.faults !== null &&
          coach.faults.length > 0 &&
          coach.faults[0].wsp_status_code === 72
        ) {
          wsp_72_count++;
        }
      });
      return wsp_72_count;
    },
    getRakeList() {
      axios
        .get(
          "http://localhost:8000/api/getRakeList/?train_no=" + this.train_no,
          {
            headers: {
              Authorization: "JWT " + this.$session.get("token"),
            },
          }
        )
        .then((res) => {
          this.rakeList = res.data;
          this.rakeList.forEach((rake) => {
            rake.coaches.forEach((coach) => {
              if (coach.faults !== null && coach.faults.length > 0) {
                coach.faults.sort(function (a, b) {
                  return (
                    new Date(b.fault_datetime) - new Date(a.fault_datetime)
                  );
                });
              }
            });
          });
        })
        .catch((e) => {
          console.log(e);
          this.loading = false;
        });
    },
    loadRakeDetail(trainrake_no) {
      router.push(
        "/rakeDetail?train_no=" + this.train_no + "&rake_no=" + trainrake_no
      );
    },
    loadCoachList(trainrake_no) {
      router.push("/coachList?rake_no=" + trainrake_no);
    },
    loadTrainList() {
      router.push("/trainList");
    },
    deleteRakeConfirmation(rake_no) {
      this.dialog3 = true;
      this.current_rake_no = rake_no;
    },
    deleteRakeDetails() {
      const config = {
        headers: {
          Authorization: "JWT " + this.$session.get("token"),
        },
      };
      let del_api_url = "http://localhost:8000/api/deleteRakeDetails/";

      axios
        .delete(del_api_url + this.current_rake_no + "/", config)
        .then((res) => {
          this.getRakeList();
          this.dialog3 = false;
          this.popup_title = "Rake No. " + this.current_rake_no.split("_")[2];
          this.popup_text = "Rake deleted Successfully !";
          this.btn_color = "success";
          this.icon = "mdi-check";
          this.dialog = true;
        })
        .catch((e) => {
          this.popup_title = "Rake No. " + this.current_rake_no.split("_")[2];
          this.popup_text = e;
          this.btn_color = "error";
          this.icon = "mdi-close";
          this.dialog = true;
        });
    },
  },
  data: () => ({
    train_no: "",
    rakeList: [],
    current_rake_no: "",
    delete_conf_text: "",
    dialog3: false,
  }),
};
</script>