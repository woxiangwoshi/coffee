<template>
  <div class="ALL">
    <div class="head">
      <el-avatar class="touxiang">hjw</el-avatar>
    </div>

    <!-- <div id="app"> -->
      <mynavbar></mynavbar>
      <!-- <div class="right">
        
          <el-tabs v-model="editableTabsValue" type="card" editable @edit="handleTabsEdit">
             <el-tab-pane
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
            </el-tab-pane> 
             <el-tab-pane
              :key="item.name"
              v-for="item in editableTabs"
              :label="item.title"
              :name="item.name"
            >
             
            </el-tab-pane>
          </el-tabs> 
          <router-view></router-view>
      </div> -->
  </div>

</template>

<script>
import mynavbar from "./AppComponents/Navbar.vue";
export default {
  name: "App",
  components: {
    mynavbar
  },
  data(){
    return{
      editableTabsValue: '2',
      editableTabs: [
        {
          title: 'Tab 1',
          name: '1',
          
        }, 
        {
          title: 'Tab 2',
          name: '2',
         
        }
      ],
      tabIndex: 2
    }
  },
  methods:{
    handleTabsEdit(targetName, action) {
        if (action === 'add') {
          let newTabName = ++this.tabIndex + '';
          this.editableTabs.push({
            title: 'New Tab',
            name: newTabName,
            content: 'New Tab content'
          });
          this.editableTabsValue = newTabName;
        }
        if (action === 'remove') {
          let tabs = this.editableTabs;
          let activeName = this.editableTabsValue;
          if (activeName === targetName) {
            tabs.forEach((tab, index) => {
              if (tab.name === targetName) {
                let nextTab = tabs[index + 1] || tabs[index - 1];
                if (nextTab) {
                  activeName = nextTab.name;
                }
              }
            });
          }
          
          this.editableTabsValue = activeName;
          this.editableTabs = tabs.filter(tab => tab.name !== targetName);
        }
      }
  }
};
</script>

<style>
#app {

  color: #2c3e50;
  height: 100%;
  display: flex;
  flex-direction: row;
  align-items: flex-start;
}

.right {
  width: 60%;
  flex-direction: column;
  margin: 10px;
}

.left {
  width: 40%;
  height: 880px;
  display: flex;
  flex-direction: column;
}

.touxiang {
  background-color: chocolate;
  float: right;
  margin-right: 25px;
}

.head{
  background-color: dodgerblue;

}

.ALL{
  flex-direction: column;
  display: flex;
}

*{
 	padding:0px;
 	margin:0px;
 	border:0px;
 }

.tagger{
  text-align: left;
}

</style>
