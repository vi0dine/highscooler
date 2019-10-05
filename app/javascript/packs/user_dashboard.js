import Vue from "vue/dist/vue.esm";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#user-dashboard",
    data: {
      isAddingStudyInterests: false
    },
    methods: {
      showModal() {
        this.isAddingStudyInterests = true;
      },
      closeModal() {
        this.isAddingStudyInterests = false;
      },
      submit() {
        this.isAddingStudyInterests = false;
        console.log(`${this.isAddingStudyInterests}`);
      }
    }
  });
});
