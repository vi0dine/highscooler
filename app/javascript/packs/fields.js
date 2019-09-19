import Vue from "vue/dist/vue.esm";
import FieldBox from "./field-box.vue";
import "pluralize";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#fields",
    components: { FieldBox }
  });
});
