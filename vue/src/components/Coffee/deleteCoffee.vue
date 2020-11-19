<template>
  <div>
    <!-- <h2 class="deleteform">This is deleteCoffee</h2> -->
    <div class="Thisform">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="关键字:">
          <el-input v-model="form.name" style="width:300px"></el-input>
        </el-form-item>
        <el-form-item style="padding-left:50px">
          <el-button type="primary" @click="onSubmit">查询</el-button>
          <el-button>查询所有</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        name: "",
        region: "",
        date1: "",
        date2: "",
        delivery: false,
        type: [],
        resource: "",
        desc: ""
      }
    };
  },
  methods: {
    onSubmit() {
      console.log("submit!");
    }
  }
};
</script>

<style scoped>
.Thisform {
  width: 30%;
  padding-left: 500px;
  padding-top: 50px;
}

.deleteform{
  padding-left: 600px;
  padding-top: 50px;
}
</style>