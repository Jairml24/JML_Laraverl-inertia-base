<script setup>
    import { ref, watch } from "vue";
    import { Head } from "@inertiajs/vue3";
    import AppHeader from "./AppHeader.vue";
    import AppSidebar from "./AppSidebar.vue";
    import VToast from "@/Components/VToast.vue";

    defineProps({
        title: { type: String, default: "" },
    });

    const STORAGE_KEY = "sidebar-open";
    const isDesktop = () => window.innerWidth >= 1024;

    // En celular el menú es un panel flotante: siempre arranca cerrado.
    // En escritorio se recuerda lo último que dejó la usuario.
    function estadoInicial() {
        if (!isDesktop()) return false;
        try {
            const guardado = localStorage.getItem(STORAGE_KEY);
            return guardado === null ? true : guardado === "true";
        } catch {
            return true;
        }
    }

    const sidebarOpen = ref(estadoInicial());

    watch(sidebarOpen, (abierto) => {
        if (!isDesktop()) return;
        try {
            localStorage.setItem(STORAGE_KEY, String(abierto));
        } catch {}
    });
</script>

<template>
    <Head :title="title" />
    <VToast />
    <div class="flex h-screen overflow-hidden bg-gray-50">
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