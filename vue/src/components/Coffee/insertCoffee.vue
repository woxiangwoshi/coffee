<template>
  <div>
    <!-- <h2 class="insertform">This is insertCoffee</h2> -->
    <br />
    <div class="Thisform">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="咖啡序号:">
          <el-input v-model="form.coffeeId" style="width:300px"></el-input>
        </el-form-item>
        <el-form-item label="咖啡名字:">
          <el-input v-model="form.coffeeName" style="width:300px"></el-input>
        </el-form-item>
        <el-form-item label="咖啡折扣:">
          <el-select v-model="form.coffeeDiscount" placeholder="请选择折扣:" style="width:300px">
            <el-option label="9折" value="9折"></el-option>
            <el-option label="8折" value="8折"></el-option>
            <el-option label="7折" value="7折"></el-option>
          </el-select>
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
          <input type="file" id="fileField" @change="getFile($event)">
        </el-form-item>
        <el-form-item style="padding-left:50px">
          <el-button type="primary" @click="onSubmit">立即添加</el-button>
          <el-button @click="toSelectCoffee">取消</el-button>
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
        coffeeId: "",
        coffeeName: "",
        coffeeKinds: "",
        coffeeDiscount: "",
        newPrice: "",
        oldPrice: "",
      },
       file: '',
    };
  },
  methods: {
    onSubmit() {
      let that = this;
      event.preventDefault();//取消默认行为
      //创建 formData 对象
      let param = new FormData();
      param.append("file", this.file);
      //console.log("12345"+param)
      this.$axios.post(this.COMMON.httpUrl+"/coffee/GetImage", param, {
        headers: {
          "Content-Type": "multipart/form-data"
        }
      })
      .then(response=> {
        let params={
          coffeeId: that.form.coffeeId,
          coffeeName: that.form.coffeeName,
          coffeeKinds: that.form.coffeeKinds,
          coffeeDiscount: that.form.coffeeDiscount,
          newPrice: that.form.newPrice,
          oldPrice: that.form.oldPrice,
          coffeeImage:response.data.object
        }
        //console.log(response)
        if(response!="false"){
          that.$axios.post(this.COMMON.httpUrl+"/coffee/insertCoffee",params)
          .then(res=>{
            if(res.data.returnState == 200){
              alert("添加成功")
              that.toSelectCoffee()
            }
            else{
              alert("添加失败")
            }
          })
          //console.log(params)
        }
      })
      
    },
   
    getFile(event) {
      this.file = event.target.files[0];
      var fileName=document.getElementById('fileField').value
      //console.log(this.file);
      //console.log(fileName)
    },

    toSelectCoffee(){
      this.$router.push({ path: "/selectAllCoffee" });
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

.insertform{
  padding-left: 600px;
  padding-top: 50px;
}

.avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>