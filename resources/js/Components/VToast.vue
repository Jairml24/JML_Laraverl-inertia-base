<script setup>
import { ref, watch, onUnmounted } from 'vue';
import { usePage } from '@inertiajs/vue3';
import { CheckCircle2, XCircle, X } from 'lucide-vue-next';

const props = defineProps({
    duration: { type: Number, default: 3000 },
});

const page = usePage();
const toast = ref(null);
let timer = null;

const cerrar = () => {
    clearTimeout(timer);
    toast.value = null;
};

const pausar = () => clearTimeout(timer);

const iniciarTimer = () => {
    clearTimeout(timer);
    timer = setTimeout(cerrar, props.duration);
};

const mostrar = (variant, message) => {
    toast.value = { variant, message, id: Date.now() };
    iniciarTimer();
};

watch(
    () => page.props.flash,
    (flash) => {
        if (flash?.error) mostrar('error', flash.error);
        else if (flash?.success) mostrar('success', flash.success);
    },
    { immediate: true }
);

onUnmounted(() => clearTimeout(timer));

defineExpose({ mostrar });
</script>

<template>
    <Teleport to="body">
        <div class="fixed bottom-6 inset-x-0 z-[100] flex justify-center pointer-events-none px-4">
            <Transition
                mode="out-in"
                enter-active-class="transition duration-300 ease-out"
                enter-from-class="translate-y-3 opacity-0"
                enter-to-class="translate-y-0 opacity-100"
                leave-active-class="transition duration-200 ease-in"
                leave-from-class="translate-y-0 opacity-100"
                leave-to-class="translate-y-3 opacity-0"
            >
                <div
                    v-if="toast"
                    :key="toast.id"
                    class="pointer-events-auto flex items-center gap-2.5 rounded-full pl-3.5 pr-2 py-2 text-sm font-medium text-white shadow-lg"
                    :class="toast.variant === 'error' ? 'bg-rose-600' : 'bg-emerald-600'"
                    @mouseenter="pausar"
                    @mouseleave="iniciarTimer"
                    @focusin="pausar"
                    @focusout="iniciarTimer"
                >
                    <XCircle v-if="toast.variant === 'error'" :size="18" class="text-white shrink-0" />
                    <CheckCircle2 v-else :size="18" class="text-white shrink-0" />

                    <span>{{ toast.message }}</span>

                    <button
                        type="button"
                        class="ml-1 p-1 rounded-full text-white/70 hover:text-white hover:bg-white/20 transition"
                        aria-label="Cerrar"
                        @click="cerrar"
                    >
                        <X :size="14" />
                    </button>
                </div>
            </Transition>
        </div>
    </Teleport>
</template>