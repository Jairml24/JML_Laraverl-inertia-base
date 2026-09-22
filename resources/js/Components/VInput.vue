<script setup>
    import { watch } from 'vue'
    import { useField } from 'vee-validate'

    const props = defineProps({
        label: { type: String, default: 'Input' },
        name: { type: String, required: true },
        rules: { type: String, default: '' },
        type: { type: String, default: 'text' },
        modelValue: { type: String, default: '' },
        serverError: { type: String, default: '' },
    })

    const emit = defineEmits(['update:modelValue'])

    const { value, errorMessage, meta, handleBlur } = useField(
        () => props.name,
        props.rules,
        { initialValue: props.modelValue , validateOnMount: false,}
    )

    watch(value, (v) => {
        emit('update:modelValue', v)
    })

    watch(() => props.modelValue, (v) => {
        value.value = v
    })
</script>
<template>
    <div class="w-full">
        <label class="block text-sm font-medium text-gray-700 mb-1.5">
            {{ label }}
        </label>

        <input
            v-model="value"
            :type="type"
            @blur="handleBlur"
            class="w-full rounded-lg border border-gray-300 bg-white px-3 py-2.5 text-sm text-gray-900 shadow-sm outline-none transition
                   placeholder:text-gray-400
                   focus:border-blue-500 focus:ring-2 focus:ring-blue-500/20"
            :class="{
                'border-red-500 focus:border-red-500 focus:ring-red-500/20':
                    (meta.touched && errorMessage) || serverError
            }"
        >

        <span
            v-if="(meta.touched && errorMessage) || serverError"
            class="mt-1.5 block text-sm text-red-500"
        >
            {{ (meta.touched && errorMessage) || serverError }}
        </span>
    </div>
</template>