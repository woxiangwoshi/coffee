<template>
    <div>
        <div class="Thisform">
            <!-- <h2 style="padding-left:50px">This is selectAllCoffee Page</h2> -->
            <br />
            <el-form ref="searchform" :model="searchform" label-width="80px">
                <el-form-item label="关键字:">
                    <el-input v-model="searchform.name" style="width:300px"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="search">查询</el-button>
                    <el-button @click="searchAll">查询所有</el-button>
                    <el-button type="primary" @click="dialogFormVisible = true">添加</el-button>
                </el-form-item>
            </el-form>
        </div>

         <!-- <div class="selectform">
            <div class="insertbutton">
                <el-button type="primary"  >批量修改咖啡机套餐</el-button>
            </div>          
        </div> -->
        
        <div class="tableStyle">
            <el-table
            ref="multipleTable"
            :data="tempList"
            border
            stripe
            >
                <!-- <el-table-column type="selection" width="55" align="center"  @selection-change="handleSelectionChange"></el-table-column> -->
                <el-table-column property="machineId" label="咖啡机序号" width="183" align="center"></el-table-column>
                <el-table-column property="coffeemachine" label="咖啡机名称" width="250" align="center"></el-table-column>
                <el-table-column property="machineKinds" label="咖啡机特点" width="300" align="center"></el-table-column>
                <el-table-column property="state" label="状态" width="150" align="center"></el-table-column>
                <el-table-column property="menuName" label="咖啡机套餐" width="150" align="center"></el-table-column>
                <!-- <el-table-column property="machinePrice" label="价格" width="180"></el-table-column>
                <el-table-column property="note" label="备注" width="180"></el-table-column>
                <el-table-column property="cook" label="可以制作的咖啡" width="228"></el-table-column> -->
                <el-table-column label="操作" width="340" align="center">
                    <template slot-scope="scope">
                    <el-button @click="updateStart(scope.row)">编辑</el-button>
                    <el-button @click="ToMachineMessage(scope.$index, scope.row)">查看详情</el-button>
                    <el-button @click="ToMaintenance(scope.row)">维护</el-button>
                    </template>
                </el-table-column>
            </el-table>           
        </div>
        <div class="machinepage">
            <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange" :current-page="currentPage"
                :page-sizes="[3, 6, 9, 12]"
                :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                :total="totalCount">
            </el-pagination> 
        </div>

        <el-dialog title="增加咖啡机" :visible.sync="dialogFormVisible">
            <el-form ref="form" :model="form" label-width="80px" class="insert">
                <el-form-item label="咖啡机序号" :label-width="formLabelWidth">
                    <el-input v-model="form.machineId"  ></el-input>
                </el-form-item>
                <el-form-item label="咖啡机名字:" :label-width="formLabelWidth">
                    <el-input v-model="form.coffeemachine"></el-input>
                </el-form-item>
                <el-form-item label="咖啡机特点:" :label-width="formLabelWidth">
                    <el-input v-model="form.machineKinds" ></el-input>
                </el-form-item>
                <el-form-item label="咖啡机状态:" :label-width="formLabelWidth">
                    <el-radio v-model="radio" label="0">空闲</el-radio>
                    <el-radio v-model="radio" label="1">忙碌</el-radio>
                </el-form-item>
                <el-form-item label="咖啡机价格:" :label-width="formLabelWidth">
                    <el-input v-model="form.machinePrice"></el-input>
                </el-form-item>
                <el-form-item label="备注:" :label-width="formLabelWidth">
                    <el-input v-model="form.note"></el-input>
                </el-form-item>
                <el-form-item label="能做的咖啡:" :label-width="formLabelWidth">
                    <el-select v-model="form.menuName" placeholder="请选择" @change="getMenuId">
                        <el-option
                            v-for="menu in menus"
                            :key="menu"
                            :label="menu"
                            :value="menu">
                        </el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisible = false">取 消</el-button>
            <el-button type="primary" @click="insertMachine">确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog title="修改咖啡机" :visible.sync="dialogFormVisibleUpdate">
            <el-form ref="updateform" :model="updateform" label-width="80px" class="insert">
                <el-form-item label="咖啡机序号" :label-width="formLabelWidth">
                    <el-input v-model="updateform.machineId"  :disabled="true"></el-input>
                </el-form-item>
                <el-form-item label="咖啡机名字:" :label-width="formLabelWidth">
                    <el-input v-model="updateform.coffeemachine"></el-input>
                </el-form-item>
                <el-form-item label="咖啡机特点:" :label-width="formLabelWidth">
                    <el-input v-model="updateform.machineKinds" ></el-input>
                </el-form-item>
                <el-form-item label="咖啡机状态:" :label-width="formLabelWidth">
                    <el-radio v-model="updateradio" label="0">空闲</el-radio>
                    <el-radio v-model="updateradio" label="1">忙碌</el-radio>
                </el-form-item>
                <el-form-item label="咖啡机价格:" :label-width="formLabelWidth">
                    <el-input v-model="updateform.machinePrice"></el-input>
                </el-form-item>
                <el-form-item label="备注:" :label-width="formLabelWidth">
                    <el-input v-model="updateform.note"></el-input>
                </el-form-item>
                <el-form-item label="能做的咖啡:" :label-width="formLabelWidth">
                    <el-select v-model="updateform.menuName" placeholder="请选择" @change="updategetMenuId">
                        <el-option
                            v-for="menu in menus"
                            :key="menu"
                            :label="menu"
                            :value="menu">
                        </el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisibleUpdate = false">取 消</el-button>
            <el-button type="primary" @click="updateMachine">确 定</el-button>
            </div>
        </el-dialog>
    </div>
   
    
    
</template>

<script>
import qs from 'qs'
import Utils from '../../assets/js/util.js';
const coffeeOptions=[];
export default {
    data(){
        this.searchAll()
        this. GetAllCoffeeName()
        return{
            // 总条数，根据接口获取数据长度(注意：这里不能为空)
            totalCount:1,
            // 默认显示第几页
            currentPage:1,
            // 默认每页显示的条数（可修改）
            pageSize:6,
            MachineDate:[{}],
            tempList:[{}],
            //增加页面条件
            dialogFormVisible: false,
            //修改页面条件
            dialogFormVisibleUpdate:false,
            formLabelWidth: '120px',
            form:{
                machineId: "",
                coffeemachine: "",
                machineKinds: "",
                machinePrice: "",
                note: "",
                menuId:"",
                menuName:""
            },
            updateform:{
                machineId: "",
                coffeemachine: "",
                machineKinds: "",
                machinePrice: "",
                note: "",
                menuId:"",
                menuName:""
            },
            searchform:{
                name:""
            },
            //增加单选框默认选项
            radio: '0',
            //修改单选框默认选项
            updateradio:'0',
            //咖啡套餐菜单
            menus:[],
            //第一行多选按钮选中的内容
            //multipleSelection: []

            
        }
    },
    methods:{
        //获取所有的咖啡机信息
        searchAll() {
            //get 请求接口
            let that = this;
            this.currentPage=1;
            this.$axios
                .get(this.COMMON.httpUrl+"/machine/selectAllMachine")
                .then(res => {
                    //alert(res.data.result.text);
                    //console.log(res.data);
                    that.MachineDate = res.data.object;
                    that.tempList=[];
                    for(var i=0 ; i<res.data.object.length ; i++){
                        that.tempList.push(res.data.object[i])
                    }
                    that.totalCount=res.data.object.length;
                    //console.log(res.data.length);   
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
        },

        //模糊搜索咖啡机
        search() {
        //get 请求接口
        let that = this;
        //console.log(that.form.name);
        this.$axios
            .get(this.COMMON.httpUrl+"/machine/search", {
            params: {
                name: that.searchform.name
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

        // 分页
        // 每页显示的条数
        handleSizeChange: function(pageSize) { 
            this.pageSize = pageSize;
            this.handleCurrentChange(this.currentPage);
        },

        // 显示第几页
        handleCurrentChange: function(currentPage) {//页码切换
            this.currentPage = currentPage;
            this.currentChangePage(this.MachineDate,currentPage);
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

        //复选框的操作方法
        // handleCheckAllChange(val) {
        //     this.checkedCoffee = val ? coffeeOptions : [];
        //     this.isIndeterminate = false;
        // },
        handleCheckedCitiesChange(value) {
            let checkedCount = value.length;
            this.checkAll = checkedCount === this.coffees.length;
            this.isIndeterminate = checkedCount > 0 && checkedCount < this.coffees.length;
        },

        //获取所有的咖啡的名字
        GetAllCoffeeName(){
            let that = this;
            this.$axios
                .get(this.COMMON.httpUrl+"/coffee/selectAllCoffee")
                .then(res => {
                    //console.log(res.data);
                    that.coffees=[];
                    for(var i=0;i<res.data.object.length;i++){
                        that.coffees.push(res.data.object[i].coffeeName);
                    }
                    //console.log(that.coffees)
                });
        },

        //增加咖啡机的时候 获取下拉列表框的值
        getMenuId(selVal){
            this.form.menuName=selVal;
           this.getMenuReallyId(selVal);
        },

        //根据名字查找ID
        getMenuReallyId(menuName){
            let that=this
            this.$axios
            .get(this.COMMON.httpUrl+"/menudetail/GetMenuId",{
                params:{
                    menuName:menuName
                }
            })
            .then(res => {
                that.form.menuId=res.data.object;
                that.updateform.menuId=res.data.object;
            });
        },

        //添加咖啡机
        insertMachine(){
            let that=this;
            this.$axios.post(this.COMMON.httpUrl+"/machine/insertMachine",{
                machineId: that.form.machineId,
                coffeemachine: that.form.coffeemachine,
                machineKinds: that.form.machineKinds,
                machinePrice: that.form.machinePrice,
                state: that.radio,
                note: that.form.note,
                menuId:that.form.menuId
            }).then(res=>{
                if(res.data.returnState==200){
                    this.$message({
                        message: '添加成功',
                        type: 'success'
                    });
                    that.searchAll();
                }
                else{
                    this.$message.error('添加失败');
                }
                that.dialogFormVisible=false
            })
        },

        //打开咖啡机修改界面
        updateStart(row){
            let that=this
            this.dialogFormVisibleUpdate=true;
            this.$axios
            .get(this.COMMON.httpUrl+"/menudetail/GetMenuName",{
                params:{
                   menuId:row.menuId
                }
            })
            .then(res => {
                this.updateform={
                    machineId:row.machineId,
                    coffeemachine:row.coffeemachine,
                    machineKinds:row.machineKinds,
                    machinePrice:row.machinePrice,
                    note:row.note,
                    menuId:row.menuId,
                    menuName:res.data.object
                }
                this.updateradio=row.state.toString();
            }); 
            //this.checkedCoffee=row.cook.toString().split(",");
            //console.log(this.checkedCoffee)

        },

        //修改  修改页面的下拉列表的值
        updategetMenuId(selVal){
            this.updateform.menuName=selVal;
            this.getMenuReallyId(selVal);

        },

        //修改咖啡机
        updateMachine(){
            let that=this;
            let data={
                machineId: that.updateform.machineId,
                coffeemachine: that.updateform.coffeemachine,
                machineKinds: that.updateform.machineKinds,
                machinePrice: that.updateform.machinePrice,
                state: that.updateradio, 
                note: that.updateform.note,
                menuId:that.updateform.menuId
            }
            this.$axios.post(this.COMMON.httpUrl+"/machine/updateMachine",data)
            .then(res=>{
                //console.log(res)
                if(res.data.returnState==200){
                    this.$message({
                        message: '修改成功',
                        type: 'success'
                    });
                    that.searchAll()
                }
                else{
                    this.$message.error('修改失败');
                }
                that.dialogFormVisible=false
            })
            this.dialogFormVisibleUpdate=false;
        },

        //跳转到咖啡机详情页面
        ToMachineMessage(index, row){
            let params={
                machineId: row.machineId,
                coffeemachine: row.coffeemachine,
                machineKinds: row.machineKinds,
                machinePrice: row.machinePrice,
                note: row.note,
                state:row.state,
                menuId:row.menuId
            }
            //console.log(params)
            Utils.$emit('demo');
            this.$router.push({
                path: '/MachineMessage',
                query: params
            })
        },

        //跳转到维护界面
        ToMaintenance(row){
            let params={
                machineId: row.machineId,
            }
            Utils.$emit('demo2');
            this.$router.push({
                path: '/maintenance',
                query: params
            })
        }
    }
    
}
</script>

<style scoped>
.Thisform {
  width: 30%;
  padding-left: 40%;
  
}

.insert{
    padding-left: 25%;
    padding-right: 25%;

}

.tableStyle{
    padding-left: 11%;
    width: 1374px;
    padding-top: 10px;
}

.machinepage{
    padding-left: 40%;
    padding-top: 2%;
}

.selectform{
    padding-top: 20px;
    width: 1224px;
    padding-left: 12%;
    flex-direction: row;
    display: flex;
}

.insertbutton{
    margin-left: 1127px;
    flex-direction: row;
    display: flex;
}
</style>