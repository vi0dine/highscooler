import Vue from "vue/dist/vue.esm";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#signup-form",
    data: {
      formIndex: 0,
      accountType: null
    },
    methods: {
      nextForm() {
        if (this.formIndex < 2) {
          this.formIndex += 1;
        } else if (this.formIndex == 2) {
          this.$refs.signup_form.submit();
          this.formIndex += 1;
        } else {
          // Disabled
        }
      },
      prevForm() {
        if (this.formIndex > 0) {
          this.formIndex -= 1;
        } else {
          // Disabled button
        }
      },
      addExam(e) {
        let regexp, time;
        time = new Date().getTime();
        regexp = new RegExp(e.target.dataset["id"], "g");
        $(this.$refs.exams).append(
          e.target.dataset["fields"].replace(regexp, time)
        );
        return e.preventDefault();
      },
      addInterest(e) {
        let regexp, time;
        time = new Date().getTime();
        regexp = new RegExp(e.target.dataset["id"], "g");
        if (this.$refs.interests.childElementCount < 5) {
          $(this.$refs.interests).append(
            e.target.dataset["fields"].replace(regexp, time)
          );
        } else {
          alert("Możesz dodać tylko 5 kierunków studiów.");
        }
        return e.preventDefault();
      }
    }
  });
});
