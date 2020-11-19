<template>
    <div>
        <div class="thisform">
            <!-- <h2>This is 咖啡机维护  page</h2> -->
            <br />
            <el-button type="primary" @click="searchState">查看咖啡机状态</el-button>
        </div>
       
        <div class="menutable">
            <el-table :data="machineState" border stripe>
                <el-table-column property="machineName" label="咖啡机名字" width="200" align="center"></el-table-column>
                <el-table-column property="state" label="咖啡机状态" width="200" align="center"></el-table-column>
                <el-table-column property="time" label="读取时间" width="200" align="center"></el-table-column>
                <el-table-column label="操作"  align="center" width="400">
                    <template >
                        <el-button @click="addWater" style="margin-left:30px">补水</el-button>
                        <el-button @click="addMilk" style="margin-left:30px">补奶</el-button>
                        <el-button @click="addCoffeeBeans" style="margin-left:30px">补咖啡豆</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
    </div>
</template>

<script>
export default {
   data(){
       return{
            getMenuId:this.$route.query.machineId,
            selectTitle:"",
            selectCheck:"",
            //下拉列表框中的内容
            menus:[],
            //表格内容
            machineState:[],
       }
   },
   methods:{

        //通过咖啡机ID去查询咖啡机的状态
        searchState(){
            let that=this
            this.$axios
            .get(this.COMMON.httpUrl+"api/state/searchOneMachineState",{
                params:{
                   machineId:that.getMenuId
                }
            })
            .then(res => {
                that.machineState=res.data
            });
            const loading = this.$loading({
                lock: true,
                text: '正在查询中，请稍等...',
                spinner: 'el-icon-loading',
                background: 'rgba(0, 0, 0, 0.7)'
            });
            setTimeout(() => {
                loading.close();
            }, 15000);
        },

        //加水
        addWater(){
            let that=this
            this.$axios
            .get(this.COMMON.httpUrl+"api/machine/AddWater",{
                params:{
                   machineId:that.getMenuId
                }
            })
            .then(res => {
                //if(res.data==true){
                this.$message({
                    message: '加水成功',
                    type: 'success'
                });
                // }
                // else{
                //     this.$message.error('加水失败');
                // }
            }); 
            const loading = this.$loading({
                lock: true,
                text: '正在加水中，请稍等...',
                spinner: 'el-icon-loading',
                background: 'rgba(0, 0, 0, 0.7)'
            });
            setTimeout(() => {
                loading.close();
            }, 15000);
        },

        //加牛奶
        addMilk(){
            let that=this
            this.$axios
            .get(this.COMMON.httpUrl+"api/machine/AddMilk",{
                params:{
                   machineId:that.getMenuId
                }
            })
            .then(res => {
                //if(res.data==true){
                this.$message({
                    message: '加牛奶成功',
                    type: 'success'
                });
                // }
                // else{
                //     this.$message.error('加牛奶失败');
                // }
            }); 
            const loading = this.$loading({
                lock: true,
                text: '正在加牛奶中，请稍等...',
                spinner: 'el-icon-loading',
                background: 'rgba(0, 0, 0, 0.7)'
            });
            setTimeout(() => {
                loading.close();
            }, 15000);
        },

        //加咖啡豆
        addCoffeeBeans(){
            let that=this
            this.$axios
            .get(this.COMMON.httpUrl+"api/machine/AddCoffeeBeans",{
                params:{
                   machineId:that.getMenuId
                }
            })
            .then(res => {
                //if(res.data==true){
                this.$message({
                    message: '加咖啡豆成功',
                    type: 'success'
                });
                // }
                // else{
                //     this.$message.error('加咖啡豆失败');
                // }
            }); 
            const loading = this.$loading({
                lock: true,
                text: '正在加咖啡豆中，请稍等...',
                spinner: 'el-icon-loading',
                background: 'rgba(0, 0, 0, 0.7)'
            });
            setTimeout(() => {
                loading.close();
            }, 15000);
        }
   }
}
</script>

<style>
.thisform{
    padding-left: 700px;
    padding-top: 50px;
}

.menutable{
    width: 1001px;
    padding-left: 18%;
    padding-top: 7%;
}

.selectform{
    padding-top: 20px;
    width: 1224px;
    padding-left: 18%;
    flex-direction: row;
    display: flex;
}

.insertTable{
    width: 701px;
    padding-left: 100px;
}
</style>