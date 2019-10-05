import Vue from "vue/dist/vue.esm";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#user-dashboard",
    data: {
      isAddingStudyInterests: false,
      isEditingMaturaResults: false
    },
    methods: {
      showStudyInterestForm() {
        this.isAddingStudyInterests = true;
      },
      closeStudyInterestForm() {
        this.isAddingStudyInterests = false;
      },
      submitStudyInterestForm() {
        this.isAddingStudyInterests = false;
      },
      showEditResultsForm() {
        this.isEditingMaturaResults = true;
      },
      closeEditResultsForm() {
        this.isEditingMaturaResults = false;
      },
      submitEditResultsForm() {
        this.isEditingMaturaResults = false;
      }
    }
  });
});
