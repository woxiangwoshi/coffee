<template>
  <div id="app123">
    <div class="title">咖啡机管理系统</div>
    <div class="username">
      <el-input placeholder="请输入账号" v-model="form.username" clearable style="width:400px"></el-input>
    </div>
    <div class="password">
      <el-input placeholder="请输入密码" v-model="form.password" show-password style="width:400px"></el-input>
    </div>
    <div class="button">
      <el-button type="primary" style="width:400px" @click="login">登录</el-button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        username: "",
        password: ""
      }
    };
  },
  methods: {
    login() {
      let that = this;
      if (this.form.username == "") {
        this.$message.error("用户名不能为空");
      } else if (this.form.password == "") {
        this.$message.error("密码不能为空");
      } else {
        this.$axios
          .get(this.COMMON.httpUrl+"/user/login", {
            params: {
              username: that.form.username,
              password: that.form.password
            }
          })
          .then(function(resp) {
            //console.log(resp);
            if (resp.data.returnState == "200") {
              that.$router.push({ path: "/index" });
            } else {
              that.$message.error("账号或密码错误");
            }
          })
          .catch(resp => {
            console.log("请求失败：" + resp.status + "," + resp.statusText);
          });
      }
    }
  }
};
</script>

<style>
#app123 {
  text-align: center;
  background-color: lightslategrey;
  width: 100%;
  height: 903px;
  background-repeat: no-repeat;
  background-size: cover;
  flex-direction:column;
  align-content: center;
}

.title {
  font-size: 40px;
  color: #000;
  padding-top: 250px;
  text-align: center;
}
.username {
  padding-top: 30px;
  font-size: 20px;
}

.password {
  padding-top: 20px;
}

.button {
  padding-top: 20px;
}

*{
 	padding:0px;
 	margin:0px;
 	border:0px;
 }
</style>
