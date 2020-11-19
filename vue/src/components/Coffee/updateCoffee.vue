<template>
  <div>
    <!-- <h2 class="updateform">This is updataCoffee</h2> -->

    <div class="Thisform">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="咖啡序号:">
          <!-- <el-select
            v-model="form.coffeeId"
            placeholder="请选择咖啡序号:"
            style="width:300px"
            clearable
            @visible-change="changeValue1($event)"
          >
            <el-option
              v-for="item in form.options"
              :key="item.value"
              :label="item.text"
              :value="item.value"
            ></el-option>
          </el-select>-->
          <el-input v-model="form.coffeeId" style="width:300px" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="咖啡名字:">
          <el-input v-model="form.coffeeName" style="width:300px" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="咖啡折扣:">
          <el-input v-model="form.coffeeDiscount" style="width:300px"></el-input>
        </el-form-item>
        <el-form-item label="现价:">
          <el-input v-model="form.newPrice" style="width:300px"></el-input>
        </el-form-item>
        <el-form-item label="原价:">
          <el-input v-model="form.oldPrice" style="width:300px"></el-input>
        </el-form-item>
        <el-form-item label="咖啡评价:">
          <el-input type="textarea" v-model="form.coffeeKinds" style="width:300px"></el-input>
        </el-form-item>
        <el-form-item label="咖啡图片:">
          <!-- <img :src="form.coffeeImage" style="width:200px;height:200px"> -->
          <img :src=imageUrl style="width:200px;height:200px">
           <input type="file" id="fileField" @change="getFile($event)">
        </el-form-item>
        <el-form-item style="padding-left:50px">
          <el-button type="primary" @click="onSubmit">立即修改</el-button>
          <el-button @click="gotoALL">取消</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import qs from 'qs'
export default {
  data() {
    let that = this;
    let coffeeId = this.$route.query.coffeeId;
    //console.log(coffeeId);
    return {
      form: {
        coffeeId: that.$route.query.coffeeId,
        coffeeName: that.$route.query.coffeeName,
        coffeeKinds: that.$route.query.coffeeKinds,
        coffeeDiscount: that.$route.query.coffeeDiscount,
        newPrice: that.$route.query.newPrice,
        oldPrice: that.$route.query.oldPrice,
        coffeeImage:that.$route.query.coffeeImage
        //options: [{ value: "1", text: "1" }]
      },
      imageUrl:that.$route.query.coffeeImage
    };
  },
  methods: {
    onSubmit() {
      let that = this;
      let data={
        coffeeId: that.form.coffeeId,
        coffeeName: that.form.coffeeName,
        coffeeKinds: that.form.coffeeKinds,
        coffeeDiscount: that.form.coffeeDiscount,
        newPrice: that.form.newPrice,
        oldPrice: that.form.oldPrice,
        coffeeImage:that.form.coffeeImage
      }
      console.log(data)
      this.$axios
        .post(this.COMMON.httpUrl+"/coffee/updateCoffee",data)
        .then(res => {
          console.log(res)
          if(res.data.returnState==200){
            alert("修改成功");
            this.$router.push({ path: "/selectAllCoffee" });
          }
          else{
            alert("修改失败");
          }
        });
    },

    gotoALL(){
      this.$router.push({ path: "/selectAllCoffee" });
    },

    getFile(event) {
      this.file = event.target.files[0];
      console.log(this.file);
      let that = this;
      event.preventDefault();//取消默认行为
      //创建 formData 对象
      let param = new FormData();
      param.append("file", this.file);
      this.$axios.post(this.COMMON.httpUrl+"/coffee/GetImage", param, {
        headers: {
          "Content-Type": "multipart/form-data"
        }
      })
      .then(response=> {
        that.imageUrl="http://localhost:8080/plate/redisImage/"+response.data;
        that.form.coffeeImage=response.data
      })
    },
  }
};
</script>

<style scoped>
.Thisform {
  width: 30%;
  padding-left: 500px;
  padding-top: 50px;
}

.updateform{
  padding-left: 600px;
  padding-top: 50px;
}
</style>