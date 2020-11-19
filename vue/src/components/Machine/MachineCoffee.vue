<template>
    <div>
        <div class="thisform">
            <!-- <h2>This is 咖啡配置  page</h2> -->
            <br />
        </div>
        <div class="selectform">
            <el-select v-model="selectTitle" placeholder="请选择" @change="updategetMenuId" >
                <el-option
                    v-for="menu in menus"
                    :key="menu"
                    :label="menu"
                    :value="menu">
                </el-option>
            </el-select>
            <div class="insertbutton">
                <!-- <el-button type="primary"  @click="insertTable">删除套餐</el-button> -->
                <el-button type="primary"  @click="insertTable">添加套餐</el-button>
                <el-button type="primary"  @click="insertStart">添加咖啡</el-button>
            </div>
            
        </div>
        <div class="menutable">
            <el-table
                :data="coffees"
                border
                stripe
                >
                    <el-table-column property="menuName" label="咖啡套餐" width="300" align="center"></el-table-column>
                    <el-table-column property="coffeeName" label="咖啡名字" width="300" align="center"></el-table-column>
                    <el-table-column property="coffeePrice" label="咖啡价格" width="300" align="center"></el-table-column>
                    <el-table-column label="操作"  align="center" width="323">
                        <template slot-scope="scope">
                            <el-button @click="updateStart(scope.row)">编辑</el-button>
                            <el-button @click="deleteStart(scope.row)">删除</el-button>
                        </template>
                    </el-table-column>
            </el-table>
        </div>
        
        <el-dialog title="增加咖啡" :visible.sync="insertCFOnMacVisible">
            <el-form :inline="true" :model="insertform" class="demo-form-inline" style="padding-left:100px">
                 <el-form-item label="咖啡种类:">
                    <el-select v-model="insertform.coffeeName" placeholder="请选择">
                        <el-option
                            v-for="coffee in Allcoffee"
                            :key="coffee"
                            :label="coffee"
                            :value="coffee">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="咖啡价格:" >
                    <el-input v-model="insertform.coffeePrice" style="width:220px"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="insertMyselfTable">添加到表</el-button>
                </el-form-item>
            </el-form>

            <div class="insertTable">
                <el-table
                :data="tableCoffees"
                border
                stripe
                >
                    <el-table-column property="coffeeName" label="咖啡名字" width="250" align="center"></el-table-column>
                    <el-table-column property="coffeePrice" label="咖啡价格" width="250" align="center"></el-table-column>
                    <el-table-column label="操作"  align="center" width="200">
                        <template slot-scope="scope">
                            <el-button @click="deleteTableCoffees(scope.row)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
            
           
            <div slot="footer" class="dialog-footer">
                <el-button @click="insertCFOnMacVisible = false">取 消</el-button>
                <el-button type="primary" @click="insertCFOnMac" >确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog title="修改咖啡" :visible.sync="updateCFOnMacVisible">
            <el-form ref="updateform" :model="updateform" label-width="100px">
                <el-form-item label="咖啡名称:" >
                    <el-input v-model="updateform.coffeeName" style="width:220px" :disabled="true"></el-input>
                </el-form-item> 
                <el-form-item label="咖啡价格:" >
                    <el-input v-model="updateform.coffeePrice" style="width:220px"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="updateCFOnMacVisible = false">取 消</el-button>
                <el-button type="primary" @click="updateCFOnMac" >确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog
            title="提示"
            :visible.sync="deletedialogVisible"
            width="30%"
            >
            <span>是否确定要删除该咖啡？</span>
            <span slot="footer" class="dialog-footer">
                <el-button @click="deletedialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="deleteCFOnMac">确 定</el-button>
            </span>
        </el-dialog>
        
        <el-dialog title="增加咖啡套餐" :visible.sync="insertMenuVisible">
            <el-form ref="insertMenuform" :model="insertMenuform" label-width="100px">
                 <el-form-item label="套餐Id:">
                    <el-input v-model="insertMenuform.menuId" style="width:220px"></el-input> 
                 </el-form-item>
                <el-form-item label="套餐名字:" >
                    <el-input v-model="insertMenuform.menuName" style="width:220px"></el-input>
                </el-form-item>
                <el-form-item label="套餐说明:" >
                    <el-input type="textarea" v-model="insertMenuform.menuNote" style="width:220px"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="insertMenuVisible = false">取 消</el-button>
                <el-button type="primary" @click="insertMenu" >确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
export default {
    data(){
        let that = this;
        let getMenuId=this.$route.query.SendmenuId;
        console.log(getMenuId)
        this.searchAllCoffee(getMenuId)
        this.searchMenuName(getMenuId)
        return{
            getMenuId:that.$route.query.SendmenuId,
            selectTitle:"",
            selectCheck:"",
            coffees:[],
            //下拉列表框中的内容
            menus:[],
            //增加咖啡的弹框
            insertCFOnMacVisible:false,
            updateCFOnMacVisible:false,
            deletedialogVisible:false,
            insertMenuVisible:false,
            //增加咖啡的表单
            insertform:{
                coffeeName:"",
                coffeePrice:""
            },
            //修改咖啡的表单
            updateform:{
                coffeeName:"",
                coffeePrice:""
            },
            //删除咖啡的表单
            deleteform:{
                coffeeName:"",
                coffeePrice:""
            },
            //增加套餐
            insertMenuform:{
                menuId:"",
                menuName:"",
                menuNote:""
            },
            Allcoffee:[],
            //增加咖啡表格数据
            tableCoffees:[]
        }
    },
    methods:{
        //搜索所有的咖啡
        searchAllCoffee(getMenuId){
            let that = this;
            this.$axios
            .get(this.COMMON.httpUrl+"/macco/searchMacCo", {
                params: {
                    menuId:getMenuId
                }
            })
            .then(function(resp) {
                //console.log(resp.data.object);
                that.coffees=resp.data.object      
            })
            .catch(resp => {
                console.log("请求失败：" + resp.status + "," + resp.statusText);
            });
            this.$axios
                .get(this.COMMON.httpUrl+"/menudetail/selectAllMenu")
                .then(res => {
                    that.menus=[]
                    for(var i=0;i<res.data.object.length;i++){
                        that.menus.push(res.data.object[i].menuName)
                    } 
                    //console.log(that.menus) 
            });
            this.$axios
                .get(this.COMMON.httpUrl+"/coffee/selectAllCoffee")
                .then(res => {
                    that.Allcoffee=[]
                    for(var i=0;i<res.data.object.length;i++){
                        that.Allcoffee.push(res.data.object[i].coffeeName)
                    }
                    
            });
        },

        //初始化下拉列表框显示的内容
        searchMenuName(menuId){
            let that=this
            this.$axios
            .get(this.COMMON.httpUrl+"/menudetail/GetMenuName",{
                params:{
                   menuId:menuId
                }
            })
            .then(res => {
                that.selectTitle=res.data.object;
            }); 
        },

        //下拉列表框修改
        updategetMenuId(selVal){
            let that=this
            this.$axios
            .get(this.COMMON.httpUrl+"/menudetail/GetMenuId",{
                params:{
                    menuName:selVal
                }
            })
            .then(res => {
                that.selectCheck=res.data.object;
                this.searchAllCoffee(res.data.object);
                that.getMenuId=res.data.object;
            });
        },

        //打开增加界面，并且为下拉菜单赋值
        insertStart(){
            this.insertCFOnMacVisible=true;
        },

        //为一个套餐增加一组咖啡
        insertCFOnMac(){
            let that=this;
            this.$axios.post(this.COMMON.httpUrl+"/macco/insertTransation",that.tableCoffees).then(res=>{
                //console.log(res.data)
                if(res.data.returnState==200){
                    this.$message({
                        message: '增加成功',
                        type: 'success'
                    });
                    that.searchAllCoffee(that.getMenuId)
                }
                else{
                   this.$message.error('增加失败'); 
                }
            })
            
            that.insertCFOnMacVisible=false
        },

        //打开修改界面，并传值
        updateStart(row){
            this.updateCFOnMacVisible=true;
            this.updateform.coffeeName=row.coffeeName;
            this.updateform.coffeePrice=row.coffeePrice;
        },

        //为一个套餐修改一种咖啡
        updateCFOnMac(){
            let that=this;
            this.$axios.post(this.COMMON.httpUrl+"/macco/updateMacCo",{
                menuId:that.getMenuId,
                coffeeName:that.updateform.coffeeName,
                coffeePrice:that.updateform.coffeePrice
            }).then(res=>{
                if(res.data.object==200){
                    this.$message({
                        message: '修改成功',
                        type: 'success'
                    });
                    that.searchAllCoffee(that.getMenuId)
                }
                else{
                    this.$message.error('修改失败');
                }
                that.updateCFOnMacVisible=false
            })
        },

        //开始删除并传值
        deleteStart(row){
            this.deletedialogVisible=true;
            this.deleteform.coffeeName=row.coffeeName;
            this.deleteform.coffeePrice=row.coffeePrice;
            //console.log(this.deleteform)
        },

        //为一个套餐删除一个咖啡
        deleteCFOnMac(){
            let that=this;
            this.$axios.post(this.COMMON.httpUrl+"/macco/deleteMacCo",{
                menuId:that.getMenuId,
                coffeeName:that.deleteform.coffeeName,
                coffeePrice:that.deleteform.coffeePrice
            }).then(res=>{
                if(res.data.returnState==200){
                    this.$message({
                        message: '删除成功',
                        type: 'success'
                    });
                    that.searchAllCoffee(that.getMenuId)
                }
                else{
                    this.$message.error('删除失败');
                }
                that.deletedialogVisible=false
            })
        },

        //打开增加套餐的弹框
        insertTable(){
            this.insertMenuVisible=true
        },
        //增加套餐
        insertMenu(){
            let that=this;
            this.$axios.post(this.COMMON.httpUrl+"/menudetail/insertMenu",{
                menuId:that.insertMenuform.menuId,
                menuName:that.insertMenuform.menuName,
                menuNote:that.insertMenuform.menuNote
            }).then(res=>{
                if(res.data==true){
                   this.$message({
                        message: '添加成功',
                        type: 'success'
                    });
                    that.menus.push(that.insertMenuform.menuName)
                    //console.log(this.menus)
                    that.selectTitle=that.insertMenuform.menuName
                }
                else{
                    this.$message.error('添加失败');
                }
                that.searchAllCoffee(that.insertMenuform.menuId)
                that.insertMenuVisible=false
            })
        },

        //将增加的咖啡加入到表格中
        insertMyselfTable(){
            var tableMenuId=this.getMenuId
            var tableCoffeeName=this.insertform.coffeeName;
            var tableCoffeePrice=this.insertform.coffeePrice
            var tableCoffee={
                menuId:tableMenuId,
                coffeeName:tableCoffeeName,
                coffeePrice:tableCoffeePrice
            };
            this.tableCoffees.push(tableCoffee)
            //console.log(this.tableCoffees)
        },

        //将表格中暂时的数据做删除
        deleteTableCoffees(row){
            let RowcoffeeName=row.coffeeName;
            for(var i=0;i<this.tableCoffees.length;i++){
                if(RowcoffeeName==this.tableCoffees[i].coffeeName){
                    this.tableCoffees.splice(i,1);
                    break;
                }
            }
        }
    }
}
</script>

<style>
.thisform{
    padding-left: 600px;
    padding-top: 50px;
}

.menutable{
    width: 1224px;
    padding-left: 12%;
    padding-top: 10px;
}

.selectform{
    padding-top: 20px;
    width: 1224px;
    padding-left: 12%;
    flex-direction: row;
    display: flex;
}

.insertbutton{
    margin-left: 800px;
    flex-direction: row;
    display: flex;
}

.insertTable{
    width: 701px;
    padding-left: 100px;
}
</style>