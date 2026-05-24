<template>
    <header class="theme-bg-tertiary theme-text-primary w-full sticky top-0 z-50 backdrop-blur-md transition-all duration-300 shadow-sm">
        <nav class="w-full">
            <div
                class="w-full flex items-center justify-between px-4 md:px-6 lg:px-8 gap-3 md:gap-8 mx-auto relative"
                :class="isDesktop ? 'h-20' : 'h-16'"
            >
                <!-- LOGO -->
                <router-link to="/surfer/home" class="flex shrink-0 items-center group transition-transform duration-200 hover:scale-105">
                    <div class="relative flex shrink-0 items-center p-0 bg-gradient-to-br from-blue-600 to-purple-600 rounded-xl shadow-lg group-hover:shadow-xl transition-all duration-300">
                        <img
                            :src="logoUrl"
                            @error="handleLogoError"
                            class="block h-10 w-auto max-w-[140px] object-contain md:h-12 md:max-w-[180px]"
                            alt="MintBlog"
                        />
                    </div>
                    <span v-if="false" class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white ml-4">
                        {{ blogSettingsStore.blogSettings?.name || "" }}
                    </span>
                </router-link>

                <!-- 移动端菜单 -->
                <template v-if="deviceType === 'isMobile'">
                    <div v-if="mobileMenuVisible" class="fixed inset-0 top-16 bg-black/30 z-30" @click="mobileMenuVisible = false"></div>
                    <div
                        v-show="mobileMenuVisible"
                        class="absolute left-0 right-0 top-16 z-40 px-4 pt-2 pb-4 theme-bg-tertiary border-t theme-border shadow-lg max-h-[calc(100vh-4rem)] overflow-y-auto"
                        id="navbar-search"
                    >
                    <ul class="flex flex-col w-full mt-3 p-3 !mb-0 font-medium border theme-border rounded-xl theme-bg-tertiary shadow-lg">
                            <li class="">
                                <a @click="handleMenuClick('/surfer/home')" :class="[
                                    currPath == '/surfer/home'
                                        ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                        : 'theme-text-secondary border-b-4 border-transparent',
                                ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40"
                                    aria-current="page">
                                    <span class="relative z-10">首页</span>
                                    <div v-if="currPath == '/surfer/home'"
                                        class="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-transparent rounded-lg animate-pulse">
                                    </div>
                                </a>
                            </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/category/list')" :class="[
                                currPath.startsWith('/surfer/category')
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">技术</span>
                            </a>
                        </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/tag/list')" :class="[
                                currPath.startsWith('/surfer/tag')
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">场景</span>
                            </a>
                        </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/archive/list')" :class="[
                                currPath.startsWith('/surfer/archive')
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">归档</span>
                            </a>
                        </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/wiki/list')" :class="[
                                currPath.startsWith('/surfer/wiki')
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">专栏</span>
                            </a>
                        </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/resource')" :class="[
                                currPath == '/surfer/resource'
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">资源</span>
                            </a>
                        </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/tools')" :class="[
                                currPath == '/surfer/tools'
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">工具</span>
                            </a>
                        </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/friend')" :class="[
                                currPath == '/surfer/friend'
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">友链</span>
                            </a>
                        </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/author')" :class="[
                                isAboutActive
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">关于</span>
                            </a>
                        </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/moments')" :class="[
                                currPath == '/surfer/moments'
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">说说</span>
                            </a>
                        </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/equipment')" :class="[
                                currPath == '/surfer/equipment'
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">设备</span>
                            </a>
                        </li>
                        <li class="">
                            <a @click="handleMenuClick('/surfer/gallery')" :class="[
                                currPath == '/surfer/gallery'
                                    ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                    : 'theme-text-secondary border-b-4 border-transparent',
                            ]" class="menu-item relative block py-3 px-4 rounded-lg hover:theme-bg-tertiary/80 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                <span class="relative z-10">墙纸</span>
                            </a>
                        </li>
                    </ul>
                </div>
                </template>

                <!-- PC端菜单 -->
                <template v-else>
                    <div class="flex items-center justify-center flex-1 min-w-0 overflow-visible" id="navbar-search">
                        <ul class="flex items-center gap-2 !mb-0 font-medium flex-wrap overflow-visible">
                            <li class="">
                                <a @click="handleMenuClick('/surfer/home')" :class="[
                                    currPath == '/surfer/home'
                                        ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                        : 'theme-text-secondary border-b-4 border-transparent',
                                ]" class="menu-item relative block py-1 px-4 rounded-lg md:rounded-xl hover:theme-bg-tertiary/80 md:hover:bg-blue-50/50 md:dark:hover:bg-blue-900/20 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                    <span class="relative z-10">首页</span>
                                    <div v-if="currPath == '/surfer/home'"
                                        class="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-transparent rounded-lg animate-pulse"></div>
                                </a>
                            </li>

                            <li class="relative category-dropdown-container">
                                <a @click="toggleCategoryDropdown" :class="[
                                    currPath.startsWith('/surfer/category')
                                        ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                        : 'theme-text-secondary border-b-4 border-transparent',
                                ]" class="menu-item relative flex items-center justify-between py-1 px-4 rounded-lg md:rounded-xl hover:theme-bg-tertiary/80 md:hover:bg-blue-50/50 md:dark:hover:bg-blue-900/20 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                    <span class="relative z-10">技术</span>
                                    <DownOutlined :class="[
                                        'ml-1 text-xs transition-transform duration-200',
                                        { 'rotate-180': categoryDropdownVisible },
                                    ]" />
                                    <div v-if="currPath.startsWith('/surfer/category')"
                                        class="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-transparent rounded-lg animate-pulse"></div>
                                </a>
                                <div v-if="categoryDropdownVisible"
                                    class="theme-bg-tertiary theme-text-primary category-dropdown absolute top-full left-0 mt-2 w-64 rounded-xl shadow-lg z-50 max-h-80 overflow-y-auto">
                                    <div class="p-2">
                                        <a @click="handleMenuClick('/surfer/category/list'); hideCategoryDropdown();" class="hover:bg-gray-400 flex items-center px-3 py-2 text-sm theme-text-secondary hover:theme-bg-tertiary theme-text-primary rounded-lg transition-colors duration-200">
                                            <span>所有技术栈</span>
                                        </a>
                                    </div>
                                    <div class="border-t border-gray-200 dark:border-gray-700"></div>
                                    <div class="p-2">
                                        <div v-if="categories.length === 0" class="px-3 py-2 text-sm theme-text-tertiary">暂无数据</div>
                                        <a v-for="category in categories" :key="category.id" @click="goCategoryArticleListPage(category.id, category.name)"
                                        class="flex items-center justify-between hover:bg-gray-400 px-1 py-2 text-sm theme-text-primary rounded-lg transition-colors duration-200 cursor-pointer">
                                            <span>{{ category.name }}</span>
                                            <span class="text-xs theme-text-tertiary">({{category.articlesTotal }})</span>
                                        </a>
                                    </div>
                                </div>
                            </li>

                            <li class="relative tag-dropdown-container">
                                <a @click="toggleTagDropdown" :class="[
                                    currPath.startsWith('/surfer/tag')
                                        ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                        : 'theme-text-secondary border-b-4 border-transparent',
                                ]" class="menu-item relative flex items-center justify-between py-1 px-4 rounded-lg md:rounded-xl hover:theme-bg-tertiary/80 md:hover:bg-blue-50/50 md:dark:hover:bg-blue-900/20 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                    <span class="relative z-10">场景</span>
                                    <DownOutlined :class="['ml-1 text-xs transition-transform duration-200',{ 'rotate-180': tagDropdownVisible },]" />
                                    <div v-if="currPath.startsWith('/surfer/tag')" class="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-transparent rounded-lg animate-pulse"></div>
                                </a>
                                <div v-if="tagDropdownVisible"
                                    class="theme-bg-tertiary theme-text-primary tag-dropdown absolute top-full left-0 mt-2 w-64 rounded-xl shadow-lg z-50 max-h-80 overflow-y-auto">
                                    <div class="p-2">
                                        <a @click="handleTagMenuClick" class="hover:bg-gray-400 flex items-center px-3 py-2 text-sm theme-text-secondary hover:theme-bg-tertiary theme-text-primary rounded-lg transition-colors duration-200">
                                            <span>查看所有场景</span>
                                        </a>
                                    </div>
                                    <div class="border-t border-gray-200 dark:border-gray-700"></div>
                                    <div class="p-2">
                                        <div v-if="tags.length === 0" class="px-3 py-2 text-sm theme-text-tertiary">暂无场景</div>
                                        <a v-for="tag in tags" :key="tag.id" @click="goTagArticleListPage(tag.id, tag.name)"
                                        class="flex items-center justify-between hover:bg-gray-400 px-1 py-2 text-sm theme-text-secondary hover:theme-bg-tertiary theme-text-primary rounded-lg transition-colors duration-200 cursor-pointer">
                                            <span>{{ tag.name }}</span>
                                            <span class="text-xs theme-text-tertiary">({{tag.articlesTotal}})</span>
                                        </a>
                                    </div>
                                </div>
                            </li>

                            <li class="relative archive-dropdown-container">
                                <a @click="toggleArchiveDropdown" :class="[
                                    currPath.startsWith('/surfer/archive')
                                        ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                        : 'theme-text-secondary border-b-4 border-transparent',
                                ]" class="menu-item relative flex items-center justify-between py-1 px-4 rounded-lg md:rounded-xl hover:theme-bg-tertiary/80 md:hover:bg-blue-50/50 md:dark:hover:bg-blue-900/20 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                    <span class="relative z-10">归档</span>
                                    <DownOutlined :class="[
                                        'ml-1 text-xs transition-transform duration-200',
                                        { 'rotate-180': archiveDropdownVisible },
                                    ]" />
                                    <div v-if="currPath.startsWith('/surfer/archive')" class="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-transparent rounded-lg animate-pulse"></div>
                                </a>
                                <div v-if="archiveDropdownVisible"
                                    class="theme-bg-tertiary theme-text-primary archive-dropdown absolute top-full left-0 mt-2 w-[352px] rounded-xl shadow-lg z-50 max-h-96 overflow-y-auto">
                                    <div class="p-2">
                                        <a @click="viewAllArchives();" class="hover:bg-gray-400 flex items-center px-1 py-2 text-sm theme-text-secondary hover:theme-bg-tertiary theme-text-primary rounded-lg transition-colors duration-200">
                                            <span>查看所有归档</span>
                                        </a>
                                    </div>
                                    <div class="border-t border-gray-200 dark:border-gray-700"></div>
                                    <div class="p-2">
                                        <div class="text-xs theme-text-tertiary mb-1">按年份</div>
                                        <div class="flex gap-2 flex-wrap">
                                            <button v-for="year in archiveYears" :key="year" @click="selectArchiveYear(year)" :class="[
                                                'px-2 py-1 rounded-md text-xs border transition-colors',
                                                year === archiveSelectedYear ? 'bg-blue-90 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 border-blue-300' : 'theme-border theme-text-secondary hover:theme-bg-tertiary'
                                            ]">
                                                {{ year }}
                                            </button>
                                        </div>
                                    </div>
                                    <div class="p-2">
                                        <div class="text-xs theme-text-tertiary mb-1">按月份</div>
                                        <div class="grid grid-cols-4 gap-2">
                                            <button v-for="m in archiveMonths" :key="m.value" @click="goArchiveMonth(archiveSelectedYear, m.value)" class="px-2 py-1 rounded-md text-xs theme-text-secondary border theme-border hover:theme-bg-tertiary transition-colors">
                                                {{ m.label }}
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </li>

                            <li class="relative wiki-dropdown-container">
                                <a @click="toggleWikiDropdown" :class="[
                                    currPath.startsWith('/surfer/wiki')
                                        ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                        : 'theme-text-secondary border-b-4 border-transparent',
                                ]" class="menu-item relative flex items-center justify-between py-1 px-4 rounded-lg md:rounded-xl hover:theme-bg-tertiary/80 md:hover:bg-blue-50/50 md:dark:hover:bg-blue-900/20 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                    <span class="relative z-10">专栏</span>
                                    <DownOutlined :class="['ml-1 text-xs transition-transform duration-200',{ 'rotate-180': wikiDropdownVisible },]" />
                                    <div v-if="currPath.startsWith('/surfer/wiki')" class="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-transparent rounded-lg animate-pulse"></div>
                                </a>
                                <div v-if="wikiDropdownVisible" class="theme-bg-tertiary theme-text-primary wiki-dropdown absolute top-full left-0 mt-2 w-64 rounded-xl shadow-lg z-50 max-h-80 overflow-y-auto">
                                    <div class="p-2">
                                        <a @click="handleMenuClick('/surfer/wiki/list');hideWikiDropdown();" class="hover:bg-gray-400 flex items-center px-1 py-2 text-sm theme-text-secondary hover:theme-bg-tertiary theme-text-primary rounded-lg transition-colors duration-200">
                                            <span>查看所有专栏</span>
                                        </a>
                                    </div>
                                    <div class="border-t border-gray-200 dark:border-gray-500"></div>
                                    <div class="p-2">
                                        <div v-if="wikis.length === 0" class="px-3 py-2 text-sm theme-text-tertiary">暂无专栏</div>
                                        <a v-for="wiki in wikis" :key="wiki.id" @click="goWikiArticleDetailPage(wiki.id, wiki.firstArticleId)" class="flex items-center justify-between hover:bg-gray-400 px-3 py-2 text-sm theme-text-primary rounded-lg transition-colors duration-200 cursor-pointer">
                                            <span class="truncate max-w-[160px]">{{ wiki.title }}</span>
                                            <span class="text-xs theme-text-tertiary">({{wiki.articlesTotal}})</span>
                                            <span v-if="wiki.isTop" class="ml-2 inline-flex items-center justify-center w-8 h-5 text-[10px] font-bold text-white bg-red-500 rounded-full">置顶</span>
                                        </a>
                                    </div>
                                </div>
                            </li>

                            <li class="">
                                <a @click="handleMenuClick('/surfer/resource')" :class="[
                                    currPath == '/surfer/resource'
                                        ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                        : 'theme-text-secondary border-b-4 border-transparent',
                                ]" class="menu-item relative block py-1 px-4 rounded-lg md:rounded-xl hover:theme-bg-tertiary/80 md:hover:bg-blue-50/50 md:dark:hover:bg-blue-900/20 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                    <span class="relative z-10">资源</span>
                                    <div v-if="currPath == '/surfer/resource'" class="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-transparent rounded-lg animate-pulse"></div>
                                </a>
                            </li>
                            <li class="">
                                <a @click="handleMenuClick('/surfer/tools')" :class="[
                                    currPath == '/surfer/tools'
                                        ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                        : 'theme-text-secondary border-b-4 border-transparent',
                                ]" class="menu-item relative block py-1 px-4 rounded-lg md:rounded-xl hover:theme-bg-tertiary/80 md:hover:bg-blue-50/50 md:dark:hover:bg-blue-900/20 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                    <span class="relative z-10">工具</span>
                                    <div v-if="currPath == '/surfer/tools'" class="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-transparent rounded-lg animate-pulse"></div>
                                </a>
                            </li>
                            <li class="">
                                <a @click="handleMenuClick('/surfer/friend')" :class="[
                                    currPath == '/surfer/friend'
                                        ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                        : 'theme-text-secondary border-b-4 border-transparent',
                                ]" class="menu-item relative block py-1 px-4 rounded-lg md:rounded-xl hover:theme-bg-tertiary/80 md:hover:bg-blue-50/50 md:dark:hover:bg-blue-900/20 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40">
                                    <span class="relative z-10">友链</span>
                                    <div v-if="currPath == '/surfer/friend'" class="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-transparent rounded-lg animate-pulse"></div>
                                </a>
                            </li>

                            <li class="relative about-dropdown-container">
                                <a @click="toggleAboutDropdown"
                                    :class="[
                                        isAboutActive
                                            ? 'text-blue-600 dark:text-blue-400 bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/40 dark:to-blue-800/30 border-b-4 border-blue-500 shadow-lg shadow-blue-500/20 dark:shadow-blue-400/20 menu-item-active'
                                            : 'theme-text-secondary border-b-4 border-transparent',
                                    ]"
                                    class="menu-item relative flex items-center justify-between py-1 px-4 rounded-lg md:rounded-xl hover:theme-bg-tertiary/80 md:hover:bg-blue-50/50 md:dark:hover:bg-blue-900/20 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 cursor-pointer font-medium active:scale-95 active:bg-blue-100 dark:active:bg-blue-800/40"
                                >
                                    <span class="relative z-10">关于</span>
                                    <DownOutlined :class="[
                                        'ml-1 text-xs transition-transform duration-200',
                                        { 'rotate-180': categoryAboutVisible },
                                    ]" />
                                    <div v-if="isAboutActive" class="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-transparent rounded-lg animate-pulse"></div>
                                </a>
                                <div v-if="categoryAboutVisible" class="theme-bg-tertiary theme-text-primary about-dropdown absolute top-full left-0 mt-2 w-64 rounded-xl shadow-lg z-50 max-h-80 overflow-y-auto">
                                    <div class="p-2 space-y-1">
                                        <a @click="hideAboutDropdown(); handleMenuClick('/surfer/author')" class="hover:bg-gray-400 flex items-center px-3 py-2 text-sm theme-text-secondary hover:theme-bg-tertiary theme-text-primary rounded-lg transition-colors duration-200">
                                            <span>关于作者</span>
                                        </a>
                                        <a @click="hideAboutDropdown(); handleMenuClick('/surfer/moments')" class="hover:bg-gray-400 flex items-center px-3 py-2 text-sm theme-text-secondary hover:theme-bg-tertiary theme-text-primary rounded-lg transition-colors duration-200">
                                            <span>说说</span>
                                        </a>
                                        <a @click="hideAboutDropdown(); handleMenuClick('/surfer/equipment')" class="hover:bg-gray-400 flex items-center px-3 py-2 text-sm theme-text-secondary hover:theme-bg-tertiary theme-text-primary rounded-lg transition-colors duration-200">
                                            <span>设备</span>
                                        </a>
                                        <a @click="hideAboutDropdown(); handleMenuClick('/surfer/gallery')" class="hover:bg-gray-400 flex items-center px-3 py-2 text-sm theme-text-secondary hover:theme-bg-tertiary theme-text-primary rounded-lg transition-colors duration-200">
                                            <span>墙纸</span>
                                        </a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </template>

                <!-- 用户 -->
                <div class="flex items-center gap-3">
                     <!-- 点击刷新页面 -->
                    <a-tooltip v-if="deviceType!='isMobile'" title="刷新" placement="bottom">
                        <div class="w-[42px] h-[64px] cursor-pointer flex items-center justify-center text-gray-700"
                            @click="handleRefresh">
                            <img :src="refreshIcon" alt="刷新" class="w-8.5 h-8.5" />
                        </div>
                    </a-tooltip>
                    <!-- 点击跳转后台首页 -->
                    <a-tooltip title="跳转后台" placement="bottom">
                        <div class="w-[42px] h-[64px] cursor-pointer flex items-center justify-center text-gray-700"
                            @click="router.push('/admin')">
                            <img :src="backstageIcon" alt="刷新" class="w-10 h-10" />
                        </div>
                    </a-tooltip>
                    <!-- 点击全屏展示 -->
                    <a-tooltip title="全屏" placement="bottom">
                        <div class="w-[42px] h-[64px] cursor-pointer flex items-center justify-center text-gray-700"
                            @click="handleToggleFullscreen">
                            <img v-if="!isFullscreen" :src="fullScreenIcon" alt="刷新" class="w-8 h-8" />
                            <img v-else :src="smallScreenIcon" alt="刷新" class="w-8 h-8" />
                        </div>
                    </a-tooltip>
                    <!-- 搜索-移动端显示 -->
                    <a-tooltip v-if="deviceType!='isDesktop'" title="搜索" placement="bottom">
                        <div class="w-[42px] h-[64px] cursor-pointer flex items-center justify-center text-gray-700"
                            @click="clickSearchBtn">
                            <img :src="searchIcon" alt="搜索" class="w-8 h-8" />
                        </div>
                    </a-tooltip>
                    <!-- 白天黑夜切换 -->
                    <label class="switch">
                        <input type="checkbox" v-model="darkSwitch" @click="toggleDark()" />
                        <span class="slider"></span>
                    </label>
                    <button v-if="deviceType!='isDesktop'" @click="mobileMenuVisible = !mobileMenuVisible" type="button"
                        class="inline-flex items-center p-1 w-12 h-12 justify-center text-sm theme-text-tertiary rounded-xl hover:theme-bg-tertiary/80 focus:outline-none focus:ring-2 focus:ring-blue-500/50 transition-all duration-200"
                        aria-controls="navbar-search" :aria-expanded="mobileMenuVisible">
                        <span class="sr-only">Open main menu</span>
                        <img :src="menuIcon" alt="菜单" class="w-18 h-18" />
                    </button>
                    <!-- 搜索框-PC端显示 -->
                     <div v-if="deviceType=='isDesktop'" class="ml-[6px] ">
                        <button  type="button" @click="clickSearchBtn" class="outline-none flex items-center text-sm leading-6 theme-text-tertiary rounded-xl ring-1 theme-border shadow-sm p-1.5 hover:ring-blue-300 dark:hover:ring-blue-600 hover:shadow-md theme-bg-tertiary/50 backdrop-blur-sm transition-all duration-200 group">
                            <SearchOutlined class="w-4 h-4 mr-3 theme-text-tertiary group-hover:text-blue-500 transition-colors duration-200" />
                            <span class="mr-4 font-medium">搜索文章...</span>
                            <span class="theme-bg-tertiary theme-text-primary px-2.5 py-1 flex-none text-xs border theme-border theme-text-tertiary rounded-md ">⌘K</span>
                        </button>
                     </div>

                </div>
            </div>
        </nav>
    </header>
    <!-- 退出登录确认模态框 -->
    <a-modal v-model:open="logoutModalVisible" title="退出登录" width="500px" :footer="null">
        <div class="logout-content py-4">
            <div class="flex items-center mb-4">
                <div
                    class="warning-icon w-8 h-8 rounded-full flex items-center justify-center mr-3 bg-orange-100 text-orange-500">
                    <ExclamationCircleOutlined />
                </div>
                <div>
                    <div class="font-medium theme-text-primary">确认退出登录</div>
                    <div class="text-sm theme-text-tertiary mt-1">
                        退出后您需要重新登录才能访问管理功能
                    </div>
                </div>
            </div>
            <div class="theme-bg-tertiary theme-text-primary logout-info p-4 rounded-lg">
                <p class="text-sm theme-text-secondary">是否确定要退出当前账户？</p>
                <p class="text-xs theme-text-tertiary mt-2">退出后需要重新登录才能访问。</p>
            </div>
        </div>
        <!-- 自定义按钮区域 -->
        <div class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t theme-border">
            <a-button size="middle" @click="logoutModalVisible = false">取消</a-button>
            <a-button type="primary" danger size="middle" @click="confirmLogout">确定退出</a-button>
        </div>
    </a-modal>

    <!-- 站内搜索模态框 -->
    <a-modal v-model:open="searchModalVisible" title="站内搜索" width="800px" centered footer="">
        <div class="mb-4">
            <a-input-search ref="searchInputRef" v-model:value="searchWord" placeholder="请输入关键词搜索..."
                :loading="searchLoading" size="large"
                @search="renderSearchArticles({ current: 1, size: size, word: searchWord })" />
        </div>
        <!-- Modal body -->
        <div class="p-4 md:p-5 space-y-4">
            <div v-if="searchArticles && searchArticles.length > 0">
                <p class="text-base leading-relaxed theme-text-tertiary mb-4">
                    共搜索到 {{ total }} 篇相关文章
                </p>
                <a-list :data-source="searchArticles" item-layout="horizontal">
                    <template #renderItem="{ item }">
                        <a-list-item class="cursor-pointer" @click="jumpToArticleDetailPage(item.id)">
                            <a-list-item-meta>
                                <template #avatar>
                                    <a-avatar shape="square" size="large" :src="item.cover" />
                                </template>
                                <template #title>
                                    <div v-html="item.title"></div>
                                </template>
                                <template #description>
                                    <span class="theme-text-tertiary">
                                        <CalendarOutlined class="mr-1" />
                                        {{ item.createDate }}
                                    </span>
                                </template>
                            </a-list-item-meta>
                        </a-list-item>
                    </template>
                </a-list>

                <!-- 分页 -->
                <div class="mt-4 flex justify-center">
                    <a-pagination v-model:current="current" :total="total" :page-size="size"
                        :show-total="(total: number, range: [number, number]) => `共 ${total} 条记录`" size="small"
                        @change="(page: number) => renderSearchArticles({ current: page, size: size, word: searchWord })" />
                </div>
            </div>
            <!-- 未搜索到结果提示 -->
            <div v-else>
                <a-empty description="未搜索到相关文章" />
            </div>
        </div>
        <!-- Modal footer -->
        <div class="p-4 md:p-5 border-t text-xs flex items-center theme-text-tertiary theme-border">
            <!-- Esc 退出提示 -->
            <span class="px-2 py-[1px] flex-none border rounded theme-border">Esc</span>
            <span class="theme-text-tertiary ml-2">关闭</span>

            <!-- 底层技术介绍 -->
            <span class="ml-auto">基于&nbsp;<a href="https://lucene.apache.org/" target="_blank" class="underline">Apache
                    Lucene</a>&nbsp;全文检索引擎开发</span>
        </div>
    </a-modal>
</template>

<script setup lang="ts">
import { onMounted, ref, onBeforeUnmount, watch, computed, type Ref } from "vue";
import { useBlogSettingsStore } from "@/stores/blogsettings.ts";
import { useFullscreen } from '@vueuse/core'
import { useUserStore } from "@/stores/user.ts";
import { useRouter, useRoute } from "vue-router";
import { showMessage } from "@/composables/util.ts";
import { getArticleSearchPageList } from "@/api/surfer/search";
import { getCategoryList } from "@/api/surfer/category";
import { getTagList } from "@/api/surfer/tag";
import { getWikiList } from "@/api/surfer/wiki";
import { getArchivePageList } from "@/api/surfer/archive.ts";
import { useTheme } from "@/composables/useTheme";
import { useArchiveStore } from "@/stores/archive";
import {
    CalendarOutlined,
    SearchOutlined,
    ExclamationCircleOutlined,
    DownOutlined,
} from "@ant-design/icons-vue";
import {useDevice} from '@/composables/useDevice.ts'
import refreshIcon from '@/assets/surfer/header/Refresh.svg'
import backstageIcon from '@/assets/surfer/header/Backstage.svg'
import fullScreenIcon from '@/assets/surfer/header/FullScreen.svg'
import smallScreenIcon from '@/assets/surfer/header/SmallScreen.svg'
import searchIcon from '@/assets/surfer/header/Search.svg'
import defaultLogo from '@/assets/MintBlogLogo.svg'
import menuIcon from '@/assets/surfer/header/Menu.svg'

// 接口定义
interface SearchArticle {
    id: number;
    title: string;
    summary: string;
    createTime: string;
    createDate?: string;
    cover?: string;
}

interface SearchResponse {
    success: boolean;
    data: SearchArticle[];
    current: number;
    size: number;
    total: number;
    pages: number;
}

interface SearchParams {
    current: number;
    size: number;
    word: string;
}

// 技术栈接口定义
interface Category {
    id: number;
    name: string;
    articlesTotal: number;
    sort: number;
}

interface CategoryResponse {
    success: boolean;
    data: Category[];
}

// 场景接口定义
interface Tag {
    id: number;
    name: string;
    articlesTotal: number;
    sort: number;
}

interface TagResponse {
    success: boolean;
    data: Tag[];
}

// 专栏接口定义
interface Wiki {
    id: number | string;
    title: string;
    summary?: string;
    cover?: string;
    isTop?: boolean;
    firstArticleId: number | string;
    weight?: number;  // 权重字段，优先级最高
    sort?: number;    // 排序字段，数字越大排序越靠前
}

interface WikiResponse {
    success: boolean;
    data: Wiki[];
}

// 归档接口定义（用于在头部下拉中提取年份）
interface ArchiveItem {
    month: string;
    articles: any[];
}
interface ArchiveApiResponse {
    success: boolean;
    data: ArchiveItem[];
    current: number;
    size: number;
    total: number;
    pages: number;
}

const { isMobile, isDesktop } = useDevice();
const deviceType = computed(() => (isDesktop.value ? 'isDesktop' : 'isMobile'));

// 使用统一的主题管理
const { isDark, darkSwitch, toggleDark } = useTheme();

// 搜索模态框显示状态
const searchModalVisible: Ref<boolean> = ref(false);
// 退出登录确认模态框显示状态
const logoutModalVisible: Ref<boolean> = ref(false);
// 移动端导航菜单显示状态
const mobileMenuVisible: Ref<boolean> = ref(false);
// 技术栈下拉菜单显示状态
const categoryDropdownVisible: Ref<boolean> = ref(false);
// 关于下拉菜单显示状态
const categoryAboutVisible: Ref<boolean> = ref(false);
// 技术栈列表
const categories: Ref<Category[]> = ref([]);
// 场景下拉菜单显示状态
const tagDropdownVisible: Ref<boolean> = ref(false);
// 场景列表
const tags: Ref<Tag[]> = ref([]);
// 专栏下拉菜单显示状态
const wikiDropdownVisible: Ref<boolean> = ref(false);
// 专栏列表
const wikis: Ref<Wiki[]> = ref([]);
// 归档下拉菜单显示状态
const archiveDropdownVisible: Ref<boolean> = ref(false);
// 归档年份列表（用于下拉菜单年-月选择），改为从 Pinia 获取
const archiveYears = computed<number[]>(() => archiveStore.archiveYears || []);
// 当前选中的年份
const archiveSelectedYear: Ref<number> = ref(new Date().getFullYear());
// 归档 Pinia 存储，用于按年份预取整年数据
const archiveStore = useArchiveStore();
// 月份选项
const archiveMonths = [
    { value: "01", label: "1月" },
    { value: "02", label: "2月" },
    { value: "03", label: "3月" },
    { value: "04", label: "4月" },
    { value: "05", label: "5月" },
    { value: "06", label: "6月" },
    { value: "07", label: "7月" },
    { value: "08", label: "8月" },
    { value: "09", label: "9月" },
    { value: "10", label: "10月" },
    { value: "11", label: "11月" },
    { value: "12", label: "12月" },
];

// 刷新页面
const handleRefresh = () => location.reload();

// isFullscreen 表示当前是否处于全屏；toggle 用于动态切换全屏、非全屏
const { isFullscreen, toggle, isSupported } = useFullscreen();

const handleToggleFullscreen = async (): Promise<void> => {
    if (!isSupported.value) {
        showMessage('当前浏览器不支持全屏', 'warning', 2)
        return
    }

    try {
        await toggle()
    } catch {
        showMessage('全屏切换失败', 'error', 2)
    }
}

// 初始化组件
onMounted(() => {
    // 注册键盘事件监听器
    window.addEventListener("keydown", handleKeyDown);
});

onBeforeUnmount(() => {
    // 在组件销毁前移除事件监听器，防止内存泄漏
    window.removeEventListener("keydown", handleKeyDown);
});

// 搜索输入框引用
const searchInputRef: Ref<HTMLInputElement | null> = ref(null);
// 键盘监听
const handleKeyDown = (event: KeyboardEvent): void => {
    // 检查是否按下了 Ctrl 键和 K 键
    if (event.ctrlKey && event.key === "k") {
        // 阻止激活浏览器本身的搜索框
        event.preventDefault();
        console.log("ctrl k 被按了");

        searchModalVisible.value = true;

        // 激活搜索框
        setTimeout(() => {
            searchInputRef.value?.focus();
        }, 100);
    }
};

const router = useRouter();
const route = useRoute();

// 当前路由地址
const currPath: Ref<string> = ref(route.path);

// 监听路由变化，实时更新当前路径
watch(
    () => route.path,
    (newPath: string) => {
        currPath.value = newPath;
    },
    { immediate: true }
);

const isAboutActive = computed(() => {
    return [
        "/surfer/author",
        "/surfer/moments",
        "/surfer/equipment",
        "/surfer/gallery",
    ].includes(currPath.value);
});

// 引入博客设置信息 store
const blogSettingsStore = useBlogSettingsStore();

const logoUrl = computed(() => {
    const raw = blogSettingsStore.blogSettings?.logo;
    const val = typeof raw === 'string' ? raw.trim() : raw;
    if (!val || val === 'null' || val === 'undefined') {
        return defaultLogo;
    }
    return val as string;
});

const handleLogoError = (event: Event): void => {
    const img = event.target as HTMLImageElement | null;
    if (img && img.src !== defaultLogo) {
        img.src = defaultLogo;
    }
};

// 是否登录，通过 userStore 中的 userInfo 对象是否有数据来判断
const userStore = useUserStore();
// 获取 userInfo 对象所有属性名称的数组
const keys = Object.keys(userStore.userInfo);
// 若大于零，则表示用户已登录
const isLogined: Ref<boolean> = ref(keys.length > 0);

// 退出登录
const confirmLogout = async () => {
    userStore.logout();
    showMessage("退出登录成功！");
    logoutModalVisible.value = false;
    // 跳转登录页
    router.push("/login");
};

// 点击搜索框
const clickSearchBtn = (): void => {
    searchModalVisible.value = true;
    // 激活搜索框
    setTimeout(() => {
        searchInputRef.value?.focus();
    }, 100);
};

// 文章搜索结果
const searchArticles: Ref<SearchArticle[]> = ref([]);
// 当前页码，给了一个默认值 1
const current: Ref<number> = ref(1);
// 总数据量，给了个默认值 0
const total: Ref<number> = ref(0);
// 每页显示的数据量，给了个默认值 10
const size: Ref<number> = ref(1);
// 总共多少页
const pages: Ref<number> = ref(0);
// 搜索关键词
const searchWord: Ref<string> = ref("");

// 搜索 Loading
const searchLoading: Ref<boolean> = ref(false);

watch(searchWord, (newText: string, oldText: string): void => {
    if (newText && newText !== oldText) {
        // 若搜索关键词不为空，且和之前的值不相同
        renderSearchArticles({
            current: current.value,
            size: size.value,
            word: newText,
        });
    } else if (newText == "") {
        // 搜索词为空
        // 置空
        searchArticles.value = [];
    }
});

// 请求后台检索接口
function renderSearchArticles(data: SearchParams): void {
    // 显示加载 Loading
    searchLoading.value = true;
    getArticleSearchPageList(data)
        .then((res: SearchResponse) => {
            console.log(res);
            if (res.success) {
                searchArticles.value = res.data;
                current.value = res.current;
                size.value = res.size;
                total.value = res.total;
                pages.value = res.pages;
            }
        })
        .finally(() => (searchLoading.value = false)); // 隐藏加载 Loading
}

// 渲染下一页搜索结果
const nextPage = (): void => {
    renderSearchArticles({
        current: current.value + 1,
        size: size.value,
        word: searchWord.value,
    });
};

// 渲染上一页搜索结果
const prePage = (): void => {
    renderSearchArticles({
        current: current.value - 1,
        size: size.value,
        word: searchWord.value,
    });
};

// 点击搜索结果，跳转文章详情页
const jumpToArticleDetailPage = (articleId: number): void => {
    // 隐藏搜索对话框
    searchModalVisible.value = false;
    // 路由跳转
    router.push("/surfer/article/" + articleId);
};

// 获取技术栈列表
const loadCategories = (): void => {
    getCategoryList({}).then((res: CategoryResponse) => {
        if (res.success) {
            // 按sort降序排序，sort相同时保持原有顺序不变
            const sortedCategories = res.data.sort((a, b) => {
                const sortA = a.sort || 0;
                const sortB = b.sort || 0;
                // 只按sort字段降序排序，sort相同时保持原有顺序不变
                return sortB - sortA;
            });
            categories.value = sortedCategories;
        }
    });
};

// 获取场景列表
const loadTags = (): void => {
    getTagList({}).then((res: TagResponse) => {
        if (res.success) {
            // 按sort降序排序，sort相同时按id升序排序
            const sortedTags = res.data.sort((a, b) => {
                const sortA = a.sort || 0;
                const sortB = b.sort || 0;
                if (sortA !== sortB) {
                    return sortB - sortA; // sort降序
                }
                // sort相同时，按id升序排序
                return Number(a.id) - Number(b.id);
            });
            tags.value = sortedTags;
        }
    });
};

// 获取专栏列表
const loadWikis = (): void => {
    getWikiList().then((res: WikiResponse) => {
            if (res.success) {
            let wikiList = res.data || [];
            // 分两步排序：第一步处理weight>0的数据，第二步处理其他数据
            
            // 第一步：筛选出weight > 0的数据并排序
            const weightItems = wikiList.filter(item => 
                item.hasOwnProperty('weight') && 
                item.weight !== null && 
                item.weight !== undefined && 
                item.weight > 0
            );
            
            // 对weight > 0的数据按weight降序排序
            weightItems.sort((a, b) => {
                const weightA = a.weight || 0;
                const weightB = b.weight || 0;
                if (weightA !== weightB) {
                    return weightB - weightA; // weight降序
                }
                // weight相同时，按sort降序排序
                const sortA = a.sort || 0;
                const sortB = b.sort || 0;
                if (sortA !== sortB) {
                    return sortB - sortA;
                }
                // weight和sort都相同时，按id升序排序
                return Number(a.id) - Number(b.id);
            });
            
            // 第二步：筛选出weight <= 0或没有weight字段的数据
            const sortItems = wikiList.filter(item => 
                !item.hasOwnProperty('weight') || 
                item.weight === null || 
                item.weight === undefined || 
                item.weight <= 0
            );
            
            // 对这些数据按sort降序排序
            sortItems.sort((a, b) => {
                const sortA = a.sort || 0;
                const sortB = b.sort || 0;
                if (sortA !== sortB) {
                    return sortB - sortA; // sort降序
                }
                // sort相同时，按id升序排序
                return Number(a.id) - Number(b.id);
            });
            
            // 合并两个数组：weight > 0的在前，其他的在后
            wikiList = [...weightItems, ...sortItems];
            
            wikis.value = wikiList;
        }
    });
};

// 点击外部区域隐藏下拉菜单
const handleClickOutside = (event: Event): void => {
    const target = event.target as HTMLElement;
    const categoryMenu = target.closest(".category-dropdown-container");
    const aboutMenu = target.closest(".about-dropdown-container");
    const tagMenu = target.closest(".tag-dropdown-container");
    const wikiMenu = target.closest(".wiki-dropdown-container");
    const archiveMenu = target.closest(".archive-dropdown-container");

    if (!categoryMenu && !aboutMenu && (categoryDropdownVisible.value || categoryAboutVisible.value)) {
        hideCategoryDropdown();
        hideAboutDropdown();
    }

    if (!tagMenu && tagDropdownVisible.value) {
        hideTagDropdown();
    }
    if (!wikiMenu && wikiDropdownVisible.value) {
        hideWikiDropdown();
    }
    if (!archiveMenu && archiveDropdownVisible.value) {
        hideArchiveDropdown();
    }
};

// 组件挂载时获取技术栈和场景数据，并添加事件监听
onMounted(() => {
    loadCategories();
    loadTags();
    loadWikis();
    loadArchiveYears();
    document.addEventListener("click", handleClickOutside);
});

// 组件卸载时移除事件监听
onBeforeUnmount(() => {
    document.removeEventListener("click", handleClickOutside);
});

// 切换技术栈下拉菜单显示状态
const toggleAboutDropdown = (): void => {
    categoryAboutVisible.value = !categoryAboutVisible.value;
};

// 切换技术栈下拉菜单显示状态
const toggleCategoryDropdown = (): void => {
    categoryDropdownVisible.value = !categoryDropdownVisible.value;
};

// 隐藏技术栈下拉菜单
const hideCategoryDropdown = (): void => {
    categoryDropdownVisible.value = false;
};

const hideAboutDropdown = (): void => {
    categoryAboutVisible.value = false;
};

// 直接跳转到技术栈文章列表页
const goCategoryArticleListPage = (id: number, name: string): void => {
    // 隐藏下拉菜单
    hideCategoryDropdown();
    // 跳转时通过 query 携带参数（技术栈 ID、技术栈名称）
    router.push({
        path: "/surfer/category/article/list",
        query: { id: String(id), name },
    });
};

// 切换场景下拉菜单显示状态
const toggleTagDropdown = (): void => {
    tagDropdownVisible.value = !tagDropdownVisible.value;
};

// 隐藏场景下拉菜单
const hideTagDropdown = (): void => {
    tagDropdownVisible.value = false;
};

// 场景菜单点击：先预取当前选择年份的归档数据至 Pinia，再跳转到场景列表
const handleTagMenuClick = async (): Promise<void> => {
    try {
        const year = String(archiveSelectedYear.value);
        await archiveStore.fetchYear(year, { force: true });
    } catch (e) {
        // 静默失败；避免影响导航
        console.warn("预取年份归档失败：", e);
    }
    // 跳转并隐藏下拉
    hideTagDropdown();
    handleMenuClick('/surfer/tag/list');
};

// 切换专栏下拉菜单显示状态
const toggleWikiDropdown = (): void => {
    wikiDropdownVisible.value = !wikiDropdownVisible.value;
};

// 隐藏专栏下拉菜单
const hideWikiDropdown = (): void => {
    wikiDropdownVisible.value = false;
};

// 切换归档下拉菜单显示状态；打开时刷新年份列表到 Pinia
const toggleArchiveDropdown = async (): Promise<void> => {
    const willOpen = !archiveDropdownVisible.value;
    archiveDropdownVisible.value = willOpen;
    if (willOpen) {
        await archiveStore.getArchiveYears();
    }
};

// 隐藏归档下拉菜单
const hideArchiveDropdown = (): void => {
    archiveDropdownVisible.value = false;
};

// 获取归档年份（从 Pinia 的 action 请求后端并存储）
const loadArchiveYears = async (): Promise<void> => {
    const years = await archiveStore.getArchiveYears();
    archiveSelectedYear.value = years?.[0] ?? new Date().getFullYear();
};

// 选择年份：从后端请求一整年的数据并存储到 Pinia
const selectArchiveYear = async (year: number): Promise<void> => {
    archiveSelectedYear.value = year;
    // 将选中的年份写入 Pinia，便于其它页面使用
    // 记录选中年份到 Pinia（直接写入 state）
    archiveStore.selectedYear = String(year);
    // 预取该年份的归档数据（若已缓存则重新拉取替换）
    try {
        await archiveStore.fetchYear(year, { force: true });
    } catch (e) {
        // 静默失败，避免影响交互；可按需添加提示
        console.warn('预取年份归档失败：', e);
    }
};

// 跳转到归档列表并定位月份（通过 query 传入年与月）
const goArchiveMonth = (year: number, month: string): void => {
    console.log("year",year)
    console.log("month",month)
    hideArchiveDropdown()
    // 将选中的年份和月份写入 Pinia
    // 记录选中的年份与月份到 Pinia（直接写入 state）
    archiveStore.selectedYear = String(year);
    archiveStore.selectedMonth = month;
    console.log("actionStoreYear",archiveStore.selectedYear)
    console.log("actionStoreMonth",archiveStore.selectedMonth)
    // 带上 scroll=1，ArchiveList 将优先尝试滚动定位到对应月份；若该页不存在则回退为筛选
    // router.push({ path: "/surfer/archive/list", query: { year: String(year), month, scroll: '1' } });
    router.push({ path: "/surfer/archive/list"});
};

// 直接跳转到场景文章列表页
const goTagArticleListPage = (id: number, name: string): void => {
    // 隐藏下拉菜单
    hideTagDropdown();
    // 跳转时通过 query 携带参数（场景 ID、场景名称）
    router.push({
        path: "/surfer/tag/article/list",
        query: { id: String(id), name },
    });
};

// 处理菜单点击
const handleMenuClick = (path: string, evt?: Event): void => {
    // 添加点击反馈动画（仅在有事件对象且目标为 HTMLElement 时生效）
    const target = (evt?.currentTarget ?? evt?.target) as EventTarget | null;
    if (target && target instanceof HTMLElement) {
        target.style.transform = "scale(0.95)";
        setTimeout(() => {
            target.style.transform = "";
        }, 150);
    }

    // 移动端菜单点击后自动关闭
    if (mobileMenuVisible.value) {
        mobileMenuVisible.value = false;
    }

    // 路由跳转
    router.push(path);
};

// 查看所有归档：重置筛选条件并跳转到归档页面
const viewAllArchives = (): void => {
    // 重置store中的筛选条件，相当于重置按钮的效果
    archiveStore.selectedYear = '';
    archiveStore.selectedMonth = '';
    
    // 隐藏下拉菜单
    hideArchiveDropdown();
    
    // 跳转到归档页面
    router.push('/surfer/archive/list');
};

// 直接跳转到某个专栏的首篇文章详情页
const goWikiArticleDetailPage = (wikiId: number | string, articleId: number | string): void => {
    // 隐藏下拉菜单
    hideWikiDropdown();
    router.push({ path: "/surfer/wiki/" + wikiId, query: { articleId: String(articleId) } });
};
</script>

<style lang="scss" scoped>

.switch {
    position: relative;
    display: inline-block;
    width: 60px;
    height: 31px;
    padding: 2px;
    margin-right: 5px;
    margin-left: 5px;
    input {
        opacity: 0;
        width: 0;
        height: 0;

        &:checked+.slider {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

            &:before {
                transform: translateX(28px);
                content: "🌙";
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 14px;
            }
        }
    }
}

.slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, #ffeaa7 0%, #fab1a0 100%);
    transition: all 0.3s ease;
    border-radius: 32px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);

    &:before {
        position: absolute;
        content: "☀️";
        height: 24px;
        width: 24px;
        left: 4px;
        bottom: 4px;
        background-color: white;
        transition: all 0.3s ease;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
    }

    &:hover {
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    }
}

/* 菜单项增强样式 */
.menu-item {
    position: relative;
    overflow: hidden;

    /* 涟漪效果 */
    &::before {
        content: "";
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        border-radius: 50%;
        background: rgba(59, 130, 246, 0.3);
        transform: translate(-50%, -50%);
        transition: width 0.3s ease, height 0.3s ease;
        pointer-events: none;
        z-index: 0;
    }

    &:active::before {
        width: 200px;
        height: 200px;
    }

    /* 确保文字在涟漪效果之上 */
    &>* {
        position: relative;
        z-index: 1;
    }

    /* 增强的悬停效果 */
    &:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    /* 活跃状态的额外样式 */
    &.menu-item-active {
        position: relative;
        overflow: hidden;

        /* 发光效果 */
        &::before {
            content: "";
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #3b82f6, #1d4ed8, #3b82f6);
            border-radius: inherit;
            z-index: -1;
            opacity: 0.6;
            filter: blur(4px);
            animation: glow 2s ease-in-out infinite alternate;
        }

        /* 顶部装饰线 */
        &:before {
            content: "";
            position: absolute;
            top: 0;
            left: 8px;
            right: 8px;
            height: 2px;
            background: linear-gradient(to right, transparent, #3b82f6, transparent);
            border-radius: 1px;
            z-index: 1;
        }
    }
}

/* 关于下拉菜单样式 */
.about-dropdown-container {
    .category-dropdown {
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);

        /* 移动端下拉菜单调整 */
        @media (max-width: 768px) {
            position: fixed;
            top: auto;
            left: 16px;
            right: 16px;
            width: auto;
            max-height: 60vh;
            z-index: 9999;
        }
    }
}
/* 技术栈下拉菜单样式 */
.category-dropdown-container {
    .about-dropdown {
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);

        @media (max-width: 768px) {
            position: fixed;
            top: auto;
            left: 16px;
            right: 16px;
            width: auto;
            max-height: 60vh;
            z-index: 9999;
        }
    }
}

/* 场景下拉菜单样式 */
.tag-dropdown-container {
    .tag-dropdown {
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);

        /* 移动端下拉菜单调整 */
    @media (max-width: 768px) {
            position: fixed;
            top: auto;
            left: 16px;
            right: 16px;
            width: auto;
            max-height: 60vh;
            z-index: 9999;
        }
    }
}

/* 专栏下拉菜单样式 */
.wiki-dropdown-container {
    .wiki-dropdown {
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);

        /* 移动端下拉菜单调整 */
        @media (max-width: 768px) {
            position: fixed;
            top: auto;
            left: 16px;
            right: 16px;
            width: auto;
            max-height: 60vh;
            z-index: 9999;
        }
    }
}

/* 移动端菜单优化 */
@media (max-width: 768px) {
    .menu-item {
        margin-bottom: 4px;

        &:hover {
            transform: translateX(4px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
    }

    .category-dropdown-container {
        position: static;
    }

    .about-dropdown-container {
        position: static;
    }

    .tag-dropdown-container {
        position: static;
    }
}

/* 页面过渡动画 */
.page-transition-enter-active,
.page-transition-leave-active {
    transition: all 0.3s ease;
}

.page-transition-enter-from {
    opacity: 0;
    transform: translateX(20px);
}

.page-transition-leave-to {
    opacity: 0;
    transform: translateX(-20px);
}

/* 选中菜单的动画效果 */
@keyframes glow {
    0% {
        opacity: 0.4;
        filter: blur(4px);
    }

    100% {
        opacity: 0.8;
        filter: blur(6px);
    }
}

@keyframes pulse-border {

    0%,
    100% {
        box-shadow: 0 0 8px rgba(59, 130, 246, 0.5);
        transform: translateY(-50%) scaleY(1);
    }

    50% {
        box-shadow: 0 0 16px rgba(59, 130, 246, 0.8);
        transform: translateY(-50%) scaleY(1.1);
    }
}

@keyframes shimmer {
    0% {
        transform: translateX(-100%);
    }

    100% {
        transform: translateX(100%);
    }
}

/* 搜索框美化样式 */
:deep(.ant-input-search) {
    .ant-input {
        border-radius: 25px;
        border: 2px solid transparent;
        background: linear-gradient(white, white) padding-box,
            linear-gradient(45deg, #3b82f6, #8b5cf6, #06b6d4) border-box;
        box-shadow: 0 4px 15px rgba(59, 130, 246, 0.1);
        transition: all 0.3s ease;
        font-size: 16px;
        padding: 12px 20px;
        // ant-input-search-button隐藏搜索按钮时设置100%
        width: 100%;

        &:hover {
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.2);
            transform: translateY(-1px);
        }

        &:focus {
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.3);
            transform: translateY(-2px);
            border-color: transparent;
        }
    }

    .ant-input-search-button {
        // 隐藏搜索按钮
        display: none;
        border-radius: 0 25px 25px 0;
        background: linear-gradient(45deg, #3b82f6, #1d4ed8);
        border: none;
        height: 100%;
        min-width: 60px;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;

        &::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        &:hover {
            background: linear-gradient(45deg, #1d4ed8, #1e40af);
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(29, 78, 216, 0.4);

            &::before {
                left: 100%;
            }
        }

        &:active {
            transform: scale(0.98);
        }

        .anticon {
            color: white;
            font-size: 22px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            z-index: 1;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
        }

        &:hover .anticon {
            transform: rotate(15deg) scale(1.2);
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
            animation: searchPulse 0.6s ease-in-out;
        }

        &:active .anticon {
            transform: rotate(10deg) scale(1.1);
        }
    }
}

/* 搜索图标脉冲动画 */
@keyframes searchPulse {
    0% {
        transform: rotate(15deg) scale(1.2);
    }

    50% {
        transform: rotate(15deg) scale(1.3);
    }

    100% {
        transform: rotate(15deg) scale(1.2);
    }
}

/* 暗色模式下的搜索框样式 */
.dark :deep(.ant-input-search) {
    .ant-input {
        background: linear-gradient(#1f2937, #1f2937) padding-box,
            linear-gradient(45deg, #3b82f6, #8b5cf6, #06b6d4) border-box;
        color: #f9fafb;

        &::placeholder {
            color: #9ca3af;
        }
    }
}
</style>
