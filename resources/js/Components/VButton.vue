<script setup>
    defineProps({
        variant: { type: String, default: "primary" },
        type: { type: String, default: "button" },
        disabled: { type: Boolean, default: false },
    })

    const estilos = {
        primary: "bg-blue-600 text-white hover:bg-blue-700 focus:ring-blue-500",
        secondary: "bg-gray-100 text-gray-800 hover:bg-gray-200 focus:ring-gray-400",
        danger: "bg-red-600 text-white hover:bg-red-700 focus:ring-red-500",
        indigo: "bg-indigo-600 text-white hover:bg-indigo-700 focus:ring-indigo-500",
    }
</script>

<template>
    <button
        :type="type"
        :disabled="disabled"
        class="px-4 py-2 rounded-md font-medium transition-all duration-150 shadow-sm
               focus:outline-none focus:ring-2 focus:ring-offset-1
               active:scale-[0.98]
               disabled:opacity-50 disabled:cursor-not-allowed disabled:active:scale-100"
        :class="estilos[variant]"
    >
        <slot />
    </button>
</template>