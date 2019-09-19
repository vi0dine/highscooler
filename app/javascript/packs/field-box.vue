<template>
  <div class="box">
    <div class="columns is-centered is-v-centered">
      <div class="colums is-2">
        <figure class="image is-64x64">
          <img src="http://placehold.it/64" class="is-rounded" />
        </figure>
      </div>
      <div class="column is-6 has-text-left">
        <p class="title is-size-4">{{ field.name }}</p>
        <p class="subtitle">{{ field.type }}</p>
      </div>
      <div class="column is-1 has-text-centered">
        <div>
          <span class="heading">Prowadzony na</span>
          <span class="title is-block">{{ field.academies_count }}</span>
          <span class="heading">{{ pluralize('uczelni') }}</span>
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
  <!-- .box{style: 'padding: 10px; margin: 5px;'}
  .columns.is-centerd.is-vcentered
    .column.is-2
      %figure.image.is-64x64
        %image.is-rounded{src: 'https://bulma.io/images/placeholders/128x128.png'}
    .column.is-6.has-text-left
      %p.title.is-size-4 {{ this.field.name }}
      %p.subtitle {{ this.field.type }}
    .column.is-1.has-text-centered
      %div
        %span.heading Prowadzony na
        %span.title.is-block{style: 'margin-bottom: 7px;'} {{ this.field.academies_count }}
        %span.heading Uczelni          
    .column.has-text-centered
      %div
        %p.heading Zainteresowanych
  %p.title {{ this.field.interested.count }}-->
</template>

<script>
export default {
  props: ["field"],
  mounted() {
    pluralize.addPluralRule("Uczelni", "Uczelniach");
  }
};
</script>

<style>
</style>