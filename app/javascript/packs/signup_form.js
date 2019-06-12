import Vue from "vue/dist/vue.esm";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#signup-form",
    data: {
      formIndex: 0
    },
    methods: {
      nextForm() {
        if (this.formIndex < 3) {
          this.formIndex += 1;
        } else {
          // Disabled button
        }
      },
      prevForm() {
        if (this.formIndex > 0) {
          this.formIndex -= 1;
        } else {
          // Disabled button
        }
      }
    }
  });
});
