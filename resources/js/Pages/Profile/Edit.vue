<script setup>
    import { ref } from "vue";
    import { useForm } from "@inertiajs/vue3";
    import AppLayout from "@/Layouts/AppLayout.vue";
    import VButton from "@/Components/VButton.vue";
    import VInput from "@/Components/VInput.vue";
    import VForm from "@/Components/VForm.vue";

    const props = defineProps({
        user: { type: Object, required: true },
    });

    const perfil = useForm({
        name: props.user.name ?? "",
        email: props.user.email ?? "",
    });

    const clave = useForm({
        current_password: "",
        password: "",
        password_confirmation: "",
    });

    // Al cambiar la key se vuelve a montar el formulario y se limpia el estado de validación
    const claveKey = ref(0);

    function guardarPerfil() {
        perfil.patch(route("profile.update"), { preserveScroll: true });
    }

    function cambiarClave() {
        clave.put(route("password.update"), {
            preserveScroll: true,
            onSuccess: () => {
                clave.reset();
                claveKey.value++;
            },
        });
    }
</script>

<template>
    <AppLayout title="Mi perfil">
        <div class="mx-auto max-w-2xl space-y-6">
            <section class="rounded-lg border border-slate-200 bg-white p-6 shadow-sm">
                <h2 class="text-lg font-semibold text-slate-900">Datos personales</h2>
                <p class="mb-5 text-sm text-slate-500">
                    Tu usuario de ingreso es
                    <span class="font-semibold text-slate-800">{{ user.dni }}</span>
                </p>

                <VForm @submit="guardarPerfil" class="space-y-4">
                    <VInput
                        label="Nombre"
                        name="name"
                        rules="required"
                        v-model="perfil.name"
                        :server-error="perfil.errors.name"
                    />
                    <VInput
                        label="Correo electrónico (opcional)"
                        name="email"
                        type="email"
                        rules="email"
                        v-model="perfil.email"
                        :server-error="perfil.errors.email"
                    />
                    <div class="flex justify-end">
                        <VButton type="submit" :disabled="perfil.processing">Guardar cambios</VButton>
                    </div>
                </VForm>
            </section>

            <section class="rounded-lg border border-slate-200 bg-white p-6 shadow-sm">
                <h2 class="text-lg font-semibold text-slate-900">Cambiar contraseña</h2>
                <p class="mb-5 text-sm text-slate-500">Usa mínimo 8 caracteres.</p>

                <VForm :key="claveKey" @submit="cambiarClave" class="space-y-4">
                    <VInput
                        label="Contraseña actual"
                        name="current_password"
                        type="password"
                        rules="required"
                        v-model="clave.current_password"
                        :server-error="clave.errors.current_password"
                    />
                    <VInput
                        label="Nueva contraseña"
                        name="password"
                        type="password"
                        rules="required|min:8"
                        v-model="clave.password"
                        :server-error="clave.errors.password"
                    />
                    <VInput
                        label="Confirmar nueva contraseña"
                        name="password_confirmation"
                        type="password"
                        rules="required|confirmed:@password"
                        v-model="clave.password_confirmation"
                        :server-error="clave.errors.password_confirmation"
                    />
                    <div class="flex justify-end">
                        <VButton type="submit" :disabled="clave.processing">Actualizar contraseña</VButton>
                    </div>
                </VForm>
            </section>
        </div>
    </AppLayout>
</template>