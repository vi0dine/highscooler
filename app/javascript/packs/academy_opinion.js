import Vue from "vue/dist/vue.esm";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#academy-opinion",
    data: {
      isVisible: false
    },
    methods: {
      showModal() {
        this.isVisible = true;
      },
      closeModal() {
        this.isVisible = false;
      },
      submit() {
        this.isVisible = false;
      }
    }
  });
});
