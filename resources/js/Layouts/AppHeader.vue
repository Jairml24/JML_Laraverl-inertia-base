<script setup>
    import { ref, computed } from "vue";
    import { Link, router, usePage } from "@inertiajs/vue3";
    import { Menu, ChevronDown, User, LogOut } from "lucide-vue-next";
    import { useClickOutside } from "@/composables/useClickOutside";

    defineEmits(["toggle-sidebar"]);

    const page = usePage();
    const user = computed(() => page.props.auth?.user);

    const menuOpen = ref(false);
    const menuRef = ref(null);
    useClickOutside(menuRef, () => (menuOpen.value = false));

    const initials = computed(() => {
        if (!user.value?.name) return "?";
        return user.value.name
            .split(" ")
            .slice(0, 2)
            .map((n) => n[0])
            .join("")
            .toUpperCase();
    });

    function logout() {
        router.post(route("logout"));
    }
</script>

<template>
    <header class="sticky top-0 z-20 flex h-14 items-center justify-between border-b bg-white px-4 shadow-sm" >
        <div class="flex items-center gap-3">
            <button
                class="rounded-lg p-2 text-gray-600 hover:bg-gray-100 hover:text-gray-900"
                @click="$emit('toggle-sidebar')"
            >
                <Menu :size="20" />
            </button>
            <!-- Título de la página actual (opcional, vía slot) -->
            <slot />
        </div>

        <div ref="menuRef" class="relative">
            <button
                class="flex items-center gap-2 rounded-lg px-2 py-1.5 text-sm text-gray-700 hover:bg-gray-100"
                @click="menuOpen = !menuOpen"
            >
                <span class="flex h-8 w-8 items-center justify-center rounded-full bg-indigo-600 text-xs font-semibold text-white" >
                    {{ initials }}
                </span>
                <span class="hidden sm:inline">{{  user?.name ?? "Mi cuenta" }}</span>
                <ChevronDown
                    :size="16"
                    class="transition-transform"
                    :class="{ 'rotate-180': menuOpen }"
                />
            </button>

            <Transition
                enter-active-class="transition duration-150 ease-out"
                leave-active-class="transition duration-100 ease-in"
                enter-from-class="scale-95 opacity-0"
                leave-to-class="scale-95 opacity-0"
            >
                <div
                    v-if="menuOpen"
                    class="absolute right-0 mt-2 w-44 overflow-hidden rounded-lg border bg-white shadow-lg"
                >
                    <Link
                        :href="route('inicio')"
                        class="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 hover:bg-gray-50"
                        @click="menuOpen = false"
                    >
                        <User :size="16" /> Perfil
                    </Link>
                    <button
                        type="button"
                        class="flex w-full items-center gap-2 px-4 py-2 text-left text-sm text-red-600 hover:bg-gray-50"
                        @click="logout"
                    >
                        <LogOut :size="16" /> Cerrar sesión
                    </button>
                </div>
            </Transition>
        </div>
    </header>
</template>
