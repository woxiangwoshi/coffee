<template>
    <div>
        <!-- <h2 class="messageform">This is MachineMessage Page</h2> -->
        <br />
        <div class="messagetable" style="text-align:center">
            <table>
                <tr>
                    <td>咖啡机序号</td>
                    <td>{{params.machineId}}</td>
                    <td>咖啡机名称</td>
                    <td>{{params.coffeemachine}}</td>
                    <td>咖啡机价格</td>
                    <td>{{params.machinePrice}}</td>
                </tr>
                <tr>
                    <td>咖啡机状态</td>
                    <td>{{params.state}}</td>
                    <td>咖啡机特点</td>
                    <td>{{params.machineKinds}}</td>
                    <td>备注</td>
                    <td>{{params.note}}</td>
                </tr>
                <tr >
                    <td class="specialtd">能做的咖啡</td>
                    <td colspan="5">
                        <!-- <div class="cotable">
                            <el-table
                            :data="cook"
                            border
                            >
                                <el-table-column property="coffeeName" label="咖啡名称" width="400" align="center"></el-table-column>
                                <el-table-column property="coffeePrice" label="咖啡价格" width="400" align="center"></el-table-column>
                                <el-table-column label="操作"  align="center">
                                <template slot-scope="scope">
                                    <el-button @click="updateStart(scope.row)">编辑</el-button>
                                    <el-button @click="deleteStart(scope.row)">删除</el-button>
                                </template>
                                </el-table-column>
                            </el-table>
                            <el-button type="primary" @click="insertStart" >编辑</el-button>
                        </div> -->
                         <div @click="ToMachineCoffee">
                             {{title}}
                         </div>
                    </td>
                </tr>
                <tr>
                    <td specialtd>咖啡机二维码</td>
                    <td colspan="5">
                        <!-- <img :src="home_url" >  -->
                        <div id="qrcode" class="erweima"></div>
                    </td>
                </tr>
            </table>
        </div>
        
        
    </div>
</template>

<script>
import QRCode from 'qrcodejs2';
import Utils from '../../assets/js/util.js';
import coffee1 from '../../assets/coffee1.png'
import coffee2 from '../../assets/coffee2.png'
import coffee3 from '../../assets/coffee3.png'
import coffee4 from '../../assets/coffee4.png'
import coffee5 from '../../assets/coffee5.png'
import coffee6 from '../../assets/coffee6.png'
import coffee7 from '../../assets/coffee7.png'
import coffee8 from '../../assets/coffee8.png'
const coffees=[coffee1,coffee1,coffee2,coffee3,coffee4,coffee5,coffee6,coffee7,coffee8]
export default {
    data(){
        let that = this;
        let menuId=that.$route.query.menuId;         
        let getmachineId= that.$route.query.machineId;
        this.GetMenuName(menuId);
        return{
            params:{
                machineId: that.$route.query.machineId,
                coffeemachine: that.$route.query.coffeemachine,
                machineKinds: that.$route.query.machineKinds,
                state:that.$route.query.state,
                machinePrice: that.$route.query.machinePrice,
                note: that.$route.query.note,
                menuId:that.$route.query.menuId   
            },
            title:"",
            //cook:[],
            //coffees:[],
            
            home_url: coffees[getmachineId]
        }
    },
    methods:{
        // 生成二维码
        qrcode (id) {
            let that = this;
            let qrcode = new QRCode('qrcode', {
              width: 151,
              height: 151,        // 高度
              text:  this.COMMON.httpUrl+id,   // 二维码内容
              // render: 'canvas' ,   // 设置渲染方式（有两种方式 table和canvas，默认是canvas）
              // background: '#f0f',   // 背景色
              // foreground: '#ff0'    // 前景色
            })
        },

        //页面跳转
        ToMachineCoffee(){
            let params={
                SendmenuId:this.params.menuId
            }
            Utils.$emit('demo1');
            this.$router.push({
                path: '/MachineCoffee',
                query:params
            })
        },
        
        //通过菜单id找到菜单名字
        GetMenuName(menuId){
            let that=this;
            this.$axios.get(this.COMMON.httpUrl+"/menudetail/GetMenuName",{
                params: {
                    menuId:menuId
                }
            }).then(res=>{
                //console.log(res.data)
                that.title=res.data.object
                //console.log(that.params.machineId)
                that.qrcode(that.params.machineId)
            })
        }
    }
}
</script>

<style scoped>
table{
    border-collapse: collapse;
}
td{
    width: 150px;
    height: 60px;
    border: 1px solid #000000;
}

.specialtd{
    width: 150px;
    height: 100px;
    border: 1px solid #000000;
}

.specialtd1{
    width: 150px;
    height: 300px;
    border: 1px solid #000000; 
}
.messagetable{
    padding-left: 20%;
}

.cotable{
    flex-direction: row;
}

.insert{
    padding-left: 20%;
    padding-right: 25%;

}

.messageform{
    padding-left: 600px;
}

.erweima{
    padding-left: 35%;
    margin: 5%;
}

</style>