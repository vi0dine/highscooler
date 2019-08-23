import Vue from "vue/dist/vue.esm";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#formula-generator",
    data: {
      subjects: [],
      basic_ratio: 0,
      advanced_ratio: 0,
      formula: ""
    },
    methods: {
      generateFormula() {
        this.formula += "["
        this.subjects.forEach((subject) => {
          let elem = `(${subject}_Pp*${this.basic_ratio})|(${subject}_Pr*${this.advanced_ratio })|`;
          this.formula += elem
        })
        this.formula = this.formula.slice(0, -1) + "]"
        console.log(this.subjects);
        console.log(this.formula);
      }
    }
  });
});
