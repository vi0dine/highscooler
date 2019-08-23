import Vue from "vue/dist/vue.esm";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#formula-generator",
    data: {
      counter: 0,
      subjects: [],
      basic_ratio: 0,
      advanced_ratio: 0,
      formula: "",
      isConfirmed: false
    },
    methods: {
      generateFormula() {
        if (this.counter > 0)
          this.formula += "+["
        else
          this.formula += "["
        this.counter += 1        
        this.subjects.forEach((subject) => {
          let elem = `(${subject}_Pp*${this.basic_ratio})|(${subject}_Pr*${this.advanced_ratio })|`;
          this.formula += elem
        })
        this.formula = this.formula.slice(0, -1) + "]"
        this.resetFields();
      },
      resetFields() {
        this.subjects = [];
        this.basic_ratio = 0;
        this.advanced_ratio = 0;
      },
      resetFormula() {
        this.formula = "";
        this.counter = 0;
        this.subjects = [];
        this.basic_ratio = 0;
        this.advanced_ratio = 0;
        this.isConfirmed = false;
      },
      confirmFormula() {
        this.isConfirmed = true;
      }
    }
  });
});
