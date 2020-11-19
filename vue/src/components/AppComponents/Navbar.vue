<template>
  <div class="Navbarfirst">
    <div class="Leftmenu">
      <el-row >
        <el-col :span="24">
          <el-menu
            default-active="1"
            class="el-menu-vertical-demo"
            background-color="#545c64"
            text-color="#fff"
            active-text-color="#ffd04b"
            
          >
            <el-menu-item index="1" @click="ToIndex">
              <i class="el-icon-menu"></i>
              <span >主页</span>
            </el-menu-item>
            <el-submenu index="2">
              <template slot="title">
                <i class="el-icon-menu"></i>
                <span >咖啡</span>
              </template>
              <el-menu-item-group>
                <el-menu-item index="2-1" @click="ToSelectAllCoffee">查看所有咖啡</el-menu-item>
                <el-menu-item index="2-2" @click="ToInsertCoffee">增加咖啡</el-menu-item>
                <!-- <el-menu-item index="2-3" @click="ToUpdateCoffee">修改咖啡</el-menu-item>
                <el-menu-item index="2-4" @click="ToDeleteCoffee">删除咖啡</el-menu-item> -->
              </el-menu-item-group> 
            </el-submenu>
            <el-submenu index="3">
              <template slot="title">
                <i class="el-icon-menu"></i>
                <span >咖啡机</span>
              </template>
              <el-menu-item-group>
                <el-menu-item index="3-1" @click="ToSelectAllMachine">查看咖啡机</el-menu-item>
                <!-- <el-menu-item index="3-2" @click="ToMachineMessage">咖啡机详情</el-menu-item>
                <el-menu-item index="3-3" @click="ToMachineCoffee">咖啡机配置咖啡</el-menu-item> -->
                <!-- <el-menu-item index="3-4" @click="ToDeleteMachine">删除咖啡机</el-menu-item> -->
              </el-menu-item-group> 
            </el-submenu>
            <el-submenu index="4">
              <template slot="title">
                <i class="el-icon-menu"></i>
                <span >咖啡套餐</span>
              </template>
              <el-menu-item-group>
                <el-menu-item index="4-1" @click="ToSelectAllMenu">查看咖啡套餐</el-menu-item>
                <!-- <el-menu-item index="4-2" @click="ToMachineMessage">咖啡机详情</el-menu-item>
                <el-menu-item index="4-3" @click="ToMachineCoffee">咖啡机配置咖啡</el-menu-item> -->
                <!-- <el-menu-item index="3-4" @click="ToDeleteMachine">删除咖啡机</el-menu-item> -->
              </el-menu-item-group> 
            </el-submenu>
            <el-menu-item index="5" @click="ToLogin">
              <i class="el-icon-menu"></i>
              <span slot="title">退出账号</span>
            </el-menu-item>
          </el-menu>
        </el-col>
      </el-row>
    </div>
    <div class="righttag">
      <el-tabs v-model="editableTabsValue" type="card" editable @edit="handleTabsEdit" @tab-click="OnclickTag">
        <!-- <el-tab-pane
        :key="editableTabs[0].name"
        :label="editableTabs[0].title"
        :name="editableTabs[0].name"
        >
        <router-view></router-view>
        </el-tab-pane>
        <el-tab-pane
            :key="editableTabs[1].name"
            :label="editableTabs[1].title"
            :name="editableTabs[1].name"
        >
        <router-view></router-view>
        </el-tab-pane>  -->
        <el-tab-pane
            :key="item.name"
            v-for="item in editableTabs"
            :label="item.title"
            :name="item.name"
        >
          
        </el-tab-pane>
        <router-view></router-view>
      </el-tabs>
    </div>
    
  </div>
  
</template>

<script>
import Utils from '../../assets/js/util.js';
const tabTitle=["首页","删除咖啡","添加咖啡","查看所有的咖啡","修改咖啡","查看所有咖啡套餐","删除咖啡机","咖啡机套餐","咖啡机详情",
                "查看所有的咖啡机","咖啡机维护"]
const tabName=["index","deleteCoffee","insertCoffee","selectAllCoffee","updateCoffee","selectAllMenu","deleteMachine",
                "MachineCoffee","MachineMessage","selectAllMachine","maintenance"]

export default {
  data(){
    return{
      editableTabsValue: '',
      editableTabs: [],
      tabIndex: 0
    }
  },
  mounted(){
    var that = this;
    Utils.$on('demo', function () {
        that.handleTabsEdit('name','add',"MachineMessage");
    }),
    Utils.$on('demo1',function(){
        that.handleTabsEdit('name','add',"MachineCoffee")
    })
    Utils.$on('demo2',function(){
        that.handleTabsEdit('name','add',"maintenance")
    })
},
  methods: {
    // handleOpen(key, keyPath) {
    //   console.log(key, keyPath);
    // },
    // handleClose(key, keyPath) {
    //   console.log(key, keyPath);
    // },
    ToIndex(){
      this.$router.push({ path: "/index" });
      this.deleteTag()
    },
    ToSelectAllCoffee(){
      this.$router.push({ path: "/"+"selectAllCoffee" });
      this.handleTabsEdit('name','add',"selectAllCoffee");
    },
    ToInsertCoffee(){
      this.$router.push({ path: "/insertCoffee" });
      this.handleTabsEdit('name','add',"insertCoffee");
    },
    ToUpdateCoffee(){
      this.$router.push({ path: "/updateCoffee" });
      this.handleTabsEdit('name','add',"updateCoffee");
    },
    ToDeleteCoffee(){
      this.$router.push({ path: "/deleteCoffee" });
      this.handleTabsEdit('name','add',"deleteCoffee");
    },
    ToLogin(){
      this.$router.push({path:"/"})
      
    },
    ToSelectAllMachine(){
      this.$router.push({path:"/selectAllMachine"})
      this.handleTabsEdit('name','add',"selectAllMachine");
    },
    ToMachineMessage(){
      let params={
        machineId: 1,
        coffeemachine: '咖啡机1号',
        machineKinds: '方便实用',
        machinePrice: '100',
        note: '无',
        state:0,
        menuId:3
      }
      this.$router.push({
        path: '/MachineMessage',
        query: params
      })
      this.handleTabsEdit('name','add',"MachineMessage");
    },
    ToMachineCoffee(){
      let params={
        SendmenuId:1
      }
      this.$router.push({
          path: '/MachineCoffee',
          query:params
      })
      this.handleTabsEdit('name','add',"MachineCoffee");
    },
    ToDeleteMachine(){
      this.$router.push({path:"/deleteMachine"})
    },
    ToSelectAllMenu(){
      this.$router.push({path:"/selectAllMenu"})
      this.handleTabsEdit('name','add',"selectAllMenu");
    },
    handleTabsEdit(targetName, action, name) {
      let that=this;
      if (action === 'add') {
        for(var i=0;i<this.editableTabs.length;i++){
          if(name==this.editableTabs[i].name){
            //this.$router.push({path:"/"+name})
            this.editableTabsValue=name;
            return;
          }
        }
        var mark=0;
        for(var i=0;i<tabName.length;i++){
          if(name==tabName[i]){
            mark=i;
            break;
          }
        }
        this.editableTabs.push({
          title: tabTitle[mark],
          name: name,
        });
        this.editableTabsValue = name;
      }
      if (action === 'remove') {
        let that=this
        let tabs = this.editableTabs;
        let activeName = this.editableTabsValue;
        let mark=0;
        //console.log(activeName)
        for(var i=0;i<this.editableTabs.length;i++){
          if(activeName==this.editableTabs[i].name){
            mark=i;
            break;
          }
        }
        //console.log(mark)
        //删除成功
        this.editableTabs = tabs.filter(tab => tab.name !== targetName);
        if(this.editableTabs.length != 0 ){
          if(mark==0){
            this.$router.push({path:"/"+this.editableTabs[mark].name})
            that.editableTabsValue=this.editableTabs[mark].name;
          }
          else{
            this.$router.push({path:"/"+this.editableTabs[mark-1].name})
            that.editableTabsValue=this.editableTabs[mark-1].name;
          }
          
        }
        else{
          this.$router.push({path:"/index"})
        }
      }
    },
    //点击标签进行跳转
    OnclickTag(){
      let str=event.target.getAttribute('id'); //获取到当前元素的id
      str=str.substring(4);
      //console.log(str)
      this.$router.push({path:"/"+str})
    },
    //清空所有的标签
    deleteTag(){
      // for(editTabs in editableTabs){
      //   this.handleTabsEdit(editTabs.title,'remove',null)
      // }
      this.editableTabs=[]
    }
  }
};
</script>

<style scoped>
.Leftmenu{
    background-color:#545c64;
    width: 290px;
    height: 863px;
    text-align: left;
}
.Navbarfirst{
  flex-direction: row;
  display: flex;
}

.righttag{
  padding-left: 1%;
  padding-top: 1%;
  width: 1800px;
  height:863px;
}
</style>