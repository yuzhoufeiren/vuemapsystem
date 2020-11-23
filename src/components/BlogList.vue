<template>
  <div id="app">
    <h3 class="title">{{ msg }}</h3>
    <div class="amap-wrapper">//高德地图引入
      <el-amap class="amap-box" :vid="'amap-vue'" :plugin="plugin">
        <el-amap-polyline
          :editable="polyline.editable"
          :path="polyline.path"
          :events="polyline.events"
          strokeWeight="12"
          :strokeColor="polyline.strokeColor"
        ></el-amap-polyline>//桥梁状态引入
        <!--  -->
        <!-- <el-amap-polyline
          :editable="polyline1.editable"
          :path="polyline1.path"
          :events="polyline1.events"
          strokeWeight="16"
        ></el-amap-polyline> -->
        <!--  -->
        <el-amap-marker
          v-for="(marker, index) in markeres"
          :key="index"
          :position="marker.position"
          :events="marker.events"
        ></el-amap-marker>//标注点引入
        <el-amap-info-window
          v-if="window"
          :position="window.position"
          :visible="window.visible"
          :content="window.content"
        ></el-amap-info-window>
        <el-amap-marker
          v-for="(marker, index) in markers"
          :key="index"
          :position="marker"
        ></el-amap-marker>
        <el-amap-search-box
          class="search-box"
          :search-option="searchOption"
          :on-search-result="onSearchResult"
        ></el-amap-search-box>
      </el-amap>
    </div>
    <div class="toolbar">
      <button type="button" name="button" v-on:click="changeEditable">
        change editable
      </button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      bridgeStatus: 3,
      markers: [[], [], []],
      searchOption: {
        city: "上海",
        citylimit: false
      },
      mapCenter: [121.59996, 31.197646],
      plugin: [
        {
          pName: "ToolBar",
          events: {
            init(instance) {
            }
          }
        },
        {
          pName: "Scale",
          events: {
            init(instance) {
            }
          }
        },
        {
          pName: "OverView",
          events: {
            init(instance) {
            }
          }
        },
        {
          pName: "MapType",
          defaultType: 0,
          events: {
            init(instance) {
            }
          }
        }
      ],
      zoom: 12,
      center: [121.5273285, 31.25515044],
      polyline: {
        path: [
          [113.27894, 23.111337],
          [113.279562, 23.113823]
        ],
        events: {
          click(e) {
            alert("click polyline" + e);
          },
          end: e => {
            let newPath = e.target
              .getPath()
              .map(point => [point.lng, point.lat]);
          }
        },
        editable: false,
        strokeColor: this.getbridecolor()
      },
      // polyline1: {
      //   path: [
      //     [113.334088, 23.107351],
      //     [113.333851, 23.111792]
      //   ],
      //   events: {
      //     click(e) {
      //       alert("click polyline" + e);
      //     },
      //     end: e => {
      //       let newPath = e.target
      //         .getPath()
      //         .map(point => [point.lng, point.lat]);
      //       console.log(newPath);
      //     }
      //   },
      //   editable: false
      // },
      msg: "",
      markeres: [],
      windows: [],
      window: "",
      left: [],
      content: [],
    };
  },
  getB() {},
  created(){
    let markeres = [];
    let windows = [];
    let self = this;
    let left = new Array(100);
    let right = new Array(100);
    let num = right.length;
    left.push(0);
    right.push(0);
    this.$axios.get("/api/article/test").then(res => {
      let statusNum;
      for (let i = 0; i < res.data.data.length; i++) {
        left[i] = res.data.data[i].x;
        right[i] = res.data.data[i].y;
        let temp1 = res.data.data[i].content1.split(",");//纵向
        let temp2 = res.data.data[i].content2.split(",");//横向
        let temp3 = res.data.data[i].content3.split(",");//风速
        let temp4 = res.data.data[i].content4; //风向
        this.content.push(temp1[temp1.length - 1].replace("]", ""));
        this.content.push(temp2[temp2.length - 1].replace("]", ""));
        this.content.push(temp3[temp3.length - 1].replace("]", ""));
        this.content.push(temp4); //风向
        statusNum = parseInt(temp1[temp1.length - 1].replace("]", "")) + parseInt(temp2[temp2.length - 1].replace("]", "")) + parseInt(temp3[temp3.length - 1].replace("]", ""));
      }
      this.polyline.strokeColor = this.getbridecolor(this.calcBridgeStatus(statusNum));
      for (let i = 0; i < num; i++) {
        markeres.push({
          position: [left[i], right[i]],
          events: {
            click() {
              self.windows.forEach(window => {
                window.visible = false;
              });
              self.window = self.windows[i];
              self.$nextTick(() => {
                self.window.visible = true;
              });
            }
          }
        });
        //这里要加定时器
        windows.push({
          position: [left[i], right[i]],
          content:
            this.content[i] === "" || this.content[i] === null
              ? ""
              : `<div class="prompt">${"数据展示"}</div><br/><div class="items">桥梁纵向变化:<span id="val1">${
                  this.content[0]
                }</span></div><br/><div class="items">桥梁横向变化:<span id="val2">${
                  this.content[1]
                }</span></div><br/><div class="items">风速:<span id="val3">${
                  this.content[2]
                }</span></div><br/><div class="items">风向:<span id="val4">${this.content[3]}</span></div>` +
                "",
          visible: false
        });
      }
      this.markeres = markeres;
      this.windows = windows;
      this.getbridecolor();
      setInterval(() => {
        this.updateData().then(content => {
          const val1 = document.getElementById('val1');
          const val2 = document.getElementById('val2');
          const val3 = document.getElementById('val3');
          const val4 = document.getElementById('val4');
          if (!(val1||val2||val3||val4)) {
            return
          }
          val1.innerText = content[0]
          val2.innerText = content[1]
          val3.innerText = content[2]
          val4.innerText = content[3]
        })
      }, 1000);
      setInterval(()=>{
        this.updateinfo()
      },1000)
      // setTimeout(()=>{
      //   this.updateinfo()
      // },10000)
      // setInterval(()=>{
      //   console.log(this.bridgeStatus);
      //   if (this.bridgeStatus === 1) {
      //     this.updateinfo1
      //   } else  {
      //     this.updateinfo()
      //   }
      // },5000)
    });
  },
  // mounted(){
  //   this.getbridecolor();
  //   setInterval(this.getbridecolor,3000);
  // },
  methods: {
    updateData: function() {
      const content = [];
      return this.$axios.get("/api/article/test").then(res => {
        // this.polyline.strokeColor = this.getbridecolor(
        // res.data.data[0].bridge_status
        // );
        for (let i = 0; i < res.data.data.length; i++) {
          let temp1 = res.data.data[i].content1.split(",");//桥梁纵向测距
          let temp2 = res.data.data[i].content2.split(",");//桥梁横向测距
          let temp3 = res.data.data[i].content3.split(",");//风速
          let temp4 = res.data.data[i].content4; //风向
          content.push(temp1[temp1.length - 1].replace("]", ""));//桥梁纵向测距
          content.push(temp2[temp2.length - 1].replace("]", ""));//桥梁横向测距
          content.push(temp3[temp3.length - 1].replace("]", ""));//风速
          content.push(temp4); //风向
    
        }
        return content;
      });
    },
    updateinfo:function(){
      return this.$axios.get("/api/article/test").then(res=>{
        // CV
        let statusNum;
        for (let i = 0; i < res.data.data.length; i++) {
          let temp1 = res.data.data[i].content1.split(",");//纵向
          let temp2 = res.data.data[i].content2.split(",");//横向
          let temp3 = res.data.data[i].content3.split(",");//风速
          let temp4 = res.data.data[i].content4; //风向
          this.content.push(temp1[temp1.length - 1].replace("]", ""));
          this.content.push(temp2[temp2.length - 1].replace("]", ""));
          this.content.push(temp3[temp3.length - 1].replace("]", ""));
          this.content.push(temp4); //风向
          statusNum = parseInt(temp1[temp1.length - 1].replace("]", "")) + parseInt(temp2[temp2.length - 1].replace("]", "")) + parseInt(temp3[temp3.length - 1].replace("]", ""));
        }
        let bs = this.calcBridgeStatus(statusNum);
        this.polyline.strokeColor = this.getbridecolor(bs);
      })
    },
    calcBridgeStatus(statusNum) {
      let bs;
      if(statusNum >= 650) {
        bs = 1;
      } else if(statusNum >= 601 && statusNum <= 650) {
        bs = 2;
      } else {
        bs = 3;
      }
      return bs;
    },
    //使用axios将数据存到data
    getBridgeStatus: function() {
      this.$axios.get('/api/article/test').then(res => {
        //CV
        let statusNum;
        for (let i = 0; i < res.data.data.length; i++) {
          let temp1 = res.data.data[i].content1.split(",");//纵向
          let temp2 = res.data.data[i].content2.split(",");//横向
          let temp3 = res.data.data[i].content3.split(",");//风速
          let temp4 = res.data.data[i].content4; //风向
          this.content.push(temp1[temp1.length - 1].replace("]", ""));
          this.content.push(temp2[temp2.length - 1].replace("]", ""));
          this.content.push(temp3[temp3.length - 1].replace("]", ""));
          this.content.push(temp4); //风向
          statusNum = parseInt(temp1[temp1.length - 1].replace("]", "")) + parseInt(temp2[temp2.length - 1].replace("]", "")) + parseInt(temp3[temp3.length - 1].replace("]", ""));
        }
        this.bridgeStatus = this.calcBridgeStatus(statusNum);
      })
    },
    //显示信息框
    updateinfo1: function(){
      this.$alert("江湾大桥出现重度危险情况", "重度安全警告", {
          confirmButtonText: "关闭此消息框",
          callback: action => {
            this.$message({ 
              type: "info",
              message: `action: ${action}`
            });
          }
        });
    },
    getbridecolor: function(bridgeStatus) {
      if (bridgeStatus === 1) {//red
      //调用，将数据存到data
        this.getBridgeStatus()
        if (!(this.bridgeStatus === 1)) {
          this.updateinfo1()
        }
        return "#f00";
      } else if (bridgeStatus === 3) {//green
        return "#0f0";

      } else if (bridgeStatus === 2) {//yellow
        return "#E6A23C";
      }
    },
    addMarker: function() {
      let lng = 121.5 + Math.round(Math.random() * 1000) / 10000;
      let lat = 31.197646 + Math.round(Math.random() * 500) / 10000;
      this.markers.push([lng, lat]);
    },
    onSearchResult(pois) {
      let latSum = 0;
      let lngSum = 0;
      if (pois.length > 0) {
        pois.forEach(poi => {
          let { lng, lat } = poi;
          lngSum += lng;
          latSum += lat;
          this.markers.push([poi.lng, poi.lat]);
        });
        let center = {
          lng: lngSum / pois.length,
          lat: latSum / pois.length
        };
        this.mapCenter = [center.lng, center.lat];
      }
    },
    changeEditable() {
      this.polyline.editable = !this.polyline.editable;
    }
  }
};
</script>

<style>
#app {
  width: 100%;
}
.search-box {
  top: -80px;
  right: 10px;
}
.amap-wrapper {
  position: relative;
  width: 100%;
  margin-bottom: 0.03rem;
  height: 640px;
  font-size: 0.12rem;
}
.prompt {
  background: white;
  width: 200px;
  margin-top: 8px;
  text-align: center;
  font-size: 20px;
}
.items {
  font-size: 20px;
}
</style>
