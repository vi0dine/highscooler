<template>
  <div
    class="box"
    id="field_box"
    style="padding: 5px; margin: 10px;"
    :style="this.fieldPhoto(field.id)"
  >
    <div class="columns is-centered is-vcentered">
      <div class="column is-2">
        <figure class="image is-64x64">
          <img :src="this.fieldType(field.type_enum)" class="type-icon" />
        </figure>
      </div>
      <div class="column is-6 has-text-left">
        <p class="title is-size-4">{{ field.name }}</p>
        <p class="subtitle">{{ field.type }}</p>
      </div>
      <div class="column is-1 has-text-centered">
        <div>
          <span class="heading">Prowadzony na</span>
          <span class="title is-block" style="margin-bottom: 7px;">{{ field.academies_count }}</span>
          <span class="heading">{{ field.academies_count == 1 ? 'uczelni' : 'uczelniach' }}</span>
        </div>
      </div>
      <div class="column has-text-centered">
        <div>
          <p class="heading">Zainteresowanych</p>
          <p class="title">{{ field.interested_count }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["field"],
  methods: {
    fieldType: type => {
      let image_path;
      try {
        image_path = require("images/fields/types/" + type + ".png");
      } catch (e) {
        console.log(e);
        image_path = require("images/fields/types/others.png");
      } finally {
        return image_path;
      }
    },
    fieldPhoto: id => {
      let image_path;
      try {
        image_path = `background-image: rgb(232,247,238), url(${require("images/fields/" +
          id +
          ".jpg")});
                      background-image: -moz-linear-gradient(33deg, rgba(232,247,238,0.3) 0%, rgba(201,214,234,0.3) 100%), url(${require("images/fields/" +
                        id +
                        ".jpg")});
                      background-image: -webkit-linear-gradient(33deg, rgba(232,247,238,0.3) 0%, rgba(201,214,234,0.3) 100%), url(${require("images/fields/" +
                        id +
                        ".jpg")});
                      background-image: linear-gradient(33deg, rgba(232,247,238,0.3) 0%, rgba(201,214,234,0.3) 100%), url(${require("images/fields/" +
                        id +
                        ".jpg")});
                      filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#e8f7ee",endColorstr="#c9d6ea",GradientType=1), url(${require("images/fields/" +
                        id +
                        ".jpg")});`;
      } catch (e) {
        console.log(e);
        image_path = `background-image: linear-gradient(
                      33deg,
                      rgba(232, 247, 238, 0.3) 0%,
                      rgba(201, 214, 234, 0.3) 100%
                      );`;
      } finally {
        return image_path;
      }
    }
  }
};
</script>