import Vue from "vue/dist/vue.esm";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#user-dashboard",
    data: {
      isAddingStudyInterests: false,
      isEditingMaturaResults: false,
      isAddingMaturaResult: false
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
      showEditResultForm() {
        this.isEditingMaturaResults = true;
      },
      closeEditResultForm() {
        this.isEditingMaturaResults = false;
      },
      submitEditResultForm() {
        this.isEditingMaturaResults = false;
      },
      showAddResultForm() {
        this.isAddingMaturaResult = true;
      },
      closeAddResultForm() {
        this.isAddingMaturaResult = false;
      },
      submitAddResultForm() {
        this.isAddingMaturaResult = false;
      }
    }
  });
});
