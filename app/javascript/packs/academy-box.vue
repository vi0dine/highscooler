<template>
  <div class="box" id="academy_box" :style="this.academyPhoto(academy.id)">
    <div class="columns">
      <div class="column is-2">
        <figure class="image is-64x64">
          <img class="city" :src="this.cityPhoto(academy.city)" />
        </figure>
      </div>
      <div class="column is-6 has-text-left">
        <p class="title is-size-4">{{ academy.name }}</p>
        <p class="subtitle">{{ academy.city }}</p>
      </div>
      <div class="column is-1 has-text-centered">
        <div>
          <p class="heading">Kierunków</p>
          <p class="title">{{ fields_count }}</p>
        </div>
      </div>
      <div class="column has-text-centered">
        <div>
          <p class="heading">Zainteresowanych</p>
          <p class="title">{{ interested_count }}</p>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  props: ["academy", "fields_count", "interested_count"],
  methods: {
    cityPhoto: function(city) {
      let image_path;
      try {
        image_path = require("images/cities/" + city.toLowerCase() + ".png");
      } catch (e) {
        console.log(e);
        image_path = "http://placehold.it/50";
      } finally {
        return image_path;
      }
    },
    academyPhoto: function(id) {
      let image_path;
      try {
        image_path = `background-image: rgb(232,247,238), url(${require("images/academies/" +
          id +
          ".jpg")});
                      background-image: -moz-linear-gradient(33deg, rgba(232,247,238,0.3) 0%, rgba(201,214,234,0.3) 100%), url(${require("images/academies/" +
                        id +
                        ".jpg")});
                      background-image: -webkit-linear-gradient(33deg, rgba(232,247,238,0.3) 0%, rgba(201,214,234,0.3) 100%), url(${require("images/academies/" +
                        id +
                        ".jpg")});
                      background-image: linear-gradient(33deg, rgba(232,247,238,0.3) 0%, rgba(201,214,234,0.3) 100%), url(${require("images/academies/" +
                        id +
                        ".jpg")});
                      filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#e8f7ee",endColorstr="#c9d6ea",GradientType=1), url(${require("images/academies/" +
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
<style lang="scss" scoped>
.city {
  opacity: 0.4;
  backface-visibility: hidden;
  transition: opacity 0.5s ease-in-out;
}

.box:hover {
  .city {
    opacity: 0.9;
  }
}
</style>