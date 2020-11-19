<template>
    <div>
        <!-- <div class="thisform">
            <h2>This is 套餐浏览  page</h2>
            <br />
        </div> -->
        
        <div class="cards">
            <!-- <el-card class="box-card" v-for="title in coffeeMenuTitle" :key="title">
                <div slot="header" class="clearfix" >
                    <span v-text="title"></span>
                    <el-button style="float: right; padding: 3px 0" type="text">操作按钮</el-button>
                </div>
                <div v-for="o in 4" :key="o" class="text item">
                    {{'列表内容 ————' + o }}
                </div>
            </el-card> -->

            <el-row>
                <el-col :span="6" v-for="coffeeMenu in coffeeMenuTitle" :key="coffeeMenu.title" :offset="1">
                    <el-card class="box-card" >
                        <div slot="header" class="clearfix" >
                            <span v-text="coffeeMenu.title" ref="aaa"></span>
                            <el-button style="float: right; padding: 3px 0; margin:5px" type="text" @click="()=>{ ToMachineCoffee(coffeeMenu.title)}">编辑套餐</el-button>
                            <el-button style="float: right; padding: 3px 0; margin:5px" type="text" @click="()=>{ deleteMenu(coffeeMenu.title)}">删除套餐</el-button>
                        </div>
                        <div v-for="coffee in coffeeMenu.coffees" :key="coffee.coffeeName" class="text item">
                            {{coffee.coffeeName+' ————' + coffee.coffeePrice +"元"}}
                        </div>
                    </el-card>
                </el-col>
            </el-row>
        </div>

        <el-dialog
            title="提示"
            :visible.sync="dialogVisible"
            width="30%"
            >
            <span>是否确定删除</span>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="Reallydelete">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import Utils from '../../assets/js/util.js';
export default {
    data(){
        this.selectAllMenu();
        return{
            coffeeMenuTitle:[],
            MenuTitles:{},
            dialogVisible:false,
            deleteName:''
        }
        
    },
    methods:{
        //获取所有的套餐
        selectAllMenu(){
            let that = this;
            this.$axios
                .get(this.COMMON.httpUrl+"/menudetail/selectAllMenu")
                .then(res => {
                    that.coffeeMenuTitle=[];
                    for(var i=0;i<res.data.object.length;i++){
                        let formenuName=res.data.object[i].menuName;
                        that.$axios
                        .get(this.COMMON.httpUrl+"/macco/searchMacCoByName",{
                            params:{
                                menuName:res.data.object[i].menuName
                            }
                        })
                        .then(resp => {
                            let forcoffees=[]
                            for(var i=0;i<resp.data.object.length;i++){
                                let coffee={
                                    coffeeName:resp.data.object[i].coffeeName,
                                    coffeePrice:resp.data.object[i].coffeePrice
                                }
                                forcoffees.push(coffee)
                            }
                            let coffeeMenu={
                                title:formenuName,
                                coffees:forcoffees
                            }
                            that.coffeeMenuTitle.push(coffeeMenu)
                        });
                    }
                });
        },

        //跳转到咖啡套餐配置页面
        ToMachineCoffee(name){
            let that = this;
            this.$axios
                .get(this.COMMON.httpUrl+"/menudetail/GetMenuId",{
                    params:{
                        menuName:name
                    }
                })
                .then(res => {
                    //console.log(res.data)
                    let params={
                        SendmenuId:res.data.object
                    }
                    Utils.$emit('demo1');
                    that.$router.push({
                        path: '/MachineCoffee',
                        query:params
                    })
                })
        },

        //删除套餐
        deleteMenu(name){
           this.deleteName=name; 
           this.dialogVisible=true;
        },

        //确定删除
        Reallydelete(){
            let that = this;
            this.$axios
                .get(this.COMMON.httpUrl+"/menudetail/GetMenuId",{
                    params:{
                        menuName:that.deleteName
                    }
                })
                .then(res => {
                   that.$axios
                        .get(this.COMMON.httpUrl+"/menudetail/deleteMenu",{
                            params:{
                                menuId:res.data.object
                            }
                        })
                        .then(resp=>{
                            if(resp.data.returnState==200){
                                this.$message({
                                    message: '删除成功',
                                    type: 'success'
                                });
                                for(var i=0;i<that.coffeeMenuTitle.length;i++){
                                    if(that.deleteName==that.coffeeMenuTitle[i].title){
                                        that.coffeeMenuTitle.splice(i,1)
                                    }
                                }
                            }
                            else{
                                this.$message.error('添加失败');
                            }
                            that.dialogVisible=false
                        })
                })
        }
    }
}
</script>

<style>
.thisform{
    padding-left: 600px;
    padding-top: 50px;
}

.text {
    font-size: 14px;
  }

.item {
    margin-bottom: 18px;
}

.clearfix:before,
.clearfix:after {
    display: table;
    content: "";
}
.clearfix:after {
    clear: both
}

.box-card {
    width: 100%;
    height: 250px;
    margin-top: 10%;
    padding-left: 20px;
}

.cards{
    padding-top: 20px;
    flex-direction: row;
    display: flex;
}

</style>