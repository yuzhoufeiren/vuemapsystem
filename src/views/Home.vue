<template>
  <div class="home">
    <div class="wrapper">
      <div class="main">
        <blog-list></blog-list>
      </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import BlogList from "@/components/BlogList.vue";

export default {
  name: "Home",
  components: {
    BlogList
  }
};
</script>
<style lang="scss" scoped>
.home {
  background-color: #909399;
}
.main {
  margin: 0 -10%;
  padding: 1%;
  background: #f8f8f8;
  -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4),
    0 0 30px rgba(10, 10, 0, 0.1) inset;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4), 0 0 30px rgba(10, 10, 0, 0.1) inset;
}
</style>