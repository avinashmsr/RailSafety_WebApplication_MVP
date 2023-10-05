<template>
  <v-container id="calendar" fluid tag="section">
    <v-row>
      <v-col cols="12" md="10" class="mx-auto">
        <v-card>
          <v-toolbar flat>
            <v-toolbar-title></v-toolbar-title>

            <v-spacer />

            <calendar-btn v-for="(t, i) in types" :key="i" @click="type = t">{{ t }}</calendar-btn>

            <v-spacer />

            <calendar-btn @click="$refs.calendar.prev()">
              <v-icon>mdi-chevron-left</v-icon>
            </calendar-btn>

            <calendar-btn @click="$refs.calendar.next()">
              <v-icon>mdi-chevron-right</v-icon>
            </calendar-btn>
          </v-toolbar>

          <v-sheet height="600" flat class="mt-5">
            <v-calendar
              ref="calendar"
              v-model="calendar"
              :events="events"
              :type="type"
              @click:event="showEvent"
              @click:more="viewDay"
              @click:date="viewDay"
              event-color="primary"
            />
          </v-sheet>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
// Components
import { VBtn } from "vuetify/lib";
import axios from "axios";

export default {
  name: "DashboardCalendar",

  components: {
    CalendarBtn: {
      extends: VBtn,

      props: {
        color: {
          type: String,
          default: "secondary",
        },
        minWidth: {
          type: Number,
          default: 0,
        },
        rounded: {
          type: Boolean,
          default: true,
        },
      },

      computed: {
        classes() {
          return {
            ...VBtn.options.computed.classes.call(this),
            "mx-1": true,
            "text-lowercase": true,
          };
        },
      },
    },
  },

  mounted() {
    this.checkLoggedIn();
  },
  methods: {
    checkLoggedIn() {
      this.$session.start();
      this.train_no = 22691;
      if (this.$session.has("token")) {
        axios
          .get(
            "http://localhost:8000/api/rakesListForTrain/" +
              this.train_no +
              "/",
            {
              headers: {
                Authorization: "JWT " + this.$session.get("token"),
              },
            }
          )
          .then((res) => {
            this.rakeList = res.data.rakes;
            let rake_obj = this.rakeList.find((x) => x.rake_no === "22691_1");
            //let coach_obj=this.rakeList.find(x=>x.rake_no==="22691_1");

            let event_arr_obj = [];
            rake_obj.coaches.forEach((coach) => {
              coach.faults.forEach((fault) => {
                let event_obj = {
                  name: fault.coach.split("_")[2],
                  start: new Date(fault.fault_datetime),
                };
                this.events.push(event_obj);
              });
            });
            this.$refs.calendar.checkChange();
          })
          .catch((e) => {
            console.log(e);
            this.loading = false;
          });
      } else {
        router.push("/pages/Login");
      }
    },
    viewDay({ date }) {
      this.focus = date;
      this.type = "day";
    },
    getEventColor(event) {
      return event.color;
    },
    setToday() {
      this.focus = "";
    },
    showEvent({ nativeEvent, event }) {
      const open = () => {
        this.selectedEvent = event;
        this.selectedElement = nativeEvent.target;
        setTimeout(() => (this.selectedOpen = true), 10);
      };

      if (this.selectedOpen) {
        this.selectedOpen = false;
        setTimeout(open, 10);
      } else {
        open();
      }

      nativeEvent.stopPropagation();
    },
  },

  data: () => ({
    calendar: "",
    disabled: true,
    events: [],
    focus: "",
    type: "month",
    types: ["month", "week", "day"],
    selectedEvent: {},
    selectedElement: null,
    selectedOpen: false,
  }),
};
</script>

<style lang="sass">
#calendar
  .v-calendar-weekly__day:last-child,
  .v-calendar-weekly__head-weekday:last-child
    border-right: none

    .v-calendar-weekly__week:last-child .v-calendar-weekly__day
      border-bottom: none
</style>
