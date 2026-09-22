<script setup>
    defineProps({
        variant: { type: String, default: 'info' }, // success | error | warning | info
        message: { type: String, default: '' },
    })

    const config = {
        success: {
            border: 'border-emerald-500',
            bg: 'bg-emerald-50/60',
            icon: 'text-emerald-600',
            path: 'M5 13l4 4L19 7',
        },
        error: {
            border: 'border-rose-500',
            bg: 'bg-rose-50/60',
            icon: 'text-rose-600',
            path: 'M6 18L18 6M6 6l12 12',
        },
        warning: {
            border: 'border-amber-500',
            bg: 'bg-amber-50/60',
            icon: 'text-amber-600',
            path: 'M12 9v3.75m0 3.75h.008v.008H12v-.008zM10.29 3.86l-8.18 14.18A1.5 1.5 0 003.5 20.5h17a1.5 1.5 0 001.39-2.46L13.71 3.86a1.5 1.5 0 00-2.42 0z',
        },
        info: {
            border: 'border-slate-400',
            bg: 'bg-slate-50/60',
            icon: 'text-slate-500',
            path: 'M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z',
        },
    }
</script>

<template>
    <div
        v-if="message"
        class="flex items-start gap-3 border-l-2 pl-4 py-3 pr-3"
        :class="[config[variant].border, config[variant].bg]"
    >
        <svg
            xmlns="http://www.w3.org/2000/svg"
            class="w-4 h-4 mt-0.5 shrink-0"
            :class="config[variant].icon"
            fill="none"
            viewBox="0 0 24 24"
            stroke-width="2"
            stroke="currentColor"
        >
            <path stroke-linecap="round" stroke-linejoin="round" :d="config[variant].path" />
        </svg>

        <p class="text-sm text-slate-700 leading-snug flex-1">
            {{ message }}
        </p>
    </div>
</template>