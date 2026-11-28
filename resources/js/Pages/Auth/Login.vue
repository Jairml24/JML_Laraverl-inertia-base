<script setup>
    import { Head, Link, useForm } from '@inertiajs/vue3'
    import VInput from '@/Components/VInput.vue'
    import VButton from '@/Components/VButton.vue'
    import VAlert from '@/Components/VAlert.vue'
    import VForm from '@/Components/VForm.vue'
    import AuthBrandPanel from './Partials/AuthBrandPanel.vue'

    const props = defineProps({
        canResetPassword: { type: Boolean, default: false },
        status: { type: String, default: '' },
    })

    const form = useForm({
        dni: '',
        password: '',
    })

    function submit() {
        form.post(route('login.try'), {
            onFinish: () => form.reset('password'),
        })
    }
</script>

<template>
    <Head title="Iniciar sesión" />
    <div class="min-h-screen flex flex-col md:flex-row">
        <AuthBrandPanel subtitle="Iniciá sesión para acceder al panel de gestión." />
        <div class="md:w-1/2 flex flex-col justify-center px-6 py-14 md:py-0 relative  bg-[#F8FAFC]">
            <div class="w-full max-w-sm mx-auto">
                <div class="bg-white border border-slate-200 shadow-[0_1px_3px_rgba(0,0,0,0.06)] px-8 py-9">
                    <h2 class="text-2xl font-semibold text-slate-900 mb-1">Iniciar sesión</h2>
                    <p class="text-sm text-slate-500 mb-8">Ingresá tus credenciales para continuar</p>
                    <VForm @submit="submit" class="space-y-5">
                        <VInput
                            label="Usuario"
                            name="dni"
                            rules="required"
                            v-model="form.dni"
                            :server-error="form.errors.dni"
                        />
                        <VInput
                            label="Contraseña"
                            name="password"
                            type="password"
                            rules="required"
                            v-model="form.password"
                            :server-error="form.errors.password"
                        />
                        <div class="flex items-center justify-between pt-2">
                            <Link
                                v-if="canResetPassword"
                                :href="route('password.request')"
                                class="text-sm text-slate-500 hover:text-[#13294D] transition"
                            >
                                ¿Olvidaste tu contraseña?
                            </Link>
                            <VButton type="submit" variant="primary" :disabled="form.processing" class="ml-auto">
                                Iniciar sesión
                            </VButton>
                        </div>
                        <VAlert v-if="status" variant="success" :message="status" />
                        <VAlert variant="error" :message="form.errors.credentials" />
                    </VForm>
                </div>
            </div>
        </div>
    </div>
</template>