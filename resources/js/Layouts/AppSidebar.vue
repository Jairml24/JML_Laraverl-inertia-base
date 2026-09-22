<script setup>
  import { Link } from '@inertiajs/vue3'

  defineProps({
    open: { type: Boolean, default: true },
  })

  const links = [
    { label: 'Inicio', route: 'inicio' },
  ]
</script>

<template>
  <aside
    class="bg-gray-800 text-white transition-all duration-200 overflow-hidden"
    :class="open ? 'w-64' : 'w-0'"
  >
    <nav class="p-4 space-y-1 whitespace-nowrap">
      <Link
        v-for="link in links"
        :key="link.route"
        :href="route(link.route)"
        class="block px-3 py-2 rounded hover:bg-gray-700"
        :class="{ 'bg-gray-700': route().current(link.route) }"
      >
        {{ link.label }}
      </Link>
    </nav>
  </aside>
</template>