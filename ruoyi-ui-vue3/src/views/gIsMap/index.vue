<template>
  <div class="app-container">

    <el-card class="app-card" :body-style="{ padding:'0px !important'}" v-loading="loadingShow">
      <div class="menu-box" v-loading="loadingShow">

        <el-switch v-model="closeDevice" active-text="开启" inactive-text="关闭" inline-prompt/>

        <div v-show="closeDevice">
          <el-tabs v-model="activeNameMode" class="demo-tabs" @tab-click="handleClick">
            <el-tab-pane label="GB" name="GB">
              <div class="head-container">
                <el-input v-model="deviceName" placeholder="请输入设备名称" clearable prefix-icon="Search"
                          style="margin-bottom: 20px"/>
              </div>
              <div class="top">
                <InfiniteList
                    v-if="deviceList.length > 0"
                    :data="deviceList"
                    :width="'100%'"
                    :height="'100%'"
                    :itemSize="40"
                    v-slot="{ item, index }"
                >
                  <div style="cursor: pointer">
                    <el-tag @click="deviceClick(item)" style="width: 100%;" size="large"
                            :type="selectDeviceId === item.deviceId ? 'success' : ''">
                      <svg-icon icon-class="camera" style="margin-right: 6px"/>
                      {{ item.name }}
                    </el-tag>
                  </div>
                </InfiniteList>
              </div>
            </el-tab-pane>

            <el-tab-pane label="ONVIF" name="ONVIF">
              <div class="head-container">
                <el-input v-model="deviceName" placeholder="请输入设备名称" clearable prefix-icon="Search"
                          style="margin-bottom: 20px" @change="deviceChange"/>
              </div>
              <InfiniteList
                  v-if="deviceList.length >0"
                  :data="deviceList"
                  :width="'100%'"
                  :height="'100%'"
                  :itemSize="40"
                  v-slot="{ item, index }"
              >
                <div style="cursor: pointer">
                  <el-tag @click="deviceClick(item)" style="width: 100%;" size="large"
                          :type="selectDeviceId === item.id ? 'success' : ''">
                    <svg-icon icon-class="camera" style="margin-right: 6px"/>
                    {{ item.name }}
                  </el-tag>
                </div>
              </InfiniteList>

              <el-empty v-if="deviceList.length === 0" :image-size="50" description="暂无数据"/>
            </el-tab-pane>

            <el-tab-pane label="RTSP" name="RTSP">
              <div class="head-container">
                <el-input v-model="deviceName" placeholder="请输入设备名称" clearable prefix-icon="Search"
                          style="margin-bottom: 20px" @change="deviceChange"/>
              </div>
              <InfiniteList
                  v-if="deviceList.length >0"
                  :data="deviceList"
                  :width="'100%'"
                  :height="'100%'"
                  :itemSize="40"
                  v-slot="{ item, index }"
              >
                <div style="cursor: pointer">
                  <el-tag @click="deviceClick(item)" style="width: 100%;" size="large"
                          :type="selectDeviceId === item.id ? 'success' : ''">
                    <svg-icon icon-class="camera" style="margin-right: 6px"/>
                    {{ item.name }}
                  </el-tag>
                </div>
              </InfiniteList>

              <el-empty v-if="deviceList.length === 0" :image-size="50" description="暂无数据"/>
            </el-tab-pane>

            <el-tab-pane label="ISUP" name="ISUP">
              <div class="head-container">
                <el-input v-model="deviceName" placeholder="请输入设备名称" clearable prefix-icon="Search"
                          style="margin-bottom: 20px" @change="deviceChange"/>
              </div>
              <InfiniteList
                  v-if="deviceList.length > 0"
                  :data="deviceList"
                  :width="'100%'"
                  :height="'100%'"
                  :itemSize="40"
                  v-slot="{ item, index }"
              >
                <div style="cursor: pointer">
                  <el-tag @click="deviceClick(item)" style="width: 100%;" size="large"
                          :type="selectDeviceId === item.deviceId ? 'success' : ''">
                    <svg-icon icon-class="camera" style="margin-right: 6px"/>
                    {{ item.name }}
                  </el-tag>
                </div>
              </InfiniteList>

              <el-empty v-if="deviceList.length === 0" :image-size="50" description="暂无数据"/>
            </el-tab-pane>
          </el-tabs>
        </div>

        <!--        <el-button type="primary" @click="handleButtonClick">123</el-button>-->
      </div>
      <div class="theme">
        <el-dropdown @command="(command)=>{moreClick(command)}">
          <span class="el-dropdown-link" style="display: flex; cursor: pointer;"> 主题
            <el-icon class="el-icon--right">
              <arrow-down/>
            </el-icon>
          </span>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item command="dark">幻影黑</el-dropdown-item>
              <el-dropdown-item command="darkblue">极夜蓝</el-dropdown-item>
              <el-dropdown-item command="grey">雅士灰</el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </div>
      <div id="container"></div>

    </el-card>

    <el-dialog v-model="dialogVisible" title="播放视频" width="835px" append-to-body draggable>
      <Hikvision :rtsp="rtspURL" v-if="dialogVisible"/>
    </el-dialog>

    <el-dialog v-model="dialogChannel" title="通道列表" width="835px" append-to-body draggable>
      <el-table v-loading="loading" :data="channelList" ref="channelListTable" border>
        <el-table-column prop="name" label="名称" min-width="180" align="center"/>
        <el-table-column prop="deviceId" label="编号" min-width="180" align="center"/>
        <el-table-column prop="manufacturer" label="厂家" min-width="100" align="center"/>
        <el-table-column prop="ptzType" label="云台类型" min-width="100" align="center">
          <template #default="scope">
            <div>{{ scope.row.ptzTypeText }}</div>
          </template>
        </el-table-column>
        <el-table-column label="状态" min-width="100" align="center">
          <template #default="scope">
            <div slot="reference" class="name-wrapper">
              <el-tag v-if="scope.row.status === 'ON'">在线</el-tag>
              <el-tag type="info" v-if="scope.row.status !== 'ON'">离线</el-tag>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="150" class-name="small-padding fixed-width" fixed="right">
          <template #default="scope">
            <el-button v-if="checkPermi(['wvp:play:start'])"
                       type="text" @click="start(scope.row)">播放
            </el-button>
          </template>
        </el-table-column>

      </el-table>

      <pagination
          v-show="total > 0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getDeviceChannelList"
      />
    </el-dialog>

    <el-dialog title="播放视频" v-model="openPlay" width="1000px" append-to-body draggable>
      <el-tabs v-model="activeName" type="card" :stretch="true">
        <el-tab-pane label="flv播放" name="flv">
          <el-row>
            <el-col :span="24">
              <div class="player" v-if="activeName === 'flv'">
                <Jessibuca v-if="activeName === 'flv'" ref="flv" :visible.sync="showVideoDialog"
                           :videoUrl="vUrl" :error="videoError" :message="videoError" height="100px"
                           :hasAudio="hasAudio" fluent autoplay live></Jessibuca>
              </div>
            </el-col>
          </el-row>
        </el-tab-pane>
        <el-tab-pane label="webRtc" name="webRtc">
          <RtcPlayer v-if="activeName === 'webRtc'" ref="webRTC" :visible.sync="showVideoDialog"
                     :videoUrl="rtcUrl" :error="videoError" :message="videoError" height="100px"
                     :hasAudio="hasAudio" fluent autoplay live></RtcPlayer>
        </el-tab-pane>
        <el-tab-pane label="H265" name="H265">
          <H265web v-if="activeName === 'H265'" ref="h265web" :visible.sync="showVideoDialog"
                   :videoUrl="wsUrl" :error="videoError" :message="videoError" height="100px"></H265web>
        </el-tab-pane>
      </el-tabs>
    </el-dialog>

  </div>
</template>

<script setup name="GIsMap">
import {checkPermi} from "@/utils/permission";
import {onMounted, onUnmounted} from "vue";
import AMapLoader from "@amap/amap-jsapi-loader";
import {getConfigKey} from "@/api/system/config.js";
import {listRtspDevice, rtspDeviceList} from "@/api/rtsp/RtspDevice.js";
import {queryForTree as groupQueryForTree} from "@/api/wvp/group.js";
import Hikvision from "@/components/Hikvision/index.vue";
import {deviceList as onvifDeviceList, listDevice} from "@/api/onvif/device.js";
import {listDevice as gbListDevice} from "@/api/wvp/device.js";
import {listLsupDevice} from "@/api/isup/lsupDevice.js";
import {listDeviceChannel} from "@/api/wvp/device.js";
import {queryListByCivilCode, queryListByParentId, sendDevicePush} from "@/api/wvp/channel.js";
import Jessibuca from "@/components/jessibuca/index.vue";
import RtcPlayer from "@/components/rtcPlayer/index.vue";
import H265web from "@/components/H265web/index.vue";
import {queryForTree} from "@/api/wvp/region.js";
import {start as playPush} from "@/api/wvp/push.js";
import {start as playProxy} from "@/api/wvp/proxy.js";
import InfiniteList from 'vue3-infinite-list';

const {proxy} = getCurrentInstance();

const loadingShow = ref(true);
const closeDevice = ref(true);
const activeValue = ref(true);
const deviceName = ref("");
let map = null;
let infoWindow = null;
let url3 = "https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/06/04/d1ea5a0495064a388371c7e800fdba63.png";
let url4 = "https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/06/04/56db50534274489b95cddb78f976c6d3.png";
let markers = [];
const map_key = ref();
const AMapSecurityConfig = ref();
const total = ref(0);
const RtspDeviceList = ref([]);
const onvifList = ref([]);
const gbList = ref([]);
const lsupDeviceList = ref([]);
const channelList = ref([]);
const dialogVisible = ref(false);
const dialogChannel = ref(false);
const openPlay = ref(false);
const loading = ref(false);
const rtspURL = ref("");
const deviceId = ref("");
const mode = ref("gb");
const activeName = ref('flv');
const defaultProps = {
  children: 'children',
  label: 'name',
  isLeaf: 'leaf'
};
const activeNameMode = ref('GB');
const deviceList = ref([]);
const treeData = ref([]);
const selectDeviceId = ref(null);


const channelId = ref('');
const streamInfo = ref({});
const vUrl = ref(null);
const rtcUrl = ref('');
const wsUrl = ref('');
const showVideoDialog = ref(false);
const hasAudio = ref(false);
const videoError = (e) => {
  console.log("播放器错误：" + JSON.stringify(e));
}

function moreClick(command){
  map.setMapStyle("amap://styles/" + command);
}

const deviceChange = () => {
  getList()
}

const handleClick = (tab, event) => {
  nextTick(async () => {
    deviceName.value = '';
    await getList();
  })
}


async function getList() {
  loadingShow.value = true;
  deviceList.value = [];
  if (activeNameMode.value === 'GB') {
    await getGBList();
  } else if (activeNameMode.value === 'ONVIF') {
    onvifDeviceList({
      name: deviceName.value
    }).then(res => {
      deviceList.value = res.data;
      getKey(deviceList.value);
      loadingShow.value = false;
    })
  } else if (activeNameMode.value === 'RTSP') {
    rtspDeviceList({
      name: deviceName.value
    }).then(res => {
      deviceList.value = res.data;
      getKey(deviceList.value);
      loadingShow.value = false;
    })
  } else if (activeNameMode.value === 'ISUP') {
    listLsupDevice({
      name: deviceName.value
    }).then(res => {
      deviceList.value = res.rows
      getKey(deviceList.value);
      loadingShow.value = false;
    })
  }
}

async function getTreeData() {
  const res = await queryForTree();
  let data = [
    {
      treeId: "",
      deviceId: "",
      name: "根资源组",
      isLeaf: false,
      type: 0,
      children: []
    }
  ]
  data[0].children = proxy.handleTree(res.data, "id")
  treeData.value = data;
  await getKey(deviceList.value);
  loadingShow.value = false;
}

async function getGroupQueryForTree() {
  const res = await groupQueryForTree();
  let data = [
    {
      treeId: "",
      deviceId: "",
      name: "根资源组",
      isLeaf: false,
      type: 0,
      children: []
    }
  ]
  data[0].children = proxy.handleTree(res.data, "id")
  treeData.value = data;
  await getKey(deviceList.value);
  loadingShow.value = false;
}

const groupLoadNode = async (node, resolve) => {
  if (node.level === 0) {
    return resolve([{
      treeId: "",
      deviceId: "",
      name: "根资源组",
      isLeaf: false,
      type: 0
    }]);
  } else {
    if (node.data.leaf) {
      return resolve([])
    }

    let res = await groupQueryForTree({
      query: '',
      parent: node.data.id,
      hasChannel: ''
    });
    queryParams.value.groupDeviceId = node.data.deviceId;
    const response = await queryListByParentId(queryParams.value);
    const children = response.rows.map(item => ({
      ...item,
      leaf: true,
      name: item.gbName
    }));

    let terr = [...proxy.handleTree(res.data, "id"), ...children]
    resolve(terr);
  }
}


async function onSwitch(e) {
  treeData.value = []
  if (activeValue.value) {
    await getTreeData();
  } else {
    await getGroupQueryForTree();
  }
}

const loadNode = async (node, resolve) => {
  if (node.level === 0) {
    return resolve([{
      treeId: "",
      deviceId: "",
      name: "根资源组",
      isLeaf: false,
      type: 0
    }]);
  } else if (node.data.deviceId.length <= 8) {
    if (node.data.leaf) {
      return resolve([])
    }

    let res = await queryForTree({
      query: '',
      parent: node.data.id,
      hasChannel: ''
    });

    queryParams.value.civilCode = node.data.deviceId;
    const response = await queryListByCivilCode(queryParams.value);
    const children = response.rows.map(item => ({
      ...item,
      leaf: true,
      name: item.gbName
    }));

    let terr = [...proxy.handleTree(res.data, "id"), ...children]
    resolve(terr);
  } else {
    resolve([]);
  }
};
function deviceClick(data) {
  if (!data.lat || !data.lng) return;
  let lngLat = [data.lng, data.lat];
  if (!map || !lngLat) return;
  map.setCenter(lngLat);
  let currentZoom = map.getZoom();
  map.setZoom(currentZoom + 1);
  markers.forEach(marker => {
    marker.setIcon(new AMap.Icon({
      image: url3,
      size: new AMap.Size(64, 45),
      imageSize: new AMap.Size(50, 45),
    }));
  });
  const targetMarker = markers.find(marker => {
    const pos = marker.getPosition();
    return pos.lng === Number(lngLat[0]) && pos.lat === Number(lngLat[1]);
  });

  if (targetMarker) {
    targetMarker.setIcon(new AMap.Icon({
      image: url4,
      size: new AMap.Size(64, 45),
      imageSize: new AMap.Size(50, 45),
    }));
  }
}


async function start(itemData) {
  const params = {
    deviceId: deviceId.value,
    channelId: itemData.deviceId
  }
  channelId.value = itemData.deviceId;
  const res = await sendDevicePush(params);
  streamInfo.value = res.data;
  vUrl.value = res.data.flv;
  rtcUrl.value = res.data.rtc;
  wsUrl.value = res.data.ws_flv;
  dialogChannel.value = false;
  openPlay.value = true;
}

const inGaDeMap = async (data) => {
  await getConfigKey("amap.security.key").then(response => {
    AMapSecurityConfig.value = response.msg;
  });



  await getConfigKey("amap.key").then(response => {
    map_key.value = response.msg;
  });

  AMapLoader.load({
    key: map_key.value,
    version: '2.0',
    plugins: [
      'AMap.AutoComplete',
      'AMap.PlaceSearch',
      "AMap.Geolocation",
      "AMap.Geocoder",
      "AMap.Marker",
      'AMap.ToolBar',
      'AMap.Scale',
      'AMap.HawkEye',
      'AMap.MapType',
      'AMap.Geolocation',
    ],
    AMapUI: {
      version: '1.1',
      plugins: []
    },
  }).then(async (AMap) => {
    let lng = 113.26;
    let lat = 23.13;
    if (data.size > 0 && data[0].lng && data[0].lat) {
      lng = data[0].lng;
      lat = data[0].lat;
    }
    map = new AMap.Map("container", {
      pitch: 50,
      // viewMode: "3D",
      terrain: true,
      zoom: 19,
      center: [lng, lat],
      mapStyle: 'amap://styles/light',
    })
    // var layer1 = new AMap.TileLayer.Satellite();
    var layer2 = new AMap.TileLayer.RoadNet();
    // map.add(layer1);
    map.add(layer2);
    addDeviceMarkers(AMap, data);
  }).catch((e) => {
    console.log(e);
  });
}

function openInfo(deviceInfo, position) {
  var info = [];
  info.push("<div><h4>" + deviceInfo.name + "</h4>");
  info.push("<p class='input-item'>IP：" + deviceInfo.ip + "</p>");
  info.push("<p class='input-item'>地址 :" + deviceInfo.addressMap + "</p></div></div>");

  infoWindow = new AMap.InfoWindow({
    content: info.join("")
  });

  infoWindow.open(map, position);
}

const addDeviceMarkers = (AMap, data) => {
  clearMarkers();
  data.forEach((device) => {
    if (!device.lng || !device.lat) return;
    let url1 = "https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/28/e95e1f9a3d7e4c128ca8f992e8f92ad2.png";
    let url2 = "https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/28/8dcf1e9a76c84c12a0e55b5411aedc4f.png";
    const icon = new AMap.Icon({
      image: url3,
      size: new AMap.Size(64, 45),
      imageSize: new AMap.Size(50, 45),
    });

    const marker = new AMap.Marker({
      position: [parseFloat(device.lng), parseFloat(device.lat)],
      icon: icon,
      title: device.name || "未命名设备",
      extData: device,
    });
    marker.on("click", (e) => {
      if (activeNameMode.value === "GB") {
        return getDeviceChannelList(device);
      }
      rtspURL.value = device.url;
      dialogVisible.value = true;
    });
    marker.on('mouseover', (e) => {
      const deviceInfo = e.target.getExtData();
      openInfo(deviceInfo, e.target.getPosition())
    });
    marker.on('mouseout', (e) => {
      infoWindow.close();
    });
    map.add(marker);
    markers.push(marker);
  });
}

function getDeviceChannelList(device) {
  deviceId.value = device.deviceId;
  listDeviceChannel(
      {
        pageNum: queryParams.value.pageNum,
        pageSize: queryParams.value.pageSize,
        deviceId: device.deviceId,
      }
  ).then(response => {
    channelList.value = response.rows;
    total.value = response.total;
    dialogChannel.value = true;
  })
}

const clearMarkers = () => {
  if (map && markers.length > 0) {
    map.remove(markers);
    markers = [];
  }
};

const queryParams = ref({
  pageNum: 1,
  pageSize: 1000,
});

const getGBList = () => {
  gbListDevice(queryParams.value).then(response => {
    deviceList.value = response.rows;
    total.value = response.total;
    getKey(deviceList.value);
    loadingShow.value = false;
  });
}

const getKey = async (data) => {
  await getConfigKey("amap.security.key").then(response => {
    AMapSecurityConfig.value = response.msg;
    getConfigKey("amap.key").then(response => {
      map_key.value = response.msg;
      inGaDeMap(data);
    });
  });
}

onMounted(() => {
  getList();
});

onUnmounted(() => {
  map?.destroy();
});

</script>

<style scoped lang="scss">
.app-card {
  position: relative;

  .el-switch__core .el-switch__inner .is-icon, .el-switch__core .el-switch__inner .is-text {
    color: #0f0756 !important;
  }

  .menu-box {
    position: absolute;
    top: 20px;
    left: 20px;
    z-index: 10;
    background-color: rgba(255, 255, 255, 0.8);
    padding: 5px 10px;
    border-radius: 4px;
    font-weight: bold;
  }

  .theme {
    position: absolute;
    display: flex;
    justify-content: center;
    align-items: center;
    bottom: 20px;
    right: 20px;
    z-index: 10;
    background-color: rgba(255, 255, 255, 0.8);
    padding: 5px 10px;
    border-radius: 4px;
    font-weight: bold;
  }
}

#container {
  width: 100%;
  height: 800px;
}


</style>
