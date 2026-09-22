<script setup>
    import { useForm as useVeeForm } from 'vee-validate'

    const emit = defineEmits(['submit'])
    const { handleSubmit } = useVeeForm()

    const onSubmit = handleSubmit(() => emit('submit'))
</script>

<template>
    <form @submit.prevent="onSubmit">
        <slot />
    </form>
</template>