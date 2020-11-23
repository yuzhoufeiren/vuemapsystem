<template>
    <!--为echarts准备一个具备大小的容器dom-->
    <div id="main" style="width: 1200px;height: 500px;">
        <div class="backBtn">
           <el-button @click="goBack">返回</el-button>
       </div>
    </div>
</template>
<script>
    import echarts from 'echarts'
    export default {
        name: '',
        data() {
            return {
                tabledata: [],
                charts: '',
            /*  opinion: ["1", "3", "3", "4", "5"],*/
                opinionData: ["3", "2", "4", "4", "5"],
                timer: null 
            }
        },
        methods: {
            goBack(){
                this.$router.go(-1)
            },
            getFormatArr(arr) {
                let temp = arr.split(',');
                let resArr = []
                for(let i = 0; i < temp.length; i++) {
                    if(i == 0) {
                        let t = temp[i].replace("[", "");
                        resArr.push(parseInt(t));
                        continue;
                    }
                    if(i == temp.length-1) {
                        let t = temp[i].replace("]", "");
                        resArr.push(parseInt(t));
                        continue;
                    }
                    resArr.push(parseInt(temp[i]));
                }
                return resArr;
            },
            getData() {
                    this.$axios.get('/api/article/getTableData').then((res) => {
                        this.tabledata = [];
                    for (let i = 0; i < res.data.data.length; i++) {
                        this.tabledata.push(res.data.data[i].content1)
                        this.tabledata.push(res.data.data[i].content2)
                        this.tabledata.push(res.data.data[i].content3)
                        this.tabledata.push(res.data.data[i].content4)
                    }
                    this.charts =echarts.init(document.getElementById("main"))
                    this.charts.setOption({
                            tooltip: {
                                trigger: 'item',
                                formatter: '{a} <br/>{b} : {c}'
                            },
                            legend: {
                                left: 'left',
                                data: ['桥梁纵向变化', '桥梁横向变化','风向','风速']
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: {
                                type: 'category',
                                name: 'x',
                                splitLine: {show: false},
                                data: ['1', '2', '3', '4', '5', '6', '7', '8', '10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30']
                            
                            },
                            yAxis: {
                                type: 'log',
                                name: 'y',
                                minorTick: {
                                    show: true
                                },
                                minorSplitLine: {
                                    show: true
                                }
                            },
                            series: [
                                {
                                    name: '桥梁纵向变化',
                                    type: 'line',
                                    // data:[256,254,256,256,257,14,10,13,257,256,254,253,254,254,257,257,259,253,255,254,255,254,257,254,255,254,254,255,255,254]
                                    data: this.getFormatArr(this.tabledata[0])
                                    //content1是风速
                                    // data: [1, 3, 5]
                                },
                                {
                                    name: '桥梁横向变化',
                                    type: 'line',
                                    // data:[175,175,176,173,175,175,176,176,175,174,173,172,173,176,176,174,176,176,176,176,175,173,176,175,176,176,177,174,174,175]
                                    // data: [2,7,9]
                                    data: this.getFormatArr(this.tabledata[1])
                                },
                                {
                                    name: '风速',
                                    type: 'line',
                                    // data:[23,31,33,25,29,39,41,23,31,33,25,29,39,41,33,25,29,39,41,23,31,33,25,29,39,41,23,29,39,41,23,31,33,25,29,39]
                                    data: this.getFormatArr(this.tabledata[2])
                                },
                                // {
                                //     name: '风向',
                                //     type: 'line',
                                //     data: this.tabledata[3]//conten4是风向
                                //     // data:[4,12,13]
                                // },
                            ]
                        })
                    })
                
            },
        },
        //调用
        created() {
            
            this.timer = setInterval(()=>{
                setTimeout(this.getData(), 0)
            },1000)

            this.$nextTick(function() {
                this.getData();
            })
            //this.getData()
            // this.$nextTick(function() {
            //     this.drawLine('main')
            // })
        },
        beforeDestroy(){
            clearInterval(this.timer);        
            this.timer = null;
        }
    }
</script>
<style scoped>
    * {
        margin: 0;
        padding: 0;

        list-style: none;
    }
    /* .backBtn{
    text-align: right;
    margin-bottom: 100px;
    } */
</style>