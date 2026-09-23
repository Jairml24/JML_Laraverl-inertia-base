<script setup>
    import { reactive } from "vue";
    import { Link } from "@inertiajs/vue3";
    import { ChevronDown, X } from "lucide-vue-next";
    import { navigation } from "@/Config/navigation";

    defineProps({
        open: { type: Boolean, default: true },
    });
    defineEmits(["close"]);

    const appName = import.meta.env.VITE_APP_NAME || 'Sistema'
    const links = navigation;

    // true/false por cada grupo (usamos el label como key)
    const openGroups = reactive({});

    function groupHasActiveChild(group) {
        return (
            group.children?.some((child) => route().current(child.route)) ?? false
        );
    }

    // Auto-expandir el grupo si estamos parados en una de sus rutas hijas
    links.forEach((link) => {
        if (link.children) {
            openGroups[link.label] = groupHasActiveChild(link);
        }
    });

    function toggleGroup(label) {
        openGroups[label] = !openGroups[label];
    }
</script>

<template>
    <Transition
        enter-active-class="transition-opacity duration-200"
        leave-active-class="transition-opacity duration-200"
        enter-from-class="opacity-0"
        leave-to-class="opacity-0"
    >
        <div
            v-if="open"
            class="fixed inset-0 z-30 bg-black/40 lg:hidden"
            @click="$emit('close')"
        />
    </Transition>

    <aside
        class="fixed inset-y-0 left-0 z-40 flex flex-col overflow-hidden bg-gray-900 text-gray-100 transition-all duration-300 ease-in-out lg:static"
        :class="open ? 'w-64' : 'w-0'"
    >
        <div class="flex h-16 items-center justify-between border-b border-gray-800 px-4" >
            <span class="whitespace-nowrap text-lg font-bold tracking-wide" >{{ appName }}</span>
            <button  class="text-gray-400 hover:text-white lg:hidden" @click="$emit('close')">
                <X :size="20" />
            </button>
        </div>

        <nav class="flex-1 space-y-1 overflow-y-auto p-3 whitespace-nowrap">
            <template v-for="link in links" :key="link.label">
                <!-- Link simple, sin hijos -->
                <Link
                    v-if="!link.children"
                    :href="route(link.route)"
                    class="flex items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium transition-colors"
                    :class="
                        route().current(link.route)
                            ? 'bg-indigo-600 text-white'
                            : 'text-gray-300 hover:bg-gray-800 hover:text-white'
                    "
                >
                    <component :is="link.icon" :size="18" class="shrink-0" />
                    <span>{{ link.label }}</span>
                </Link>

                <!-- Grupo con submenú -->
                <div v-else>
                    <button
                        type="button"
                        class="flex w-full items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium transition-colors"
                        :class="
                            groupHasActiveChild(link)
                                ? 'text-white'
                                : 'text-gray-300 hover:bg-gray-800 hover:text-white'
                        "
                        @click="toggleGroup(link.label)"
                    >
                        <component
                            :is="link.icon"
                            :size="18"
                            class="shrink-0"
                        />
                        <span class="flex-1 text-left">{{ link.label }}</span>
                        <ChevronDown
                            :size="16"
                            class="shrink-0 transition-transform"
                            :class="{ 'rotate-180': openGroups[link.label] }"
                        />
                    </button>

                    <Transition
                        enter-active-class="transition-all duration-200 ease-out"
                        leave-active-class="transition-all duration-150 ease-in"
                        enter-from-class="max-h-0 opacity-0"
                        enter-to-class="max-h-96 opacity-100"
                        leave-from-class="max-h-96 opacity-100"
                        leave-to-class="max-h-0 opacity-0"
                    >
                        <div  v-show="openGroups[link.label]"   class="ml-4 mt-1 space-y-1 overflow-hidden border-l border-gray-800 pl-3" >
                            <Link
                                v-for="child in link.children"
                                :key="child.route"
                                :href="route(child.route)"
                                class="block rounded-lg px-3 py-1.5 text-sm transition-colors"
                                :class="
                                    route().current(child.route)
                                        ? 'bg-indigo-600 text-white'
                                        : 'text-gray-400 hover:bg-gray-800 hover:text-white'
                                "
                            >
                                {{ child.label }}
                            </Link>
                        </div>
                    </Transition>
                </div>
            </template>
        </nav>
    </aside>
</template>
