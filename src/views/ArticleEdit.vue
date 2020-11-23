<template>
    <div v-loading="loading">
        <div class="backBtn">
           <el-button @click="goBack">返回</el-button>
       </div>
        <el-form :inline="true" :model="formInline" class="demo-form-inline mytable">
            <el-form-item label="桥梁名称">
                <el-input v-model="formInline.bridge_name" placeholder="桥梁名称"></el-input>
            </el-form-item>
            <br>
            <el-form-item label="坐标">
                <el-input v-model="formInline.x" placeholder="坐标"></el-input>
            </el-form-item>
            <el-form-item label="坐标">
                <el-input v-model="formInline.y" placeholder="坐标"></el-input>
            </el-form-item>
            <br>
            <el-form-item label="风速">
                <el-input v-model="formInline.content1" placeholder="风速"></el-input>
            </el-form-item>
            <el-form-item label="桥梁纵向变化">
                <el-input v-model="formInline.content2" placeholder="桥梁纵向变化"></el-input>
            </el-form-item>
            <br>
            <el-form-item label="桥梁横向变化">
                <el-input v-model="formInline.content3" placeholder="桥梁横向变化"></el-input>
            </el-form-item>
             <el-form-item label="风向">
                <el-input v-model="formInline.content4" placeholder="风向"></el-input>
            </el-form-item>
            <br>
             <el-form-item label="桥梁状态">
                <el-input v-model="formInline.bridge_status" placeholder="桥梁状态"></el-input>
            </el-form-item>
            <!-- <el-form-item label="坐标">
                <el-input v-model="formInline.x1" placeholder="坐标"></el-input>
            </el-form-item>
            <el-form-item label="坐标">
                <el-input v-model="formInline.y1" placeholder="坐标"></el-input>
            </el-form-item>
                <el-form-item label="数据">
                <el-input v-model="formInline.content1" placeholder="数据"></el-input>
            </el-form-item> -->
            <el-form-item>
                <el-button type="primary" @click="setZuoBiao()" v-if="isAddFlag">添加坐标</el-button>
                <el-button type="success" @click="setZuoBiao()" v-else>更新</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>


<script>
  export default {
    data() {
      return {
        loading: false,
        formInline: {
          bridge_name:'',
          x: '',
          y: '',
          x1: '',
          y1: '',
          content1: '',
          content2: '',
          content3: '',
          content4: '',
          bridge_status:3,
        },
        isAddFlag: this.$route.params.isAdd
      }
    },
    methods: {
        handleEdit(){
                if(this.$route.params.id){
                    this.$axios.post('/api/article/update',{
                        bridge_name:this.bridge_name,
                        title:this.title,
                        content:this.content,
                        article_id:this.$route.params.id
                    }).then(res => {
                        if(res.data.code === 0){
                            this.$message({
                                message: '更新成功',
                                type: 'success'
                            });
                           setTimeout(()=>{
                                this.loading = false
                                this.$router.push({name:'home'})
                            },1500);
                        }
                    }).catch(e => {
                        console.log(e)
                    })
                }else{
                    this.$axios.post('/api/article/add',{
                     bridge_name:this.bridge_name,   
                    title:this.title,
                    content:this.content,
                    bridge_status:this.bridge_status
                }).then(res => {
                    if(res.data.code === 0){
                        this.$message({
                            message: '新增成功',
                            type: 'success'
                        });
                        setTimeout(() => {
                            this.$router.push({name:'article'})
                        }, 1500);
                    }
                }).catch(e => {
                    console.log(e)
                })
                }     
            },
        goBack(){
                this.$router.go(-1)
            },
      setZuoBiao(){
          let isAddFlag = this.isAddFlag;
          let that = this
          let data = {
              "bridge_name":that.formInline.bridge_name,
              "x": that.formInline.x,
              "y": that.formInline.y,
              "content1": that.formInline.content1,
              "content2": that.formInline.content2,
              "content3": that.formInline.content3,
              "content4": that.formInline.content4,
              "bridge_status":that.formInline.bridge_status,
          }
          let updateData = {
              "bridge_name":that.formInline.bridge_name,
              "id": this.$route.params.id,
              "x": that.formInline.x,
              "y": that.formInline.y,
              "content1": that.formInline.content1,
              "content2": that.formInline.content2,
              "content3": that.formInline.content3,
              "content4": that.formInline.content4,
              "bridge_status":that.formInline.bridge_status,
          }
         this.loading = true
          console.log(that.x);
          if(isAddFlag) {
              this.$axios.post('/api/article/addX',data).then((res) => {
                console.log(res);
                setTimeout(()=>{
                    this.loading = false
                    this.$router.push({name:'home'})
                },1500);
            })
          } else {
                this.$axios.post('/api/article/update', updateData).then((res) => {
                    that.loading = false;
                    console.log(res);
                    setTimeout(()=>{
                    this.loading = false
                    this.$router.push({name:'home'})
                },1500)
                })
              console.log(data)
          }
            
        },
        getDetail() {
            this.$axios.get('/api/article/getById',{
            params:{
                id:this.$route.params.id
            }
            }).then(res => {
                console.log(res.data.data);
                    this.formInline.bridge_name = res.data.data.bridge_name
                    this.formInline.x = res.data.data.x
                    this.formInline.y = res.data.data.y
                    this.formInline.content1 = res.data.data.content1
                    this.formInline.content2 = res.data.data.content2
                    this.formInline.content3 = res.data.data.content3
                    this.formInline.content4 = res.data.data.content4
                    this.formInline.bridge_status = res.data.data.bridge_status
            }).catch(e=>{
                console.log(e)
            })
        }
    },
    created() {
        if(this.$route.params.id){
            this.getDetail()
        }
    }
  }
</script>

<style scoped>
    .mytable {
        margin-left: 40px;
    }
    .backBtn{
    text-align: right;
    margin-bottom: 40px;
    }
</style>
