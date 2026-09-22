<script setup>
    import { Head, useForm } from '@inertiajs/vue3'
    import VInput from '@/Components/VInput.vue'
    import VButton from '@/Components/VButton.vue'
    import VForm from '@/Components/VForm.vue'
    import AuthBrandPanel from './Partials/AuthBrandPanel.vue'

    const props = defineProps({
        email: { type: String, required: true },
        token: { type: String, required: true },
    })

    const form = useForm({
        token: props.token,
        email: props.email,
        password: '',
        password_confirmation: '',
    })

    function submit() {
        form.post(route('password.store'), {
            onFinish: () => form.reset('password', 'password_confirmation'),
        })
    }
</script>

<template>
    <Head title="Restablecer contraseña" />
    <div class="min-h-screen flex flex-col md:flex-row">
        <AuthBrandPanel subtitle="Creá una nueva contraseña para tu cuenta." />
        <div class="md:w-1/2 flex flex-col justify-center px-6 py-14 md:py-0 relative bg-[#F8FAFC]">
            <div class="w-full max-w-sm mx-auto">
                <div class="bg-white border border-slate-200 shadow-[0_1px_3px_rgba(0,0,0,0.06)] px-8 py-9">
                    <h2 class="text-2xl font-semibold text-slate-900 mb-1">Nueva contraseña</h2>
                    <p class="text-sm text-slate-500 mb-8">Ingresá tu nueva contraseña para continuar.</p>
                    <VForm @submit="submit" class="space-y-5">
                        <VInput
                            label="Correo electrónico"
                            name="email"
                            type="email"
                            rules="required|email"
                            v-model="form.email"
                            :server-error="form.errors.email"
                        />
                        <VInput
                            label="Nueva contraseña"
                            name="password"
                            type="text"
                            rules="required|min:8"
                            v-model="form.password"
                            :server-error="form.errors.password"
                        />
                        <VInput
                            label="Confirmar contraseña"
                            name="password_confirmation"
                            type="text"
                            rules="required|confirmed:@password"
                            v-model="form.password_confirmation"
                        />
                        <VButton type="submit" variant="primary" :disabled="form.processing" class="w-full">
                            Restablecer contraseña
                        </VButton>
                    </VForm>
                </div>
            </div>
        </div>
    </div>
</template>