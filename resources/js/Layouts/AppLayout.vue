<script setup>
    import { ref, onMounted } from "vue";
    import { Head } from "@inertiajs/vue3";
    import AppHeader from "./AppHeader.vue";
    import AppSidebar from "./AppSidebar.vue";

    defineProps({
        title: { type: String, default: "" },
    });

    const sidebarOpen = ref(true);

    onMounted(() => {
        if (window.innerWidth < 1024) sidebarOpen.value = false;
    });
</script>

<template>
    <Head :title="title" />

    <div class="flex min-h-screen bg-gray-50">
        <AppSidebar :open="sidebarOpen" @close="sidebarOpen = false" />

        <div class="flex min-w-0 flex-1 flex-col">
            <AppHeader @toggle-sidebar="sidebarOpen = !sidebarOpen">
                <span class="font-semibold text-gray-800">{{ title }}</span>
            </AppHeader>

            <main class="flex-1 overflow-y-auto p-6">
                <slot />
            </main>
        </div>
    </div>
</template>
