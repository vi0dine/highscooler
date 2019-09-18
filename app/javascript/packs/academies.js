import Vue from "vue/dist/vue.esm";
import AcademyBox from "./academy-box.vue";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#academies",
    components: { AcademyBox }
  });
});
