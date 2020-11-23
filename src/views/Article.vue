<template>
    <div class="wrapper">
       <h1 class="title">数据系统</h1>
       <div class="article">
           <el-button class="addBtn" @click="handleAdd">坐标新增+</el-button>
           <el-table :data="articleList" border stripe>
               <el-table-column
                    prop="bridge_name"
                    label="桥梁名称"
                    width="180">
                </el-table-column>
                <el-table-column
                    prop="id"
                    label="数据名称"
                    width="180">
                </el-table-column>
                <el-table-column
                    prop="x"
                    label="坐标"
                    width="180">
                </el-table-column>
                <el-table-column
                    prop="y"
                    label="坐标"
                    width="180">
                </el-table-column>
                <el-table-column
                    label="日期"
                    width="230">
                   <template slot-scope="scope">
                       <i class="el-icon-time"></i>
                     <span>  {{ scope.row.create_date | dateformat('YYYY-MM-DD HH:mm') }}分</span>
                   </template>
                </el-table-column>
                <el-table-column
                    label="操作">
                     <template slot-scope="scope">
                       <el-button size="mini" type="primary" @click="handleLook(scope.row)">查看</el-button>
                       <el-button size="mini" type="success"  @click="handleEdit(scope.row)">编辑</el-button>
                       <el-button size="mini" type="danger" @click="handleDelect(scope.row)">删除</el-button>
                   </template>
                </el-table-column>
           </el-table>
           
       </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                articleList:[]
            }
        },
        methods: {
            handleAdd(){
                this.$router.push({
                    name:'editArticle',
                    params: {
                        isAdd: 1
                    }
                })
            },
            handleLook(row){
                let id = row.id
                this.$router.push('/detail/'+id)
            },
            handleEdit(row){
                let id = row.id;
                this.$router.push({
                    name:'editArticle', 
                    params: {
                        id,
                        isAdd: 0
                    }
                })
            },
              handleDelect(row){
                let id = row.id
                this.$confirm('此操作将删除该数据, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$axios.post('/api/article/delete',{
                        id:id
                    })
                    .then(res => {
                        if(res.data.code === 0){
                            //发起删除请求操作
                            this.$message({
                                type: 'success',
                                message: `${id}数据删除成功!`
                            });
                        }
                    }).catch(e=>{
                        console.log(e)
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });          
                });
            },
            getMyBlogList(){
                this.$axios.get('/api/article/allList')
                .then(res =>{
                    if(res.data.code === 0){
                        this.articleList =res.data.data
                    }
                }).catch(e=>{
                    console.log(e)
                })
            }
        },
        created(){
            this.getMyBlogList();
        }
    }
</script>

<style lang="scss" scoped>
.title{
    margin: 30px 0;
    text-align: center;
    font-weight: bold;
    font-size: 28px;

}
.article{
    .addBtn{
        float:right;
        margin-bottom: 20px;
    }
}
/deep/.el-table{
.cell{
    text-align: center;
}
}
</style>