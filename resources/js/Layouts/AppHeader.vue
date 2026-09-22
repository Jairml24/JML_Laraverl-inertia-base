<!-- resources/js/Layouts/AppHeader.vue -->
<script setup>
import { Link, router } from '@inertiajs/vue3'

defineEmits(['toggle-sidebar'])

function logout() {
  router.post(route('logout'))
}
</script>

<template>
    <header class="bg-white shadow flex items-center justify-between px-4 py-3">
        <button @click="$emit('toggle-sidebar')" class="text-gray-600 hover:text-gray-900">
        ☰
        </button>

        <span class="font-semibold text-gray-800">Mi App</span>

        <div class="relative group">
            <button class="text-gray-600 hover:text-gray-900">
                Mi cuenta ▾
            </button>
            <div class="absolute right-0 mt-2 w-40 bg-white shadow-md rounded  group-hover:block">
                <Link :href="route('inicio')" class="block px-4 py-2 hover:bg-gray-100">Perfil</Link>
                <button type="button" @click="router.post(route('logout'))" class="block w-full text-left px-4 py-2 hover:bg-gray-100" >
                    Cerrar Sesión
                </button>
            </div>
        </div>
    </header>
</template>