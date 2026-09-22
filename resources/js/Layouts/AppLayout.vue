<!-- resources/js/Layouts/AppLayout.vue -->
<script setup>
import { ref } from 'vue'
import AppHeader from './AppHeader.vue'
import AppSidebar from './AppSidebar.vue'

const sidebarOpen = ref(true)
</script>

<template>
  <div class="min-h-screen flex">
    <AppSidebar :open="sidebarOpen" />

    <div class="flex-1 flex flex-col">
      <AppHeader @toggle-sidebar="sidebarOpen = !sidebarOpen" />

      <main class="flex-1 p-6 bg-gray-50">
        <slot />
      </main>
    </div>
  </div>
</template>