<template>
  <v-container id="dashboard" fluid tag="section">
    <v-row>
      <v-col cols="6" md="3">
        <base-material-card :title="train_card_title">
          <v-row>
            <v-col cols="12" md="6" class="mt-10">
              <v-btn color="orange" class="px-1 ml-1" fab large v-on:click="loadTrainList()">
                <v-icon>mdi-train</v-icon>
              </v-btn>
            </v-col>
          </v-row>
        </base-material-card>
      </v-col>
      <v-col cols="6" md="3">
        <base-material-card :title="coach_card_title">
          <v-row>
            <v-col cols="12" md="6" class="mt-10">
              <v-btn color="orange" class="px-1 ml-1" fab large>
                <v-icon>mdi-subway</v-icon>
              </v-btn>
            </v-col>
          </v-row>
        </base-material-card>
      </v-col>
      <v-col cols="6" md="3">
        <base-material-card :title="fault_card_title">
          <v-row>
            <v-col cols="12" md="6" class="mt-10">
              <v-btn color="orange" class="px-1 ml-1" fab large>
                <v-icon>mdi-alert-circle</v-icon>
              </v-btn>
            </v-col>
          </v-row>
        </base-material-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import router from "../../router";
import axios from "axios";

export default {
  name: "DashboardDashboard",

  data() {
    return {
      train_list: [],
      train_card_title: "",
      coach_card_title: "",
      fault_card_title: "",
    };
  },

  computed: {},
  mounted() {
    this.getSummary();
  },
  methods: {
    complete(index) {
      this.list[index] = !this.list[index];
    },
    loadTrainList() {
      router.push("/trainList");
    },
    getSummary() {
      this.$session.start();
      axios
        .get("http://localhost:8000/api/getSummary/", {
          headers: {
            Authorization: "JWT " + this.$session.get("token"),
          },
        })
        .then((res) => {
          this.train_list = res.data;
          this.train_card_title = "Trains: ";
          this.coach_card_title = "Coaches: ";
          this.fault_card_title = "Faults: ";
          let coach_count = 0;
          let fault_count = 0;
          if (this.train_list !== null) {
            this.train_card_title += this.train_list.length;
            if (this.train_list.length > 0) {
              this.train_list.forEach((train) => {
                train.rakes.forEach((rake) => {
                  if (rake.coaches != null) {
                    coach_count += rake.coaches.length;
                    rake.coaches.forEach((coach) => {
                      if (coach.faults != null) {
                        fault_count += coach.faults.length;
                      }
                    });
                  }
                });
              });
            }
            this.coach_card_title += coach_count;
            this.fault_card_title += fault_count;
          }
        })
        .catch((e) => {
          console.log(e);
          this.loading = false;
        });
    },
  },
};
</script>

<style lang="scss">
.v-sheet {
  border-radius: 4px;
}
</style>
