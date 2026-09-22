<script setup>
    import { Head, Link, useForm } from '@inertiajs/vue3'
    import VInput from '@/Components/VInput.vue'
    import VButton from '@/Components/VButton.vue'
    import VAlert from '@/Components/VAlert.vue'
    import VForm from '@/Components/VForm.vue'
    import AuthBrandPanel from './Partials/AuthBrandPanel.vue'

    const props = defineProps({
        status: { type: String, default: '' },
    })

    const form = useForm({
        email: '',
    })

    function submit() {
        form.post(route('password.email'))
    }
</script>

<template>
    <Head title="Recuperar contraseña" />
    <div class="min-h-screen flex flex-col md:flex-row">
        <AuthBrandPanel subtitle="Te enviaremos un enlace para restablecer tu contraseña." />
        <div
            class="md:w-1/2 flex flex-col justify-center px-6 py-14 md:py-0 relative bg-[#F8FAFC]">
            <div class="w-full max-w-sm mx-auto">
                <div class="bg-white border border-slate-200 shadow-[0_1px_3px_rgba(0,0,0,0.06)] px-8 py-9">
                    <h2 class="text-2xl font-semibold text-slate-900 mb-1">Recuperar contraseña</h2>
                    <p class="text-sm text-slate-500 mb-8">
                        Ingresá tu correo y te enviaremos un enlace para restablecer tu contraseña.
                    </p>
                    <VForm @submit="submit" class="space-y-5">
                        <VInput
                            label="Correo electrónico"
                            name="email"
                            type="email"
                            rules="required|email"
                            v-model="form.email"
                            :server-error="form.errors.email"
                        />
                        <div class="flex items-center justify-between pt-2">
                            <Link :href="route('login')" class="text-sm text-slate-500 hover:text-[#13294D] transition">
                                Volver al inicio de sesión
                            </Link>
                            <VButton type="submit" variant="primary" :disabled="form.processing" class="ml-auto">
                                Enviar enlace
                            </VButton>
                        </div>
                    <VAlert v-if="status" variant="success" :message="status" />
                    </VForm>
                </div>
            </div>
        </div>
    </div>
</template>