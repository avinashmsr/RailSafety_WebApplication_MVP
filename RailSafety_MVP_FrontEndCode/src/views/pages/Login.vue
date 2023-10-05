<template>
  <v-container id="login" fill-height tag="section">
    <v-row justify="center">
      <v-slide-y-transition appear>
        <base-material-card color="success" light max-width="100%" width="400" class="px-5 py-3">
          <template v-slot:heading>
            <div class="text-center">
              <h1 class="display-2 font-weight-bold mb-2">Login</h1>
            </div>
          </template>

          <v-card-text class="text-center">
            <v-layout row fill-height justify-center align-center v-if="loading">
              <v-progress-circular :size="50" color="primary" indeterminate />
            </v-layout>
            <v-form v-else ref="form" v-model="valid" lazy-validation>
              <v-text-field
                v-model="credentials.username"
                :counter="70"
                label="User Name"
                :rules="rules.username"
                maxlength="70"
                required
              />

              <v-text-field
                type="password"
                v-model="credentials.password"
                :counter="20"
                label="Password"
                :rules="rules.password"
                maxlength="20"
                required
              />

              <v-btn
                class="orange white--text"
                :disabled="!valid"
                @click="login()"
              >Login</v-btn>
            </v-form>
          </v-card-text>
        </base-material-card>
      </v-slide-y-transition>
    </v-row>
    <base-material-snackbar
      v-model="snackbar"
      type="error"
      v-bind="{
        ['bottom']: true,
        ['center']: true
      }"
    >
      Username or Password is invalid.
    </base-material-snackbar>
  </v-container>
</template>

<script>
import axios from "axios";
import router from "../../router";

export default {
  name: "PagesLogin",

  data: () => ({
    credentials: {},
    valid: true,
    loading: false,
    rules: {
      username: [
        (v) => !!v || "Username is required",
        (v) =>
          (v && v.length > 3) || "Username must be more than 3 characters long",
        (v) =>
          /^[a-z0-9_]+$/.test(v) ||
          "Username can only contain letters and digits",
      ],
      password: [
        (v) => !!v || "Password is required",
        (v) =>
          (v && v.length > 7) || "Password must be longer than 7 characters",
      ],
    },
    snackbar: false,
  }),

  methods: {
    login() {
      // checking if the input is valid
      if (this.$refs.form.validate()) {
        this.loading = true;
        axios
          .post("http://localhost:8000/auth/", this.credentials)
          .then((res) => {
            this.$session.start();
            this.$session.set("token", res.data.token);
            router.push("/");
          })
          .catch((e) => {
            this.loading=false;
            this.snackbar = true;
            console.log(e);
          });
      }
    },
  },
};
</script>
