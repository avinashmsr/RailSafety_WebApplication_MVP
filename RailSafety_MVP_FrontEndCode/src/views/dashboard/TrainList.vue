<template>
  <v-container fluid tag="section">
    <v-row>
      <v-col cols="10">
        <base-material-card
          color="orange"
          icon="mdi-train"
          inline
          title="Train List Main Page"
          class="px-5 py-3 mb-5"
        >
          <div class="my-6" />
          <div align="right">
            <v-btn v-on:click="loadTrainDetail(0)" large class="ma-1" color="blue">ADD TRAIN</v-btn>
            <v-btn v-on:click="loadDashboardPage()" large class="ma-1" color="secondary">BACK</v-btn>
          </div>
          <div class="my-6" />
          <v-simple-table>
            <thead>
              <tr>
                <th>Train No.</th>
                <th>Train Name</th>
                <th class="text-right">Actions</th>
              </tr>
            </thead>

            <tbody>
              <tr v-for="train in trainList" :key="train.train_no">
                <td>{{ train.train_no }}</td>
                <td>{{ train.train_name }}</td>
                <td class="text-right">
                  <v-btn
                    color="orange"
                    class="px-1 ml-1"
                    fab
                    x-small
                    v-on:click="loadRakeList(train.train_no)"
                  >
                    <v-icon>mdi-train</v-icon>
                  </v-btn>
                  <v-btn
                    color="blue"
                    class="px-1 ml-1"
                    fab
                    x-small
                    v-on:click="loadTrainDetail(train.train_no)"
                  >
                    <v-icon>mdi-pencil</v-icon>
                  </v-btn>
                  <v-btn
                    v-on:click="deleteTrainConfirmation(train.train_no)"
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
                Are you sure to delete train ?
                <v-spacer />

                <v-icon aria-label="Close" @click="dialog3 = false">mdi-close</v-icon>
              </v-card-title>

              <v-card-text class="pb-6 pt-12 text-center">
                <v-btn class="mr-3" text @click="dialog3 = false">No</v-btn>

                <v-btn color="success" text @click="deleteTrainDetails()">Yes</v-btn>
              </v-card-text>
            </v-card>
          </v-dialog>
        </base-material-card>
      </v-col>
    </v-row>
  </v-container>
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
      if (this.$session.has("token")) {
        this.getTrainList();
      } else {
        router.push("/pages/Login");
      }
    },
    getTrainList() {
      axios
        .get("http://localhost:8000/api/getTrainList/", {
          headers: {
            Authorization: "JWT " + this.$session.get("token"),
          },
        })
        .then((res) => {
          this.trainList = res.data;
        })
        .catch((e) => {
          console.log(e);
          this.loading = false;
        });
    },
    loadRakeList(train_no) {
      router.push("/rakeList?train_no=" + train_no);
    },
    loadTrainDetail(train_no, mode) {
      router.push("/trainDetail?train_no=" + train_no);
    },
    loadDashboardPage() {
      router.push("/");
    },
    deleteTrainConfirmation(train_no) {
      this.dialog3 = true;
      this.current_train_no = train_no;
    },
    deleteTrainDetails() {
      const config = {
        headers: {
          Authorization: "JWT " + this.$session.get("token"),
        },
      };
      let del_api_url = "http://localhost:8000/api/deleteTrainDetails/";

      axios
        .delete(del_api_url + this.current_train_no + "/", config)
        .then((res) => {
          this.getTrainList();
          this.dialog3 = false;
          this.popup_title = "Train No. " + this.current_train_no;
          this.popup_text = "Train deleted Successfully !";
          this.btn_color = "success";
          this.icon = "mdi-check";
          this.dialog = true;
        })
        .catch((e) => {
          this.popup_title = "Train No. " + this.current_train_no;
          this.popup_text = e;
          this.btn_color = "error";
          this.icon = "mdi-close";
          this.dialog = true;
        });
    },
  },
  data: () => ({
    train_no: "",
    trainList: [],
    current_train_no: "",
    delete_conf_text: "",
    dialog3: false,
  }),
};
</script>