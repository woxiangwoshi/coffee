<template>
  <div >
    
    <div class="Thisform">
      <!-- <h2 style="padding-left:50px">This is selectAllCoffee Page</h2> -->
      <br />
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="关键字:">
          <el-input v-model="form.name" style="width:300px"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="search">查询</el-button>
          <el-button @click="searchAll">查询所有</el-button>
          <el-button type="primary" @click="gotoinsert">添加</el-button>
        </el-form-item>
      </el-form>
    </div>
    
    <div class="coffeetable">
      <el-table :data="tempList"  stripe border style="margin-bottom:50px;">
        <el-table-column property="coffeeId" label="咖啡序号" width="200" align="center"></el-table-column>
        <el-table-column property="coffeeName" label="咖啡名字" width="282" align="center"></el-table-column>
        <el-table-column property="coffeeDiscount" label="咖啡折扣" width="180" align="center"></el-table-column>
        <!-- <el-table-column property="newPrice" label="现价" width="198"></el-table-column>
        <el-table-column property="oldPrice" label="原价" width="197"></el-table-column> -->
        <el-table-column property="coffeeKinds" label="咖啡评价" width="333" align="center"></el-table-column>
        <el-table-column label="图片" width="228" align="center">
          <template slot-scope="scope">
            <!-- <span>{{scope.row.i}}</span> -->
            <img :src="scope.row.coffeeImage" width="80" height="80" class="img"/>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="228" align="center">
          <template slot-scope="scope">
            <el-button  @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="coffeepage">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange" :current-page="currentPage"
          :page-sizes="[4,6,8]"
          :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
          :total="totalCount">
      </el-pagination> 
    </div>
  </div>
</template>

<script>
export default {
  data() {
    this.searchAll()
    return {
      input: "",
      coffeeData: [{}],
      tempList:[{}],
      form: {
        name: ""
      },
      //coffeeImage:"",
      // 总条数，根据接口获取数据长度(注意：这里不能为空)
      totalCount:1,
      // 默认显示第几页
      currentPage:1,
      // 默认每页显示的条数（可修改）
      pageSize:4,
    };
  },
  methods: {
    //模糊搜索咖啡
    search() {
      //get 请求接口
      let that = this;
      this.currentPage=1;
      //console.log(that.form.name);
      this.$axios
        .get(this.COMMON.httpUrl+"/coffee/search", {
          params: {
            name: that.form.name
          }
        })
        .then(function(resp) {
          //console.log(resp.data);
          that.coffeeData = resp.data.object;
          that.tempList=[];
          for(var i=0 ; i<that.pageSize ; i++){
            if(resp.data.object[i]!=null){
              that.tempList.push(resp.data.object[i])
            }   
          }
          that.totalCount=resp.data.object.length;      
        })
        .catch(resp => {
          console.log("请求失败：" + resp.status + "," + resp.statusText);
        });
    },
    //获取所有的咖啡信息
    searchAll() {
      //get 请求接口
      let that = this;
      this.$axios
        .get(this.COMMON.httpUrl+"/coffee/selectAllCoffee")
        .then(res => {
          console.log(res.data);
          that.coffeeData = res.data.object;
          that.tempList=[];
          for(var i=0 ; i<that.pageSize ; i++){
            that.tempList.push(res.data.object[i])
          }
          that.totalCount=res.data.object.length;
          //console.log(that.tempList)
        });
    },
    //跳转到增加咖啡页面
    gotoinsert() {
      this.$router.push({ path: "/insertCoffee" });
    },
    //跳转到修改咖啡的页面，并传值过去
    handleEdit(index, row) {
      let params={
        coffeeId:row.coffeeId,
        coffeeName:row.coffeeName,
        coffeeDiscount:row.coffeeDiscount,
        coffeeKinds:row.coffeeKinds,
        newPrice:row.newPrice,
        oldPrice:row.oldPrice,
        coffeeImage:row.coffeeImage
      }
      this.$router.push({
        path: '/updateCoffee',
        query: params
      })
    },
    // 分页
    // 每页显示的条数
    handleSizeChange: function(pageSize) { 
      this.pageSize = pageSize;
      this.handleCurrentChange(this.currentPage);
    },
    // 显示第几页
    handleCurrentChange: function(currentPage) {//页码切换
      this.currentPage = currentPage;
      this.currentChangePage(this.coffeeData,currentPage);
    },
    //分页方法（重点）
    currentChangePage(list,currentPage) { 
      let from = (currentPage - 1) * this.pageSize;
      let to = currentPage * this.pageSize;
      this.tempList = [];
      for (; from < to; from++) {
        if (list[from]) {
            this.tempList.push(list[from]);
        }
      }
    },
  }
};
</script>




<style scoped>
.rightcenter {
  flex-direction: row;
  align-content: center;
}

.input {
  width: 300px;
}


.Thisform {
  width: 30%;
  padding-left: 40%;
  
}

.coffeetable{
  padding-left: 7%;
  width: 1452px;
}


.coffeepage{
  padding-left: 36%;
}
</style>