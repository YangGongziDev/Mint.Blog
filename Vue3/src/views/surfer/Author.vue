<template>
  <div class="home-page">
    <a-layout :class="themeClass">
      <a-layout-content>
        <a-row :gutter="16">
          <!-- 第一列：占5份，手机端隐藏 -->
          <a-col v-if="isDesktop" class="layout-col-left" :span="5" :xs="0" :sm="0" :md="5" :lg="5">
            <div class="head-portrait">
              <img style="position: absolute;top:-15%;left:-10%;width: 120%; aspect-ratio: 1/1;" src="@/assets/surfer/author/img/HeadPortraitKuang.png" alt="" />
            </div>
            <div class="left-div left-des">
              <div class="left-des-item">
                <img src="@/assets/surfer/author/svg/location.svg" alt="" />
                China-Guangzhou
              </div>
              <div class="left-des-item">
                <img src="@/assets/surfer/author/svg/briefcase.svg" alt="" />
                Technology Ltd.
              </div>
            </div>
            <div class="left-div left-tag">
              <div class="left-tag-item">网瘾</div>
              <div class="left-tag-item">小学生</div>
              <div class="left-tag-item">动漫</div>
              <div class="left-tag-item">《三体》</div>
              <div class="left-tag-item">Coding</div>
              <div class="left-tag-item">旅者</div>
              <div class="left-tag-item">骑行</div>
            </div>
            <div class="left-div left-time">
              <ul class="left-time-line">
                <li>
                  <div className="focus"></div>
                  <div>
                    <a className="link-text" href="#">Mint.Blog-V2<br/>：使用.Net+Vue3构建的博客网站2.0版本上线,同时v1版本并入v2仓库分支</a>
                  </div>
                  <div>：2026.6</div>
                </li>
                <li>
                  <div className="focus"></div>
                  <div>
                    <a className="link-text" href="#">MintAuthor<br/>：基于Vue3的程序员在线简历上线开源</a>
                  </div>
                  <div>：2024.12</div>
                </li>
                <li>
                  <div className="focus"></div>
                  <div>
                    <a className="link-text" href="#">加入广州XXX集团工业自动化领域<br/>：负责某新能源客户软件代码编写</a>
                  </div>
                  <div>：2023.6</div>
                </li>
                <li>
                  <div className="focus"></div>
                  <div>
                    <a className="link-text" href="#">捡起了碎的一地的IT知识</a>
                  </div>
                  <div>：2023.2</div>
                </li>
                <li>
                  <div className="focus"></div>
                  <div>
                    <a className="link-text" href="#">离职出来后洗心革面,决定专心学习巩固专业技能</a>
                  </div>
                  <div>：2022.6</div>
                </li>
                <li>
                  <div className="focus"></div>
                  <div>
                    <a className="link-text" href="#">MintBlog-V1<br/>使用Java8+Vue3构建的博客网站1.0版本上线</a>
                  </div>
                  <div>：2021.9</div>
                </li>
                <li>
                  <div className="focus"></div>
                  <div>
                    <a className="link-text" href="#">加入贵阳XX科技集团<br/>：负责某省东\南部某项业务的售后和运营</a>
                  </div>
                  <div>：2020.12</div>
                </li>
              </ul>
            </div>
          </a-col>
          <!-- 第二列：占19份，手机和电脑端都显示 -->
          <a-col class="layout-col-right" :span="19" :xs="24" :sm="24" :md="19" :lg="19">
            <a-modal v-model:open="showModal" centered :footer="null" closeIcon="" title="" width="50">
              <img :src="popPicture" alt="" style="max-width: 200px;max-height: 350px;margin: 20px" />
            </a-modal>
            <div v-if="!isDesktop" class="index-head-portrait">
              <img style="position: absolute;top:-15%;left:-10%;width: 120%; aspect-ratio: 1/1;" src="@/assets/surfer/author/img/HeadPortraitKuang.png" alt="">
            </div>
            <div class="welcome">
              Hello&nbsp;I'&nbsp;m
              <span class="gradientText">程序员-杨工子</span>
              <h6>练习编程两年半、喜欢CV、Tab、Agent 。</h6>
            </div>
            <div class="description">
              👦
              <span class="purpleText">C#.Net</span>&nbsp;
              B/S&nbsp;
              <span class="purpleText">Full Stack</span>&nbsp;
              Developer
            </div>
            <div class="description">
              📝 The only way to achieve greatness is to
              <span class="purpleText textBackground">love</span>
              and
              <span class="purpleText textBackground">persevere</span> in what you do.
            </div>
            <div class="iconContainer">
              <a-popover title="" trigger="click">
                <template #content>
                  <a-button link type="link" href="https://gitee.com/YangMufan">Gitee</a-button><br>
                  <a-button link type="link" href="https://github.com/YangMufan">Github</a-button>
                </template>
                <div class="iconItem">
                  <img src="@/assets/surfer/author/svg/github.svg" alt="">
                  <div class="iconTip">Git</div>
                </div>
              </a-popover>
              <a-popover title="网易邮箱" trigger="click">
                <template #content>
                  <a-button link type="link" href="https://mail.163.com">yangmufa@163.com</a-button>
                </template>
                <div class="iconItem">
                  <img src="@/assets/surfer/author/svg/mail.svg" alt="">
                  <div class="iconTip">Mail</div>
                </div>
              </a-popover>
              <a class="iconItem" @click="showModalHandle('sponsor')" href="javascript:void(0)">
                <img src="@/assets/surfer/author/svg/sponsor.svg" alt="">
                <div class="iconTip">赞助</div>
              </a>
              <a class="iconItem" @click="showModalHandle('qq')" href="javascript:void(0)">
                <img src="@/assets/surfer/author/svg/qq.svg" alt="">
                <div class="iconTip">QQ</div>
              </a>
              <a class="iconItem" @click="showModalHandle('weixin')" href="javascript:void(0)">
                <img src="@/assets/surfer/author/svg/weixin.svg" alt="">
                <div class="iconTip">微信</div>
              </a>
            </div>
            <div class="tanChiShe">
              <img :src="themeIcon" alt="">
            </div>
            <div class="title">
              <img src="@/assets/surfer/author/svg/site.svg" alt="">
              Site
            </div>
            <div class="projectList">
              <a v-for="(siteData,index) in site" :key="index" class="projectItem a" target="_blank" :href="siteData.link" >
                <div class="projectItemLeft">
                  <h1>{{siteData.title}}</h1>
                  <p>{{siteData.introduce}}</p>
                </div>
                <div class="projectItemRight">
                  <img :src="siteData.img.toString()" alt="">
                </div>
              </a>
            </div>
            <div class="title">
              <img src="@/assets/surfer/author/svg/project.svg" alt="">
              Project
            </div>
            <div class="projectList">
              <a v-for="(projectData,index) in project" :key="index" class="projectItem b" target="_blank" :href="projectData.link" >
                <div class="projectItemLeft">
                  <h1>{{projectData.title}}</h1>
                  <p>{{projectData.introduce}}</p>
                </div>
                <div class="projectItemRight">
                  <img :src="projectData.img.toString()" alt="">
                </div>
              </a>
            </div>
            <div class="title">
              <img src="@/assets/surfer/author/svg/skills.svg" alt="">
              Skills
            </div>
            <div class="skill">
              <img class="skillPcImg" src="@/assets/surfer/author/svg/skillPc.svg" alt="" srcset="">
              <img class="skillWapImg" src="@/assets/surfer/author/svg/skillWap.svg" alt="" srcset="">
            </div>
          </a-col>
        </a-row>
      </a-layout-content>
    </a-layout>
  </div>
</template>

<script setup lang="ts">

import {computed, onBeforeUnmount, onMounted, ref} from "vue";
import snakeLightSvg from '@/assets/surfer/author/svg/snake-Light.svg';
import siteProjectIcon1 from '@/assets/surfer/author/img/i1.png';
import siteProjectIcon2 from '@/assets/surfer/author/img/i2.png';
import siteProjectIcon3 from '@/assets/surfer/author/img/i3.png';
import siteProjectIcon4 from '@/assets/surfer/author/img/i4.png';
import siteProjectIcon5 from '@/assets/surfer/author/img/i5.png';
import siteProjectIcon6 from '@/assets/surfer/author/img/i6.png';
import qqImg from '@/assets/surfer/author/img/QQGroup.jpg';
import weixinImg from '@/assets/surfer/author/img/WeixinGroup.jpg';
import sponsorImg from '@/assets/surfer/author/img/WeixinSponsor.jpg';
import {useTheme,} from "@/composables/useTheme";

const isDesktop = ref(false); // 默认不是桌面端
const isDarkMode = ref(false); // 控制是否是暗黑模式
const themeIcon = ref(snakeLightSvg); // 主题图标
const showModal = ref<boolean>(false); //qq弹框
const popPicture = ref(""); //弹框图片

// 使用统一的主题管理
const { isDark, darkSwitch, toggleDark } = useTheme();

// 网站
const site = ref([
  { title: "MintBlogV2", introduce: "基于.Net10+Vue3程序员菜鲲的个人博客", img: siteProjectIcon1, link: "https://www.yangmufa.cn" },
  { title: "MintJilehe", introduce: "基于JavaScript的鸡乐盒演示站", img: siteProjectIcon5, link: "https://jilehe.yangmufa.cn" },
  { title: "MintAuthor(本页)", introduce: "基于Vue3的程序员在线简历演示站", img: siteProjectIcon6, link: "#" },
]);
// 项目
const project = ref([
  { title: "MintBlogV2", img: siteProjectIcon4, link: "https://github.com/YangMufa/Mint.Blog",introduce: "基于.Net10+PostgreSql18+Vue3的博客项目, 内置后台管理、权限管理、代码生成、资源导航、技术百科等模块",  },
  { title: "MintAuthor", img: siteProjectIcon3, link: "https://github.com/YangMufa/MintAuthor",introduce: "炫酷唯美的 程序员专属 个人简介,采用TypeScript5 + Vite6 + Axios2 + Vue3 + NextJs15 + AntDesign5 + SCSS2",  },
  { title: "MintJilehe", img: siteProjectIcon2, link: "https://github.com/YangMufa/MintJilehe",introduce: "唱、跳、rap、篮球,基于JavaScript + HTML5 + CSS3",  },
]);

// 监听主题设定的值如果发生变化则动态设定对应的class
let themeClass = computed(() => {
  // return  isDarkMode.value ? "dark" : "light";
  return  darkSwitch.value ? "dark" : "light";
});


// 点击qq或打赏图标的回调
const showModalHandle = (img:string) => {
  if (img == "qq") {
    popPicture.value = qqImg;
  }
  if (img == "weixin") {
    popPicture.value = weixinImg;
  }
  if (img == "sponsor") {
    popPicture.value = sponsorImg;
  }
  showModal.value = true;
};

// 检查窗口是否大于992,并设定到isDesktop
const checkIfDesktop = () => {
  // 992px 作为桌面端的标准
  isDesktop.value = window.innerWidth >= 992;
}

onMounted(() => {
  // 页面加载时检测屏幕尺寸
  checkIfDesktop();
  // 监听窗口变化
  window.addEventListener('resize', checkIfDesktop);
  // 第一次加载或刷新后重新从localStore获取黑/白天设定
  isDarkMode.value = localStorage.getItem('theme') === 'dark';
});

onBeforeUnmount(() => {
  // 移除事件监听
  window.removeEventListener('resize', checkIfDesktop);
})

</script>

<style scoped lang="scss">
@font-face {
  font-family: "a";
  /*中文字体*/
  src: url(@/assets/surfer/author/fonts/Ubuntu-Regular.ttf);
  font-display: swap;
}
@font-face {
  font-family: "b";
  src: url(@/assets/surfer/author/fonts/Ubuntu-Regular.ttf);
  font-display: swap;
}
@font-face {
  font-family: "title";
  /*英文字体*/
  src: url(@/assets/surfer/author/fonts/Pacifico-Regular.ttf);
  font-display: swap;
}

/* 默认白天模式 */
.light {
  background-color: rgba(255, 255, 255, 0.1);
  color: #fff;
}
/* 黑夜模式 */
.dark {
  background-color: rgba(0, 0, 0, 0.7) !important;
}

.home-page {
  width: 100%;
  height: 100%;
  background-image: url("@/assets/surfer/Background.jpg");
  background-size: cover;
  background-position: center;
  :deep(.ant-layout) {
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    background-color: rgb(0, 0, 0,0.2);
    background-blend-mode: multiply;//背景混合模式
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(5px);
    .ant-layout-content{
      width: 100%;
      height: 95%;
      padding: 0 15%;
      .ant-row{
        height: 100%;
        .layout-col-left {
          margin:0%;
          height: 100%;
          overflow-y: scroll;
          display: flex;
          padding: 0 15px;
          // 左边不会因为右边撑开父元素而一同滚动
          position: sticky;
          top: 0;
          left: 0;
          align-items: center;
          flex-direction: column;
          color: white;
          .head-portrait {
            flex-shrink: 0;
            width: 80%;
            position: relative;
            aspect-ratio: 1/1;
            margin-top: 50px;
            background-size: cover;
            border-radius: 50%;
            background-image: url('@/assets/surfer/author/img/HeadPortrait.jpg');
          }
          .left-div {
            flex-shrink: 0;
            width: 100%;
            border-radius: 13px;
            margin-top: 15px;
            padding: 20px;
            background-color: rgb(0, 0, 0,0.3);
          }
          .left-des {
            display: flex;
            flex-direction: column;
            justify-content: center;
            .left-des-item {
              display: flex;
              align-items: center;
              line-height: 20px;
              font-size: 15px;
              margin-bottom: 5px;
              overflow: hidden;
              img{
                width: 26px;
                height: 26px;
                fill:var(--fill);
                font-size: 18px;
                margin-right: 10px;
              }
            }
          }
          .left-tag {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            padding: 14px;
            .left-tag-item {
              display: flex;
              justify-content: center;
              align-items: center;
              height: 28px;
              margin: 0px 5px 5px 0;
              padding: 10px;
              font-size: 13px;
              border-radius: 111px;
              background: rgb(27 42 57 / 20%);
            }
          }
          .left-time {
            .left-time-line {
              width: 100%;
              //height: 200px;
              max-height: 270px;
              font-size: 13px;
              padding-left: 8px;
              scroll-snap-type: y mandatory;
              overflow-y: scroll;
              li {
                list-style: none;
                position: relative;
                padding: 15px 0px 0px 15px;
                border-left: 2px solid #d5d5d5;
                border-radius: 0;
                scroll-snap-align: end;
                color: #ffffff;
                .focus {
                  width: 8px;
                  height: 8px;
                  border-radius: 22px;
                  background-color: rgb(255 255 255);
                  border: 2px solid #fff;
                  position: absolute;
                  left: -5px;
                  top: 50%;
                }
                .link-text {
                  word-wrap: break-word; /* 让长单词在容器边界处换行 */
                  word-break: break-word; /* 支持国际化文本换行 */
                  overflow-wrap: break-word; /* 标准化的写法 */
                  white-space: normal; /* 允许文字换行 */
                }
              }
              //第一个 li 子元素的第一个 .focus 子元素。
              li:first-child {
                .focus:first-child {
                  background-color: #aaffcd;
                  animation: focus 1.8s ease infinite;
                }
              }
            }
            //选中 left-time-line 元素的滚动条，并将其隐藏
            .left-time-line::-webkit-scrollbar {
              display: none;
            }
          }
        }
        //滚动条设置为不显示
        .layout-col-left::-webkit-scrollbar {
          display: none;
        }
        .layout-col-right {
          height: 100%;
          padding: 40px 0px;
          display: flex;
          flex-direction: column;
          overflow-y: scroll;
          color: white;
          .index-head-portrait {
            flex-shrink: 0;
            width: 40%;
            margin-top: 40px;
            position: relative;
            max-width: 200px;
            aspect-ratio: 1/1;
            background-size: cover;
            border-radius: 50%;
            border: 0.5px solid #ffffff;
            background-image: url('@/assets/surfer/author/img/HeadPortrait.jpg');
          }
          .welcome {
            font-size: 60px;
            font-weight: 500;
            margin: 20px 0;
            position: relative;
            .gradientText {
              //允许背景图像或背景颜色只在文本区域内显示，而不是在整个元素的背景中显示
              -webkit-background-clip: text;
              //引入自定义字体名称
              font-family: "title";
              -webkit-text-fill-color: transparent;
              background-size: 200%;
              background-position: 0%;
              animation: backgroundSizeAnimation 10s ease-in-out infinite;
              //设置背景图像渐变
              background-image: linear-gradient(120deg, rgb(133, 62, 255), #f76cc6 30%, rgb(255, 255, 255) 60%);
            }
            h6{
              margin: 0;
              position: relative;
              left: 0;
              right: 0;
              transform: scaleY(1); /* 垂直翻转文本 */
              opacity: 0.5; /* 调整透明度以模拟水中倒影效果 */
              filter: blur(2px); /* 添加模糊效果 */
            }
          }
          .description {
            font-size: 20px;
            margin-top: 7px;
            .purpleText {
              color: #747bff;
              font-weight: 800;
            }
            .textBackground {
              font-weight: 800;
              background: rgb(19, 20, 24,0.2);
              border-radius: 5px;
              font-size: 17px;
              margin: 0 3px;
              padding: 2px 4px;
            }
          }
          .iconContainer {
            width: 100%;
            height: auto;
            display: flex;
            align-items: center;
            margin-top: 40px;
            flex-wrap: wrap;
            justify-content: start;
            .iconItem {
              width: 49px;
              height: 43px;
              box-sizing: border-box;
              border-radius: 7px;
              display: flex;
              margin-left: 16px;
              margin-bottom: 5px;
              backdrop-filter: blur(var(0px));
              background: rgba(249, 250, 251, 0.2);
              align-items: center;
              justify-content: center;
              transition: width 0.3s ease, opacity 0.3s ease, transform 0.3s ease;
              flex-shrink: 0;
              cursor: pointer;
              img {
                width: 29px;
                height: 29px;
                fill:#ffffff;;
                font-size: 22px;
                margin-right: 3px;
              }
              .iconTip {
                white-space: nowrap;
                display: none;
              }
            }
            .iconItem:hover {
              width: 85px;
              transform: translateY(-2px);
              background: rgba(249, 250, 251, 0.2);
            }
            .iconItem:hover .iconTip {
              display: block;
            }
            .switch {
              width: 49px;
              height: 43px;
              box-sizing: border-box;
              border-radius: 7px;
              display: flex;
              margin-left: 16px;
              margin-bottom: 5px;
              backdrop-filter: blur(var(0px));
              background: rgba(249, 250, 251, 0.2);
              align-items: center;
              justify-content: center;
              transition: width 0.3s ease, opacity 0.3s ease, transform 0.3s ease;
              flex-shrink: 0;
              cursor: pointer;
              .ant-switch-checked {
                display: flex;
                align-items: center;
                .ant-switch-inner {
                  text-align: center;
                }
              }
            }
            .switch:hover {
              width: 55px;
              background: rgba(249, 250, 251, 0.2);
            }
          }
          .iconContainer::-webkit-scrollbar {
            display: none;
          }
          .tanChiShe {
            width: 99%;
            img {
              width: 100%;
              height: 100%;
              object-fit: cover;
            }
          }

          .title {
            display: flex;
            align-items: center;
            font-size: 26px;
            font-weight: 800;
            margin: 20px 0;
            transition: transform 0.4s ease;
            img {
              margin-right: 8px;
              height: 26px;
              width: 26px;
              fill: #ffffff;
            }
          }
          .title:hover {
            transform: translateY(-5px);
          }
          .projectList {
            width: 100%;
            height: auto;
            display: flex; // 启用 Flexbox 布局
            flex-wrap: wrap;
            //justify-content: start;
            //justify-content: space-between;
            .child {
              flex: 1; // 每个子元素平分父元素的宽度
            }
            .projectItem {
              width: calc(25% - 5px);
              margin: 5px 5px;
              border-radius: 8px;
              padding: 15px;
              display: flex;
              background-color: rgba(249, 250, 251, 0.22);
              backdrop-filter: blur(0px);-webkit-backdrop-filter: blur(0px);
              transition: opacity 0.5s ease, background-color 0.2s ease, border 0.2s ease, transform 0.3s ease;
              .projectItemLeft {
                transition: width 0.4s ease;
                width: 80%;
                p {
                  font-size: 12px;
                  margin-top: 15px;
                  color: rgb(228, 228, 228);
                  word-wrap: break-word; /* 让长单词在容器边界处换行 */
                  word-break: break-word; /* 支持国际化文本换行 */
                  overflow-wrap: break-word; /* 标准化的写法 */
                  white-space: normal; /* 允许文字换行 */
                }
                h1 {
                  font-weight: normal;
                  font-size: 16px;
                  margin: 0px;

                  transition: font-size 0.4s ease;
                  color: rgb(255, 255, 255);
                }
              }
              .projectItemRight {
                overflow: hidden;
                transition: width 0.4s ease;
                display: flex;
                justify-content: center;
                align-items: center;
                width: 20%;
                img {
                  height: 39px;
                  width: 39px;
                }
              }
            }
            .projectItem.pressed {
              transform: scale(0.9);
              /* 缩小到原来的0.9倍 */
              background-color: rgb(19, 23, 27);
            }
            .projectItem:hover {
              box-shadow: 0 8px 16px -4px #2c2d300c;
              transform: translateY(-2px);
              .projectItemLeft {
                width: 100%;
              }
              .projectItemRight {
                width: 0%;
                img {
                  transform: rotate(40deg);
                }
              }
              h1 {
                font-size: 18px;
              }
            }
          }
          .skill {
            padding: 5px 5px 5px 5px;
            width: 100%;
            .skillPcImg {
              width: 100%;
              display: block !important;
            }
            .skillWapImg {
              display: none !important;
            }
          }
        }
      }
    }
  }
}

@media (max-width: 991px) {
  :deep(.ant-layout) {
    .ant-layout-content{
      padding: 0 5% !important;
      .ant-row{
        height: 100%;
        .layout-col-left {
          .head-portrait {
          }
          .left-div {
          }
          .left-des {
            .left-des-item {
              img{
              }
            }
          }
          .left-tag {
            .left-tag-item {
            }
          }
          .left-time {
            .left-time-line {
              li {
                .focus {
                }
              }
              //第一个 li 子元素的第一个 .focus 子元素。
              li:first-child {
                .focus:first-child {
                  background-color: #aaffcd;
                  animation: focus 1.8s ease infinite;
                }
              }
            }
            //选中 left-time-line 元素的滚动条，并将其隐藏
            .left-time-line::-webkit-scrollbar {
              display: none;
            }
          }
        }
        //滚动条设置为不显示
        .layout-col-left::-webkit-scrollbar {
        }
        .layout-col-right {
          padding: 20px 0px !important;
          .index-head-portrait {
          }
          .welcome {
            font-size: 45px !important;
            font-weight: 500;
            .gradientText {
            }
            h6{
            }
          }
          .description {
            font-size: 18px !important;
            .purpleText {
              font-weight: 500;
            }
            .textBackground {
              font-weight: 500;
              border-radius: 5px;
              font-size: 17px;
              margin: 0 3px;
              padding: 2px 4px;
            }
          }
          .iconContainer {
            margin-top: 64px !important;
            .iconItem {
              margin-left: 16px;
              img {
                width: 22px;
                height: 22px;
                fill:#ffffff;;
                font-size: 22px;
                margin-right: 3px;
              }
              .iconTip {
              }
            }
            .iconItem:hover {
            }
            .iconItem:hover .iconTip {
            }
            .switch {
              margin-left: 16px !important;
            }
            .switch:hover {
            }
          }
          .iconContainer::-webkit-scrollbar {
          }
          .tanChiShe {
            img {
            }
          }

          .title {
            font-size: 20px !important;
            font-weight: 600 !important;
            margin: 15px 0 !important;
            img {
            }
          }
          .title:hover {
          }
          .projectList {
            //display: flex;
            //flex-wrap: wrap;
            //align-items: center;
            //justify-content: center;
            .projectItem {
              width: calc(46.5% - 0px) !important;
              padding: 10px !important;
              .projectItemLeft {

                h1 {
                  font-size: 14px !important;
                }
                p {
                  margin: 5px 0px !important;
                  font-size: 11px !important;
                }
              }
              .projectItemRight {
                img {
                  height: 29px !important;
                  width: 29px !important;
                }
              }
            }
            .projectItem.pressed {
            }
            .projectItem:hover {
              .projectItemLeft {
                width: 100%;
              }
              .projectItemRight {
                width: 0%;
                img {
                }
              }
              h1 {
                font-size: 18px;
              }
            }
          }
          .skill {
            .skillPcImg {
              display: none !important;
            }
            .skillWapImg {
              display: block !important;
              width: 100%;
            }
          }
        }
      }
    }
  }
}

a:hover,
a:link,
a:visited,
a:active,
a:focus {
  text-decoration: none;
  outline: none;
  border: none;
  color: inherit;
  -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
}


/* 设置滚动条样式 */
::-webkit-scrollbar {
  width: 0px;
}
::-webkit-scrollbar-thumb {
  background-color: var(--main_text_color, #000000);
  border-radius: 8px;
  height: 20%;
}
::-webkit-scrollbar-track {
  background-color: var(--main_bg_color, linear-gradient(50deg, #a2d0ff, #ffffff));
}



</style>